(require 'livingston-core)
(require 'livingston-weapons)

(defun zip (&rest lists)
  "Zips n lists together such that each element at index i is grouped together in a sub-list."
  (mapcar
    (lambda (n)
      (mapcar
        (apply-partially 'nth (- n 1))
        lists))
    (number-sequence 1 (apply 'max (mapcar 'length lists)))))

(defmacro letl (var-names list &rest body)
  "Assigns a series of variable names to the values of a list, and uses them in the body as in a
let function."
  ;; This function has a problem! The following causes an error:
  ;;
  ;; (let ((min 1)
  ;;       (max 2))
  ;;   (letl (a b) (number-sequence min max)
  ;;     `(,a ,b)))
  ;;
  ;; But weirdly the following does not,
  ;;
  ;; (let ((attempt '(let ((min 1)
  ;;                       (max 2))
  ;;                   (letl (a b) (number-sequence min max)
  ;;                     `(,a ,b)))))
  ;;   (eval attempt))
  `(let ,(zip var-names (eval list))
     ,@body))

(defmacro leth (var-names ht &rest body)
  "Assigns a series of variable names to the corresponding values of a hash table, and uses them in
the body as in a let function."
  `(let ,(zip var-names (mapcar
                          (lambda (var-name)
                            `(ht-get
                               ,ht
                               ,(intern-soft (concat ":" (symbol-name var-name)))))
                          var-names))
     ,@body))

(defun ffl/combat/attack-strength (entity)
  (+
    (ht-get entity :skill)
    (ffl/roll-die 2)))

(defun ffl/combat/determine-attacker (player monster)
  (let ((player-attack-strength (ffl/combat/attack-strength player))
         (monster-attack-strength (ffl/combat/attack-strength monster)))
    (cond
      ((= player-attack-strength monster-attack-strength) nil)
      ((> player-attack-strength monster-attack-strength) `(,player . ,monster))
      ((< player-attack-strength monster-attack-strength) `(,monster . ,player)))))

(defun ffl/combat/do-round (player monster)
  (letl (attacker defender) (ffl/combat/determine-attacker player monster)
    (leth (name) attacker
      name)))

(provide 'livingston-combat)
