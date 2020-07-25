;; namespace: ffl (fighting fantasy livingstone)

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


(defun ffl/new-player ()
  ;; skill: Roll 1d6 and add 6 to the score
  ;; stamina: Roll 2d6 and add 12 to the score
  ;; luck: Roll 1d6 and add 6 to the score
  (ht
    (:skill (+ 6 (ffl/roll-die)))
    (:stamina (+ 12 (ffl/roll-die 2)))
    (:luck (+ 6 (ffl/roll-die))))
  )
