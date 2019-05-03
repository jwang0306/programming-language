(defun fib1(n)
    (if (< n 2)
        n
        (+ (fib1(- n 1)) (fib1(- n 2)))
    )
)

;; (defun fib2 (n &optional (a 0) (b 1))
;;     (cond 
;;         ((= n 0) a)
;;         ((= n 1) b)
;;         (t (fib2 (- n 1) b (+ a b)))
;;     )
;; )
(defun tailfib (a b num n)
    (if (< num n)
        (tailfib (+ a b) a (+ num 1) n)
        a
    )
)
(defun fib2 (n)
    (tailfib 0 1 0 n)
)