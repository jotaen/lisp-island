#lang racket

(require
  rackunit
  rackunit/text-ui
  "src/math-spec.rkt")

(define-test-suite all-tests
  "Lisp Exercises Tests"
  math-spec)

(run-tests all-tests)
