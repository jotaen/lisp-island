#lang racket

(include "math.scm")
(require rackunit)

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

