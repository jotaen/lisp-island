(load-option 'format)

(define *scmunit/groups* ())

(define-structure scmunit/check
    predicate expression actual arguments ok? runtime)

(define-structure scmunit/group
    name checks groups)

(define-syntax check
  (syntax-rules () ((_ predicate expression arguments ...)
    (let* (
        (time-start (real-time-clock))
        (actual expression)
        (time-end (real-time-clock))
        (args (list arguments ...))
        (ok? (apply predicate actual args)))
            (make-scmunit/check
                'predicate
                'expression
                actual
                args
                ok?
                (* 1000 (internal-time/ticks->seconds (- time-end time-start))))))))

(define-syntax test-group
    (syntax-rules () ((_ name xs)
        (make-scmunit/group
            name
            (filter (lambda (x) (scmunit/check? x)) xs)
            (filter (lambda (x) (scmunit/group? x)) xs)))))

(define-syntax test-group*
    (syntax-rules () ((_ name xs ...)
        (set! *scmunit/groups* (append *scmunit/groups* (list (test-group name xs ...)))))))

(define (scmunit-run groups callback)
    (define (check-overview cs)
        (fold-right (lambda (c a) (string-append a (if (scmunit/check-ok? c) "." "x"))) "" cs))
    (define (check-runtime cs) (fold-right (lambda (c a) (+ a (scmunit/check-runtime c))) 0 cs))
    (define (group-listing g)
        (string-append
            "# " (scmunit/group-name g)
            (if (< 0 (length (scmunit/group-checks g)))
                (format #f " ~A (~Ams)" (check-overview (scmunit/group-checks g)) (check-runtime (scmunit/group-checks g)))
                "")))
    (define (listing gs pref) (fold-right (lambda (g a)
        (string-append a "\n" pref (group-listing g) " " (listing (scmunit/group-groups g) (string-append pref "  ")))) "" gs))
    (define (check-verbose c:ps) (fold-right (lambda (c:p a:i)
        (define (concat-paths ps) (fold-right (lambda (p a) (string-append p ": " a)) "" ps))
        (let ((c (first c:p)) (ps (second c:p)) (a (first a:i)) (i (second a:i)))
        (list (format #f
            "~A\n~A) ~A  ~A   ->   (~A ~A~A)"
            a
            i
            (concat-paths ps)
            (scmunit/check-expression c)
            (scmunit/check-predicate c)
            (scmunit/check-actual c)
            (fold-left (lambda (x a) (format #f "~A ~A" x a)) "" (scmunit/check-arguments c))) (+ i 1)))) '("" 1) c:ps))
    (define (get-checks gs path) (fold-right (lambda (g a)
        (let ((current-path (append path (list (scmunit/group-name g)))))
        (append
            a
            (get-checks (scmunit/group-groups g) current-path)
            (map (lambda (c) (list c current-path)) (scmunit/group-checks g))))) () gs))
    (define (summary nr-all nr-failed) (format #f "~A checks ran: ~A passed, ~A failed" nr-all (- nr-all nr-failed) nr-failed))
    (let* (
        (all-checks (get-checks groups ()))
        (failed-checks (filter (lambda (cp) (not (scmunit/check-ok? (first cp)))) all-checks))
        (success? (= 0 (length failed-checks)))
        (output-text (string-append
            (listing groups "")
            "\n\n"
            (summary (length all-checks) (length failed-checks))
            "\n"
            (first (check-verbose failed-checks))
            "\n"
            (if (not success?) "\n" ""))))
    (begin
        (callback output-text (if (eq? success? #t) 0 1))
        output-text)))

(define (scmunit-run*) (scmunit-run *scmunit/groups* (lambda (out status) (begin (display out) (exit status)))))
