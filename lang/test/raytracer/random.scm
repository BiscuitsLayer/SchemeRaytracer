;;; RANDOM NUMER GENERATOR ;;;

;; generator
(define random-generator
    (lambda (seed)
        (begin
            (define (rng)
                (begin
                    (set! seed (mod (+ (* 16807 seed) 0) 2147483647))
                    (define ans (quotient seed 2147483647))
                    (set! seed (mod seed 2147483647))
                    ans
                )
            )
            rng
        )
    )
)

;; generator with fixed seed
(define random
    (random-generator 61616161) ;; Seed the random number generator
)