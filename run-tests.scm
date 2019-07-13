(load '("lib/scmunit/scmunit.scm"
        "src/math-spec.scm"
        "src/sort-spec.scm"
        "src/list-spec.scm"))

(scmunit-run*)
