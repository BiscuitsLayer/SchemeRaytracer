;;; GEOMETRY ;;;

(define sum-list (lambda (lst) (if (null? lst) 0 (+ (car lst) (sum-list (cdr lst))))))

(define prod-list (lambda (lst) (if (null? lst) 1 (* (car lst) (prod-list (cdr lst))))))

(define reduce-list (lambda (lst base op) (if (null? lst) base (op (car lst) (reduce-list (cdr lst) base op)))))

;; vec3
(define (vec3 x y z) (list x y z))

;; get components
(define (vec-x v) (car v))
(define (vec-y v) (car (cdr v)))
(define (vec-z v) (car (cdr (cdr v))))

;; common vector operation
(define (vec-oper v1 v2 op)
 (if
    ;; v2 is a vector
    (list? v2) (vec3 
                  (op (vec-x v1) (vec-x v2)) 
                  (op (vec-y v1) (vec-y v2)) 
                  (op (vec-z v1) (vec-z v2))
                )
    ;; v2 is a number, not a vector
    (vec3 (op (vec-x v1) v2) (op (vec-y v1) v2) (op (vec-z v1) v2))
  )
)

;; vec-add first operand must be a vector
(define (vec-add v1 v2)
  (vec-oper v1 v2 +)
)

;; vec-sub first operand must be a vector
(define (vec-sub v1 v2)
  (vec-oper v1 v2 -)
)

;; vec-mul first operand must be a vector
(define (vec-mul v1 v2)
  (vec-oper v1 v2 *)
)

;; vec-mul first operand must be a vector
(define (vec-div v1 v2)
  (vec-oper v1 v2 /)
)

;; dot product
(define (vec-dot v1 v2)
  (sum-list (vec-mul v1 v2))
)

; vector length
(define (vec-len v) 
  (sqrt (vec-dot v v))
)

;; unit vector
(define vec-unit 
  (lambda (v)
    (vec-div v (vec-len v))
  )
)