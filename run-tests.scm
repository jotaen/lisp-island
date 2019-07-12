(load '("lib/scmunit.scm"
        "src/math-spec.scm"
        "src/sort-spec.scm"
        "src/list-spec.scm"))

(display (scmunit-run*))
(exit)
