(define (abs x) (if (< x 0) (- x) x))

(define (diff x y) (abs (- x y)))

(define (average x y) (/ (+ x y) 2))

(define (sqrt x)
  (define (approx g) (average (/ x g) g))
  (define (newton-iter guess previous-guess precision)
    (define (precise-enough?) (< (diff guess previous-guess) precision))
    (if (precise-enough?)
        guess
        (newton-iter (approx guess) guess precision)
     )
  )
  (newton-iter 1.0 0.0 0.000001))

(define (factorial x)
  (if (= 0 x)
    1
    (* x (factorial (- (abs x) 1)))))

(define (fibonacci x)
  (define (iter a b i)
    (if (= 0 i) b (iter (+ a b) a (- i 1))))
  (iter 1 0 x))

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

(define (sin x) ; `x` in radians
  (define (approx g) (- (* 3 g) (* 4 g g g)))
  (define (trigonometry-iter precision)
    (if (not (> (abs x) precision))
      x
      (approx (sin (/ x 3.0)))))
  (trigonometry-iter 0.000001))
