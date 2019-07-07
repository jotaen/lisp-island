#lang racket

(include "sort.rkt")
(require rackunit)

(define/provide-test-suite sort-spec

  (test-case "insert-sort"
    (check-equal? (insert-sort '(1 2 3)) '(1 2 3))
    (check-equal? (insert-sort '(3 2 1)) '(1 2 3))
  )

)
