(include "src/list.scm")

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
