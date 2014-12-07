(setq axlcat '(Sequence
	       (Sequence
		(Sequence
		 (Import () LangLib)
		 (Import () MachLib)
		 (Import () BasicLib))
		(Import () Machine))
	       (Define
		 (Declare BasicType Category)
		 (With
		  ()
		  (Sequence
		   (Declare = (Apply -> (Comma % %) Boolean))
		   (Declare ~= (Apply -> (Comma % %) Boolean))
		   (Declare << (Apply -> (Comma TextWriter %) TextWriter))
		   (Declare << (Apply -> % (Apply -> TextWriter TextWriter)))
		   (Declare sample %)
		   (Declare hash (Apply -> % SingleInteger))
		   (Declare case (Apply -> (Comma % %) Boolean))
		   (Default
		     (Define
		       (Declare ~= (Apply -> (Comma (Declare x %) (Declare y %)) Boolean))
		       (Lambda
			(Comma (Declare x %) (Declare y %))
			Boolean
			(Label ~= (Not (Test (Apply = x y)))))))
		   (Default
		     (Define
		       (Declare hash (Apply -> (Declare x %) SingleInteger))
		       (Lambda
			(Comma (Declare x %))
			SingleInteger
			(Label hash (CoerceTo (Qualify \0 Machine) SingleInteger)))))
		   (Default
		     (Define
		       (Declare
			<<
			(Apply -> (Declare x %) (Apply -> (Declare p TextWriter) TextWriter)))
		       (Lambda
			(Comma (Declare x %))
			(Apply -> (Declare p TextWriter) TextWriter)
			(Lambda
			 (Comma (Declare p TextWriter))
			 TextWriter
			 (Label << (Apply << p x))))))
		   (Default
		     (Define
		       (Declare case (Apply -> (Comma (Declare x %) (Declare y %)) Boolean))
		       (Lambda
			(Comma (Declare x %) (Declare y %))
			Boolean
			(Label case (Apply = x y))))))))
	       (Define
		 (Declare Logic Category)
		 (With
		  BasicType
		  (Sequence
		   (Declare ~ (Apply -> % %))
		   (Declare |/\\| (Apply -> (Comma % %) %))
		   (Declare |\\/| (Apply -> (Comma % %) %))
		   (Declare xor (Apply -> (Comma % %) %))
		   (Default
		     (Define
		       (Declare |\\/| (Apply -> (Comma (Declare x %) (Declare y %)) %))
		       (Lambda
			(Comma (Declare x %) (Declare y %))
			%
			(Label |\\/| (Apply ~ (Apply |/\\| (Apply ~ x) (Apply ~ y)))))))
		   (Default
		     (Define
		       (Declare xor (Apply -> (Comma (Declare x %) (Declare y %)) %))
		       (Lambda
			(Comma (Declare x %) (Declare y %))
			%
			(Label
			 xor
			 (Apply |\\/| (Apply |/\\| x (Apply ~ y)) (Apply |/\\| (Apply ~ x) y)))))))))
	       (Define
		 (Declare Conditional Category)
		 (With BasicType (Declare test (Apply -> % Boolean))))
	       (Define
		 (Declare Aggregate (Apply -> (Declare S Type) Category))
		 (Lambda
		  (Comma (Declare S Type))
		  Category
		  (Label
		   Aggregate
		   (With
		    BasicType
		    (Sequence
		     (Declare empty? (Apply -> % Boolean))
		     (Declare generator (Apply -> % (Apply Generator S)))
		     (Declare map (Apply -> (Comma (Apply -> S S) %) %))
		     (Export () S ()))))))
	       (Define
		 (Declare FiniteAggregate (Apply -> (Declare S Type) Category))
		 (Lambda
		  (Comma (Declare S Type))
		  Category
		  (Label
		   FiniteAggregate
		   (With
		    (Apply Aggregate S)
		    (Sequence
		     (Declare |#| (Apply -> % SingleInteger))
		     (Default
		       (Define
			 (Declare empty? (Apply -> (Declare a %) Boolean))
			 (Lambda
			  (Comma (Declare a %))
			  Boolean
			  (Label
			   empty?
			   (Sequence
			    (Sequence (Import () SingleInteger) (Import () Machine))
			    (CoerceTo (Apply = (CoerceTo (Apply |#| a) SInt) \0) Boolean)))))))))))
	       (Define
		 (Declare LinearAggregate (Apply -> (Declare S Type) Category))
		 (Lambda
		  (Comma (Declare S Type))
		  Category
		  (Label
		   LinearAggregate
		   (With
		    (Apply Aggregate S)
		    (Sequence
		     (Declare empty (Apply -> (Comma) %))
		     (Declare bracket (Apply -> (Apply Generator S) %))
		     (Declare bracket (Apply -> (Apply Tuple S) %))
		     (Declare map (Apply -> (Comma (Apply -> (Comma S S) S) % %) %))
		     (Declare apply (Apply -> (Comma % SingleInteger) S))
		     (Default
		       (Sequence
			(Define
			  (Declare empty (Apply -> (Comma) %))
			  (Lambda (Comma) % (Label empty (Apply bracket))))
			(Define
			  (Declare
			   map
			   (Apply -> (Comma (Declare f (Apply -> S S)) (Declare a %)) %))
			  (Lambda
			   (Comma (Declare f (Apply -> S S)) (Declare a %))
			   %
			   (Label map (Apply bracket (Collect (Apply f x) (For x a ()))))))
			(Define
			  (Declare
			   map
			   (Apply
			    ->
			    (Comma
			     (Declare f (Apply -> (Comma S S) S))
			     (Declare a %)
			     (Declare b %))
			    %))
			  (Lambda
			   (Comma
			    (Declare f (Apply -> (Comma S S) S))
			    (Declare a %)
			    (Declare b %))
			   %
			   (Label
			    map
			    (Apply bracket (Collect (Apply f x y) (For x a ()) (For y b ())))))))))))))
	       (Define
		 (Declare FiniteLinearAggregate (Apply -> (Declare S Type) Category))
		 (Lambda
		  (Comma (Declare S Type))
		  Category
		  (Label
		   FiniteLinearAggregate
		   (Apply Join (Apply FiniteAggregate S) (Apply LinearAggregate S)))))
	       (Define
		 (Declare Finite Category)
		 (With BasicType (Declare |#| Integer)))
	       (Define
		 (Declare Order Category)
		 (With
		  BasicType
		  (Sequence
		   (Declare > (Apply -> (Comma % %) Boolean))
		   (Declare < (Apply -> (Comma % %) Boolean))
		   (Declare >= (Apply -> (Comma % %) Boolean))
		   (Declare <= (Apply -> (Comma % %) Boolean))
		   (Declare max (Apply -> (Comma % %) %))
		   (Declare min (Apply -> (Comma % %) %))
		   (Default
		     (Sequence
		      (Define
			(Declare < (Apply -> (Comma (Declare x %) (Declare y %)) Boolean))
			(Lambda
			 (Comma (Declare x %) (Declare y %))
			 Boolean
			 (Label < (Apply > y x))))
		      (Define
			(Declare >= (Apply -> (Comma (Declare x %) (Declare y %)) Boolean))
			(Lambda
			 (Comma (Declare x %) (Declare y %))
			 Boolean
			 (Label >= (Not (Test (Apply < x y))))))
		      (Define
			(Declare <= (Apply -> (Comma (Declare x %) (Declare y %)) Boolean))
			(Lambda
			 (Comma (Declare x %) (Declare y %))
			 Boolean
			 (Label <= (Not (Test (Apply > x y))))))
		      (Define
			(Declare max (Apply -> (Comma (Declare x %) (Declare y %)) %))
			(Lambda
			 (Comma (Declare x %) (Declare y %))
			 %
			 (Label max (If (Test (Apply > x y)) x y))))
		      (Define
			(Declare min (Apply -> (Comma (Declare x %) (Declare y %)) %))
			(Lambda
			 (Comma (Declare x %) (Declare y %))
			 %
			 (Label min (If (Test (Apply < x y)) x y))))))
		   (Default
		     (Sequence
		      ()
		      (Define
			(Declare
			 >
			 (Apply -> (Comma (Declare x %) (Declare y %)) (Apply Cross Boolean %)))
			(Lambda
			 (Comma (Declare x %) (Declare y %))
			 (Apply Cross Boolean %)
			 (Label > (Comma (Apply > x y) y))))
		      (Define
			(Declare
			 <
			 (Apply -> (Comma (Declare x %) (Declare y %)) (Apply Cross Boolean %)))
			(Lambda
			 (Comma (Declare x %) (Declare y %))
			 (Apply Cross Boolean %)
			 (Label < (Comma (Apply < x y) y))))
		      (Define
			(Declare
			 >=
			 (Apply -> (Comma (Declare x %) (Declare y %)) (Apply Cross Boolean %)))
			(Lambda
			 (Comma (Declare x %) (Declare y %))
			 (Apply Cross Boolean %)
			 (Label >= (Comma (Apply >= x y) y))))
		      (Define
			(Declare
			 <=
			 (Apply -> (Comma (Declare x %) (Declare y %)) (Apply Cross Boolean %)))
			(Lambda
			 (Comma (Declare x %) (Declare y %))
			 (Apply Cross Boolean %)
			 (Label <= (Comma (Apply <= x y) y))))
		      (Define
			(Declare
			 >
			 (Apply
			  ->
			  (Comma (Declare bx (Apply Cross Boolean %)) (Declare y %))
			  (Apply Cross Boolean %)))
			(Lambda
			 (Comma (Declare bx (Apply Cross Boolean %)) (Declare y %))
			 (Apply Cross Boolean %)
			 (Label
			  >
			  (Sequence
			   (Assign (Comma b x) bx)
			   (Comma (And (Test b) (Test (Apply > x y))) y)))))
		      (Define
			(Declare
			 <
			 (Apply
			  ->
			  (Comma (Declare bx (Apply Cross Boolean %)) (Declare y %))
			  (Apply Cross Boolean %)))
			(Lambda
			 (Comma (Declare bx (Apply Cross Boolean %)) (Declare y %))
			 (Apply Cross Boolean %)
			 (Label
			  <
			  (Sequence
			   (Assign (Comma b x) bx)
			   (Comma (And (Test b) (Test (Apply < x y))) y)))))
		      (Define
			(Declare
			 >=
			 (Apply
			  ->
			  (Comma (Declare bx (Apply Cross Boolean %)) (Declare y %))
			  (Apply Cross Boolean %)))
			(Lambda
			 (Comma (Declare bx (Apply Cross Boolean %)) (Declare y %))
			 (Apply Cross Boolean %)
			 (Label
			  >=
			  (Sequence
			   (Assign (Comma b x) bx)
			   (Comma (And (Test b) (Test (Apply >= x y))) y)))))
		      (Define
			(Declare
			 <=
			 (Apply
			  ->
			  (Comma (Declare bx (Apply Cross Boolean %)) (Declare y %))
			  (Apply Cross Boolean %)))
			(Lambda
			 (Comma (Declare bx (Apply Cross Boolean %)) (Declare y %))
			 (Apply Cross Boolean %)
			 (Label
			  <=
			  (Sequence
			   (Assign (Comma b x) bx)
			   (Comma (And (Test b) (Test (Apply <= x y))) y)))))
		      (Define
			(Declare
			 >
			 (Apply
			  ->
			  (Comma (Declare bx (Apply Cross Boolean %)) (Declare y %))
			  Boolean))
			(Lambda
			 (Comma (Declare bx (Apply Cross Boolean %)) (Declare y %))
			 Boolean
			 (Label
			  >
			  (Sequence (Assign (Comma b x) bx) (And (Test b) (Test (Apply > x y)))))))
		      (Define
			(Declare
			 <
			 (Apply
			  ->
			  (Comma (Declare bx (Apply Cross Boolean %)) (Declare y %))
			  Boolean))
			(Lambda
			 (Comma (Declare bx (Apply Cross Boolean %)) (Declare y %))
			 Boolean
			 (Label
			  <
			  (Sequence (Assign (Comma b x) bx) (And (Test b) (Test (Apply < x y)))))))
		      (Define
			(Declare
			 >=
			 (Apply
			  ->
			  (Comma (Declare bx (Apply Cross Boolean %)) (Declare y %))
			  Boolean))
			(Lambda
			 (Comma (Declare bx (Apply Cross Boolean %)) (Declare y %))
			 Boolean
			 (Label
			  >=
			  (Sequence
			   (Assign (Comma b x) bx)
			   (And (Test b) (Test (Apply >= x y)))))))
		      (Define
			(Declare
			 <=
			 (Apply
			  ->
			  (Comma (Declare bx (Apply Cross Boolean %)) (Declare y %))
			  Boolean))
			(Lambda
			 (Comma (Declare bx (Apply Cross Boolean %)) (Declare y %))
			 Boolean
			 (Label
			  <=
			  (Sequence
			   (Assign (Comma b x) bx)
			   (And (Test b) (Test (Apply <= x y))))))))))))
	       (Define
		 (Declare OrderedFinite Category)
		 (With
		  (Apply Join Finite Order)
		  (Sequence (Declare min %) (Declare max %))))
	       (Define
		 (Declare ArithmeticSystem Category)
		 (With
		  ()
		  (Sequence
		   (Declare \0 %)
		   (Declare + (Apply -> % %))
		   (Declare + (Apply -> (Comma % %) %))
		   (Declare - (Apply -> % %))
		   (Declare - (Apply -> (Comma % %) %))
		   (Declare \1 %)
		   (Declare * (Apply -> (Comma % %) %))
		   (Declare ^ (Apply -> (Comma % Integer) %))
		   (Declare coerce (Apply -> Integer %))
		   (Declare coerce (Apply -> SingleInteger %)))))
	       (Define
		 (Declare Monoid Category)
		 (With
		  BasicType
		  (Sequence
		   (Declare \1 %)
		   (Declare * (Apply -> (Comma % %) %))
		   (Declare ^ (Apply -> (Comma % Integer) %)))))
	       (Define
		 (Declare Group Category)
		 (With
		  Monoid
		  (Sequence
		   (Declare / (Apply -> (Comma % %) %))
		   (Declare |\\| (Apply -> (Comma % %) %))
		   (Declare inv (Apply -> % %))
		   (Default
		     (Define
		       (Declare / (Apply -> (Comma (Declare a %) (Declare b %)) %))
		       (Lambda
			(Comma (Declare a %) (Declare b %))
			%
			(Label / (Apply * a (Apply inv b))))))
		   (Default
		     (Define
		       (Declare |\\| (Apply -> (Comma (Declare a %) (Declare b %)) %))
		       (Lambda
			(Comma (Declare a %) (Declare b %))
			%
			(Label |\\| (Apply * (Apply inv a) b))))))))
	       (Define
		 (Declare AbelianMonoid Category)
		 (With
		  BasicType
		  (Sequence
		   (Declare \0 %)
		   (Declare + (Apply -> % %))
		   (Declare + (Apply -> (Comma % %) %))
		   (Declare zero? (Apply -> % Boolean))
		   (Default
		     (Define
		       (Declare + (Apply -> (Declare x %) %))
		       (Lambda (Comma (Declare x %)) % (Label + x))))
		   (Default
		     (Define
		       (Declare zero? (Apply -> (Declare x %) Boolean))
		       (Lambda (Comma (Declare x %)) Boolean (Label zero? (Apply = x \0)))))
		   (Default (Define (Declare sample %) \0)))))
	       (Define
		 (Declare AbelianGroup Category)
		 (With
		  AbelianMonoid
		  (Sequence
		   (Declare - (Apply -> % %))
		   (Declare - (Apply -> (Comma % %) %))
		   (Default
		     (Define
		       (Declare - (Apply -> (Comma (Declare a %) (Declare b %)) %))
		       (Lambda
			(Comma (Declare a %) (Declare b %))
			%
			(Label - (Apply + a (Apply - b)))))))))
	       (Define
		 (Declare Ring Category)
		 (Apply Join ArithmeticSystem Monoid AbelianGroup))
	       (Define
		 (Declare EuclideanDomain Category)
		 (With
		  Ring
		  (Sequence
		   (Declare gcd (Apply -> (Comma % %) %))
		   (Declare quo (Apply -> (Comma % %) %))
		   (Declare rem (Apply -> (Comma % %) %))
		   (Declare divide (Apply -> (Comma % %) (Comma % %)))
		   (Default
		     (Define
		       (Declare
			divide
			(Apply -> (Comma (Declare a %) (Declare b %)) (Comma % %)))
		       (Lambda
			(Comma (Declare a %) (Declare b %))
			(Comma % %)
			(Label divide (Comma (Apply quo a b) (Apply rem a b)))))))))
	       (Define
		 (Declare Field Category)
		 (With
		  (Apply Join EuclideanDomain Group)
		  (Default
		    (Sequence
		     (Define
		       (Declare gcd (Apply -> (Comma (Declare a %) (Declare b %)) %))
		       (Lambda
			(Comma (Declare a %) (Declare b %))
			%
			(Label
			 gcd
			 (Sequence
			  (Exit (Test (And (Test (Apply zero? a)) (Test (Apply zero? b)))) \0)
			  \1))))
		     (Define
		       (Declare quo (Apply -> (Comma (Declare a %) (Declare b %)) %))
		       (Lambda
			(Comma (Declare a %) (Declare b %))
			%
			(Label quo (Apply / a b))))
		     (Define
		       (Declare rem (Apply -> (Comma (Declare a %) (Declare b %)) %))
		       (Lambda (Comma (Declare a %) (Declare b %)) % (Label rem \0)))
		     (Define
		       (Declare unit? (Apply -> (Declare x %) Boolean))
		       (Lambda
			(Comma (Declare x %))
			Boolean
			(Label unit? (Not (Test (Apply zero? x))))))))))
	       (Define
		 (Declare FiniteField Category)
		 (With
		  (Apply Join Finite Field)
		  (Sequence
		   (Declare integer (Apply -> Literal %))
		   (Declare reduce (Apply -> SingleInteger %))
		   (Declare lift (Apply -> % SingleInteger)))))
	       (Define
		 (Declare OrderedAbelianMonoid Category)
		 (Apply Join Order AbelianMonoid))
	       (Define
		 (Declare OrderedAbelianGroup Category)
		 (Apply Join OrderedAbelianMonoid AbelianGroup))
	       (Define
		 (Declare OrderedRing Category)
		 (With
		  (Apply Join OrderedAbelianGroup Ring)
		  (Sequence
		   (Declare abs (Apply -> % %))
		   (Declare sign (Apply -> % %))
		   (Declare negative? (Apply -> % Boolean))
		   (Declare positive? (Apply -> % Boolean))
		   (Default
		     (Sequence
		      (Define
			(Declare abs (Apply -> (Declare x %) %))
			(Lambda
			 (Comma (Declare x %))
			 %
			 (Label abs (If (Test (Apply > x \0)) x (Apply - x)))))
		      (Define
			(Declare sign (Apply -> (Declare x %) %))
			(Lambda
			 (Comma (Declare x %))
			 %
			 (Label
			  sign
			  (Sequence
			   (Exit (Test (Apply > x \0)) \1)
			   (Exit (Test (Apply < x \0)) (Apply - \1))
			   \0))))
		      (Define
			(Declare negative? (Apply -> (Declare x %) Boolean))
			(Lambda
			 (Comma (Declare x %))
			 Boolean
			 (Label negative? (Apply < x \0))))
		      (Define
			(Declare positive? (Apply -> (Declare x %) Boolean))
			(Lambda
			 (Comma (Declare x %))
			 Boolean
			 (Label positive? (Apply > x \0)))))))))
	       (Define
		 (Declare IntegerNumberSystem Category)
		 (With
		  (Apply Join OrderedRing EuclideanDomain)
		  (Sequence
		   (Declare integer (Apply -> Literal %))
		   (Declare even? (Apply -> % Boolean))
		   (Declare odd? (Apply -> % Boolean))
		   (Declare single? (Apply -> % Boolean))
		   (Declare prev (Apply -> % %))
		   (Declare next (Apply -> % %))
		   (Declare mod (Apply -> (Comma % %) %))
		   (Declare length (Apply -> % SingleInteger))
		   (Declare shift (Apply -> (Comma % SingleInteger) %))
		   (Declare bit (Apply -> (Comma % SingleInteger) Boolean))
		   (Declare retract (Apply -> % SingleInteger))
		   (Declare intToString (Apply -> % String)))))
	       (Define
		 (Declare FloatingPointNumberSystem Category)
		 (With
		  (Apply Join OrderedRing Field)
		  (Sequence
		   (Declare float (Apply -> Literal %))
		   (Declare << (Apply -> (Comma % %) Boolean))
		   (Declare >> (Apply -> (Comma % %) Boolean))
		   (Declare coerce (Apply -> Integer %))
		   (Declare coerce (Apply -> SingleInteger %))
		   (Declare
		    step
		    (Apply -> SingleInteger (Apply -> (Comma % %) (Apply Generator %))))
		   (Declare integer (Apply -> % Integer))
		   (Declare fraction (Apply -> % %))
		   (Declare
		    round
		    (Apply
		     ->
		     (Comma % (Define (Declare mode RoundingMode) (Apply nearest)))
		     Integer))
		   (Declare prev (Apply -> % %))
		   (Declare next (Apply -> % %))
		   (Declare floor (Apply -> % %))
		   (Declare ceiling (Apply -> % %))
		   (Declare
		    round+
		    (Apply
		     ->
		     (Comma % % (Define (Declare mode RoundingMode) (Apply nearest)))
		     %))
		   (Declare
		    round-
		    (Apply
		     ->
		     (Comma % % (Define (Declare mode RoundingMode) (Apply nearest)))
		     %))
		   (Declare
		    round*
		    (Apply
		     ->
		     (Comma % % (Define (Declare mode RoundingMode) (Apply nearest)))
		     %))
		   (Declare
		    round*+
		    (Apply
		     ->
		     (Comma % % % (Define (Declare mode RoundingMode) (Apply nearest)))
		     %))
		   (Declare
		    round/
		    (Apply
		     ->
		     (Comma % % (Define (Declare mode RoundingMode) (Apply nearest)))
		     %))
		   (Declare mantissa (Apply -> % Integer))
		   (Declare exponent (Apply -> % Integer))
		   (Export () RoundingMode ()))))
	       (Define
		 (Declare ElementaryFunctions Category)
		 (With
		  ()
		  (Sequence
		   (Declare exp (Apply -> % %))
		   (Declare sin (Apply -> % %))
		   (Declare cos (Apply -> % %))
		   (Declare tan (Apply -> % %))
		   (Declare sinh (Apply -> % %))
		   (Declare cosh (Apply -> % %))
		   (Declare tanh (Apply -> % %))
		   (Declare log (Apply -> % %))
		   (Declare log10 (Apply -> % %))
		   (Declare asin (Apply -> % %))
		   (Declare acos (Apply -> % %))
		   (Declare atan (Apply -> % %))
		   (Declare asinh (Apply -> % %))
		   (Declare acosh (Apply -> % %))
		   (Declare atanh (Apply -> % %))
		   (Declare sqrt (Apply -> % %))
		   (Declare root (Apply -> (Comma % SingleInteger) %))
		   (Declare ^ (Apply -> (Comma % %) %)))))
	       (Define
		 (Declare FortranMultiArray Category)
		 (With
		  FortranArray
		  (Sequence
		   ()
		   ()
		   ()
		   (Declare
		    flatten
		    (Apply
		     ->
		     (Comma
		      (Declare A Type)
		      A
		      SingleInteger
		      (Apply -> (Comma A SingleInteger) %))
		     (Qualify Arr Machine)))
		   (Declare
		    unflatten
		    (Apply
		     ->
		     (Comma
		      %
		      (Qualify Arr Machine)
		      (Qualify SInt Machine)
		      (Qualify SInt Machine))
		     (Comma))))))
	       (Define
		 (Declare FortranFString Category)
		 (With
		  DenseStorageCategory
		  (Sequence () (Declare |#| (Apply -> (Comma) (Qualify SInt Machine))))))
	       (Define
		 (Declare FortranFStringArray Category)
		 (With
		  FortranArray
		  (Sequence () (Declare |#| (Apply -> (Comma) (Qualify SInt Machine))))))
	       (Define
		 (Declare DenseStorageCategory Category)
		 (With
		  ()
		  (Sequence
		   ()
		   ()
		   ()
		   (Declare
		    PackedArrayNew
		    (Apply -> (Qualify SInt Machine) (Qualify Arr Machine)))
		   (Declare
		    PackedArrayGet
		    (Apply -> (Comma (Qualify Arr Machine) (Qualify SInt Machine)) %))
		   (Declare
		    PackedArraySet
		    (Apply -> (Comma (Qualify Arr Machine) (Qualify SInt Machine) %) %))
		   (Declare PackedRecordSet (Apply -> (Comma (Qualify Ptr Machine) %) %))
		   (Declare PackedRecordGet (Apply -> (Qualify Ptr Machine) %))
		   (Declare PackedRepSize (Apply -> (Comma) (Qualify SInt Machine))))))
	       (Define
		 (Declare PrimitiveArrayCategory (Apply -> (Declare S Type) Category))
		 (Lambda
		  (Comma (Declare S Type))
		  Category
		  (Label
		   PrimitiveArrayCategory
		   (With
		    ()
		    (Sequence
		     (Declare new (Apply -> SingleInteger %))
		     (Declare new (Apply -> (Comma SingleInteger S) %))
		     (Declare dispose! (Apply -> % (Comma)))
		     (Declare set! (Apply -> (Comma % SingleInteger S) S))
		     (Declare apply (Apply -> (Comma % SingleInteger) S))
		     (Declare
		      resize!
		      (Apply
		       ->
		       (Comma % (Declare osz SingleInteger) (Declare nsz SingleInteger))
		       %))
		     (Export () S ()))))))))

(defun extract-defaults (sexp)
  (declare ((input "An S-expression produced by aldor -Fax")
	    (output "A list of defaults.")))
  (let ((decs (cddr sexp)))
    (with-open-file (str (make-pathname :name "test" :type "xml")
                         :direction :output :if-exists :supersede)
                    (format t "Writing ~A~%" 'test)
		    (mapcar #'(lambda (el) (print-cat str el)) decs))))

(defun print-cat (str thy)
  (let ((name (cadr (second thy)))
	(decs (cdr (third (third thy)))))
    (format str "<theory id='~A'>" name)
    (mapcar #'(lambda (el) (print-dec str el)) decs)
    (format str "</theory>")))

(defun print-dec (str dec)
  (cond ((eq (first dec) 'Declare)
	 (format t "ignoring Declare~%"))
	((eq (first dec) 'Default)
	 (format str "<definition id='~A-def' for='~A' kind='object' scope='global'>"
		 (second (second (second dec)))
		 (second (second (second dec)))
		 (format nil "<FMP/>")
		 (format nil "</definition>")))))

(defun print-om (sexp)
  (cond ((equal sexp "->")
	 (format t "<OMS cd='aldor' name='mapsto'/>"))
	((symbolp sexp) (format t "<OMS name='~A'/>" sexp))
	((eq (first sexp) 'apply)
	 (format t "<OMA>" (mapcar #'print-om (rest sexp)))
	 (format t "</OMA>"))
	((eq (first sexp) 'Comma)
	 (mapcar #'print-om (rest sexp)))))
	



	   
