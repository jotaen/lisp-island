(include "src/list.scm")

(test-group "empty?"
  (check eq? (empty? '()) #t)
  (check eq? (empty? '(1)) #f)
  (check eq? (empty? '(1 2 3)) #f)
)

(define (plus4 x) (+ x 4))
(define (times6 x) (* x 6))
(define (minus2 x) (- x 2))

(test-group "compose"
  (check eq? ((compose identity) 'a) 'a)
  (check eq? ((compose identity identity identity) 'a) 'a)
  (check eq? ((compose plus4 times6 minus2) 3) 10)
  (check eq? ((compose minus2 times6 plus4) 3) 40)
)
