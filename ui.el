;; a transient example?:
;; https://gist.github.com/abrochard/dd610fc4673593b7cbce7a0176d897de
;; https://github.com/magit/magit/blob/master/lisp/magit-status.el#L357
;; https://www.gnu.org/software/emacs/manual/html_node/elisp/Tabulated-List-Mode.html

;; huuuuuuuuuge thanks to @abrochard

;; number is percent?
(let ((columns [("Col1" 50) ("Col2" 50)])
       (rows (list
               '(nil ["row1" "value1"])
               '(nil ["row2" "value2"])
               '(nil ["row3" "value3"]))))
  (switch-to-buffer "*temp*")
  (setq tabulated-list-format columns)
  (setq tabulated-list-entries rows)
  (tabulated-list-init-header)
  (tabulated-list-print))

(define-derived-mode livingstone-mode tabulated-list-mode "Livingstone"
  "Kubernetes mode"
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
