(load "src/sort.scm")

(testcase* "sorting" 

  (map (lambda (p) (let ((name (first p)) (f (second p)))
      (testcase name (list
          (assert equal? (f '()) '())
          (assert equal? (f '(0)) '(0))
          (assert equal? (f '(0 1)) '(0 1))
          (assert equal? (f '(1 1 1)) '(1 1 1))
          (assert equal? (f '(1 3 3 1)) '(1 1 3 3))
          (assert equal? (f '(1 2 3 4 5)) '(1 2 3 4 5))
          (assert equal? (f '(5 4 3 2 1)) '(1 2 3 4 5))
          (assert equal? (f '(4 2 1 3 5)) '(1 2 3 4 5))
          (assert equal? (f '(12 1 19 100 31 0 -182)) '(-182 0 1 12 19 31 100))
          (assert equal? (f '(-91 100 1 50 -512 13 -40 245)) '(-512 -91 -40 1 13 50 100 245))
  )))) (list
      `("insert-sort" ,insert-sort)
      `("bubble-sort" ,bubble-sort)
      `("merge-sort" ,merge-sort)
      `("quick-sort" ,quick-sort)
  ))

)
