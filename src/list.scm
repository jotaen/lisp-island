(define (empty? xs) (= 0 (length xs)))

(define (compose . fs)
  (lambda (x) (fold-right (lambda (f x) (f x)) x fs)))
