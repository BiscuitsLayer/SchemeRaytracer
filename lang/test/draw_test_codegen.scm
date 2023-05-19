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

                        (gl-put-pixel i j (* i 2.55) (* j 2.55) 255)
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