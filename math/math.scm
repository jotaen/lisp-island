(include "sqrt-newton.scm")

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

(define (fibonacci x)
  (define (fibonacci-iter a b i)
    (if (= 0 i) b (fibonacci-iter (+ a b) a (- i 1))))
  (fibonacci-iter 1 0 x))

(define (binomial-coefficients n)
  (define (row-iter prev)
    (if (= 1 (length prev))
      '(1)
      (cons (+ (first prev) (second prev)) (row-iter (cdr prev)))))
  (define (pascal-triangle-iter row i)
    (if (= i n)
      row
      (pascal-triangle-iter (row-iter (cons 0 row)) (+ i 1))))
  (pascal-triangle-iter '(1) 1))
