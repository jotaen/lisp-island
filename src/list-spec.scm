(load "src/list.scm")

(testcase* "list" (list

  (testcase "sort-pair" (list
    (assert equal? (sort-pair '(1 1)) '(1 1))
    (assert equal? (sort-pair '(1 2)) '(1 2))
    (assert equal? (sort-pair '(2 1)) '(1 2))
  ))

  (testcase "slice" (list
    (assert equal? (slice '(1 2 3) 0 0) '())
    (assert equal? (slice '(1 2 3) 0 1) '(1))
    (assert equal? (slice '(1 2 3) 1 2) '(2))
    (assert equal? (slice '(1 2 3) 0 2) '(1 2))
    (assert equal? (slice '(1 2 3) 1 3) '(2 3))
    (assert equal? (slice '(1 2 3) 0 3) '(1 2 3))
    (assert equal? (slice '(1 2 3) 1 3) '(2 3))
    (assert equal? (slice '(1 2 3) 2 3) '(3))
    (assert equal? (slice '(1 2 3) 3 3) '())
  ))

  (testcase "compose" (let () 
  (define (plus4 x) (+ x 4))
  (define (times6 x) (* x 6))
  (define (minus2 x) (- x 2))
  (list
    (assert eq? ((compose identity) 'a) 'a)
    (assert eq? ((compose identity identity identity) 'a) 'a)
    (assert eq? ((compose plus4 times6 minus2) 3) 10)
    (assert eq? ((compose minus2 times6 plus4) 3) 40)
  )))

  (testcase "last" (list
    (assert equal? (last '(1)) 1)
    (assert equal? (last '(1 2)) 2)
    (assert equal? (last '(1 2 3)) 3)
    (assert equal? (last `(13 ,'(1829 82) 40 ,'(23 19))) '(23 19))
  ))

  (testcase "flatten" (list
    (assert equal? (flatten '()) '())
    (assert equal? (flatten `(,'1 ,'(2) 3)) '(1 2 3))
    (assert equal? (flatten `(,'(1 2 3))) '(1 2 3))
    (assert equal? (flatten `(,'(1 2) ,'(3))) '(1 2 3))
    (assert equal? (flatten `(,'(1 2) ,`(3 ,'(4)))) `(,'1 ,'2 ,'3 ,'(4)))
  ))

  (testcase "deep-flatten" (list
    (assert equal? (deep-flatten '()) '())
    (assert equal? (deep-flatten `(,`(1))) '(1))
    (assert equal? (deep-flatten '(1 2 3)) '(1 2 3))
    (assert equal? (deep-flatten `(,'() ,'())) '())
    (assert equal? (deep-flatten `(1 ,'(2 3))) '(1 2 3))
    (assert equal? (deep-flatten `(1 ,`(2 3 ,`(4) 5) ,`(,`(6)))) '(1 2 3 4 5 6))
  ))

  (testcase "flat?" (list
    (assert true? (flat? '()))
    (assert true? (flat? '(1)))
    (assert true? (flat? '(1 2 3)))
    (assert false? (flat? `(,`())))
    (assert false? (flat? `(,`(1))))
    (assert false? (flat? `(1 2 ,`(3))))
  ))

))
