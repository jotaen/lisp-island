(load '("../scmunit/scmunit.scm"
        "src/math-spec.scm"
        "src/list-spec.scm"
        "src/misc-spec.scm"
        "src/sort-spec.scm"))

(scmunit-run*)
