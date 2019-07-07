#lang racket

(include "list.scm")
(require rackunit)

(define/provide-test-suite list-spec

  (test-case "empty?"
    (check-equal? (empty? '()) #t)
    (check-equal? (empty? '(1)) #f)
    (check-equal? (empty? '(1 2 3)) #f)
  )

)
