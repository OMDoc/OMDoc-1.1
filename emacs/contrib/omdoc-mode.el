;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; A first attempt at an OMDoc mode
;;; Copyright 2001 Michael Kohlhase, 
;;; released under the Gnu Public License
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(autoload 'time-stamp-string "time-stamp")
(autoload 'xsl-calculate-indent "xslide")

;; the counter for omdoc-genid
(defvar *idcounter* 0)

;; the DTD string 
(defvar omdoc-dtd "http://www.mathweb.org/omdoc/omdoc.dtd")
;; try to guess the user name
(defvar omdoc-user (getenv "USER"))

(defvar omdoc-Time-format "%:y-%02m-%02dT%02H:%02M:%02S")
(defun omdoc-header ()
  (let ((bname (buffer-name (current-buffer))))
       (list "<?xml version=\"1.0\"?>"
	  (concat "<!DOCTYPE omdoc SYSTEM '" omdoc-dtd "' []>")
	  (concat "<omdoc Ident='" bname "'>")
	  " <metadata>"
	  (concat "  <Title>" (substring bname 0 
					  (or (search "." bname)
					      (length bname)))
		  "  </Title>")
	  (concat "  <Creator role='aut'>" omdoc-user "</Creator>")
	  (concat "  <Date action='created'>" (time-stamp-string omdoc-Time-format) "</dc:Date>")
	  "  <Type>Text</Type>"
	  "  <Format>application/omdoc+xml</Format>"
	  " </metadata>")))		

(defvar omdoc-footer "</omdoc>")

(defun omdoc-init ()
  "Inserts an outer OMDoc environment into the buffer"
  (interactive)
  (goto-char(point-min))
  (dolist (line (omdoc-header))
    (insert line "\n"))
  (insert "\n\n")
  (insert omdoc-footer "\n"))

(defun omdoc-elt (name &optional atts)
  "Inserts an OMDoc element after point with the current indentation"
  (interactive)
  (if atts (omdoc-belt name atts) (omdoc-belt name))
  (omdoc-indent-line)
  (insert "\n")
  (make-marker)
  (insert "\n")
  (omdoc-eelt name)
  (omdoc-indent-line)
  (end-of-line 0))

; Inserts the start tag for an OMDoc element after point with the current indentation
(defun omdoc-belt (name &optional atts)
  (insert "<" (omdoc-attstring name atts) ">"))

;Inserts the end tag for an OMDoc element after point with the current indentation
(defun omdoc-eelt (name) (insert "</" name ">"))

(defun omdoc-attstring (string pairlist)
  (if pairlist 
      (omdoc-attstring 
       (concat string " " (car (car pairlist)) "=\"" (second (car pairlist)) "\"") 
       (cdr pairlist))
    string))

(defun omdoc-indent-line ()
  "Indent the line containing point, as XML source."
  (interactive)
  (let* ((case-fold-search nil)
	 (indent (xsl-calculate-indent)))
    (save-excursion
      (if (/= (current-indentation) indent)
	  (let ((beg (progn
		       (beginning-of-line)
		       (point))))
	    (back-to-indentation)
	    (delete-region beg (point))
	    (indent-to indent))))
    (if (< (current-column) indent)
	(back-to-indentation))))


(defun omdoc-omtext ()
  "inserts an omtext element at point"
  (interactive)
  (omdoc-elt "omtext" (list (list "id" (omdoc-genid "text"))))
  (omdoc-elt "CMP"))

(defun omdoc-omtext-add-language ()
  "adds a language CMP into an omtext element by copying the text,
   adding 'id' attributes where necessary to the top-level OMOBJ
   elements and, and using references in the copy"
  (interactive)
  nil)



(defun omdoc-genid (prefix)
  (setq *idcounter* (+ *idcounter* 1))
  (concat prefix (prin1-to-string *idcounter*)))

(defun omdoc-get-sexp ()
  (let ((opoint (point)))
    (forward-sexp -1)
    (narrow-to-region (point-min) opoint)
    (read (current-buffer))))



(defun omdoc-translate-from-lisp (exp indent)
  "Translate the lisp-like syntax into OpenMath"
  (cond ((integerp exp) 
	 (insert (make-string indent ?\ ) "<OMI>" (prin1-to-string exp) "</OMI>\n"))
	((symbolp exp) 
	 (insert (make-string indent ?\ ) "<OMV name=\"" (prin1-to-string exp) "\"/>\n"))
	((equal (car exp) 'BIND)
	   (insert (make-string indent ?\ ) "<OMBIND>\n")
	   (omdoc-translate-from-lisp (cadr exp) (+ indent 1))
	   (insert (make-string (+ indent 1) ?\ ) "<OMBVAR>\n")
	   (mapcar (lambda (x) (omdoc-translate-from-lisp x (+ indent 2))) (caddr  exp))
	   (insert (make-string (+ indent 1) ?\ ) "</OMBVAR>\n")
	   (omdoc-translate-from-lisp (cdddr exp) (+ indent 1))
	   (insert (make-string indent ?\ ) "</OMBIND>\n"))
	((equal (car exp) 'ATTR)
	 (let ((alist (cdar exp))
	       (body (cddr exp)))
	   (insert (make-string indent ?\ ) "<OMATTR>\n")
	   (insert (make-string (+ indent 1) ?\ ) "<OMATP>\n")
	   (omdoc-translate-from-list alist (+ indent 2))
	   (insert (make-string (+ indent 1) ?\ ) "</OMATP>\n")
	   (omdoc-translate-from-lisp body)
	   (insert (make-string indent ?\ )"</OMATTR>\n")))
	(t (insert (make-string indent ?\ ) "<OMA>\n")
	   (mapcar (lambda (x) (omdoc-translate-from-lisp x (+ indent 1))) exp)
	   (insert (make-string indent ?\ ) "</OMA>\n"))))
	
(defun omdoc-translate-before-point ()
  "Translate the lisp-like syntax before point into OpenMath"
  (interactive)
  (terpri)
  (omdoc-translate-from-lisp (omdoc-get-sexp) 0))

(defun omdoc-test ()
  "test"
  (interactive)
  (omdoc-translate-from-lisp '(test tast)))
