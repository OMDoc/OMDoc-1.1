;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; -*- Mode: Lisp -*- ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; pp-omdoc.lisp -- 
;; Author          : Michael Kohlhase
;; Created On      : Mon May 14 2001
;; Status          : Unknown, Use with caution!
;; 
;; HISTORY           This file was developed from pp.lisp but adapted to OMDoc 
;;                   output. 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(in-package :pvs)

;; for testing purposes on the prelude, this generates all prelude OMDocs.
(defun pp-omdoc-generate-all ()
  (mapcar #'(lambda (sym) (pp-omdoc-generate (string sym)))
	  '("booleans" "equalities" "notequal" "if_def" "boolean_props" "xor_def"
 	    "quantifier_props" "defined_types" "exists1" "equality_props"
 	    "if_props" "functions" "functions_alt" "restrict" "extend"
 	    "extend_bool" "K_conversion" "K_props" "identity" "identity_props"
	    "relations" "orders" "orders_alt" "wf_induction" "measure_induction"
 	    "epsilons" "sets" "sets_lemmas" "function_inverse" "function_image"
 	    "function_props" "function_props2" "relation_defs" "relation_props"
 	    "relation_props2" "operator_defs" "numbers" "reals" "real_axioms"
 	    "bounded_real_defs" "bounded_real_defs_alt" "real_types" "rationals"
 	    "integers" "naturalnumbers" "min_nat" "real_defs" "real_props"
 	    "rational_props" "integer_props" "floor_ceil" "exponentiation"
 	    "euclidean_division" "divides" "modulo_arithmetic"
 	    "subrange_inductions" "bounded_int_inductions"
 	    "bounded_nat_inductions" "subrange_type" "int_types" "nat_types"
 	    "finite_sets_def" "function_iterate" "sequences" "seq_functions"
	    "finite_sequences" "ordinals" "lex2" "list_props" "map_props"
 	    "filters" "list2finseq" "list2set" "disjointness" "strings"
 	    "mucalculus" "ctlops" "fairctlops" "Fairctlops" "bit" "bv" "exp2"
 	    "bv_cnv" "bv_concat_def" "bv_bitwise" "bv_nat" "empty_bv" "bv_caret"
	    ))) 

(defvar *generated-by* "")

