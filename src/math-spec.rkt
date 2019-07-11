#lang racket

(include "math.scm")
(require rackunit)

(define PREC 0.0001)

(define/provide-test-suite math-spec

  (test-case "abs"
    (check-equal? (abs -182) 182)
    (check-equal? (abs -1) 1)
    (check-equal? (abs 0) 0)
    (check-equal? (abs 1) 1)
    (check-equal? (abs 184) 184)
  )

  (test-case "diff"
    (check-equal? (diff 1 2) 1)
    (check-equal? (diff 2 1) 1)
    (check-equal? (diff -5 -7) 2)
    (check-equal? (diff -9 3) 12)
    (check-equal? (diff 9 -3) 12)
    (check-equal? (diff 0 5) 5)
    (check-equal? (diff 1726 0) 1726)
  )

  (test-case "average"
    (check-equal? (average 2 0) 1)
    (check-equal? (average 13 1) 7)
    (check-equal? (average 1 14) 15/2)
    (check-equal? (average 4 -4) 0)
  )

  (test-case "sqrt"
    (check-within (sqrt 0) 0 PREC)
    (check-within (sqrt 1) 1 PREC)
    (check-within (sqrt 2) 1.4142 PREC)
    (check-within (sqrt 9) 3 PREC)
    (check-within (sqrt 16) 4 PREC)
    (check-within (sqrt 25) 5 PREC)
    (check-within (sqrt 100) 10 PREC)
    (check-within (sqrt 100001) 316.2293471 PREC)
  )

  (test-case "factorial"
    (check-equal? (factorial -5) -120)
    (check-equal? (factorial -4) -24)
    (check-equal? (factorial -3) -6)
    (check-equal? (factorial -2) -2)
    (check-equal? (factorial -1) -1)
    (check-equal? (factorial 0) 1)
    (check-equal? (factorial 1) 1)
    (check-equal? (factorial 2) 2)
    (check-equal? (factorial 3) 6)
    (check-equal? (factorial 4) 24)
    (check-equal? (factorial 5) 120)
    (check-equal? (factorial 14) 87178291200)
  )

  (test-case "fibonacci"
    (check-equal? (fibonacci 0) 0)
    (check-equal? (fibonacci 1) 1)
    (check-equal? (fibonacci 2) 1)
    (check-equal? (fibonacci 3) 2)
    (check-equal? (fibonacci 4) 3)
    (check-equal? (fibonacci 5) 5)
    (check-equal? (fibonacci 6) 8)
    (check-equal? (fibonacci 7) 13)
    (check-equal? (fibonacci 8) 21)
    (check-equal? (fibonacci 50) 12586269025)
  )

  (test-case "binomial-coefficients"
    (check-equal? (binomial-coefficients 1) '(1))
    (check-equal? (binomial-coefficients 2) '(1 1))
    (check-equal? (binomial-coefficients 3) '(1 2 1))
    (check-equal? (binomial-coefficients 4) '(1 3 3 1))
    (check-equal? (binomial-coefficients 5) '(1 4 6 4 1))
    (check-equal? (binomial-coefficients 6) '(1 5 10 10 5 1))
  )

  (test-case "sin"
    (check-within (sin 0) 0 PREC)
    (check-within (sin (/ pi 6)) 0.5 PREC)
    (check-within (sin (/ pi 2)) 1 PREC)
    (check-within (sin pi) 0 PREC)
    (check-within (sin (* pi 1.5)) -1 PREC)
    (check-within (sin (* pi 10)) 0 PREC)
  )

  (test-case "identity"
    (check-equal? (identity 1) 1)
    (check-equal? (identity '()) '())
    (check-equal? (identity '(2)) '(2))
  )

  (test-case "reciprocal"
    (check-equal? (reciprocal 1) 1/1)
    (check-equal? (reciprocal 5) 1/5)
    (check-equal? (reciprocal -5) -1/5)
  )

  (test-case "power"
    (check-equal? (power 0 1) 0)
    (check-equal? (power 0 2) 0)
    (check-equal? (power 1 1) 1)
    (check-equal? (power 1 2) 1)
    (check-equal? (power 3 -3) 1/27)
    (check-equal? (power 3 -2) 1/9)
    (check-equal? (power 3 -1) 1/3)
    (check-equal? (power 3 0) 1)
    (check-equal? (power 3 1) 3)
    (check-equal? (power 3 2) 9)
    (check-equal? (power 3 3) 27)
    (check-equal? (power 3 4) 81)
    (check-equal? (power 475 12) 131923849527010977268218994140625)
    (check-equal? (power 475 13) 62663828525330214202404022216796875)
    (check-equal? (power 476 12) 135295525131890643183257125912576)
    (check-equal? (power 476 13) 64400669962779946155230391934386176)
  )

)
