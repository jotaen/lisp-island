#lang racket

(require
  rackunit
  rackunit/text-ui
  "src/math-spec.rkt"
  "src/sort-spec.rkt"
  "src/list-spec.rkt")

(define-test-suite all-tests
  "Lisp Exercises Tests"
  math-spec
  sort-spec
  list-spec)

(run-tests all-tests)
