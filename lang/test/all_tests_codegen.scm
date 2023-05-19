(print 'PRINT)
(print 5)
(print 'phrase)
(print #t)
(print 0.45)

(print 'GL_OPERATIONS)
(gl-init)
(gl-clear)
(print (gl-is-open))
(gl-put-pixel 10 10 1 1 1)
(gl-draw)
(gl-finish)

(print 'MATH)
(print (* 5 6 7))
(print (+ 1 (+ 3 4 5)))
(print (- 5 2))
(print (- 5 1 2))
(print (/ 4 2))
(print (/ 4 2 2))
(print (/ 4 2 0))
(print (/ 0 2))
(print (mod 5 3))
(print (mod 5 0))
(print (mod 6 4))

(print 'COMPARISONS)
(print (> 9 8 7 6 5 4 3 2 0.1))
(print (< 1 3 4))
(print (= 3 3 3 3))
(print (>= 4 4 3 3))
(print (<= 2 2 5 6 6))

(print 'EXTERNAL_MATH)
(print (expt 5 2))
(print (sqrt 25))
(print (sqrt 2))

(print 'LIST)
(print (list 1 2 3 (list 3 4 'SAMPLE)))

(print 'CONTROL_FLOW)
(if #t
    (print 'TRUE1)
    (print 'FALSE1)
)
(print 'AFTER1)

(if #t
    (print 'TRUE2)
)
(print 'AFTER2)

(if #f
    (print 'TRUE3)
    (print 'FALSE3)
)
(print 'AFTER3)

(if #f
    (print 'TRUE4)
)
(print 'AFTER4)

(print 'DEFINE_VARIABLE)
(define x 5)
(set! x (- x 1))
(print x)

(print 'BEGIN)
(define y 7)
(begin
    (print y)
    (set! y (- y 1))
    (print y)
)
(print y)

(print 'WHILE)
(define x 0)
(while (< x 5)
    (set! x (+ 1 x))
)

(print 'LAMBDA_IN_PLACE_CALL)
(print ((lambda (x) (+ 1 x)) 5))

(print 'LAMBDA_CLOSURE)
(define x 2)
((lambda (x) (print x)) 10)
((lambda (x) (print (+ x 1))) 10)
(print x)

(print 'DEFINE_LAMBDA)
(define new-print (lambda (x) (print (+ x 1))))
(new-print 7)

(print 'SET_VARIABLE)
(define x 5)
(print x)
(set! x 1)
(print x)

(print 'WHILE)
(define x 5)
(while (>= x 0)
    (begin
        (print x)
        (set! x (- x 1))
    )
)

(print 'SLOW_ADD)
(define slow-add 
    (lambda (x y)
        (if (= x 0) 
            y 
            (slow-add (- x 1) (+ y 1))
        )
    )
)
(define a (slow-add 3 3))
(print a)
(print (+ a 1))

(gl-init)
(while (gl-is-open)
    (begin
        (gl-clear)

        (define i 0)
        (while (and (< i 100) (gl-is-open))
            (begin
                (define j 0)
                (while (and (< j 100) (gl-is-open))
                    (begin
                        (if (= (mod j 1) 0)
                            (gl-draw)
                        )

                        (gl-put-pixel i j 255 255 255)
                        (set! j (+ j 1))
                    )
                )
                (set! i (+ i 1))
            )
        )
        (gl-draw)
    )
)
(gl-finish)

(print 'AND)
(print (and))
(print (and (= 2 2) (> 2 1)))
(print (and #t #f))
(print (and (= 2 2) (< 2 1)))
(print (and 3 (= 2 2) 4))

(print 'OR)
(print (or))
(print (or (= 2 2) (> 2 1)))
(print (or #f (< 2 1)))
(print (or #f 1))

(print 'BOOLEAN?)
(print (boolean? #t))
(print (boolean? #f))
(print (boolean? 1))

(print 'SYMBOL?)
(print (symbol? 'x))
(print (symbol? 1))

(print 'NUMBER?)
(print (number? -1))
(print (number? 1))
(print (number? #t))

(define lst (list 1 2 3))

(print 'CONS)
(print (cons 1 2))

(print 'NULL)
(print (null? (car lst)))
(print (null? (cdr lst)))

(print (null? (car (cdr lst))))
(print (null? (cdr (cdr lst))))

(print (null? (car (cdr (cdr lst)))))
(print (null? (cdr (cdr (cdr lst)))))

(print 'LAMBDA_SUGAR)
(define inc-long (lambda (x) (+ x 1)))
(print (inc-long -1))

(define (inc-short x) (+ x 1))
(print (inc-short -1))

(define (add x y) (+ x y 1))
(print (add 10 10))

(print 'MIN_MAX)
(print (min 5 3))
(print (max 5 3 6 4))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; MAJOR PROBLEM THERE ;;;
; returning list created in lambda's scope
; list parts are lost when print

; (define vec3
;     (lambda (x y z)
;         (print x)
;         (print z)
;         ; (list x y z)
;         (list x y z)
;     )
; )
; (define my-vec (vec3 3 4 0))
; (print 'RESULT)
; (print my-vec)