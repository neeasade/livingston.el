(require 'livingston-core)
(require 'livingston-weapons)

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
