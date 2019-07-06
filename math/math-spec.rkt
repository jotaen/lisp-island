#lang racket

(include "math.scm")
(require rackunit)

;;; `abs`
(check-equal? (abs -182) 182)
(check-equal? (abs -1) 1)
(check-equal? (abs 0) 0)
(check-equal? (abs 1) 1)
(check-equal? (abs 184) 184)

;;; `diff`
(check-equal? (diff 1 2) 1)
(check-equal? (diff 2 1) 1)
(check-equal? (diff -5 -7) 2)
(check-equal? (diff -9 3) 12)
(check-equal? (diff 0 5) 5)
(check-equal? (diff 1726 0) 1726)

;;; `average`
(check-equal? (average 2 0) 1)
(check-equal? (average 13 1) 7)
(check-equal? (average 1 14) 15/2)
(check-equal? (average 4 -4) 0)

;;; `sqrt`
; Computed values are within required precision
(define PREC 0.0001)

(check-within (sqrt 0) 0 PREC)
(check-within (sqrt 1) 1 PREC)
(check-within (sqrt 2) 1.4142 PREC)
(check-within (sqrt 9) 3 PREC)
(check-within (sqrt 16) 4 PREC)
(check-within (sqrt 25) 5 PREC)
(check-within (sqrt 100) 10 PREC)
(check-within (sqrt 100001) 316.2293471 PREC)

; Negative values are not allowed"
(check-equal? (sqrt -1) #f)

;;; `factorial`
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

;;; `fibonacci`
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

;;; `binomial-coefficients`
(check-equal? (binomial-coefficients 1) '(1))
(check-equal? (binomial-coefficients 2) '(1 1))
(check-equal? (binomial-coefficients 3) '(1 2 1))
(check-equal? (binomial-coefficients 4) '(1 3 3 1))
(check-equal? (binomial-coefficients 5) '(1 4 6 4 1))
(check-equal? (binomial-coefficients 6) '(1 5 10 10 5 1))
