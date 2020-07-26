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
      ((> player-attack-strength monster-attack-strength) :player)
      ((< player-attack-strength monster-attack-strength) :monster))))

(defun ffl/combat/calculate-damage (attacker)
  ;; TODO: calculate damage from an attacker?
  2)

(defun ffl/combat/perform-attack (attacker recipient)
  (ffl/leth (stamina) recipient
    (ht-set recipient :stamina (- stamina (ffl/combat/calculate-damage attacker)))))

(defun ffl/combat/do-round (player monster)
  (let ((attacker (ffl/combat/determine-attacker player monster)))
    (cond
      ((= attacker nil) `(,player ,monster))
      ((= attacker :player `(,player ,(ffl/combat/perform-attack player monster))))
      ((= attacker :monster `(,(ffl/combat/perform-attack monster player) ,monster))))))

(defun ffl/combat/do-combat (player monster)
  (if (or
        (<= (ht-get player :stamina) 0)
        (<= (ht-get monster :stamina) 0))
    `(,player ,monster)
    (apply 'ffl/combat/do-combat (ffl/combat/do-round player monster))))

(provide 'livingston-combat)
