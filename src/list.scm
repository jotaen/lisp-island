(define (empty? xs) (= 0 (length xs)))

(define (compose . fs)
  (lambda (x) (fold-right (lambda (f x) (f x)) x fs)))

(define (sort-pair p) (if (> (first p) (second p)) (reverse p) p))

(define (insert-sort numbers)
  (define (sort-into x smaller larger)
    (if (or (empty? larger) (<= x (first larger)))
      (append smaller (list x) larger)
      (sort-into x (append smaller (list (first larger))) (cdr larger))))
  (define (sort-iter unsorted sorted)
    (if (empty? unsorted)
      sorted
      (sort-iter (cdr unsorted) (sort-into (car unsorted) '() sorted))))
  (sort-iter numbers '()))
