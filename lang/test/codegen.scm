(print 5)
(print 'phrase)
(print #t)

(gl-init)
(gl-clear)
(print (gl-is-open))
(gl-put-pixel 10 10 1 1 1)
(gl-draw)
(gl-finish)

(print #f)
(print 0.45)
