(defun palindrome(n)
    (if (equal n (reverse n))
        'palindrome
        'not-palindrome
    )
)