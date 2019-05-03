(defun mergesort (numbers)
    (let ((list_len (length numbers)))
        ;; (print list_len)
        (cond
            ((or (null numbers) (= list_len 1)) numbers)
            (t
				(let
                    (
                        (list_left (mergesort (subseq numbers 0 (floor list_len 2))))
                        (list_right (mergesort (subseq numbers (floor list_len 2))))
                    )
                    (merge 'list list_left list_right #'<)
                )
                
            )
        )
    )
    
)

; main function
(let 
    ((n (read))
        (numbers))
    (setf numbers
        (do 
            ((i 0 (+ i 1)) ; i = 0, tmp = nil, ++i
                (tmp nil))
            ((>= i n)
                (reverse tmp))
            (setf tmp (cons (read) tmp))
        )
    )
    (format t "~{~A ~}~%" (mergesort numbers))
)