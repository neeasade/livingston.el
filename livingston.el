;; namespace: ffl (fighting fantasy livingstone)

;; ui options?:
;; https://github.com/magit/transient
;; https://github.com/ebpa/tui.el

;; crazy thing to add current dir to load-path for require:
;;
;; (let ((current-dir (file-name-directory buffer-file-name))) (unless (member current-dir load-path) (setq load-path (append load-path `(,current-dir)))))
;;

(require 'livingston-combat)
(require 'livingston-core)

(setq ffl/state
  (ht
    (:player 1)
    (:monsters-defeated '())
    ;; sometimes you are fighting multiple monsters
    (:monsters-fighting '())
    ))

(defun ffl/new-player ()
  ;; skill: Roll 1d6 and add 6 to the score
  ;; stamina: Roll 2d6 and add 12 to the score
  ;; luck: Roll 1d6 and add 6 to the score
  (ht
    (:name "Player Character")
    (:skill (+ 6 (ffl/roll-die)))
    (:stamina (+ 12 (ffl/roll-die 2)))
    (:luck (+ 6 (ffl/roll-die)))
    (:inventory '())
    (:gold 0)
    ))

(defun ffl/new-monster (name skill stamina)
  (ht
    (:name name)
    (:skill skill)
    (:stamina stamina)
    (:luck nil)))

(defun ffl/init-game ()
  nil
  )
