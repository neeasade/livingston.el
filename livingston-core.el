;; get the sugar
(progn
  (use-package s)    ;; string
  (use-package f)    ;; file
  (use-package ht)   ;; hash table
  (use-package dash) ;; list
  )

(defmacro ffl/comment (&rest body) nil)

(defmacro ffl/with-ht-context (table content)
  (-tree-map
    (lambda (tree)
      (-tree-map-nodes (lambda (node) t)
        (lambda (node)
          (if (s-starts-with-p ":" (prin1-to-string node))
            (list 'ht-get table node)
            node))
        tree))
    content))

(ffl/comment
  (macroexpand-1
    `(ffl/with-ht-context
       ffl/state
       (progn :player)))

  (ffl/with-ht-context
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

(defmacro ffl/letl (var-names list &rest body)
  "Assigns a series of variable names to the values of a list, and uses them in the body as in a
let function."
  ;; This function has a problem! The following causes an error:
  ;;
  ;; (let ((min 1)
  ;;       (max 2))
  ;;   (ffl/letl (a b) (number-sequence min max)
  ;;     `(,a ,b)))
  ;;
  ;; But weirdly the following does not,
  ;;
  ;; (let ((attempt '(let ((min 1)
  ;;                       (max 2))
  ;;                   (ffl/letl (a b) (number-sequence min max)
  ;;                     `(,a ,b)))))
  ;;   (eval attempt))
  `(let ,(ffl/zip var-names (eval list))
     ,@body))

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
