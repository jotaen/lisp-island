(load-option 'format)

(define *scmunit-groups* ())

(define-structure scmunit-check
    predicate expression actual expected ok?)

(define-structure scmunit-group
    name checks groups)

(define-syntax check
  (syntax-rules () ((_ predicate expression expected)
    (let* (
      (actual expression)
      (ok? (predicate actual expected)))
        (make-scmunit-check 'predicate 'expression actual expected ok?)))))

(define-syntax test-group
    (syntax-rules () ((_ name items ...)
        (let ((is (list items ...)))
            (make-scmunit-group
                name
                (filter (lambda (x) (scmunit-check? x)) is)
                (filter (lambda (x) (scmunit-group? x)) is))))))

(define-syntax test-group*
    (syntax-rules () ((_ name items ...)
        (set! *scmunit-groups* (append *scmunit-groups* (list (test-group name items ...)))))))

(define (scmunit-run)
    (define (result-verbose c)
        (format #f
        "\n~A   :::   (~A ~A ~A)   >>>   ~A"
        (scmunit-check-expression c)
        (scmunit-check-predicate c)
        (scmunit-check-actual c)
        (scmunit-check-expected c)
        (scmunit-check-ok? c)))
    (define (check-summary cs)
        (fold-right (lambda (c a) (string-append a (if (scmunit-check-ok? c) "." "E"))) "" cs))
    (define (group-summary g)
        (string-append "# " (scmunit-group-name g) " " (check-summary (scmunit-group-checks g))))
    (define (stringify xs pref) (fold-right (lambda (x a) (if
        (list? x) (string-append a (stringify x pref))
        (string-append a "\n" pref (group-summary x) " " (stringify (list (scmunit-group-groups x)) (string-append pref "  ")))
    )) "" xs))
    (begin
        (display (stringify *scmunit-groups* ""))
        (display "\n\n")
    ))
