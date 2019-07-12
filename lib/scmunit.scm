(load-option 'format)

(define *scmunit-groups* ())

(define-structure scmunit-result
    predicate expression actual expected ok?)

(define-structure scmunit-group
    name items)

(define-syntax check
  (syntax-rules () ((_ predicate expression expected)
    (let* (
      (actual expression)
      (ok? (predicate actual expected)))
        (make-scmunit-result 'predicate 'expression actual expected ok?)))))

(define-syntax test-group
    (syntax-rules () ((_ name items ...)
        (make-scmunit-group name (list items ...)))))

(define-syntax test-group*
    (syntax-rules () ((_ name items ...)
        (set! *scmunit-groups* (append *scmunit-groups* (list (make-scmunit-group name (list items ...))))))))

(define (scmunit-run)
    (define (header g) (string-append "# " (scmunit-group-name g)))
    (define (check-verbose c)
        (format #f
        "\n~A   :::   (~A ~A ~A)   >>>   ~A"
        (scmunit-result-expression c)
        (scmunit-result-predicate c)
        (scmunit-result-actual c)
        (scmunit-result-expected c)
        (scmunit-result-ok? c)))
    (define (check-quiet c) (if (scmunit-result-ok? c) "." "E"))
    (define (groups-strs gs) (map (lambda (x) (cond
        ((list? x) (suites-strs x))
        ((scmunit-group? x) (make-scmunit-group (header x) (groups-strs (scmunit-group-items x))))
        ((scmunit-result? x) (check-quiet x))
        )) gs))
    (define (join-indented xs pref) (fold-right (lambda (x a) (cond
        ((string? x) (string-append x a))
        ((scmunit-group? x) (string-append a "\n" pref (scmunit-group-name x) " " (join-indented (list (scmunit-group-items x)) (string-append pref "  "))))
        ((list? x) (string-append a (join-indented x pref)))
        (error "Wrong type!")
    )) "" xs))
    (begin
        (display (join-indented (groups-strs *scmunit-groups*) ""))
        (display "\n\n")
    ))
