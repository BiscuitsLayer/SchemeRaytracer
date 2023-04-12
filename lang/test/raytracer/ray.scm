;;; RAY CLASS ;;;

;; constructor
(define (ray origin direction) (list origin direction))

;; origin
(define (ray-origin r) (car r))

;; direction
(define (ray-direction r) (car (cdr r)))

;; point on a ray (from given parameter value)
(define (ray-point r t) (vec-add (ray-origin r) (vec-mul (ray-direction r) t)))