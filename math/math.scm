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
  (define (sums-of-neighbours row)
    (cons
      (+ (first row) (second row))
      (if (= 2 (length row)) '() (sums-of-neighbours (cdr row)))))
  (define (pascal-triangle-iter row)
    (if (= n (length row))
      row
      (pascal-triangle-iter (sums-of-neighbours (append '(0) row '(0))))))
  (pascal-triangle-iter '(1)))

(define (sin angle-rad)
  (define (approx x) (- (* 3 x) (* 4 x x x)))
  (if (not (> (abs angle-rad) 0.000001))
    angle-rad
    (approx (sin (/ angle-rad 3.0)))))
