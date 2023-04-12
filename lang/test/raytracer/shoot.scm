;;; SHOOTING ;;;

;; returns a pair of the closest object and the distance to it
(define (intersect-list objects r)
    (if (null? objects)
        (list -1 (expt 2 16)) ;; return -1 object and max distance
    
        ;; compute closest in rest of list
        (begin
            (define closest (intersect-list (cdr objects) r))
            ;; get distance to first closest object
            (define dist (intersect (car objects) r))
            ;; if dist is less than already found in closest
            (if (> (car (cdr closest)) dist)
                ;; if we get no intersection (-1) or too close (small distance)
                (if (< dist 0.00001)
                    closest ;; return closest of rest of list
                    (list (car objects) dist) ;; otherwise new found closest
                )
                closest
            )
        )
    )
)

(define (shoot r objects depth color)
    (if (= depth 3) ;; if we reach maximum allowed recusion depth
        (vec3 1 1 1) ;; return background
        (begin
            (define closest (intersect-list objects r))
            (if (and (number? (car closest)) (= (car closest) -1))
                (vec3 1 1 1) ;; if no hit return background color
                (sphere-color (car closest))
                ;; ray tracing different materials (not used in current version)
                ; (begin
                ;     (define impact (vec-add (vec-mul (ray-direction r) (car (cdr closest))) (ray-origin r)))
                ;     (define normal (vec-unit (vec-sub impact (sphere-center (car closest)))))
                ;     (define refRay (ray impact (vec-sub (ray-direction r) 
                ;                                         (vec-mul normal (* 2 (vec-dot (ray-direction r) normal))))))
                ;     (if (= (sphere-type (car closest)) 0) ;; diffuse
                ;         (begin
                ;             (define target (vec-add normal (random-in-unit-sphere)))
                ;             (shoot (ray impact (vec-unit target))
                ;                     objects
                ;                     (+ depth 1)
                ;                     (vec-mul color (sphere-color (car closest))))
                ;         )
                ;         (if (= (sphere-type (car closest)) 1) ;; mirror
                ;             (shoot refRay objects (+ depth 1) (vec-mul color (sphere-color (car closest))))
                ;             (vec-mul color (sphere-color (car closest)))
                ;         )
                ;     ) ;; nor diffuse, nor mirror, => emissive
                ; )
            )
        )
    )
)