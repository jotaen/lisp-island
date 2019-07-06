#lang racket

(include "math/math.scm")
(require rackunit)

(define PREC 0.0001)

(check-within (sqrt 0) 0 PREC)
(check-within (sqrt 1) 1 PREC)
(check-within (sqrt 2) 1.4142 PREC)
(check-within (sqrt 9) 3 PREC)
(check-within (sqrt 16) 4 PREC)
(check-within (sqrt 25) 5 PREC)
(check-within (sqrt 100) 10 PREC)
(check-within (sqrt 100001) 316.2293471 PREC)

(check-equal? (sqrt -1) #f)
