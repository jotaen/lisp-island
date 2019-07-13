(load "src/misc.scm")

(test-group* "misc" (list
  
  (test-group "true?" (list
    (check eq? (true? #t) #t)
    (check eq? (true? '(1)) #t)
    (check eq? (true? ()) #t)
    (check eq? (true? "") #t)
    (check eq? (true? 1) #t)
    (check eq? (true? #f) #f)
  ))

  (test-group "identity" (list
    (check eq? (identity ()) ())
    (check eq? (identity 'a) 'a)
    (check eq? (identity 1736322) 1736322)
    (check eq? (identity #t) #t)
  ))

))
