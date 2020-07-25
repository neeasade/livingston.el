;; namespace: ffl (fighting fantasy livingstone)

;; ui options?:
;; https://github.com/magit/transient
;; https://github.com/ebpa/tui.el


(load-file "./livingston-core.el")

(setq ffl/state
  (ht
    (:player nil)
    (:monsters-defeated nil)
    (:monsters-fighting nil)))

(defun ffl/new-player ()
  ;; skill: Roll 1d6 and add 6 to the score
  ;; stamina: Roll 2d6 and add 12 to the score
  ;; luck: Roll 1d6 and add 6 to the score
  (ht
    (:skill (+ 6 (ffl/roll-die)))
    (:stamina (+ 12 (ffl/roll-die 2)))
    (:luck (+ 6 (ffl/roll-die)))
    (:inventory '())
    (:gold 0)
    ))

(defun ffl/init-game ()
  nil
  )
