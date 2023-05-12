;;; RANDOM NUMER GENERATOR ;;;

;;;;; old-style random, now deprecated because of nested lambda calls
;;;;; it allows to create multiple random number generators, which is not
;;;;; a necessary feature by now
;; generator
; (define random-generator
;     (lambda (seed)
;         (begin
;             (define (rng)
;                 (begin
;                     (set! seed (mod (+ (* 16807 seed) 0) 2147483647))
;                     (define ans (quotient seed 2147483647))
;                     (set! seed (mod seed 2147483647))
;                     ans
;                 )
;             )
;             rng
;         )
;     )
; )

; ;; generator with fixed seed
; (define random
;     (random-generator 61616161) ;; Seed the random number generator
; )

;;;;; new-style random
;;;;; creating only one random number generator with given seed
(define seed 61616161)

(define random
  (lambda ()
    (set! seed (mod (+ (* 16807 seed) 0) 2147483647))
    (define ans (quotient seed 2147483647))
    (set! seed (mod seed 2147483647))
    ans
  )
)
