;; a transient example?:
;; https://gist.github.com/abrochard/dd610fc4673593b7cbce7a0176d897de
;; https://github.com/magit/magit/blob/master/lisp/magit-status.el#L357
;; https://www.gnu.org/software/emacs/manual/html_node/elisp/Tabulated-List-Mode.html

;; huuuuuuuuuge thanks to @abrochard

;; for now: assume there will only be one game buffer, *livingstone*

(defmacro ffl/with-buffer (content)
  `(with-current-buffer "*livingstone*"
     ,@content
     ))

;; return plist with name + index attached
(defun ffl/unroll-list (name list)
  (->> list
    (-map-indexed
      (lambda (i item)
        (list (intern (format ":%s-%s" name i)) item)))
    (-flatten)))

;; (ffl/unroll-list "test" '(1 2 3))

(defun ffl/state-to-rows (state)
  (ffl/with-ht-context state
    ;; todo
    ))

(defun ffl/render-ui (state)
  ;; see core for state outline, ht
  ;; (ht-get state :monsters-defeated '())
  )

;; number is percent?
(let ((columns [("Col1" 50) ("Col2" 50)])
       (rows (list
               '(nil ["row1" "value1"])
               '(nil ["row2" "value2"])
               '(nil ["row3" "value3"]))))
  (setq tabulated-list-format columns)
  (setq tabulated-list-entries rows)
  (tabulated-list-init-header)
  (tabulated-list-print))

(define-derived-mode livingstone-mode tabulated-list-mode "Livingstone"
  "livingstone mode"
  (let ((columns
          ;; todo
          ;; [("Pod" 100)]
          )
         (rows
           ;; todo
           ;; '("this" "is" "test")
           ))
    (setq tabulated-list-format columns)
    (setq tabulated-list-entries rows)
    (tabulated-list-init-header)
    (tabulated-list-print)))

(defun livingstone ()
  (interactive)
  (switch-to-buffer "*livingstone*")
  (livingstone-mode))
