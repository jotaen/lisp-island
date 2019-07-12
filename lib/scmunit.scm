(load-option 'format)

(define *scmunit/groups* ())

(define-structure scmunit/check
    predicate expression actual expected ok? runtime)

(define-structure scmunit/group
    name checks groups)

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

(define-syntax test-group
    (syntax-rules () ((_ name items ...)
        (let ((is (list items ...)))
            (make-scmunit/group
                name
                (filter (lambda (x) (scmunit/check? x)) is)
                (filter (lambda (x) (scmunit/group? x)) is))))))

(define-syntax test-group*
    (syntax-rules () ((_ name items ...)
        (set! *scmunit/groups* (append *scmunit/groups* (list (test-group name items ...)))))))

(define (scmunit-run*)
    (define (check-overview cs)
        (fold-right (lambda (c a) (string-append a (if (scmunit/check-ok? c) "." "E"))) "" cs))
    (define (check-runtime cs) (fold-right (lambda (c a) (+ a (scmunit/check-runtime c))) 0 cs))
    (define (group-summary g)
        (string-append
            "# " (scmunit/group-name g)
            (if (< 0 (length (scmunit/group-checks g)))
                (format #f " ~A (~Ams)" (check-overview (scmunit/group-checks g)) (check-runtime (scmunit/group-checks g)))
                "")))
    (define (summary gs pref) (fold-right (lambda (g a)
        (string-append a "\n" pref (group-summary g) " " (summary (scmunit/group-groups g) (string-append pref "  ")))
    ) "" gs))
    (define (result-verbose c)
        (format #f
        "\n~A   :::   (~A ~A ~A)   >>>   ~A"
        (scmunit/check-expression c)
        (scmunit/check-predicate c)
        (scmunit/check-actual c)
        (scmunit/check-expected c)
        (scmunit/check-ok? c)))
    (begin
        (display (summary *scmunit/groups* ""))
        (display "\n\n")
    ))
