;;; copied from cl-macs
(defvar *gensym-counter*)
(defun gensym (&optional arg)
  "Generate a new uninterned symbol.
The name is made by appending a number to PREFIX, default \"G\"."
  (let ((prefix (if (stringp arg) arg "G"))
	(num (if (integerp arg) arg
	       (prog1 *gensym-counter*
		 (setq *gensym-counter* (1+ *gensym-counter*))))))
    (make-symbol (format "%s%d" prefix num))))
;;; end copy

(defun genid (&optional arg)
  "Generate a new ID string.
   The name is made by appending a number to PREFIX, default \"G\"."
  (let ((prefix (if (stringp arg) arg "G"))
	(num (if (integerp arg) arg
	       (prog1 *gensym-counter*
		 (setq *gensym-counter* (1+ *gensym-counter*))))))
    (format "%s%d" prefix num)))

(defun lmg-env (point end)
  "Convert the next LaTeX environement environment into OMdoc in the region 
   between POINT and END"
  (interactive "r\nP")
  (if (search-forward-regexp "\\\\begin{\\(.*\\)}" end t)
      (let ((eb (point))
	    (bb (match-beginning 0))
	    (env (match-string 1)))
	(search-forward-regexp (concat "\\\\end{" env "}") end t)
	(let ((ee (point))
	      (be (match-beginning 0)))
	  (cond ((string= env "document")
		 (kill-region bb eb)
		 (insert "<omdoc id=\"" (genid "doc") "\">")
		 (lmg-env eb be)
		 (kill-region be ee)
		 (insert "  </omdoc>\n"))
		((string= env "slide")
		 (kill-region bb eb)
		 (goto-char bb)
		 (insert "<omgroup type=\"slide\" id=\"" (genid "sl") "\">")
		 (re-search-forward "\\\\heading{\\(.*\\)}" be nil)
		 (cond ((match-string 1)
			(kill-region (match-beginning 0) (match-end 0))
			(insert "<metadata><Title>" (match-string 1) "</Title></metadata>")))
		 (lmg-env eb be)
		 (kill-region be ee)
		 (insert "  </omgroup>"))
		((string= env "itemize")
		 (kill-region bb eb)
		 (insert "<omgroup type=\"itemize\" id=\"" (genid "i") "\">")
		 (lmg-env eb be)
		 (kill-region be ee)
		 (insert "  </omgroup>\n")))))))

(defun lmg-sectioning (levelpoint end)
  "Convert the LaTeX sectioning commands into OMdoc groups 
   in the region between POINT and END starting at level LEVEL"
  (interactive)
  ())

(defun lmg-test ()
  (interactive)
  (lmg-env 1 10000))
  
  
(defun lmg-do-items ()
  "Convert the items in a list environment into OMDoc"
  ())

