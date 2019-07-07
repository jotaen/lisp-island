#lang racket

(require
  rackunit
  rackunit/text-ui
  "math/math-spec.rkt")

(define-test-suite all-tests
  "Lisp Exercises Tests"
  math-spec)

(run-tests all-tests)
