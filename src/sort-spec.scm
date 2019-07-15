(load "src/sort.scm")

(test-group* "sorting" 

  (map (lambda (p) (let ((name (first p)) (f (second p)))
      (test-group name (list
          (check equal? (f '()) '())
          (check equal? (f '(0)) '(0))
          (check equal? (f '(0 1)) '(0 1))
          (check equal? (f '(1 1 1)) '(1 1 1))
          (check equal? (f '(1 3 3 1)) '(1 1 3 3))
          (check equal? (f '(1 2 3 4 5)) '(1 2 3 4 5))
          (check equal? (f '(5 4 3 2 1)) '(1 2 3 4 5))
          (check equal? (f '(4 2 1 3 5)) '(1 2 3 4 5))
          (check equal? (f '(12 1 19 100 31 0 -182)) '(-182 0 1 12 19 31 100))
          (check equal? (f '(-91 100 1 50 -512 13 -40 245)) '(-512 -91 -40 1 13 50 100 245))
  )))) (list
      `("insert-sort" ,insert-sort)
      `("select-sort" ,select-sort)
      `("merge-sort" ,merge-sort)
  ))

)
