(include "sqrt-util.scm")

(define (abs x) (if (< x 0) (- x) x))

(define (diff x y) (abs (- x y)))

(define (average x y) (/ (+ x y) 2))

(define (sqrt x)
  (if
    (> 0 x)
    #f
    (sqrt-newton x 0.000001)))

(define (factorial x)
  (if (= 0 x)
    1
    (* x (factorial (- (abs x) 1)))))
