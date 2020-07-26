;; get the sugar
(progn
  (use-package s)    ;; string
  (use-package f)    ;; file
  (use-package ht)   ;; hash table
  (use-package dash) ;; list
  )

(defmacro ffl/comment (&rest body) nil)

(defmacro ht-with-context (table content)
  (-tree-map
    (lambda (tree)
      (-tree-map-nodes (lambda (node) t)
        (lambda (node)
          (if (and
                (s-starts-with-p ":" (prin1-to-string node))
                (-contains-p (ht-keys (eval table)) node))
            (list 'ht-get table node)
            node))
        tree))
    content))

(ffl/comment
  (macroexpand-1
    `(ht-with-context
       ffl/state
       (progn :player)))

  (ht-with-context
    ffl/state
    :player))

(defun ffl/roll-die (&optional times)
  (* (or times 1)
    (+ 1 (random 6))))

(defun ffl/zip (&rest lists)
  "Zips n lists together such that each element at index i is grouped together in a sub-list."
  (mapcar
    (lambda (n)
      (mapcar
        (apply-partially 'nth (- n 1))
        lists))
    (number-sequence 1 (apply 'max (mapcar 'length lists)))))

(defmacro ffl/leth (var-names ht &rest body)
  "Assigns a series of variable names to the corresponding values of a hash table, and uses them in
the body as in a let function."
  `(let ,(ffl/zip var-names (mapcar
                          (lambda (var-name)
                            `(ht-get
                               ,ht
                               ,(intern-soft (concat ":" (symbol-name var-name)))))
                          var-names))
     ,@body))

(provide 'livingston-core)
