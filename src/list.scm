(define (empty? xs) (= 0 (length xs)))

(define (single? xs) (= 1 (length xs)))

(define (compose . fs)
  (lambda (x) (fold-right (lambda (f x) (f x)) x fs)))

(define (sort-pair p) (if (> (first p) (second p)) (reverse p) p))

(define (slice xs start end)
  (define (slice-iter head tail result)
    (if (not (= start (length head)))
      (slice-iter (append head (list (first tail))) (cdr tail) result)
      (let ((size (- end start)))
        (if (= size (length result))
          result
          (slice-iter head (cdr tail) (append result (list (first tail))))))))
  (slice-iter '() xs '()))
