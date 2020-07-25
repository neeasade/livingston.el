;; get the sugar
(progn
  (use-package s)    ;; string
  (use-package f)    ;; file
  (use-package ht)   ;; hash table
  (use-package dash) ;; list
  )

(defun ffl/roll-die (&optional times)
  (* (or times 1)
    (+ 1 (random 6))))

(provide 'livingston-core)
