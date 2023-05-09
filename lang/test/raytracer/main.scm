;;; MAIN RAY TRACER ;;;

(load 'random.scm)
(load 'geom.scm)
(load 'ray.scm)
(load 'sphere.scm)
(load 'shoot.scm)

;; generate random direction in sphere
(define random-in-unit-sphere
    (lambda ()
        (define v (vec-sub (vec-mul (vec3 (random) (random) (random)) 2) 1))
        (if (< (vec-len v) 1.0)
            v
            (random-in-unit-sphere)
        )
    )
)

(define (min a b)
    (if (< a b) a b)
)

;; color adjustment (gamma correction)
(define (color-adj color)
    (vec3
        (expt (min (vec-x color) 1) 0.5)
        (expt (min (vec-y color) 1) 0.5)
        (expt (min (vec-z color) 1) 0.5)
    )
)

;; viewport parameters
(define width 100)
(define height 100)

;; type 0: diffuse
;; type 1: mirror
;; type 2: emitter
(define spheres '())
;; red sphere
(define spheres (cons (sphere (vec3 0 0 20) 20 (vec3 1 0 0) 0) spheres))
;; green sphere, intersecting with red
(define spheres (cons (sphere (vec3 20 -10 10) 3 (vec3 0 1 0) 0) spheres))

;; walls
; (define spheres (cons (sphere (vec3 0 0 10000) 9900 (vec3 0.9 0.9 0.9) 0) spheres))
; (define spheres (cons (sphere (vec3 0 10000 0) 9900 (vec3 0.9 0.9 0.9) 0) spheres))
; (define spheres (cons (sphere (vec3 0 -10000 0) 9900 (vec3 0.9 0.9 0.9) 0) spheres))
; (define spheres (cons (sphere (vec3 10000 0 0) 9885 (vec3 0.984 0.504 0.007) 0) spheres))
; (define spheres (cons (sphere (vec3 -10000 0 0) 9885 (vec3 0 0.02 0.147) 0) spheres))

;; scene geometry
; (define spheres (cons (sphere (vec3 -45 -50 20) 50 (vec3 1 1 1) 1) spheres))
; (define spheres (cons (sphere (vec3 50 -50 -20) 40 (vec3 1 0 0) 0) spheres))
; (define spheres (cons (sphere (vec3 -15 -80 -60) 20 (vec3 0.053 0.244 0.398) 0) spheres))
; (define spheres (cons (sphere (vec3 0 1099.2 -20) 1000 (vec3 10 10 10) 2) spheres))

;; camera parameters
(define cam-pos (vec3 0 0 -440))
(define fov 60) ;; width angle
(define fov (* fov (/ 3.14159265 180))) ;; convert to rad
(define ratio (/ height width))
(define xtan 0.577350269) 
(define ytan (* xtan ratio))

;; almost no difference with given scene (red and green spheres) if value is greater than 1
(define num-samples 1)

;; generate ray + trace
(define (draw-pixel x y)
    (begin
        ;; sample gives the result of several rays averaged
        ;; arguments: sample ordering number and sample accumemulated value
        (define (sample i vec)
            (if (= i num-samples)
                vec
                (begin
                    ;; pixel center (add -0.5) and small random adjustment (between 0.0 and 1.0)
                    (define vx (* (/ (+ x -0.5 (random) (* -0.5 width)) width) xtan))
                    (define vy (* (/ (- (* 0.5 height) (+ y -0.5 (random))) height) ytan))

                    ;; generate ray with given direction and normalize
                    (define v (vec3 vx vy 1))
                    (define v (vec-unit v))
                    (define r (ray cam-pos v))

                    ;; answer - accumulated samples
                    (sample (+ i 1) (vec-add vec (shoot r spheres 0 (vec3 1 1 1)))) ;; shoot ray
                )
            )
        )

        ;; compute average sampled value
        (define sampled (vec-mul (sample 0 (vec3 0 0 0)) (/ 1 num-samples)))

        ; (print sampled)
        (define sampled (color-adj sampled))
        (set! sampled (vec-mul sampled 255))

        ;; draw in OpenGL
        (gl-put-pixel x y (vec-x sampled) (vec-y sampled) (vec-z sampled))

        ;; done
        ; (print 'OK)
    )
)

;; draw every n-th frame
(define should-draw 0)

;; RNG generates number from 0 to 1 with
;; given precision (digits after dot)
; (define PRECISION 100) 

(gl-init)
(while (gl-is-open)
    (begin
        (gl-clear)

        (define x (mod (* (random) PRECISION) width))
        (define y (mod (* (random) PRECISION) height))

        (draw-pixel x y)

        (if (= (mod should-draw 10) 0)
            (gl-draw)
        )
        (set! should-draw (+ should-draw 1))
    )
)
(gl-finish)

;; Legacy: iterate over all pixels, not randomly
; (gl-init)
; (while (gl-is-open)
;     (begin
;         (gl-clear)

;         (define i 0)
;         (while (and (< i 100) (gl-is-open))
;             (begin
;                 (define j 0)
;                 (while (and (< j 100) (gl-is-open))
;                     (begin
;                         (if (= (mod j 5) 0)
;                             (gl-draw)
;                         )

;                         (draw-pixel i j)
;                         (set! j (+ j 1))
;                     )
;                 )
;                 (set! i (+ i 1))
;             )
;         )
;         (gl-draw)
;     )
; )
; (gl-finish)