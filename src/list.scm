(define (single? xs) (= 1 (length xs)))

(define (compose . fs)
  (lambda (x) (fold-right (lambda (f x) (f x)) x fs)))

(define (slice xs start end)
  (define (slice-iter head tail result)
    (if (not (= start (length head)))
      (slice-iter (append head (list (first tail))) (cdr tail) result)
      (let ((size (- end start)))
        (if (= size (length result))
          result
          (slice-iter head (cdr tail) (append result (list (first tail))))))))
  (slice-iter '() xs '()))

(define (last xs) (car (reverse xs)))

(define (flatten xs)
  (fold-left (lambda (a x)
    (append a (if (list? x) (flatten x) (list x)))
  ) '() xs))

(define (flat? xs)
  (cond
    ((null? xs) #t)
    ((list? (car xs)) #f)
    (else (flat? (cdr xs)))))
