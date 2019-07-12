(load-option 'format)

(define scmunit-report ())

(define-structure scmunit-result
    predicate expression actual expected ok?)

(define-structure scmunit-group
    name checks)

(define-syntax check
  (syntax-rules () ((_ predicate expression expected)
    (let* (
      (actual expression)
      (ok? (predicate actual expected)))
        (make-scmunit-result 'predicate 'expression actual expected ok?)))))

(define (test-group name . checks) 
    (set! scmunit-report (append scmunit-report `(,(make-scmunit-group name checks)))))

(define (scmunit-run)
    (define (headline h) (string-append "# " h))
    (define (verbose c)
        (format #f
        "\n  ~A   :::   (~A ~A ~A)   >>>   ~A"
        (scmunit-result-expression c)
        (scmunit-result-predicate c)
        (scmunit-result-actual c)
        (scmunit-result-expected c)
        (scmunit-result-ok? c)))
    (define (quiet c) (if (scmunit-result-ok? c) "." "E"))
    (begin
        (display "\n")
        (for-each (lambda (g) (begin
            (display (headline (scmunit-group-name g)))
            (display "\n  ")
            (for-each (lambda (c) (display (quiet c))) (scmunit-group-checks g))
            (for-each (lambda (c) (display (verbose c)))
                (filter (lambda (c) (not (scmunit-result-ok? c))) (scmunit-group-checks g)))
            (display "\n\n")
            )) scmunit-report)
        ))
