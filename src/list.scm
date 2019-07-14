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

(define (select-sort numbers)
  (define (put-smallest-first x left right smallest)
    (if (empty? left)
      (cons smallest right)
      (let* ((c (first left)) (smaller (min smallest c)) (bigger (max smallest c)))
        (put-smallest-first x (cdr left) (cons bigger right) smaller))))
  (define (sort-iter unsorted sorted)
    (if (>= 1 (length unsorted))
      (append sorted unsorted)
      (let* (
        (p (put-smallest-first (car unsorted) (cdr unsorted) '() (car unsorted)))
        (next-smallest (first p))
        (remainder (cdr p)))
          (sort-iter remainder (append sorted `(,next-smallest))))))
  (sort-iter numbers '()))
