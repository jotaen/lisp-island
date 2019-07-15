(load "src/list.scm")

(test-group* "list" (list

  (test-group "empty?" (list
    (check true? (empty? '()))
    (check false? (empty? '(1)))
    (check false? (empty? '(1 2 3)))
  ))

  (test-group "sort-pair" (list
    (check equal? (sort-pair '(1 1)) '(1 1))
    (check equal? (sort-pair '(1 2)) '(1 2))
    (check equal? (sort-pair '(2 1)) '(1 2))
  ))

  (test-group "slice" (list
    (check equal? (slice '(1 2 3) 0 0) '())
    (check equal? (slice '(1 2 3) 0 1) '(1))
    (check equal? (slice '(1 2 3) 1 2) '(2))
    (check equal? (slice '(1 2 3) 0 2) '(1 2))
    (check equal? (slice '(1 2 3) 1 3) '(2 3))
    (check equal? (slice '(1 2 3) 0 3) '(1 2 3))
    (check equal? (slice '(1 2 3) 1 3) '(2 3))
    (check equal? (slice '(1 2 3) 2 3) '(3))
    (check equal? (slice '(1 2 3) 3 3) '())
  ))

  (test-group "compose" (let () 
  (define (plus4 x) (+ x 4))
  (define (times6 x) (* x 6))
  (define (minus2 x) (- x 2))
  (list
    (check eq? ((compose identity) 'a) 'a)
    (check eq? ((compose identity identity identity) 'a) 'a)
    (check eq? ((compose plus4 times6 minus2) 3) 10)
    (check eq? ((compose minus2 times6 plus4) 3) 40)
  )))

))
