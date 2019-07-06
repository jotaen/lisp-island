(define (abs x) (if (< x 0) (- x) x))

(define (diff x y) (abs (- x y)))

(define (average x y) (/ (+ x y) 2))
