(defun LCS (list1 list2 commonSequence)
    (cond
        ((or (null list1) (null list2)) commonSequence)
        ( 
            (equal (car list1) (car list2))
            (LCS (cdr list1) (cdr list2) (cons (car list1) commonSequence))
        )
        (t
            (let
                (
                    (seq1 (LCS list1 (cdr list2) commonSequence))
                    (seq2 (LCS (cdr list1) list2 commonSequence))
                )
                (cond
                    ((> (length seq1) (length seq2)) seq1)
                    (t seq2)
                )
            )
        )
    )
)
;; (defun LCS (list1 list2)
;;     (cond
;;         ((or (null list1) (null list2)) 0)
;;         ( 
;;             (equal (car list1) (car list2))
;;             (+ 1 (LCS (cdr list1) (cdr list2)))
;;         )
;;         (t
;;             (max (LCS list1 (rest list2)) (LCS (rest list1) list2))
;;         )
;;     )
;; )


(defun diff (lcs fileA fileB)
    ;; (print fileA)
    ;; (print fileB)
    (let 
        (
            (startIndexA 0)
            (startIndexB 0)
            (ans '())
        )
        (loop for str in lcs
            
            do (let* 
                (
                    (endIndexA (position str fileA :test #'equal))
                    (endIndexB (position str fileB :test #'equal))
                    (seqA (subseq fileA startIndexA endIndexA))
                    (seqB (subseq fileB startIndexB endIndexB))
                )
                (if (not (null seqA))
                    ;; (push seqA ans)
                    (dolist (s seqA)
                        (format t "-~A~%" s)
                    )
                    ;; (format t "~{+~A ~}~%" seqA)
                )
                ;; (format t "~{~A ~}~%" ans)

                (if (not (null seqB))
                    ;; (push seqB ans)
                    (dolist (s seqB)
                        (format t "+~A~%" s)
                    )
                    ;; (format t "~{-~A ~}~%" seqB)
                )
                ;; (format t "~{~A ~}~%" ans)

                ;; (push (subseq fileA endIndexA (+ 1 endIndexA)) ans)
                (format t " ~{~A ~}~%" (subseq fileA endIndexA (+ 1 endIndexA)))
                ;; (format t "~{~A ~}~%" ans)
                ;; (format t "~%")

                (setq startIndexA (+ 1 endIndexA))
                (setq startIndexB (+ 1 endIndexB))
            )
        )
        (dolist (s (subseq fileA startIndexA (length fileA)))
            (format t "-~A~%" s)
        )
        (dolist (s (subseq fileB startIndexB (length fileB)))
            (format t "+~A~%" s)
        )
        ;; (format t "~{~A ~}~%" (reverse ans))
    )
)

(defun readFile (filename)
    (let ((in (open filename :if-does-not-exist nil)))
        (when in
            (loop for line = (read-line in nil)
                while line 
                collect line
            )
        )
    )
)

;; (defparameter fileIn1 '(1 2 3 4 5 6))
;; (defparameter fileIn2 '(1 a 2 b 3 c))

(defparameter fileIn1 (readFile "/test/helloWorld.c"))
(defparameter fileIn2 (readFile "/test/helloWorld.cpp"))

;; (trace LCS)
(defvar longestCS (LCS (reverse fileIn1) (reverse fileIn2) '()))
;; (format t "~{~A ~}~%" longestCS)
(diff longestCS fileIn1 fileIn2)
;; (format t "~%")
