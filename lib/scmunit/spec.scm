(load "scmunit.scm")

(define c (check eq? (+ 1 3) 4))

(define g (test-group "" (list c c (test-group "" '()))))

; `check` gets constructed correctly
(begin
  (if (not (equal? (scmunit/check-predicate c) 'eq?)) (error "predicate"))
  (if (not (equal? (scmunit/check-expression c) '(+ 1 3))) (error "expression"))
  (if (not (equal? (scmunit/check-actual c) 4)) (error "evaluation"))
  (if (not (equal? (scmunit/check-arguments c) '(4))) (error "arguments"))
  (if (not (equal? (scmunit/check-ok? c) #t)) (error "result"))
  (if (not (>= (scmunit/check-runtime c) 0.0)) (error "runtime"))
)

; `test-group` gets constructed correctly
(begin
  (if (not (= 1 (length (scmunit/group-groups g)))) (error "groups"))
  (if (not (= 2 (length (scmunit/group-checks g)))) (error "checks"))
)

; check expression gets evaluated just once
(let ((i 0))
  (define (spy) (set! i (+ i 1)))
  (begin
    (check (lambda (_) ()) (spy))
    (if (not (= i 1)) (error "nr of invocations (standalone)"))
    (test-group "" (list (check (lambda (_) ()) (spy))))
    (if (not (= i 2)) (error "nr of invocations (in group)"))
))

(exit 0)