(defun pp-omdoc-generate (str)
  (with-open-file
   (outstream (concatenate 'string str ".omdoc")
	      :direction :output :if-exists :supersede)
   (let ((*print-right-margin* 100)
	 (*generated-by* "")
	 (*standard-output* outstream)
	 (timestamp (multiple-value-bind (second minute hour date month year)
			(get-decoded-time)
		      (format nil "~A-~A-~A@~A:~A:~A" year month date hour minute second)))
	 (mod (get-theory str)))
     (pprint-logical-block (nil nil)
       (write-string "<?xml version=\"1.0\" encoding=\"utf-8\"?>")
       (pprint-indent :block 0)
       (pprint-newline :mandatory)
       (write-string "<!DOCTYPE omdoc SYSTEM \"omdoc.dtd\">")
       (pprint-newline :mandatory)
       (pp-omdoc-beltid 
	"omdoc" 
	(format nil "~A.omdoc" str)
	:attr "catalogue=\"catalogue.omdoc\"")
       (pp-omdoc-metadata :creator "PVS" :cdate timestamp)
       (pprint-newline :mandatory)
       (pp-omdoc mod)
       (pp-omdoc-eelt "omdoc")
       nil))))

(defun pp-omdoc (obj)
  (let ((*disable-gc-printout* t)
	(*pretty-printing-decl-list* nil)
	(*pretty-printed-prefix* nil))
    (pprint-logical-block (nil nil)
      (pp-omdoc* obj))))

(defmethod pp-omdoc* ((list list))
  (pprint-logical-block (nil list)
    (loop (pp-omdoc* (pprint-pop))
	  (pprint-exit-if-list-exhausted)
	  (pprint-newline :mandatory))))

(defmethod pp-omdoc* ((ex symbol))
  (pp-omdoc-escape (string ex)))

(defmethod pp-omdoc* ((ex string))
  (pp-omdoc-escape (string ex)))


;;; Module level

(defmethod pp-omdoc* ((mod module))
  (with-slots (id formals exporting assuming theory) mod
;;; first create the source theory we want to import later on
    (when formals (pp-omdoc-source-theory (append formals assuming) id))
    (pprint-logical-block (nil nil)
      (pprint-indent :block 0)
      (pp-omdoc-beltid "theory" (format nil "~A_test" id))
      (pprint-newline :mandatory)
      (when formals (pp-omdoc-imports formals id))
;      (when exporting (pp-omdoc-elt "exporting" exporting :format :pp-omdoc))
      (when theory (pp-omdoc* theory))
      (pp-omdoc-eelt "theory"))))


(defun pp-omdoc-source-theory  (formals id)
  (pprint-logical-block (nil nil)
    (pp-omdoc-beltid "theory" (format nil "~A-parameters" (pp-omdoc-escape id)))
    (pprint-newline :mandatory)
    (pp-omdoc* formals)
    (pp-omdoc-eelt "theory")
    (pprint-newline :mandatory)
    (pp-omdoc-omit (format nil "~A-parameters" (pp-omdoc-escape id))
		   (format nil "theory, it goes to the parameter declarations of theory ~A" id)
		   :for id)
    (pprint-newline :mandatory)))


(defun pp-omdoc-imports (formals id)
  (pprint-logical-block (nil nil)
    (pprint-logical-block (nil formals)
       (loop (pp-omdoc* (pprint-pop))
	     (pprint-exit-if-list-exhausted)
	     (pprint-newline :mandatory)))
    (pp-omdoc-eltid "imports" (format nil "~A-import-parameters" id) nil
		    :attr (format nil "from=\"~A-parameters\"" (pp-omdoc-escape id)))
    (pprint-newline :mandatory)))

(defmethod pp-omdoc* :after ((decl formal-decl))
  (pp-omdoc-omit (id decl) "declaration, it goes into the theory parameters"))
    
;;; Need this as a primary method
(defmethod pp-omdoc* ((decl declaration)) nil)

(defmethod pp-omdoc* :around ((decl declaration)) (call-next-method))

(defmethod pp-omdoc* ((decl type-decl))
  (with-slots (id module) decl
    (pprint-logical-block (nil nil)
      (pp-omdoc-beltid "symbol" id
       :attr (concatenate 'string "scope=\"global\" kind=\"type\"" *generated-by*))
      (pprint-indent :block 2)
      (pprint-newline :mandatory)
      (pprint-logical-block (nil nil)
        (pp-omdoc-belt "type" :attr "system=\"pvs\"")
        (pprint-newline :mandatory)		      
	(pprint-logical-block (nil nil)
          (pp-omdoc-belt "OMOBJ")
	  (pprint-newline :mandatory)
	  (pp-omdoc-oms "pvs" (if (typep decl 'nonempty-type-decl) "nonempty-type" "type"))
	  (pp-omdoc-eelt "OMOBJ"))
	(pp-omdoc-eelt "type"))
      (pp-omdoc-eelt "symbol"))
      (when (typep decl 'nonempty-type-decl)
	(pprint-newline :mandatory)
	(pp-omdoc-assdef "axiom"
			 (format nil "~A-non-empty" (pp-omdoc-escape id)) 
			 (format nil "The type ~A is non-empty"  (pp-omdoc-escape id))
			 nil)
	(pp-omdoc-omit (format nil "~A-non-empty" id) "axiom" :for id)
	(pprint-newline :mandatory))))

(defmethod pp-omdoc*  ((decl type-def-decl))
  (call-next-method)
  (pprint-newline :mandatory)
  (pp-omdoc-assdef "definition" (id decl) "" (type-expr decl)
		   :attr (format nil "for=\"~A\" type=\"simple\"" (pp-omdoc-escape (id decl))))
  (when (contains decl)
    (pp-omdoc-private (contains decl)
		      :for (id decl)
		      :format :pp 
		      :attr (format nil "type=\"type-eq-decl\" replaces=\"~A-contains\""
			      (pp-omdoc-escape (id decl))))
    (pprint-newline :mandatory)
    (pp-omdoc-assdef "axiom"
		     (format nil "~A-contains" (id decl))
		     (format nil "Type ~A contains the element XXXX"
			     (pp-omdoc-escape (id decl)))
		     nil)
    (pprint-newline :mandatory)))

(defmethod pp-omdoc* ((decl formal-type-decl))
  (call-next-method))
;     (when (typep decl 'formal-subtype-decl)
;       (write-char #\space)
;       (write 'FROM)
;       (write-char #\space)
;       (pp-omdoc* type-expr))

;; we do not want to export variable declarations, since we use the closed-form axioms.
(defmethod pp-omdoc* ((decl var-decl)) nil)

(defmethod pp-omdoc* ((decl typed-declaration))
  (with-slots (id type) decl
    (let ((kind (etypecase decl
		  (const-decl "global")
		  (var-decl   "local")
		  (formal-const-decl "local"))))
      (pprint-logical-block (nil nil)
        (pp-omdoc-beltid "symbol" id
			 :attr (concatenate
				'string
				(format nil "scope=\"~A\" kind=\"object\"" kind)
				*generated-by*)))
      (pprint-indent :block 2)
      (pprint-newline :mandatory)
      (pp-omdoc-with-omobj "type" type :attr "system=\"pvs\"")
      (pp-omdoc-eelt "symbol")
      (pprint-newline :mandatory))))

(defmethod pp-omdoc* ((decl const-decl))
  (call-next-method)
  (with-slots (def-axiom id) decl
    (when def-axiom
      (pprint-newline :mandatory)
      (pprint-logical-block (nil nil)
        (pp-omdoc-beltid "definition"
			 (format nil "~A-def" id)
			 :attr (format nil "for=\"~A\" type=\"~A\""
				       (pp-omdoc-escape id)
				       (etypecase decl
					 (def-decl "recursive")
					 (const-decl "simple"))))
	(pp-omdoc-fmp (last def-axiom))
	(when (eq (type-of decl) 'def-decl)
	  (when (measure decl)
	    (pprint-newline :mandatory)
	    (pp-omdoc-with-omobj "measure"  (declared-measure decl)))
	  (when (ordering decl)
	    (pprint-newline :mandatory)
	    (pp-omdoc-with-omobj "ordering"  (ordering decl))))
      (pp-omdoc-eelt "definition")
      (pprint-newline :mandatory)))))
       
(defmethod pp-omdoc* ((decl formula-decl))
  (with-slots (spelling closed-definition id proofs module) decl
    (if (eq spelling 'axiom)
	(pp-omdoc-assdef "axiom" id "" closed-definition)
	(pp-omdoc-assdef "assertion" id "" closed-definition 
			 :attr (format nil "type=\"~A\"" (string-downcase spelling))))			 
    (pprint-newline :mandatory)
    (when proofs
      (pprint-newline :mandatory)
      (pprint-logical-block (nil proofs)
        (loop (pp-omdoc-script (pprint-pop)
			      (pp-omdoc-escape id))
	      (pprint-exit-if-list-exhausted)
	      (pprint-newline :mandatory)))
      (pprint-newline :mandatory))))

(defmethod pp-omdoc* ((decl judgement))
  (pp-omdoc-private decl :for (id decl) :format :pp)
  (pprint-newline :mandatory))

(defmethod pp-omdoc* :after ((decl conversion-decl))
  (pp-omdoc-private decl :for (id decl) :format :pp)
  (pprint-newline :mandatory))


;;; Type expressions

(defmethod pp-omdoc* :around ((te type-expr))
  (if (print-type te)
      (pp-omdoc* (print-type te))
    (call-next-method)))

(defmethod pp-omdoc* ((te type-application))
  (with-slots (type parameters) te
    (if (and (eq (length parameters) 1)
	     (eq (type-of (first parameters)) 'tupletype))
	(pp-omdoc-psloma (cons type (types (first parameters))))
	(pp-omdoc-psloma (cons type  parameters)))))

(defmethod pp-omdoc* ((ex field-application))
  (with-slots (id argument) ex
     (pp-omdoc-psioma "select-record-field" id argument)))

(defmethod pp-omdoc* ((te subtype))
  (pp-omdoc-psloma (list (predicate te)) "subtype"))

(defmethod pp-omdoc* ((te expr-as-type))
  (pp-omdoc-psloma (list (expr te)) "subtype"))

(defmethod pp-omdoc* ((te recordtype))
  (if (some #'(lambda (el) (eq (type-of el) 'dep-binding)) (fields te))
      (pp-omdoc-psloma (fields te) "dependent-recordtype")
    (pp-omdoc-psloma (fields te) "recordtype")))

(defmethod pp-omdoc* ((te funtype))
  (with-slots (range domain) te
    (etypecase domain
      (tupletype (pp-omdoc-psloma (append (types domain) (list range)) "funtype"))
      (dep-binding (pp-omdoc-ombind  "sigmatype" (list domain) range))
      (type-expr (pp-omdoc-psloma (list domain range) "funtype")))))

(defmethod pp-omdoc* ((te tupletype))
  (if (some #'(lambda (el) (eq (type-of el) 'dep-binding)) (types te))
      (pp-omdoc-psloma (types te) "dependent-tupletype")
    (pp-omdoc-psloma (types te) "tupletype")))

(defmethod pp-omdoc* ((te cotupletype))
  (pp-omdoc-psloma (types te) "cotupletype"))

;;; Expressions

(defmethod pp-omdoc* ((ex number-expr))
  (pp-omdoc-omi (number ex)))

(defmethod pp-omdoc* ((ex string-expr))
  (unless (string-value ex)
    (setf (string-value ex) (pp-string-expr (argument ex))))
  (pp-omdoc-omstr (string-value ex)))

(defmethod pp-omdoc* ((ex list-expr))
  (if (valid-list-expr? ex)
      (pp-omdoc-psloma (list-arguments ex) "list")
    (call-next-method)))

(defmethod pp-omdoc* ((ex null-expr))
  (pp-omdoc-oms "pvs" "emptylist"))

(defmethod pp-omdoc* ((ex record-expr))
  (pp-omdoc-psloma (assignments ex) "record"))


(defmethod pp-omdoc* ((ex tuple-expr))
  (pp-omdoc-psloma (exprs ex) "tuple"))

(defmethod pp-omdoc* ((ex projection-application))
  (with-slots (index argument) ex
  (pp-omdoc-psnoma "proj" index argument)))

(defmethod pp-omdoc* ((ex application))
  (if (or (eq (type-of (argument ex)) 'tuple-expr)
	  (eq (type-of (argument ex)) 'arg-tuple-expr))
      (pp-omdoc-psloma (cons (operator ex) (exprs (argument ex))))
    (pp-omdoc-psloma (list (operator ex)  (argument ex)))))


(defmethod pp-omdoc* ((ex binding-expr))
  (with-slots (bindings expression) ex
    (pp-omdoc-ombind (etypecase ex
		       (lambda-expr "lambda")
		       (forall-expr "forall")
		       (exists-expr "exists"))
		     bindings
		     expression)))

(defmethod pp-omdoc* ((ex set-expr))
  (with-slots (bindings expression) ex
    (pp-omdoc-ombind  "set" bindings expression)))

(defmethod pp-omdoc* ((ex update-expr))
  (with-slots (expression assignments) ex
    (pp-omdoc-psloma (cons expression assignments) "update")))

(defmethod pp-omdoc* ((ex cases-expr))
  (with-slots (expression selections else-part) ex
    (pp-omdoc-psloma (append (cons expression selections) 
			     (list else-part)) 
		     "cases")))
      
(defmethod pp-omdoc* ((sel selection))
  (with-slots (constructor args expression) sel
    (pprint-logical-block (nil nil)
      (pp-omdoc-belt "OMA")
      (pprint-newline :mandatory)
      (pp-omdoc-oms "pvs" "case")
      (pprint-newline :mandatory)
      (pp-omdoc* constructor)
      (pprint-newline :mandatory)
      (if args
	  (pp-omdoc-ombind "case-lambda" args  expression)
	(pp-omdoc* expression))
      (pp-omdoc-eelt "OMA"))))

(defmethod pp-omdoc* ((ass assignment))
  (with-slots (arguments expression) ass
	      (if (typep ass 'uni-assignment)
		  (pp-omdoc* (caar arguments))
		(pp-omdoc* arguments))
	      (pprint-newline :mandatory)
	      (pp-omdoc* expression)))

(defmethod pp-omdoc* ((ex name))
  (pp-omdoc-oms (symbol-name (id (module-instance (first (resolutions ex)))))
		(id ex)))

(defmethod pp-omdoc* ((ex name-expr))
  (if (freevar-p ex)
      (pp-omdoc-omv (symbol-name (id ex)))
    (pp-omdoc-oms (symbol-name (id (module-instance (first (resolutions ex))))) (id ex))))

(defun freevar-p (ex)
  (eq (type-of (declaration (first (resolutions ex))))
      'untyped-bind-decl))
  
(defmethod pp-omdoc* ((ex field-name-expr))
  (pp-omdoc-omstr (id ex)))

(defmethod pp-omdoc* ((bd bind-decl))
  (with-slots (type id) bd (pp-omdoc-typed-var id type)))
  
(defmethod pp-omdoc* ((bd simple-decl))
  (with-slots (type id) bd (pp-omdoc-typed-var id type)))

;;; there is no concpt of codatatye in OMDoc yet.
(defmethod pp-omdoc* ((dt datatype))
  (with-slots (id formals importings assuming constructors adt-theory) dt
    (pprint-logical-block (nil nil)
      (when formals (pp-omdoc-source-theory (append formals assuming) id))
      (pprint-logical-block (nil nil)
	(pp-omdoc-beltid "theory" id)
	(pprint-newline :mandatory)
	(when formals (pp-omdoc-imports formals id))
	(pprint-newline :mandatory)
	(when importings
	  (pprint-logical-block (nil importings)
   	    (loop (pp-omdoc-beltid "imports" (gensym)
				   :attr (format nil "from=\"~A\"" (theory-name (pprint-pop))))
		  (pprint-exit-if-list-exhausted)
		  (pprint-newline :mandatory)))
	  (pprint-newline :mandatory))
	(pprint-logical-block (nil nil)
          (pp-omdoc-beltid "adt" (format nil "~A-adt" id) :attr "type=\"free\"")
	  (pprint-newline :mandatory)
;       (when (typep dt 'datatype-with-subtypes)
; 	(write 'WITH)
; 	(write 'SUBTYPES)
; 	(pprint-logical-block (nil (subtypes dt))
; 	  (loop (pp* (pprint-pop))
; 		(pprint-exit-if-list-exhausted)))
	  (pprint-logical-block (nil nil)
            (pp-omdoc-beltid "sortdef" id)
	    (pprint-newline :mandatory)
	    (pprint-logical-block (nil constructors)
  	      (loop (pp-omdoc* (pprint-pop))
		    (pprint-exit-if-list-exhausted)
		    (pprint-newline :mandatory)))
	    (pp-omdoc-eelt "sortdef"))
	  (pp-omdoc-eelt "adt")
	  (pprint-newline :mandatory)
	  (pprint-newline :mandatory)
	  (let ((*generated-by* (format nil " generated-by=\"~A\"" id)))
	    (pp-omdoc* (theory adt-theory)))
	  (pp-omdoc-eelt "theory"))))))

(defmethod pp-omdoc* ((decl simple-constructor))
  (with-slots (recognizer con-decl rec-decl acc-decls arguments id) decl
    (pprint-logical-block (nil nil)
      (pp-omdoc-beltid "constructor" id)
      (when acc-decls
	(pprint-newline :mandatory)
	(pprint-logical-block (nil acc-decls)
	  (loop (let ((acc (pprint-pop)))
		  (pp-omdoc-belt "argument"
				 :attr (format nil "sort=\"~A\""
					       (pp-omdoc-escape (id (range (type acc))))))
		  (pp-omdoc-eltid "selector" (id acc) nil)
		  (pp-omdoc-eelt "argument")
		  (pprint-exit-if-list-exhausted)
		  (pprint-newline :mandatory)))))
      (when recognizer
	(pp-omdoc-eltid "recognizer" (id rec-decl) nil))
      (pp-omdoc-eelt "constructor"))))

	      
;;;;;;;;;;;;;;;;;;;; abbreviation functions for OMDoc ;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; first we set up some infrastructure
;;;
;;; this function wraps an element of type 'elt' (with attribute string 'attr') 
;;; around its content. If the format is 
;;; - :pp, then pvs pp* is applied to the content, 
;;; - :pp-omdoc, then the OMDoc pretty-printing, 
;;; - :string, then write-string.
(defun pp-omdoc-elt (elt content &key attr format before-string after-string)
  (pprint-newline :mandatory)
  (pprint-logical-block (nil nil)
    (if content 
	(progn (pp-omdoc-belt elt :attr attr)
	       (when before-string (write-string before-string))
	       (cond ((eq format :pp) (pp* content))
		     ((eq format :pp-omdoc) (pp-omdoc* content))
		     ((eq format :string) (write-string (string content)))
		     (t (error "~A is an incorrect :format in pp-omdoc-elt" format)))
	       (when after-string (write-string after-string))
	       (pp-omdoc-eelt elt))
      (progn (if attr (format t "<~A ~A/>" elt attr) (format t "<~A/>" elt))))))


(defun pp-omdoc-belt (elt &key attr)
  (if attr (format t "<~A ~A>" elt attr) (format t "<~A>" elt))
  (pprint-indent :block 2))

(defun pp-omdoc-eelt (elt)
  (pprint-indent :block 0)
  (pprint-newline :mandatory)
  (format t "</~A>" elt))

;;; since many elements have an id attribute, which must be escaped, 
;;; here are special cases of the functions above
(defun pp-omdoc-beltid (elt id &key attr)
  (pp-omdoc-belt elt 
		 :attr (if attr
			   (concatenate 'string (format nil "id=\"~A\" ~A"
							(pp-omdoc-escape id)
							attr))
			 (concatenate 'string (format nil "id=\"~A\"" (pp-omdoc-escape id))))))

(defun pp-omdoc-eltid (elt id content &key attr format)
  (pp-omdoc-elt elt
		content
		:attr (if attr
			  (concatenate 'string
				       (format nil "id=\"~A\" ~A"
					       (pp-omdoc-escape id)
					       attr))
			(concatenate 'string (format nil "id=\"~A\"" (pp-omdoc-escape id))))
		:format format))

;;; concrete OMDoc elements

(defun pp-omdoc-oms (cd name)
  (format t "<OMS cd=\"~A\" name=\"~A\"/>" (pp-omdoc-escape cd) (pp-omdoc-escape name)))

(defun pp-omdoc-omstr (string)
  (format t "<OMSTR>~A</OMSTR>" (pp-omdoc-escape string)))

(defun pp-omdoc-omv (name)
  (format t "<OMV name=\"~A\"/>" (pp-omdoc-escape name)))

(defun pp-omdoc-omi (num)
  (format t  "<OMI>~A</OMI>" num))

;;; writes an OMA shell and recurses over list of arguments. If the optional
;;; string argument is present, then it is interpreted as a symbol with name 'str'
;;; and cd 'pvs' and prepended is as a OMS to the list.
(defun pp-omdoc-psloma (list &optional str)
  (pprint-logical-block (nil nil)
    (pp-omdoc-belt "OMA")
    (pprint-newline :mandatory)
    (when str
      (pp-omdoc-oms "pvs" str)
      (pprint-newline :mandatory))
    (pprint-logical-block (nil list)
      (loop (pp-omdoc* (pprint-pop))
	    (pprint-exit-if-list-exhausted)
	    (pprint-newline :mandatory)))
    (pp-omdoc-eelt "OMA")))

;;; writes an OMA with function <OMS cd="pvs" name="str"/>, with first argument
;;; <OMV name="id"/> and second argument arg. Useful for field-application. 
(defun pp-omdoc-psioma (str id arg)
  (pprint-logical-block (nil nil)
    (pp-omdoc-belt "OMA")
    (pprint-newline :mandatory)
    (pp-omdoc-oms "pvs" str)
    (pprint-newline :mandatory)
    (pp-omdoc-omv id)
    (pprint-newline :mandatory)
    (pp-omdoc* arg)
    (pp-omdoc-eelt "OMA")))

(defun pp-omdoc-psnoma (str num arg)
  (pprint-logical-block (nil nil)
    (pp-omdoc-belt "OMA")
    (pprint-newline :mandatory)
    (pp-omdoc-oms "pvs" str)
    (pprint-newline :mandatory)
    (pp-omdoc-omi num)
    (pprint-newline :mandatory)
    (pp-omdoc* arg)
    (pp-omdoc-eelt "OMA")))

;;; sym is a string (for the symbol of the binding)
;;; bvars a list of variable bindings
;;; exp the scope of the binder
(defun pp-omdoc-ombind (sym bvars expr)
  (pprint-logical-block (nil nil)
    (pp-omdoc-belt "OMBIND")
    (pprint-newline :mandatory)
    (pp-omdoc-oms "pvs" sym)
    (pprint-newline :mandatory)
    (pprint-logical-block (nil nil)
      (pp-omdoc-belt "OMBVAR")
      (pprint-indent :block 2)
      (pprint-newline :mandatory)
      (pprint-logical-block (nil bvars)
        (loop (pp-omdoc* (pprint-pop))
	      (pprint-exit-if-list-exhausted)
	      (pprint-newline :mandatory)))
      (pp-omdoc-eelt "OMBVAR"))
    (pprint-newline :mandatory)
    (pp-omdoc* expr)
    (pp-omdoc-eelt "OMBIND")))

;;; this funcion pretty-prints attributed variables if the kind argment is
;;; present, the type argument is ignored and a symbol for the kind is optput
(defun pp-omdoc-typed-var (varname type &optional kind)
  (pprint-logical-block (nil nil)
    (pp-omdoc-belt "OMATTR")
    (pprint-newline :mandatory)
    (pprint-logical-block (nil nil)
      (pp-omdoc-belt "OMATP")
      (pprint-newline :mandatory)
      (pprint-logical-block (nil nil)
  	(pp-omdoc-oms "mltt" "type")
	(pprint-newline :mandatory)
	(if kind (pp-omdoc-oms "pvs" kind) (pp-omdoc* type)))
      (pp-omdoc-eelt "OMATP"))
    (pprint-newline :mandatory)
    (pp-omdoc-omv varname)
    (pp-omdoc-eelt "OMATTR")))

(defun pp-omdoc-fmp (ex)
  (pprint-newline :mandatory)
  (pprint-logical-block (nil nil)
    (pp-omdoc-belt "FMP")
    (pprint-newline :mandatory)
    (pprint-logical-block (nil nil)
      (pp-omdoc-belt "OMOBJ")
      (pprint-newline :mandatory)
      (pp-omdoc* ex)
      (pp-omdoc-eelt "OMOBJ"))
    (pp-omdoc-eelt "FMP")))

;;; makes an OMDoc private element from the information in the arguments
;;; The format argument is that of pp-omdoc-elt
(defun pp-omdoc-private (data &key for id title cdate mdate descr attr format)
  (pprint-newline :mandatory)
  (pprint-logical-block (nil nil)
    (pp-omdoc-beltid 
     "private"
     (if id id (gensym))
     :attr (format nil "for=\"~A\" pto=\"pvs\" pto-version=\"3.0\"~A"
		   for
		   (if attr (concatenate 'string " " attr) "")))
    (when (or cdate title mdate) (pp-omdoc-metadata :title title :cdate cdate
						    :mdate mdate))
    (when descr (progn 
		  (pp-omdoc-belt "metadata")
		  (pp-omdoc-elt "Description" descr :format :string)
		  (pp-omdoc-eelt "metadata")))
    (if data
	(if format 
	    (pp-omdoc-elt "data" data :format format
			  :before-string "<![CDATA[" :after-string "]]>")
	  (pp-omdoc-elt "data" data :format :string
			:before-string "<![CDATA[" :after-string "]]>"))
      (pp-omdoc-elt "data" nil))      
      (pp-omdoc-eelt "private")))

(defun pp-omdoc-omit (what description &key for)
  (pp-omdoc-private nil :for for
		    :descr (format nil "PVS does not need this ~A" description)
		    :attr (format nil "replaces=\"~A\"" (pp-omdoc-escape what))))

(defun pp-omdoc-script (decl for)
  (with-slots (id description script create-date) decl
    (pp-omdoc-private (format nil "~A" script) :for for :id id :cdate create-date
		      :descr description :format :string
		      :attr  "type=\"proofscript\"")))
  
(defun pp-omdoc-metadata (&key creator title cdate mdate description)
  (pprint-newline :mandatory)
  (pprint-logical-block (nil nil)
    (pp-omdoc-belt "metadata")
    (when creator (pp-omdoc-elt "Creator" creator :format :string))
    (when title (pp-omdoc-elt "Title" description :format :string))
    (when cdate
      (pp-omdoc-elt "Date"
		    (etypecase cdate
		      (string cdate)
		      (bignum (pp-omdoc-date-string cdate)))
		    :attr "action=\"created\""
		    :format :string))
    (when mdate
      (pp-omdoc-elt "Date"
		    (etypecase mdate
		      (string mdate)
		      (bignum (pp-omdoc-date-string mdate)))
		    :attr "action=\"modified\""
		    :format :string))
    (pp-omdoc-eelt "metadata")))

(defun pp-omdoc-date-string (num)
  (multiple-value-bind (second minute hour date month year)
      (decode-universal-time num)
    (format nil "~A-~A-~A@~A:~A:~A" year month date hour minute second)))

(defun pp-omdoc-with-omobj (elt ex &key attr id)
  (pprint-logical-block (nil nil)
    (if id 
	(pp-omdoc-beltid  elt id :attr attr)
      (pp-omdoc-belt elt :attr attr))
    (pprint-newline :mandatory)
    (pp-omdoc-belt "OMOBJ")
    (pprint-newline :mandatory)
    (pp-omdoc* ex)
    (pp-omdoc-eelt "OMOBJ")
    (pp-omdoc-eelt elt)))

;;; since OMDoc is an XML format, we have to escape the symbols &, <, >, which
;;; would confuse the XML parser that reads OMDoc. This function does the
;;; necessary translation. 
(defun pp-omdoc-escape (name)
  (labels ((replace-char (char)
			 (if (stringp char) char
			   (case char
			     (#\& "&amp;")
			     (#\< "&lt;")
			     (#\> "&gt;")
			     (t   (string char))))))
    (let ((name (etypecase name
		  (symbol (symbol-name name))
		  (string name))))
      (if (equal (length name) 1)
	  (replace-char (char name 0))
	(format nil "~A" (reduce #'(lambda (string char)
				     (concatenate 'string (replace-char string)(replace-char char)))
				 name))))))

(defun pp-omdoc-assdef (elt id cmp infmp &key attr)
  (pprint-logical-block (nil nil)
    (pp-omdoc-beltid elt id :attr (concatenate 'string attr *generated-by*))
    (unless (equal cmp "") (pp-omdoc-elt "CMP" cmp :format :string))
    (when infmp (pp-omdoc-fmp infmp))
    (pp-omdoc-eelt elt)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; TODO LIST ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; 
;;;
;;; 1) the output is valid XML, but the back-translation to pvs does not typecheck
;;;    yet.
;;;
;;; 2) abstract data types need to be generated as OMDoc adt elements
;;;
;;; 3) theory interpretations are not generated yet
;;;
;;; 4) the dependent record, tuple, cotuple types should be somehow cast as
;;;    binding objects in OMBIND.
;;;
;;; 5) the include statements for prelude theories are not complete yet. Need a
;;;    function from Sam that returns the necessary theory instances.
;;;
;;; 6) proof output, and an infrastructure to get at the proofs themselves.
;;;    see pp-omdoc-proof.lisp
;;;
;;; 7) subdivide the current pvs.omdoc file into a logical language hierarchy, and
;;;    change the OMS generated here accordingly.
;;;
;;; 8) glean the comments out of the prelude and stick them into the CMP elements
;;; 
;;; 9) do something for codatatyes
