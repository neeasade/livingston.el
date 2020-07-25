(load-file "./livingston-core.el")

(defun ffl/combat/attack-strength (entity)
  (+
    (ht-get entity :skill)
    (ffl/roll-die 2)))

(defun ffl/combat/determine-attacker (player monster)
  (let ((player-attack-strength (ffl/combat/attack-strength player))
         (monster-attack-strength (ffl/combat/attack-strength monster)))
    (if (>= player-attack-strength monster-attack-strength)
      :player
      :monster)))
