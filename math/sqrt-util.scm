;;; SQUARE-ROOT

; Newton approximation algorithm:
; x/G   = Q,      (Q+G)/2 = A
;
; e.g.:
; x/1   = 2,      (2+1)/2 = 1.5
; x/1.5 = 1.3333, (1.3333+1.5)/2 = 1.41665
; ...

(define (sqrt-approx x guess)
  (average (/ x guess) guess)
)

(define (precise-enough? x1 x2 precision)
  (< (diff x1 x2) precision)
)

(define (sqrt-iter x guess previous-guess precision)
  (if (precise-enough? previous-guess guess precision)
      guess
      (sqrt-iter x (sqrt-approx x guess) guess precision)
   )
)

(define (sqrt-newton x precision) (sqrt-iter x 1.0 0.0 precision))
