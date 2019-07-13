(load "src/math.scm")

(test-group* "math" (let ((PREC 0.0001)) (list

  (test-group "abs" (list
    (check eq? (abs -182) 182)
    (check eq? (abs -1) 1)
    (check eq? (abs 0) 0)
    (check eq? (abs 1) 1)
    (check eq? (abs 184) 184)
  ))

  (test-group "diff" (list
    (check eq? (diff 1 2) 1)
    (check eq? (diff 2 1) 1)
    (check eq? (diff -5 -7) 2)
    (check eq? (diff -9 3) 12)
    (check eq? (diff 9 -3) 12)
    (check eq? (diff 0 5) 5)
    (check eq? (diff 1726 0) 1726)
  ))

  (test-group "within?" (list
    (check true? (within? 2 1 1))
    (check true? (within? 2 2 1))
    (check false? (within? 2 0 1))
    (check false? (within? 2 -2 1))
  ))

  (test-group "average" (list
    (check eq? (average 2 0) 1)
    (check eq? (average 13 1) 7)
    (check equal? (average 1 14) 15/2)
    (check eq? (average 4 -4) 0)
  ))

  (test-group "sqrt" (list
    (check within? (sqrt 0) 0 PREC)
    (check within? (sqrt 1) 1 PREC)
    (check within? (sqrt 2) 1.4142 PREC)
    (check within? (sqrt 9) 3 PREC)
    (check within? (sqrt 16) 4 PREC)
    (check within? (sqrt 25) 5 PREC)
    (check within? (sqrt 100) 10 PREC)
    (check within? (sqrt 100001) 316.2293471 PREC)
  ))

  (test-group "factorial" (list
    (check eq? (factorial -5) -120)
    (check eq? (factorial -4) -24)
    (check eq? (factorial -3) -6)
    (check eq? (factorial -2) -2)
    (check eq? (factorial -1) -1)
    (check eq? (factorial 0) 1)
    (check eq? (factorial 1) 1)
    (check eq? (factorial 2) 2)
    (check eq? (factorial 3) 6)
    (check eq? (factorial 4) 24)
    (check eq? (factorial 5) 120)
    (check eq? (factorial 14) 87178291200)
  ))

  (test-group "fibonacci" (list
    (check eq? (fibonacci 0) 0)
    (check eq? (fibonacci 1) 1)
    (check eq? (fibonacci 2) 1)
    (check eq? (fibonacci 3) 2)
    (check eq? (fibonacci 4) 3)
    (check eq? (fibonacci 5) 5)
    (check eq? (fibonacci 6) 8)
    (check eq? (fibonacci 7) 13)
    (check eq? (fibonacci 8) 21)
    (check eq? (fibonacci 50) 12586269025)
  ))

  (test-group "binomial-coefficients" (list
    (check equal? (binomial-coefficients 1) '(1))
    (check equal? (binomial-coefficients 2) '(1 1))
    (check equal? (binomial-coefficients 3) '(1 2 1))
    (check equal? (binomial-coefficients 4) '(1 3 3 1))
    (check equal? (binomial-coefficients 5) '(1 4 6 4 1))
    (check equal? (binomial-coefficients 6) '(1 5 10 10 5 1))
  ))

  (test-group "sin" (list
    (check within? (sin 0) 0 PREC)
    (check within? (sin (/ pi 6)) 0.5 PREC)
    (check within? (sin (/ pi 2)) 1 PREC)
    (check within? (sin pi) 0 PREC)
    (check within? (sin (* pi 1.5)) -1 PREC)
    (check within? (sin (* pi 10)) 0 PREC)
  ))

  (test-group "identity" (list
    (check eq? (identity 1) 1)
    (check equal? (identity '()) '())
    (check equal? (identity '(2)) '(2))
  ))

  (test-group "reciprocal" (list
    (check equal? (reciprocal 1) 1/1)
    (check equal? (reciprocal 5) 1/5)
    (check equal? (reciprocal -5) -1/5)
  ))

  (test-group "power" (list
    (check eq? (power 0 1) 0)
    (check eq? (power 0 2) 0)
    (check eq? (power 1 1) 1)
    (check eq? (power 1 2) 1)
    (check equal? (power 3 -3) 1/27)
    (check equal? (power 3 -2) 1/9)
    (check equal? (power 3 -1) 1/3)
    (check eq? (power 3 0) 1)
    (check eq? (power 3 1) 3)
    (check eq? (power 3 2) 9)
    (check eq? (power 3 3) 27)
    (check eq? (power 3 4) 81)
    (check equal? (power 475 12) 131923849527010977268218994140625)
    (check equal? (power 475 13) 62663828525330214202404022216796875)
    (check equal? (power 476 12) 135295525131890643183257125912576)
    (check equal? (power 476 13) 64400669962779946155230391934386176)
  ))

)))
