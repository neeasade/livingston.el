(defconst ffl/weapons/weapon-table
  (ht
    (:battle-axe '(2 2 2 2 2 3 3))
    (:club '(1 2 2 2 2 2 4))
    (:dagger '(1 1 2 2 2 2 2))
    (:pole '(arm 1 2 2 2 3 3 3))
    (:spear '(1 1 2 2 2 3 3))
    (:staff '(1 2 2 2 2 2 3))
    (:sword '(1 2 2 2 2 3 3))
    (:two-handed-sword '(2 2 2 3 3 3 4))
    (:arrow '(1 1 2 2 2 3 3))
    (:crossbow-bolt '(1 2 2 2 2 3 3))
    (:javelin '(1 2 2 2 2 3 3))
    (:throwing-dagger '(1 2 2 2 2 2 3))
    (:fist-kick-human-size '(1 1 1 2 2 2 3))
    (:fist-kick-larger '(size 2 2 2 3 3 3 3))
    (:bite-claw-small '(1 1 2 2 2 2 3))
    (:bite-claw-large '(1 2 2 2 3 3 4))
    (:bite-claw-very-large '(2 2 3 3 4 5 6))))

(defun ffl/weapons/available ()
  (ht-keys ffl/weapons/weapon-table))

(defun ffl/weapons/damage (weapon roll)
  "Retrieves the damage that a particular weapon can"
  (let ((weapon (ht-get ffl/weapons/weapon-table weapon)))
    (or (nth (- roll 1) weapon) (car (last weapon)))))

(provide 'livingston-weapons)
