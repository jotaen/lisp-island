(load-option 'format)

(define scmunit-report ())

(define-structure scmunit-result
    predicate expression actual expected ok?)

(define-syntax check
  (syntax-rules () ((_ predicate expression expected)
    (let* (
      (actual expression)
      (ok? (predicate actual expected)))
        (make-scmunit-result 'predicate 'expression actual expected ok?)))))

(define (test-case name . checks) 
    (set! scmunit-report (append scmunit-report (list (list name checks)))))

(define (scmunit-run)
    (define (headline h) (string-append "# " h))
    (define (verbose c)
        (format #f
        "Evaluate:    ~A\n  Assert:      (~A ~A ~A)\n  Result:      ~A\n"
        (scmunit-result-expression c)
        (scmunit-result-predicate c)
        (scmunit-result-actual c)
        (scmunit-result-expected c)
        (scmunit-result-ok? c)))
    (define (quiet c) (if (scmunit-result-ok? c) "." "E"))
    (begin
        (display "\n")
        (for-each (lambda (t) (begin
            (display (headline (first t)))
            (display "\n  ")
            (for-each (lambda (c) (display (quiet c))) (second t))
            (display "\n\n")
            )) scmunit-report)
        ))
