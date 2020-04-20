(load "src/misc.scm")

(testcase* "misc" (list
  
  (testcase "true?" (list
    (assert eq? (true? #t) #t)
    (assert eq? (true? '(1)) #t)
    (assert eq? (true? ()) #t)
    (assert eq? (true? "") #t)
    (assert eq? (true? 1) #t)
    (assert eq? (true? #f) #f)
  ))

  (testcase "identity" (list
    (assert eq? (identity ()) ())
    (assert eq? (identity 'a) 'a)
    (assert eq? (identity 1736322) 1736322)
    (assert eq? (identity #t) #t)
  ))

))
