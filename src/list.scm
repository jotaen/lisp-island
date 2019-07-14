(define (empty? xs) (= 0 (length xs)))

(define (compose . fs)
  (lambda (x) (fold-right (lambda (f x) (f x)) x fs)))

(define (insert-sort numbers)
  (define (insert x left right)
    (if (or (empty? right) (<= x (first right)))
      (append left (list x) right)
      (insert x (append left (list (first right))) (cdr right))))
  (define (sort-iter unsorted sorted)
    (if (= 0 (length unsorted))
      sorted
      (sort-iter (cdr unsorted) (insert (car unsorted) '() sorted))))
  (sort-iter numbers '()))
