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

(gl-init)
(while (gl-is-open)
    (print 'OPENED)
)
(print 'FINISHED)