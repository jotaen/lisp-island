(load "src/list.scm")

(define (insert-sort numbers)
  (define (sort-into-iter x smaller larger)
    (if (or (empty? larger) (<= x (car larger)))
      (append smaller `(,x) larger)
      (sort-into-iter x (append smaller `(,(car larger))) (cdr larger))))
  (define (sort-into x sorted) (sort-into-iter x '() sorted))
  (define (sort-iter unsorted sorted)
    (if (empty? unsorted)
      sorted
      (sort-iter (cdr unsorted) (sort-into (car unsorted) sorted))))
  (sort-iter numbers '()))

(define (select-sort numbers)
  (define (find-smallest-iter left right candidate)
    (if (empty? left)
      `(,candidate ,right)
      (let* ((n (car left)) (smaller (min candidate n)) (bigger (max candidate n)))
        (find-smallest-iter (cdr left) (cons bigger right) smaller))))
  (define (find-smallest xs) (find-smallest-iter (cdr xs) '() (car xs)))
  (define (sort-iter unsorted sorted)
    (if (>= 1 (length unsorted))
      (append sorted unsorted)
      (let* (
        (p (find-smallest unsorted))
        (smallest (first p))
        (remainder (second p)))
          (sort-iter remainder (append sorted `(,smallest))))))
  (sort-iter numbers '()))

(define (merge-sort numbers)
  (define (split-half xs) (let ((h (/ (length xs) 2)))
    (list (slice xs 0 (ceiling h)) (slice xs (ceiling h) (length xs)))))
  (define (merge-iter as bs sorted)
    (if (or (empty? as) (empty? bs))
      (append sorted (if (empty? as) bs as))
      (let ((smallest (min (car as) (car bs))))
        (merge-iter
          (if (= smallest (car as)) (cdr as) as)
          (if (and (= smallest (car bs)) (not (= smallest (car as)))) (cdr bs) bs)
          (append sorted (list smallest))
      ))))
  (define (merge as bs) (merge-iter as bs '()))
  (define (sort-iter xs)
    (if (<= (length xs) 1)
      xs
      (let ((p (split-half xs)))
        (merge (sort-iter (first p)) (sort-iter (second p))))))
  (sort-iter numbers))

; (define (quick-sort numbers) (
;   ))

; (define (bubble-sort numbers) (
;   ))
