;;; SPHERE CLASS ;;;

;; constructor
(define (sphere center radius color type)
    (list center radius color type)
)

;; center
(define (sphere-center s)
    (car s)
)

;; radius
(define (sphere-radius s)
    (car (cdr s))
)

;; base color
(define (sphere-color s)
    (car (cdr (cdr s)))
)

;; material type
(define (sphere-type s)
    (car (cdr (cdr (cdr s))))
)

;; return value < 0 <- no intersection
;; return value >= 0 <- length to intersection point
(define intersect 
    (lambda (s r)
        (define otos (vec-sub (sphere-center s) (ray-origin r)))
        (define rT (vec-dot otos (ray-direction r)))
        (define l (- (expt (sphere-radius s) 2) (- (vec-dot otos otos) (* rT rT))))
        (if (< l 0)
            -1
            ;; begin <=> creating lambda and immediately applying it
            (begin
                ;; compute the least length value
                (define t_min (- rT (sqrt l)))
                (if (< t_min 0)
                    ;; one more attempt if it turned out to be negative
                    (define t_min (+ rT (sqrt l)))
                    ;; if the value is still negative, return it anyway
                )
                t_min
            )
        )
    )
)