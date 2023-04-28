; (print 5)
; (print 'phrase)
; (print #t)

; (gl-init)
; (gl-clear)
; (print (gl-is-open))
; (gl-put-pixel 10 10 1 1 1)
; (gl-draw)
; (gl-finish)

; (print #f)
; (print 0.45)

; (print (* 5 6 7))
; (print (+ 1 (+ 3 4 5)))

; (print (list 1 2 3 (list 3 4 'SAMPLE)))
; (print (expt 5 2))
; (print (sqrt 25))
; (print (sqrt 2))

; (if #t
;     (print 'TRUE1)
;     (print 'FALSE1)
; )
; (print 'AFTER1)

; (if #t
;     (print 'TRUE2)
; )
; (print 'AFTER2)

; (if #f
;     (print 'TRUE3)
;     (print 'FALSE3)
; )
; (print 'AFTER3)

; (if #f
;     (print 'TRUE4)
; )
; (print 'AFTER4)

; (print (- 5 2))
; (print (- 5 1 2))
; (print (/ 4 2))
; (print (/ 4 2 2))
; (print (/ 4 2 0))
; (print (/ 0 2))

; (print 'PHRASE)
; (define x 5)
; (set! x (- x 1 1))
; (print (+ x 5))

; (print (quotient 5 3))
; (print (quotient 5 0))
; (print (quotient 6 3))

; (print (mod 5 3))
; (print (mod 5 0))
; (print (mod 6 4))

; (print (> 9 8 7 6 5 4 3 2 0.1))
; (print (< 1 3 4))
; (print (= 3 3 3 3))
; (print (>= 4 4 3 3))
; (print (<= 2 2 5 6 6))

; (gl-init)
; (while (gl-is-open)
;     (print 'OPENED)
; )
; (print 'FINISHED)

; (define x 0)
; (while (< x 5)
;     (set! x (+ 1 x))
; )

; (print ((lambda (x) (+ 1 x)) 5))

;;;; LAMBDA CLOSURE 
; (define x 2)

; ((lambda (x) (print x)) 10)
; ((lambda (x) (print (+ x 1))) 10)

; (print x)

; (define new-print (lambda (x) (print (+ x 1))))
; (new-print 7)

;;;; NOT WORKING

; (define pair-op (lambda (op f s) (op f s)))
; (print (pair-op + 1 2))

; (define slow-add 
;     (lambda (x y)
;         (if (= x 0) 
;             y 
;             (slow-add (- x 1) (+ y 1))
;         )
;     )
; )
; (define a (slow-add 3 3))
; (print a)
; (print (+ a 1))

;; should be error: x not found
(while (>= x 0)
    (if (= x 0)
        (print 'DONE)
        (set! x (- x 1))
    )
)