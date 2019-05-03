(defun prime(n)
    (loop for i from 2
        while (< i n)
            do (if (= (mod n i) 0)
                (return-from prime 'not-prime)
            )
    )
    (cond 
        ((= 1 n)
            (return-from prime 'not-prime))
        (t (return-from prime 'is-prime))
    )
)