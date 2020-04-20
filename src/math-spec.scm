(load "src/math.scm")

(testcase* "math" (let ((PREC 0.0001)) (list

  (testcase "abs" (list
    (assert eq? (abs -182) 182)
    (assert eq? (abs -1) 1)
    (assert eq? (abs 0) 0)
    (assert eq? (abs 1) 1)
    (assert eq? (abs 184) 184)
  ))

  (testcase "diff" (list
    (assert eq? (diff 1 2) 1)
    (assert eq? (diff 2 1) 1)
    (assert eq? (diff -5 -7) 2)
    (assert eq? (diff -9 3) 12)
    (assert eq? (diff 9 -3) 12)
    (assert eq? (diff 0 5) 5)
    (assert eq? (diff 1726 0) 1726)
  ))

  (testcase "within?" (list
    (assert true? (within? 2 1 1))
    (assert true? (within? 2 2 1))
    (assert false? (within? 2 0 1))
    (assert false? (within? 2 -2 1))
  ))

  (testcase "average" (list
    (assert eq? (average 2 0) 1)
    (assert eq? (average 13 1) 7)
    (assert equal? (average 1 14) 15/2)
    (assert eq? (average 4 -4) 0)
  ))

  (testcase "sqrt" (list
    (assert within? (sqrt 0) 0 PREC)
    (assert within? (sqrt 1) 1 PREC)
    (assert within? (sqrt 2) 1.4142 PREC)
    (assert within? (sqrt 9) 3 PREC)
    (assert within? (sqrt 16) 4 PREC)
    (assert within? (sqrt 25) 5 PREC)
    (assert within? (sqrt 100) 10 PREC)
    (assert within? (sqrt 100001) 316.2293471 PREC)
  ))

  (testcase "factorial" (list
    (assert eq? (factorial -5) -120)
    (assert eq? (factorial -4) -24)
    (assert eq? (factorial -3) -6)
    (assert eq? (factorial -2) -2)
    (assert eq? (factorial -1) -1)
    (assert eq? (factorial 0) 1)
    (assert eq? (factorial 1) 1)
    (assert eq? (factorial 2) 2)
    (assert eq? (factorial 3) 6)
    (assert eq? (factorial 4) 24)
    (assert eq? (factorial 5) 120)
    (assert eq? (factorial 14) 87178291200)
  ))

  (testcase "fibonacci" (list
    (assert eq? (fibonacci 0) 0)
    (assert eq? (fibonacci 1) 1)
    (assert eq? (fibonacci 2) 1)
    (assert eq? (fibonacci 3) 2)
    (assert eq? (fibonacci 4) 3)
    (assert eq? (fibonacci 5) 5)
    (assert eq? (fibonacci 6) 8)
    (assert eq? (fibonacci 7) 13)
    (assert eq? (fibonacci 8) 21)
    (assert eq? (fibonacci 50) 12586269025)
  ))

  (testcase "binomial-coefficients" (list
    (assert equal? (binomial-coefficients 1) '(1))
    (assert equal? (binomial-coefficients 2) '(1 1))
    (assert equal? (binomial-coefficients 3) '(1 2 1))
    (assert equal? (binomial-coefficients 4) '(1 3 3 1))
    (assert equal? (binomial-coefficients 5) '(1 4 6 4 1))
    (assert equal? (binomial-coefficients 6) '(1 5 10 10 5 1))
  ))

  (testcase "sin" (list
    (assert within? (sin 0) 0 PREC)
    (assert within? (sin (/ pi 6)) 0.5 PREC)
    (assert within? (sin (/ pi 2)) 1 PREC)
    (assert within? (sin pi) 0 PREC)
    (assert within? (sin (* pi 1.5)) -1 PREC)
    (assert within? (sin (* pi 10)) 0 PREC)
  ))

  (testcase "identity" (list
    (assert eq? (identity 1) 1)
    (assert equal? (identity '()) '())
    (assert equal? (identity '(2)) '(2))
  ))

  (testcase "reciprocal" (list
    (assert equal? (reciprocal 1) 1/1)
    (assert equal? (reciprocal 5) 1/5)
    (assert equal? (reciprocal -5) -1/5)
  ))

  (testcase "power" (list
    (assert eq? (power 0 1) 0)
    (assert eq? (power 0 2) 0)
    (assert eq? (power 1 1) 1)
    (assert eq? (power 1 2) 1)
    (assert equal? (power 3 -3) 1/27)
    (assert equal? (power 3 -2) 1/9)
    (assert equal? (power 3 -1) 1/3)
    (assert eq? (power 3 0) 1)
    (assert eq? (power 3 1) 3)
    (assert eq? (power 3 2) 9)
    (assert eq? (power 3 3) 27)
    (assert eq? (power 3 4) 81)
    (assert equal? (power 475 12) 131923849527010977268218994140625)
    (assert equal? (power 475 13) 62663828525330214202404022216796875)
    (assert equal? (power 476 12) 135295525131890643183257125912576)
    (assert equal? (power 476 13) 64400669962779946155230391934386176)
  ))

)))
