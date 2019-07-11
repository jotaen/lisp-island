#lang racket

(include "list.scm")
(require rackunit)

(define/provide-test-suite list-spec

  (test-case "empty?"
    (check-equal? (empty? '()) #t)
    (check-equal? (empty? '(1)) #f)
    (check-equal? (empty? '(1 2 3)) #f)
  )

  (test-case "compose"
    (define (plus4 x) (+ x 4))
    (define (times6 x) (* x 6))
    (define (minus2 x) (- x 2))
    (check-equal? ((compose identity) 'a) 'a)
    (check-equal? ((compose identity identity identity) 'a) 'a)
    (check-equal? ((compose plus4 times6 minus2) 3) 10)
    (check-equal? ((compose minus2 times6 plus4) 3) 40)
  )

)
