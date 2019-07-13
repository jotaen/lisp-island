# scmunit: unit testing for Scheme

scmunit is a lightweight test runner and assertion library written in MIT Scheme (R7RS).

## Example

```scheme
(load "scmunit.scm")

(define (increment x) (+ x 1))

(test-group* "increment" (list
    (check eq? (increment 0) 1)
    (check eq? (increment 12) 13)
))

(scmunit-run*)
```

## Reference

### `(check predicate expression [arguments])`

Executes `expression` and passes its return value to `predicate`, along with every `argument` (if there is any). The check is considered successful if `predicate` returns `#t`.

### `(test-group name [items])`

Container for grouping checks and/or other groups, that are provided as list. Can be nested arbitrarily deep. `name` is a string to identify the group in the test output.

### `(test-group* ...)`

Same as `(test-group ...)`, but it automatically registers the test group with all its content, so that it gets picked up by the test runner. Supposed to be used for standalone groups at top-level.

### `(scmunit-run*)`

Runs all test groups that had been registered via `(test-group* ...)`, displays the result and exits the program with status `0` or `1` (depending on whether there were failed tests).

### `(scmunit-run [groups] callback)`

Runs all test groups that are passed in and invokes a callback of form `(lambda (text-output status-code) (...))`.

## FAQ

### How can I declare local variables or functions in a test group?

Provide the list of test items by means of a `let` block:

```scheme
(test-group "magic computation" (let ((MAGIC 42))
    (define (square x) (* x x))
    (list
        (check eq? (square MAGIC) 1764)
)))
```

### Can test groups be nested?

Yes, arbitrarily deep:

```scheme
(test-group "foo" (list
    (test-group "bar" (list
        (test-group "baz" (list
            ; ...
        ))
    ))
))
```
