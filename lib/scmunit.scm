(load-option 'format)

(define *scmunit/groups* ())

(define-structure scmunit/check
    predicate expression actual expected ok? runtime)

(define-structure scmunit/group
    name checks groups)

; Test assertion
; (predicate expression value) -> scmunit/check
(define-syntax check
  (syntax-rules () ((_ predicate expression expected)
    (let* (
        (time-start (real-time-clock))
        (actual expression)
        (time-end (real-time-clock))
        (ok? (predicate actual expected)))
            (make-scmunit/check
                'predicate
                'expression
                actual
                expected
                ok?
                (* 1000 (internal-time/ticks->seconds (- time-end time-start))))))))

; Group of checks and/or sub-groups
; (string [check|group]...) -> scmunit/group
(define-syntax test-group
    (syntax-rules () ((_ name items ...)
        (let ((is (list items ...)))
            (make-scmunit/group
                name
                (filter (lambda (x) (scmunit/check? x)) is)
                (filter (lambda (x) (scmunit/group? x)) is))))))

; Test group that automatically registers itself at the test-runner
; (string [check|group]...) -> NIL
(define-syntax test-group*
    (syntax-rules () ((_ name items ...)
        (set! *scmunit/groups* (append *scmunit/groups* (list (test-group name items ...)))))))

; Command to run all registered tests, returns the formatted result
; () -> string
(define (scmunit-run*)
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
            "~A\n~A) ~A  ~A   ->   (~A ~A ~A)"
            a
            i
            (concat-paths ps)
            (scmunit/check-expression c)
            (scmunit/check-predicate c)
            (scmunit/check-actual c)
            (scmunit/check-expected c)) (+ i 1)))) '("" 1) c:ps))
    (define (get-checks gs path) (fold-right (lambda (g a)
        (let ((current-path (append path (list (scmunit/group-name g)))))
        (append
            a
            (get-checks (scmunit/group-groups g) current-path)
            (map (lambda (c) (list c current-path)) (scmunit/group-checks g))))) () gs))
    (define (summary nr-all nr-failed) (format #f "~A checks ran: ~A passed, ~A failed" nr-all (- nr-all nr-failed) nr-failed))
    (let* (
        (all-checks (get-checks *scmunit/groups* ()))
        (failed-checks (filter (lambda (cp) (not (scmunit/check-ok? (first cp)))) all-checks)))
    (string-append
        (listing *scmunit/groups* "")
        "\n\n"
        (summary (length all-checks) (length failed-checks))
        "\n"
        (first (check-verbose failed-checks))
        "\n"
        (if (< 0 (length failed-checks)) "\n" ""))))
