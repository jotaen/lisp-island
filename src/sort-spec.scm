(include "src/sort.scm")

(test-case "insert-sort"
    (check equal? (insert-sort '()) '())
    (check equal? (insert-sort '(1)) '(1))
    (check equal? (insert-sort '(1 2 3)) '(1 2 3))
    (check equal? (insert-sort '(3 2 1)) '(1 2 3))
    (check equal? (insert-sort '(2 1 3)) '(1 2 3))
    (check equal? (insert-sort '(12 1 19 100 31 0 -182)) '(-182 0 1 12 19 31 100))
    (check equal? (insert-sort '(1 1)) '(1 1))
    (check equal? (insert-sort '(1 3 1)) '(1 1 3))
)
