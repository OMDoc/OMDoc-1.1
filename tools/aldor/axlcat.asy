((|Declare|
    |PrimitiveArrayCategory|
    (|Apply|
      ->
      (|Declare|
        s
        |Type|
        ((|symeNameCode| . 200124)
          (|symeTypeCode| . 547582661)
          (|domExports|)))
      (|Define|
        (|Declare| (|Label| |PrimitiveArrayCategory| ()) |Category|)
        (|With|
          ()
          (|Sequence|
            (|Declare|
              |new|
              (|Apply| -> |SingleInteger| %)
              ((|documentation| .
                  " `new(n)' creates a new empty array with space for
 n elements.
")
                (|symeNameCode| . 318528389)
                (|symeTypeCode| . 352135667)))
            (|Declare|
              |new|
              (|Apply| -> (|Comma| |SingleInteger| s) %)
              ((|documentation| .
                  " `new(n,s)' creates a new array with n elements,
 each initialized to s.
")
                (|symeNameCode| . 318528389)
                (|symeTypeCode| . 960759087)))
            (|Declare|
              |dispose!|
              (|Apply| -> % (|Comma|))
              ((|documentation| .
                  " `dispose! a' indicates that `a' will no longer be used.
")
                (|symeNameCode| . 614579040)
                (|symeTypeCode| . 585233638)))
            (|Declare|
              |set!|
              (|Apply| -> (|Comma| % |SingleInteger| s) s)
              ((|documentation| .
                  " `v.n := s' sets the `n'-th element of `v' to `s'.
")
                (|symeNameCode| . 55906833)
                (|symeTypeCode| . 974440431)))
            (|Declare|
              |apply|
              (|Apply| -> (|Comma| % |SingleInteger|) s)
              ((|documentation| . " `v.n' extracts the `n'-th element of `v'.
")
                (|symeNameCode| . 306472243)
                (|symeTypeCode| . 546428975)))
            (|Declare|
              |resize!|
              (|Apply|
                ->
                (|Comma|
                  %
                  (|Declare|
                    |osz|
                    |SingleInteger|
                    ((|symeNameCode| . 318072215) (|symeTypeCode| . 83725344)))
                  (|Declare|
                    |nsz|
                    |SingleInteger|
                    ((|symeNameCode| . 318531990) (|symeTypeCode| . 83725344))))
                %)
              ((|documentation| .
                  " `resize!(v, oldsize, newsize)' returns an array with
 the number of elements equal to newsize and containing
 the first m elements of `v', where `m' is the minimum of
 newsize and oldsize.  The value `v' must no longer be used.
")
                (|symeNameCode| . 160175762)
                (|symeTypeCode| . 1048516490)))
            (|Export| () s ())))))
    ((|documentation| .
        " `PrimitiveArrayCategory' provides primitive array operations.
 
 Author: AXIOM-XL library
 Date Created: 1999
 Keywords: array
")
      (|symeNameCode| . 191439868)
      (|symeTypeCode| . 253040407)
      (|catExports|
        (|Declare|
          |new|
          (|Apply| -> |SingleInteger| %)
          ((|documentation| .
              " `new(n)' creates a new empty array with space for
 n elements.
")
            (|symeNameCode| . 318528389)
            (|symeTypeCode| . 352135667)))
        (|Declare|
          |new|
          (|Apply| -> (|Comma| |SingleInteger| s) %)
          ((|documentation| .
              " `new(n,s)' creates a new array with n elements,
 each initialized to s.
")
            (|symeNameCode| . 318528389)
            (|symeTypeCode| . 960759087)))
        (|Declare|
          |dispose!|
          (|Apply| -> % (|Comma|))
          ((|documentation| .
              " `dispose! a' indicates that `a' will no longer be used.
")
            (|symeNameCode| . 614579040)
            (|symeTypeCode| . 585233638)))
        (|Declare|
          |set!|
          (|Apply| -> (|Comma| % |SingleInteger| s) s)
          ((|documentation| .
              " `v.n := s' sets the `n'-th element of `v' to `s'.
")
            (|symeNameCode| . 55906833)
            (|symeTypeCode| . 974440431)))
        (|Declare|
          |apply|
          (|Apply| -> (|Comma| % |SingleInteger|) s)
          ((|documentation| . " `v.n' extracts the `n'-th element of `v'.
")
            (|symeNameCode| . 306472243)
            (|symeTypeCode| . 546428975)))
        (|Declare|
          |resize!|
          (|Apply|
            ->
            (|Comma|
              %
              (|Declare|
                |osz|
                |SingleInteger|
                ((|symeNameCode| . 318072215) (|symeTypeCode| . 83725344)))
              (|Declare|
                |nsz|
                |SingleInteger|
                ((|symeNameCode| . 318531990) (|symeTypeCode| . 83725344))))
            %)
          ((|documentation| .
              " `resize!(v, oldsize, newsize)' returns an array with
 the number of elements equal to newsize and containing
 the first m elements of `v', where `m' is the minimum of
 newsize and oldsize.  The value `v' must no longer be used.
")
            (|symeNameCode| . 160175762)
            (|symeTypeCode| . 1048516490)))
        (|Declare|
          %%
          (|Apply| |PrimitiveArrayCategory| s)
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 63698103))))))
  (|Declare|
    |FortranFStringArray|
    (|Define|
      (|Declare| (|Label| |FortranFStringArray| ()) |Category|)
      (|With|
        |FortranArray|
        (|Sequence|
          ()
          (|Declare|
            |#|
            (|Apply| -> (|Comma|) (|Qualify| |SInt| |Machine|))
            ((|documentation| . " Length of the fixed-string elements.
")
              (|symeNameCode| . 200076)
              (|symeTypeCode| . 932039034))))))
    ((|documentation| .
        " Domains satisfying FortranFStringArray can be passed to Fortran
 as values declared as `CHARACTER *(N) arg(M)'. That is, an array
 of M elements, each element being a CHARACTER*N

 This is a language defined category.
")
      (|symeNameCode| . 114082915)
      (|symeTypeCode| . 398663959)
      (|catExports|
        (|Declare|
          %%
          |FortranArray|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 398498402)))
        (|Declare|
          |#|
          (|Apply| -> (|Comma|) (|Qualify| |SInt| |Machine|))
          ((|documentation| . " Length of the fixed-string elements.
")
            (|symeNameCode| . 200076)
            (|symeTypeCode| . 932039034)))
        (|Declare|
          %%
          |FortranFStringArray|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 55336446))))))
  (|Declare|
    |DenseStorageCategory|
    (|Define|
      (|Declare| (|Label| |DenseStorageCategory| ()) |Category|)
      (|With|
        ()
        (|Sequence|
          ()
          ()
          ()
          (|Declare|
            |PackedArrayNew|
            (|Apply| -> (|Qualify| |SInt| |Machine|) (|Qualify| |Arr| |Machine|))
            ((|documentation| .
                " Create a machine array with enough storage
 for the specified number of elements. There
 is no support for providing initial values.
")
              (|symeNameCode| . 757252399)
              (|symeTypeCode| . 230929250)))
          (|Declare|
            |PackedArrayGet|
            (|Apply|
              ->
              (|Comma| (|Qualify| |Arr| |Machine|) (|Qualify| |SInt| |Machine|))
              %)
            ((|documentation| .
                " Given a machine array, return the element
 at the specified index. Note that zero-based
 indexing is used.
")
              (|symeNameCode| . 767785253)
              (|symeTypeCode| . 504190320)))
          (|Declare|
            |PackedArraySet|
            (|Apply|
              ->
              (|Comma| (|Qualify| |Arr| |Machine|) (|Qualify| |SInt| |Machine|) %)
              %)
            ((|documentation| .
                " Given a machine array replace the value at
 the specified index with a new value. Note
 that zero-based indexing is used.
")
              (|symeNameCode| . 756527409)
              (|symeTypeCode| . 7666178)))
          (|Declare|
            |PackedRecordSet|
            (|Apply| -> (|Comma| (|Qualify| |Ptr| |Machine|) %) %)
            ((|documentation| .
                " `PackedRecordSet(p, v)' writes the raw representation
 of `v' into the machine address `p'. Use `pretend' to
 view `p' as an Aldor record or array as appropriate.
")
              (|symeNameCode| . 940586746)
              (|symeTypeCode| . 278278893)))
          (|Declare|
            |PackedRecordGet|
            (|Apply| -> (|Qualify| |Ptr| |Machine|) %)
            ((|documentation| .
                " `PackedRecordGet(p)' reads the raw representation of
 a value from the machine address `p'. Use `pretend'
 to view `p' as an Aldor record or array as appropriate.
")
              (|symeNameCode| . 939800302)
              (|symeTypeCode| . 632591839)))
          (|Declare|
            |PackedRepSize|
            (|Apply| -> (|Comma|) (|Qualify| |SInt| |Machine|))
            ((|documentation| .
                " This function returns the amount of memory required
 to store a raw value in a raw record.
")
              (|symeNameCode| . 920971615)
              (|symeTypeCode| . 932039034))))))
    ((|documentation| .
        " Domains which satisfy DenseStorageCategory promise to provide
 exports that can be used to create arrays in which their values
 are stored using their \"natural\" size, and allow their values to
 be placed in RawRecords. For example, Byte values would be stored
 using 8-bits while DoubleFloat would use 64.
 
 Domains which satisfy this category and which define Rep as a
 constant (not a macro) do not need to provide implementations
 for the exports since the compiler will do this automatically.
 However, if the value of Rep is not the same as the packed
 representation, then the exports supplied by the compiler must
 be over-ridden by defining replacements. See DoubleFloat and
 Complex(R) for examples of how to do this.
 
 Author: AXIOM-XL library
 Date Created: 1999
 Keywords: dense, packed, implicit
")
      (|symeNameCode| . 1017595958)
      (|symeTypeCode| . 669275033)
      (|catExports|
        (|Declare|
          |PackedArrayNew|
          (|Apply| -> (|Qualify| |SInt| |Machine|) (|Qualify| |Arr| |Machine|))
          ((|documentation| .
              " Create a machine array with enough storage
 for the specified number of elements. There
 is no support for providing initial values.
")
            (|symeNameCode| . 757252399)
            (|symeTypeCode| . 230929250)))
        (|Declare|
          |PackedArrayGet|
          (|Apply|
            ->
            (|Comma| (|Qualify| |Arr| |Machine|) (|Qualify| |SInt| |Machine|))
            %)
          ((|documentation| .
              " Given a machine array, return the element
 at the specified index. Note that zero-based
 indexing is used.
")
            (|symeNameCode| . 767785253)
            (|symeTypeCode| . 504190320)))
        (|Declare|
          |PackedArraySet|
          (|Apply|
            ->
            (|Comma| (|Qualify| |Arr| |Machine|) (|Qualify| |SInt| |Machine|) %)
            %)
          ((|documentation| .
              " Given a machine array replace the value at
 the specified index with a new value. Note
 that zero-based indexing is used.
")
            (|symeNameCode| . 756527409)
            (|symeTypeCode| . 7666178)))
        (|Declare|
          |PackedRecordSet|
          (|Apply| -> (|Comma| (|Qualify| |Ptr| |Machine|) %) %)
          ((|documentation| .
              " `PackedRecordSet(p, v)' writes the raw representation
 of `v' into the machine address `p'. Use `pretend' to
 view `p' as an Aldor record or array as appropriate.
")
            (|symeNameCode| . 940586746)
            (|symeTypeCode| . 278278893)))
        (|Declare|
          |PackedRecordGet|
          (|Apply| -> (|Qualify| |Ptr| |Machine|) %)
          ((|documentation| .
              " `PackedRecordGet(p)' reads the raw representation of
 a value from the machine address `p'. Use `pretend'
 to view `p' as an Aldor record or array as appropriate.
")
            (|symeNameCode| . 939800302)
            (|symeTypeCode| . 632591839)))
        (|Declare|
          |PackedRepSize|
          (|Apply| -> (|Comma|) (|Qualify| |SInt| |Machine|))
          ((|documentation| .
              " This function returns the amount of memory required
 to store a raw value in a raw record.
")
            (|symeNameCode| . 920971615)
            (|symeTypeCode| . 932039034)))
        (|Declare|
          %%
          |DenseStorageCategory|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 958849489))))))
  (|Declare|
    |FortranFString|
    (|Define|
      (|Declare| (|Label| |FortranFString| ()) |Category|)
      (|With|
        |DenseStorageCategory|
        (|Sequence|
          ()
          (|Declare|
            |#|
            (|Apply| -> (|Comma|) (|Qualify| |SInt| |Machine|))
            ((|documentation| . " Length of the fixed-string values.
")
              (|symeNameCode| . 200076)
              (|symeTypeCode| . 932039034))))))
    ((|documentation| .
        " Domains satisfying FortranFString can be passed to Fortran as
 values of type CHARACTER*N for fixed values of N.

 This is a language defined category.
")
      (|symeNameCode| . 326461271)
      (|symeTypeCode| . 1061899765)
      (|catExports|
        (|Declare|
          |PackedArrayNew|
          (|Apply| -> (|Qualify| |SInt| |Machine|) (|Qualify| |Arr| |Machine|))
          ((|documentation| .
              " Create a machine array with enough storage
 for the specified number of elements. There
 is no support for providing initial values.
")
            (|symeNameCode| . 757252399)
            (|symeTypeCode| . 230929250)))
        (|Declare|
          |PackedArrayGet|
          (|Apply|
            ->
            (|Comma| (|Qualify| |Arr| |Machine|) (|Qualify| |SInt| |Machine|))
            %)
          ((|documentation| .
              " Given a machine array, return the element
 at the specified index. Note that zero-based
 indexing is used.
")
            (|symeNameCode| . 767785253)
            (|symeTypeCode| . 504190320)))
        (|Declare|
          |PackedArraySet|
          (|Apply|
            ->
            (|Comma| (|Qualify| |Arr| |Machine|) (|Qualify| |SInt| |Machine|) %)
            %)
          ((|documentation| .
              " Given a machine array replace the value at
 the specified index with a new value. Note
 that zero-based indexing is used.
")
            (|symeNameCode| . 756527409)
            (|symeTypeCode| . 7666178)))
        (|Declare|
          |PackedRecordSet|
          (|Apply| -> (|Comma| (|Qualify| |Ptr| |Machine|) %) %)
          ((|documentation| .
              " `PackedRecordSet(p, v)' writes the raw representation
 of `v' into the machine address `p'. Use `pretend' to
 view `p' as an Aldor record or array as appropriate.
")
            (|symeNameCode| . 940586746)
            (|symeTypeCode| . 278278893)))
        (|Declare|
          |PackedRecordGet|
          (|Apply| -> (|Qualify| |Ptr| |Machine|) %)
          ((|documentation| .
              " `PackedRecordGet(p)' reads the raw representation of
 a value from the machine address `p'. Use `pretend'
 to view `p' as an Aldor record or array as appropriate.
")
            (|symeNameCode| . 939800302)
            (|symeTypeCode| . 632591839)))
        (|Declare|
          |PackedRepSize|
          (|Apply| -> (|Comma|) (|Qualify| |SInt| |Machine|))
          ((|documentation| .
              " This function returns the amount of memory required
 to store a raw value in a raw record.
")
            (|symeNameCode| . 920971615)
            (|symeTypeCode| . 932039034)))
        (|Declare|
          %%
          |DenseStorageCategory|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 958849489)))
        (|Declare|
          |#|
          (|Apply| -> (|Comma|) (|Qualify| |SInt| |Machine|))
          ((|documentation| . " Length of the fixed-string values.
")
            (|symeNameCode| . 200076)
            (|symeTypeCode| . 932039034)))
        (|Declare|
          %%
          |FortranFString|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 267714802))))))
  (|Declare|
    |FortranMultiArray|
    (|Define|
      (|Declare| (|Label| |FortranMultiArray| ()) |Category|)
      (|With|
        |FortranArray|
        (|Sequence|
          ()
          ()
          ()
          (|Declare|
            |flatten|
            (|Apply|
              ->
              (|Comma|
                (|Declare|
                  a
                  |Type|
                  ((|symeNameCode| . 200106)
                    (|symeTypeCode| . 547582661)
                    (|domExports|)))
                a
                |SingleInteger|
                (|Apply| -> (|Comma| a |SingleInteger|) %))
              (|Qualify| |Arr| |Machine|))
            ((|documentation| .
                " flatten(%, x, n, getter) is used to convert the
 `multi-dimensional array `x' with `n'  rows into
 a single-dimensional machine array organised in
 Fortran format. The `getter' function is used to
 extract individual rows from `x'.
")
              (|symeNameCode| . 631988429)
              (|symeTypeCode| . 1000688566)))
          (|Declare|
            |unflatten|
            (|Apply|
              ->
              (|Comma|
                %
                (|Qualify| |Arr| |Machine|)
                (|Qualify| |SInt| |Machine|)
                (|Qualify| |SInt| |Machine|))
              (|Comma|))
            ((|documentation| .
                " unflatten(x, f, off, step) is used to update `x'
 after it has been passed to Fortran as the raw
 array `f'. The updated array elements start at
 offset `off' (counting from 0) in `f' and are
 `step' elements apart.
")
              (|symeNameCode| . 994960770)
              (|symeTypeCode| . 225936914))))))
    ((|documentation| .
        " Domains which satisfy FortranMultiArray can be passed to
 Fortran as multi-dimensional arrays. The exports defined
 by this domain are generally only applied by the exports
 for FortranArray, which in turn are automatically applied
 by the compiler when array values are passed to Fortran.

 This is NOT a language defined category.
 
 Author: AXIOM-XL library
 Date Created: 1999
 Keywords: fortran, array, multi-dimensional
")
      (|symeNameCode| . 286028255)
      (|symeTypeCode| . 308880865)
      (|catExports|
        (|Declare|
          %%
          |FortranArray|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 398498402)))
        (|Declare|
          |flatten|
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                a
                |Type|
                ((|symeNameCode| . 200106)
                  (|symeTypeCode| . 547582661)
                  (|domExports|)))
              a
              |SingleInteger|
              (|Apply| -> (|Comma| a |SingleInteger|) %))
            (|Qualify| |Arr| |Machine|))
          ((|documentation| .
              " flatten(%, x, n, getter) is used to convert the
 `multi-dimensional array `x' with `n'  rows into
 a single-dimensional machine array organised in
 Fortran format. The `getter' function is used to
 extract individual rows from `x'.
")
            (|symeNameCode| . 631988429)
            (|symeTypeCode| . 1000688566)))
        (|Declare|
          |unflatten|
          (|Apply|
            ->
            (|Comma|
              %
              (|Qualify| |Arr| |Machine|)
              (|Qualify| |SInt| |Machine|)
              (|Qualify| |SInt| |Machine|))
            (|Comma|))
          ((|documentation| .
              " unflatten(x, f, off, step) is used to update `x'
 after it has been passed to Fortran as the raw
 array `f'. The updated array elements start at
 offset `off' (counting from 0) in `f' and are
 `step' elements apart.
")
            (|symeNameCode| . 994960770)
            (|symeTypeCode| . 225936914)))
        (|Declare|
          %%
          |FortranMultiArray|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 227281786))))))
  (|Declare|
    |ElementaryFunctions|
    (|Define|
      (|Declare| (|Label| |ElementaryFunctions| ()) |Category|)
      (|With|
        ()
        (|Sequence|
          (|Declare|
            |exp|
            (|Apply| -> % %)
            ((|documentation| . " Exponential of `e'.
")
              (|symeNameCode| . 314805384)
              (|symeTypeCode| . 143998972)))
          (|Declare|
            |sin|
            (|Apply| -> % %)
            ((|documentation| . " Circular trigonometric sine.
")
              (|symeNameCode| . 315719557)
              (|symeTypeCode| . 143998972)))
          (|Declare|
            |cos|
            (|Apply| -> % %)
            ((|documentation| . " Circular trigonometric cosine.
")
              (|symeNameCode| . 316766592)
              (|symeTypeCode| . 143998972)))
          (|Declare|
            |tan|
            (|Apply| -> % %)
            ((|documentation| . " Circular trigonometric tangent.
")
              (|symeNameCode| . 315787134)
              (|symeTypeCode| . 143998972)))
          (|Declare|
            |sinh|
            (|Apply| -> % %)
            ((|documentation| . " Hyperbolic trigonometric sine.
")
              (|symeNameCode| . 61999190)
              (|symeTypeCode| . 143998972)))
          (|Declare|
            |cosh|
            (|Apply| -> % %)
            ((|documentation| . " Hyperbolic trigonometric cosine.
")
              (|symeNameCode| . 865863505)
              (|symeTypeCode| . 143998972)))
          (|Declare|
            |tanh|
            (|Apply| -> % %)
            ((|documentation| . " Hyperbolic trigonometric tangent.
")
              (|symeNameCode| . 5834575)
              (|symeTypeCode| . 143998972)))
          (|Declare|
            |log|
            (|Apply| -> % %)
            ((|documentation| . " Natural logarithm.
")
              (|symeNameCode| . 318396797)
              (|symeTypeCode| . 143998972)))
          (|Declare|
            |log10|
            (|Apply| -> % %)
            ((|documentation| . " Logarithm base 10.
")
              (|symeNameCode| . 244789936)
              (|symeTypeCode| . 143998972)))
          (|Declare|
            |asin|
            (|Apply| -> % %)
            ((|documentation| . " Functional inverse of `sin'.
")
              (|symeNameCode| . 357173071)
              (|symeTypeCode| . 143998972)))
          (|Declare|
            |acos|
            (|Apply| -> % %)
            ((|documentation| . " Functional inverse of `cos'.
")
              (|symeNameCode| . 362368330)
              (|symeTypeCode| . 143998972)))
          (|Declare|
            |atan|
            (|Apply| -> % %)
            ((|documentation| . " Functional inverse of `tan'.
")
              (|symeNameCode| . 357236552)
              (|symeTypeCode| . 143998972)))
          (|Declare|
            |asinh|
            (|Apply| -> % %)
            ((|documentation| . " Functional inverse of `sinh'.
")
              (|symeNameCode| . 525358624)
              (|symeTypeCode| . 143998972)))
          (|Declare|
            |acosh|
            (|Apply| -> % %)
            ((|documentation| . " Functional inverse of `cosh'.
")
              (|symeNameCode| . 215422235)
              (|symeTypeCode| . 143998972)))
          (|Declare|
            |atanh|
            (|Apply| -> % %)
            ((|documentation| . " Functional inverse of `tanh'.
")
              (|symeNameCode| . 532202777)
              (|symeTypeCode| . 143998972)))
          (|Declare|
            |sqrt|
            (|Apply| -> % %)
            ((|documentation| . " Square root.
")
              (|symeNameCode| . 61469806)
              (|symeTypeCode| . 143998972)))
          (|Declare|
            |root|
            (|Apply| -> (|Comma| % |SingleInteger|) %)
            ((|documentation| . " General surd.
")
              (|symeNameCode| . 715193448)
              (|symeTypeCode| . 546428929)))
          (|Declare|
            ^
            (|Apply| -> (|Comma| % %) %)
            ((|documentation| . " General exponentiation.
")
              (|symeNameCode| . 200135)
              (|symeTypeCode| . 355597834))))))
    ((|documentation| .
        " `ElementaryFunctions' provides the basic trigonometric and exponential
 functions and their inverses.

 Author: AXIOM-XL library
 Date Created: 1992-94
 Keywords: elementary functions, transcendental functions
")
      (|symeNameCode| . 670700442)
      (|symeTypeCode| . 97802927)
      (|catExports|
        (|Declare|
          |exp|
          (|Apply| -> % %)
          ((|documentation| . " Exponential of `e'.
")
            (|symeNameCode| . 314805384)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          |sin|
          (|Apply| -> % %)
          ((|documentation| . " Circular trigonometric sine.
")
            (|symeNameCode| . 315719557)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          |cos|
          (|Apply| -> % %)
          ((|documentation| . " Circular trigonometric cosine.
")
            (|symeNameCode| . 316766592)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          |tan|
          (|Apply| -> % %)
          ((|documentation| . " Circular trigonometric tangent.
")
            (|symeNameCode| . 315787134)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          |sinh|
          (|Apply| -> % %)
          ((|documentation| . " Hyperbolic trigonometric sine.
")
            (|symeNameCode| . 61999190)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          |cosh|
          (|Apply| -> % %)
          ((|documentation| . " Hyperbolic trigonometric cosine.
")
            (|symeNameCode| . 865863505)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          |tanh|
          (|Apply| -> % %)
          ((|documentation| . " Hyperbolic trigonometric tangent.
")
            (|symeNameCode| . 5834575)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          |log|
          (|Apply| -> % %)
          ((|documentation| . " Natural logarithm.
")
            (|symeNameCode| . 318396797)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          |log10|
          (|Apply| -> % %)
          ((|documentation| . " Logarithm base 10.
")
            (|symeNameCode| . 244789936)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          |asin|
          (|Apply| -> % %)
          ((|documentation| . " Functional inverse of `sin'.
")
            (|symeNameCode| . 357173071)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          |acos|
          (|Apply| -> % %)
          ((|documentation| . " Functional inverse of `cos'.
")
            (|symeNameCode| . 362368330)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          |atan|
          (|Apply| -> % %)
          ((|documentation| . " Functional inverse of `tan'.
")
            (|symeNameCode| . 357236552)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          |asinh|
          (|Apply| -> % %)
          ((|documentation| . " Functional inverse of `sinh'.
")
            (|symeNameCode| . 525358624)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          |acosh|
          (|Apply| -> % %)
          ((|documentation| . " Functional inverse of `cosh'.
")
            (|symeNameCode| . 215422235)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          |atanh|
          (|Apply| -> % %)
          ((|documentation| . " Functional inverse of `tanh'.
")
            (|symeNameCode| . 532202777)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          |sqrt|
          (|Apply| -> % %)
          ((|documentation| . " Square root.
")
            (|symeNameCode| . 61469806)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          |root|
          (|Apply| -> (|Comma| % |SingleInteger|) %)
          ((|documentation| . " General surd.
")
            (|symeNameCode| . 715193448)
            (|symeTypeCode| . 546428929)))
        (|Declare|
          ^
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " General exponentiation.
")
            (|symeNameCode| . 200135)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          %%
          |ElementaryFunctions|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 611953973))))))
  (|Declare|
    |FloatingPointNumberSystem|
    (|Define|
      (|Declare| (|Label| |FloatingPointNumberSystem| ()) |Category|)
      (|With|
        (|Apply| |Join| |OrderedRing| |Field|)
        (|Sequence|
          (|Declare|
            |float|
            (|Apply| -> |Literal| %)
            ((|documentation| . " Floating point-style literals.
")
              (|symeNameCode| . 474568739)
              (|symeTypeCode| . 794338558)))
          (|Declare|
            <<
            (|Apply| -> (|Comma| % %) |Boolean|)
            ((|documentation| . " Insignificance: a << b => a+b=b
")
              (|symeNameCode| . 51492426)
              (|symeTypeCode| . 21900315)))
          (|Declare|
            >>
            (|Apply| -> (|Comma| % %) |Boolean|)
            ((|documentation| . " Dominance:      a >> b => a+b=a
")
              (|symeNameCode| . 51492942)
              (|symeTypeCode| . 21900315)))
          (|Declare|
            |coerce|
            (|Apply| -> |Integer| %)
            ((|documentation| . " Conversion from `Integer'.
")
              (|symeNameCode| . 770345191)
              (|symeTypeCode| . 363839259)))
          (|Declare|
            |coerce|
            (|Apply| -> |SingleInteger| %)
            ((|documentation| . " Conversion from `SingleInteger'.
")
              (|symeNameCode| . 770345191)
              (|symeTypeCode| . 352135667)))
          (|Declare|
            |step|
            (|Apply|
              ->
              |SingleInteger|
              (|Apply| -> (|Comma| % %) (|Apply| |Generator| %)))
            ((|documentation| .
                " `step(n)(a,b)' yields `n' evenly
 separated values on `[a,b]'
")
              (|symeNameCode| . 61407584)
              (|symeTypeCode| . 850656788)))
          (|Declare|
            |integer|
            (|Apply| -> % |Integer|)
            ((|symeNameCode| . 477900237) (|symeTypeCode| . 628006939)))
          (|Declare|
            |fraction|
            (|Apply| -> % %)
            ((|symeNameCode| . 244914846) (|symeTypeCode| . 143998972)))
          (|Declare|
            |round|
            (|Apply|
              ->
              (|Comma|
                %
                (|Define|
                  (|Declare|
                    |mode|
                    |RoundingMode|
                    ((|symeNameCode| . 699481161) (|symeTypeCode| . 863477586)))
                  (|Apply| |nearest|)))
              |Integer|)
            ((|symeNameCode| . 195459125) (|symeTypeCode| . 818457164)))
          (|Declare|
            |prev|
            (|Apply| -> % %)
            ((|symeNameCode| . 613807201) (|symeTypeCode| . 143998972)))
          (|Declare|
            |next|
            (|Apply| -> % %)
            ((|symeNameCode| . 782953315) (|symeTypeCode| . 143998972)))
          (|Declare|
            |floor|
            (|Apply| -> % %)
            ((|symeNameCode| . 474572335) (|symeTypeCode| . 143998972)))
          (|Declare|
            |ceiling|
            (|Apply| -> % %)
            ((|documentation| . " Next (lowest, highest) respv.
")
              (|symeNameCode| . 427129530)
              (|symeTypeCode| . 143998972)))
          (|Declare|
            |round+|
            (|Apply|
              ->
              (|Comma|
                %
                %
                (|Define|
                  (|Declare|
                    |mode|
                    |RoundingMode|
                    ((|symeNameCode| . 699481161) (|symeTypeCode| . 863477586)))
                  (|Apply| |nearest|)))
              %)
            ((|symeNameCode| . 769743561) (|symeTypeCode| . 48083647)))
          (|Declare|
            |round-|
            (|Apply|
              ->
              (|Comma|
                %
                %
                (|Define|
                  (|Declare|
                    |mode|
                    |RoundingMode|
                    ((|symeNameCode| . 699481161) (|symeTypeCode| . 863477586)))
                  (|Apply| |nearest|)))
              %)
            ((|symeNameCode| . 769743563) (|symeTypeCode| . 48083647)))
          (|Declare|
            |round*|
            (|Apply|
              ->
              (|Comma|
                %
                %
                (|Define|
                  (|Declare|
                    |mode|
                    |RoundingMode|
                    ((|symeNameCode| . 699481161) (|symeTypeCode| . 863477586)))
                  (|Apply| |nearest|)))
              %)
            ((|symeNameCode| . 769743560) (|symeTypeCode| . 48083647)))
          (|Declare|
            |round*+|
            (|Apply|
              ->
              (|Comma|
                %
                %
                %
                (|Define|
                  (|Declare|
                    |mode|
                    |RoundingMode|
                    ((|symeNameCode| . 699481161) (|symeTypeCode| . 863477586)))
                  (|Apply| |nearest|)))
              %)
            ((|symeNameCode| . 213819484) (|symeTypeCode| . 398020433)))
          (|Declare|
            |round/|
            (|Apply|
              ->
              (|Comma|
                %
                %
                (|Define|
                  (|Declare|
                    |mode|
                    |RoundingMode|
                    ((|symeNameCode| . 699481161) (|symeTypeCode| . 863477586)))
                  (|Apply| |nearest|)))
              %)
            ((|symeNameCode| . 769743565) (|symeTypeCode| . 48083647)))
          (|Declare|
            |mantissa|
            (|Apply| -> % |Integer|)
            ((|symeNameCode| . 998253480) (|symeTypeCode| . 628006939)))
          (|Declare|
            |exponent|
            (|Apply| -> % |Integer|)
            ((|symeNameCode| . 13508537) (|symeTypeCode| . 628006939)))
          (|Export| () |RoundingMode| ()))))
    ((|documentation| .
        " `FloatingPointNumberSystem' provides the basic operations for a type which
 approximates the real numbers as a floating point system.

 Author: AXIOM-XL library
 Date Created: 1992-94
 Keywords: floating point, real, approximate, arithmetic
")
      (|symeNameCode| . 884781677)
      (|symeTypeCode| . 185914101)
      (|catExports|
        (|Declare|
          =
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Equality test.
")
            (|symeNameCode| . 200102)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          ~=
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Inequality test.
")
            (|default| . 1)
            (|symeNameCode| . 51509389)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          <<
          (|Apply| -> (|Comma| |TextWriter| %) |TextWriter|)
          ((|documentation| . " Basic output.
")
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 561215334)))
        (|Declare|
          <<
          (|Apply| -> % (|Apply| -> |TextWriter| |TextWriter|))
          ((|documentation| . " Basic output.
")
            (|default| . 1)
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 112505899)))
        (|Declare|
          |sample|
          %
          ((|documentation| . " Example element.
")
            (|default| . 1)
            (|symeNameCode| . 255806968)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          |hash|
          (|Apply| -> % |SingleInteger|)
          ((|documentation| . " Hashing function.
")
            (|default| . 1)
            (|symeNameCode| . 746853960)
            (|symeTypeCode| . 286270707)))
        (|Declare|
          |case|
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " for 'select' statements;
")
            (|default| . 1)
            (|symeNameCode| . 864625472)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          %%
          |BasicType|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 866929616)))
        (|Declare|
          >
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Greater than test.
")
            (|symeNameCode| . 200103)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          <
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Less than test.
")
            (|default| . 1)
            (|symeNameCode| . 200101)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          >=
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Greater than or equal test.
")
            (|default| . 1)
            (|symeNameCode| . 51492941)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          <=
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Less than or equal test.
")
            (|default| . 1)
            (|symeNameCode| . 51492427)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          |max|
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Maximum argument.
")
            (|default| . 1)
            (|symeNameCode| . 318461825)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          |min|
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Minimum argument.
")
            (|default| . 1)
            (|symeNameCode| . 318459775)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          >
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |x|
                %
                ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 200103)
            (|symeTypeCode| . 134984876)))
        (|Declare|
          <
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |x|
                %
                ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 200101)
            (|symeTypeCode| . 134984876)))
        (|Declare|
          >=
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |x|
                %
                ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 51492941)
            (|symeTypeCode| . 134984876)))
        (|Declare|
          <=
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |x|
                %
                ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 51492427)
            (|symeTypeCode| . 134984876)))
        (|Declare|
          >
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 200103)
            (|symeTypeCode| . 305073998)))
        (|Declare|
          <
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 200101)
            (|symeTypeCode| . 305073998)))
        (|Declare|
          >=
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 51492941)
            (|symeTypeCode| . 305073998)))
        (|Declare|
          <=
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 51492427)
            (|symeTypeCode| . 305073998)))
        (|Declare|
          >
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            |Boolean|)
          ((|default| . 1)
            (|symeNameCode| . 200103)
            (|symeTypeCode| . 191989437)))
        (|Declare|
          <
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            |Boolean|)
          ((|default| . 1)
            (|symeNameCode| . 200101)
            (|symeTypeCode| . 191989437)))
        (|Declare|
          >=
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            |Boolean|)
          ((|default| . 1)
            (|symeNameCode| . 51492941)
            (|symeTypeCode| . 191989437)))
        (|Declare|
          <=
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            |Boolean|)
          ((|default| . 1)
            (|symeNameCode| . 51492427)
            (|symeTypeCode| . 191989437)))
        (|Declare|
          %%
          |Order|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 105187748)))
        (|Declare|
          \0
          %
          ((|documentation| . " Identity for addition.
")
            (|symeNameCode| . 200089)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          +
          (|Apply| -> % %)
          ((|documentation| . " Identity function.
")
            (|default| . 1)
            (|symeNameCode| . 200084)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          +
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Addition.
")
            (|symeNameCode| . 200084)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          |zero?|
          (|Apply| -> % |Boolean|)
          ((|documentation| . " Test whether value equals 0.
")
            (|default| . 1)
            (|symeNameCode| . 206475020)
            (|symeTypeCode| . 884043277)))
        (|Declare|
          %%
          |AbelianMonoid|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 744293378)))
        (|Declare|
          %%
          |OrderedAbelianMonoid|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 383243686)))
        (|Declare|
          -
          (|Apply| -> % %)
          ((|documentation| . " Negation.
")
            (|symeNameCode| . 200086)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          -
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Subtraction.
")
            (|default| . 1)
            (|symeNameCode| . 200086)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          %%
          |AbelianGroup|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 269400384)))
        (|Declare|
          %%
          |OrderedAbelianGroup|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 555959524)))
        (|Declare|
          \1
          %
          ((|documentation| . " Identity for `*'
")
            (|symeNameCode| . 200090)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          *
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Multiplication
")
            (|symeNameCode| . 200083)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          ^
          (|Apply| -> (|Comma| % |Integer|) %)
          ((|documentation| . " Exponentiation or error
")
            (|symeNameCode| . 200135)
            (|symeTypeCode| . 455750953)))
        (|Declare|
          |coerce|
          (|Apply| -> |Integer| %)
          ((|symeNameCode| . 770345191) (|symeTypeCode| . 363839259)))
        (|Declare|
          |coerce|
          (|Apply| -> |SingleInteger| %)
          ((|symeNameCode| . 770345191) (|symeTypeCode| . 352135667)))
        (|Declare|
          %%
          |ArithmeticSystem|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 297185210)))
        (|Declare|
          %%
          |Monoid|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 656786807)))
        (|Declare|
          %%
          |Ring|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 118610639)))
        (|Declare|
          |abs|
          (|Apply| -> % %)
          ((|documentation| . " Absolute value.
")
            (|default| . 1)
            (|symeNameCode| . 315051633)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          |sign|
          (|Apply| -> % %)
          ((|documentation| . " -1, 0, or 1.
")
            (|default| . 1)
            (|symeNameCode| . 61935445)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          |negative?|
          (|Apply| -> % |Boolean|)
          ((|documentation| . " Test whether value is negative?
")
            (|default| . 1)
            (|symeNameCode| . 424301635)
            (|symeTypeCode| . 884043277)))
        (|Declare|
          |positive?|
          (|Apply| -> % |Boolean|)
          ((|documentation| . " Test whether value is positive?
")
            (|default| . 1)
            (|symeNameCode| . 733146723)
            (|symeTypeCode| . 884043277)))
        (|Declare|
          %%
          |OrderedRing|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 816910963)))
        (|Declare|
          |gcd|
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Greatest commond divisor.
")
            (|default| . 1)
            (|symeNameCode| . 318604649)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          |quo|
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Quotient leaving remainder.
")
            (|default| . 1)
            (|symeNameCode| . 318204816)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          |rem|
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Remainder.
")
            (|default| . 1)
            (|symeNameCode| . 318266239)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          |divide|
          (|Apply| -> (|Comma| % %) (|Comma| % %))
          ((|documentation| . " Quotient-remainder pair.
")
            (|default| . 1)
            (|symeNameCode| . 42114539)
            (|symeTypeCode| . 624266776)))
        (|Declare|
          %%
          |EuclideanDomain|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 78774180)))
        (|Declare|
          /
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Division: a/b = a*inv(b).
")
            (|default| . 1)
            (|symeNameCode| . 200088)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          |\\|
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Division: a\\b = inv(a)*b
")
            (|default| . 1)
            (|symeNameCode| . 200133)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          |inv|
          (|Apply| -> % %)
          ((|documentation| . " Inverse.
")
            (|symeNameCode| . 318722696)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          %%
          |Group|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 372253109)))
        (|Declare|
          |unit?|
          (|Apply|
            ->
            (|Declare|
              |x|
              %
              ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
            |Boolean|)
          ((|default| . 1)
            (|symeNameCode| . 896181516)
            (|symeTypeCode| . 884043277)))
        (|Declare|
          %%
          |Field|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 627245452)))
        (|Declare|
          |float|
          (|Apply| -> |Literal| %)
          ((|documentation| . " Floating point-style literals.
")
            (|symeNameCode| . 474568739)
            (|symeTypeCode| . 794338558)))
        (|Declare|
          <<
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Insignificance: a << b => a+b=b
")
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          >>
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Dominance:      a >> b => a+b=a
")
            (|symeNameCode| . 51492942)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          |step|
          (|Apply|
            ->
            |SingleInteger|
            (|Apply| -> (|Comma| % %) (|Apply| |Generator| %)))
          ((|documentation| .
              " `step(n)(a,b)' yields `n' evenly
 separated values on `[a,b]'
")
            (|symeNameCode| . 61407584)
            (|symeTypeCode| . 850656788)))
        (|Declare|
          |integer|
          (|Apply| -> % |Integer|)
          ((|symeNameCode| . 477900237) (|symeTypeCode| . 628006939)))
        (|Declare|
          |fraction|
          (|Apply| -> % %)
          ((|symeNameCode| . 244914846) (|symeTypeCode| . 143998972)))
        (|Declare|
          |round|
          (|Apply|
            ->
            (|Comma|
              %
              (|Define|
                (|Declare|
                  |mode|
                  |RoundingMode|
                  ((|symeNameCode| . 699481161) (|symeTypeCode| . 863477586)))
                (|Apply| |nearest|)))
            |Integer|)
          ((|symeNameCode| . 195459125) (|symeTypeCode| . 818457164)))
        (|Declare|
          |prev|
          (|Apply| -> % %)
          ((|symeNameCode| . 613807201) (|symeTypeCode| . 143998972)))
        (|Declare|
          |next|
          (|Apply| -> % %)
          ((|symeNameCode| . 782953315) (|symeTypeCode| . 143998972)))
        (|Declare|
          |floor|
          (|Apply| -> % %)
          ((|symeNameCode| . 474572335) (|symeTypeCode| . 143998972)))
        (|Declare|
          |ceiling|
          (|Apply| -> % %)
          ((|documentation| . " Next (lowest, highest) respv.
")
            (|symeNameCode| . 427129530)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          |round+|
          (|Apply|
            ->
            (|Comma|
              %
              %
              (|Define|
                (|Declare|
                  |mode|
                  |RoundingMode|
                  ((|symeNameCode| . 699481161) (|symeTypeCode| . 863477586)))
                (|Apply| |nearest|)))
            %)
          ((|symeNameCode| . 769743561) (|symeTypeCode| . 48083647)))
        (|Declare|
          |round-|
          (|Apply|
            ->
            (|Comma|
              %
              %
              (|Define|
                (|Declare|
                  |mode|
                  |RoundingMode|
                  ((|symeNameCode| . 699481161) (|symeTypeCode| . 863477586)))
                (|Apply| |nearest|)))
            %)
          ((|symeNameCode| . 769743563) (|symeTypeCode| . 48083647)))
        (|Declare|
          |round*|
          (|Apply|
            ->
            (|Comma|
              %
              %
              (|Define|
                (|Declare|
                  |mode|
                  |RoundingMode|
                  ((|symeNameCode| . 699481161) (|symeTypeCode| . 863477586)))
                (|Apply| |nearest|)))
            %)
          ((|symeNameCode| . 769743560) (|symeTypeCode| . 48083647)))
        (|Declare|
          |round*+|
          (|Apply|
            ->
            (|Comma|
              %
              %
              %
              (|Define|
                (|Declare|
                  |mode|
                  |RoundingMode|
                  ((|symeNameCode| . 699481161) (|symeTypeCode| . 863477586)))
                (|Apply| |nearest|)))
            %)
          ((|symeNameCode| . 213819484) (|symeTypeCode| . 398020433)))
        (|Declare|
          |round/|
          (|Apply|
            ->
            (|Comma|
              %
              %
              (|Define|
                (|Declare|
                  |mode|
                  |RoundingMode|
                  ((|symeNameCode| . 699481161) (|symeTypeCode| . 863477586)))
                (|Apply| |nearest|)))
            %)
          ((|symeNameCode| . 769743565) (|symeTypeCode| . 48083647)))
        (|Declare|
          |mantissa|
          (|Apply| -> % |Integer|)
          ((|symeNameCode| . 998253480) (|symeTypeCode| . 628006939)))
        (|Declare|
          |exponent|
          (|Apply| -> % |Integer|)
          ((|symeNameCode| . 13508537) (|symeTypeCode| . 628006939)))
        (|Declare|
          %%
          |FloatingPointNumberSystem|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 826035208))))))
  (|Declare|
    |IntegerNumberSystem|
    (|Define|
      (|Declare| (|Label| |IntegerNumberSystem| ()) |Category|)
      (|With|
        (|Apply| |Join| |OrderedRing| |EuclideanDomain|)
        (|Sequence|
          (|Declare|
            |integer|
            (|Apply| -> |Literal| %)
            ((|documentation| . " Integer-style literals.
")
              (|symeNameCode| . 477900237)
              (|symeTypeCode| . 794338558)))
          (|Declare|
            |even?|
            (|Apply| -> % |Boolean|)
            ((|documentation| . " Test whether the value is even.
")
              (|symeNameCode| . 498514682)
              (|symeTypeCode| . 884043277)))
          (|Declare|
            |odd?|
            (|Apply| -> % |Boolean|)
            ((|documentation| . " Test whether the value is odd.
")
              (|symeNameCode| . 665072666)
              (|symeTypeCode| . 884043277)))
          (|Declare|
            |single?|
            (|Apply| -> % |Boolean|)
            ((|documentation| . " Can a SingleInteger hold the value?
")
              (|symeNameCode| . 362464416)
              (|symeTypeCode| . 884043277)))
          (|Declare|
            |prev|
            (|Apply| -> % %)
            ((|documentation| . " Decrement the value by 1.
")
              (|symeNameCode| . 613807201)
              (|symeTypeCode| . 143998972)))
          (|Declare|
            |next|
            (|Apply| -> % %)
            ((|documentation| . " Increment the value by 1.
")
              (|symeNameCode| . 782953315)
              (|symeTypeCode| . 143998972)))
          (|Declare|
            |mod|
            (|Apply| -> (|Comma| % %) %)
            ((|documentation| . " Modulus.
")
              (|symeNameCode| . 318461307)
              (|symeTypeCode| . 355597834)))
          (|Declare|
            |length|
            (|Apply| -> % |SingleInteger|)
            ((|documentation| . " Length in bits.
")
              (|symeNameCode| . 437828088)
              (|symeTypeCode| . 286270707)))
          (|Declare|
            |shift|
            (|Apply| -> (|Comma| % |SingleInteger|) %)
            ((|documentation| . " Shift by the a number of bits.
")
              (|symeNameCode| . 375083307)
              (|symeTypeCode| . 546428929)))
          (|Declare|
            |bit|
            (|Apply| -> (|Comma| % |SingleInteger|) |Boolean|)
            ((|documentation| . " Extract the desired bit.
")
              (|symeNameCode| . 315119482)
              (|symeTypeCode| . 212731410)))
          (|Declare|
            |retract|
            (|Apply| -> % |SingleInteger|)
            ((|documentation| . " Convert to SingleInteger, if can.
")
              (|symeNameCode| . 386811348)
              (|symeTypeCode| . 286270707)))
          (|Declare|
            |intToString|
            (|Apply| -> % |String|)
            ((|documentation| . " convert to a string
")
              (|symeNameCode| . 135709192)
              (|symeTypeCode| . 729041755))))))
    ((|documentation| .
        " `IntegerNumberSystem' provides the basic operations for a type which
 represents a range of integers.

 Author: AXIOM-XL library
 Date Created: 1992-94
 Keywords: integer, arithmetic
")
      (|symeNameCode| . 324190343)
      (|symeTypeCode| . 290697749)
      (|catExports|
        (|Declare|
          =
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Equality test.
")
            (|symeNameCode| . 200102)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          ~=
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Inequality test.
")
            (|default| . 1)
            (|symeNameCode| . 51509389)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          <<
          (|Apply| -> (|Comma| |TextWriter| %) |TextWriter|)
          ((|documentation| . " Basic output.
")
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 561215334)))
        (|Declare|
          <<
          (|Apply| -> % (|Apply| -> |TextWriter| |TextWriter|))
          ((|documentation| . " Basic output.
")
            (|default| . 1)
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 112505899)))
        (|Declare|
          |sample|
          %
          ((|documentation| . " Example element.
")
            (|default| . 1)
            (|symeNameCode| . 255806968)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          |hash|
          (|Apply| -> % |SingleInteger|)
          ((|documentation| . " Hashing function.
")
            (|default| . 1)
            (|symeNameCode| . 746853960)
            (|symeTypeCode| . 286270707)))
        (|Declare|
          |case|
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " for 'select' statements;
")
            (|default| . 1)
            (|symeNameCode| . 864625472)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          %%
          |BasicType|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 866929616)))
        (|Declare|
          >
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Greater than test.
")
            (|symeNameCode| . 200103)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          <
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Less than test.
")
            (|default| . 1)
            (|symeNameCode| . 200101)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          >=
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Greater than or equal test.
")
            (|default| . 1)
            (|symeNameCode| . 51492941)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          <=
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Less than or equal test.
")
            (|default| . 1)
            (|symeNameCode| . 51492427)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          |max|
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Maximum argument.
")
            (|default| . 1)
            (|symeNameCode| . 318461825)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          |min|
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Minimum argument.
")
            (|default| . 1)
            (|symeNameCode| . 318459775)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          >
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |x|
                %
                ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 200103)
            (|symeTypeCode| . 134984876)))
        (|Declare|
          <
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |x|
                %
                ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 200101)
            (|symeTypeCode| . 134984876)))
        (|Declare|
          >=
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |x|
                %
                ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 51492941)
            (|symeTypeCode| . 134984876)))
        (|Declare|
          <=
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |x|
                %
                ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 51492427)
            (|symeTypeCode| . 134984876)))
        (|Declare|
          >
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 200103)
            (|symeTypeCode| . 305073998)))
        (|Declare|
          <
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 200101)
            (|symeTypeCode| . 305073998)))
        (|Declare|
          >=
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 51492941)
            (|symeTypeCode| . 305073998)))
        (|Declare|
          <=
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 51492427)
            (|symeTypeCode| . 305073998)))
        (|Declare|
          >
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            |Boolean|)
          ((|default| . 1)
            (|symeNameCode| . 200103)
            (|symeTypeCode| . 191989437)))
        (|Declare|
          <
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            |Boolean|)
          ((|default| . 1)
            (|symeNameCode| . 200101)
            (|symeTypeCode| . 191989437)))
        (|Declare|
          >=
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            |Boolean|)
          ((|default| . 1)
            (|symeNameCode| . 51492941)
            (|symeTypeCode| . 191989437)))
        (|Declare|
          <=
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            |Boolean|)
          ((|default| . 1)
            (|symeNameCode| . 51492427)
            (|symeTypeCode| . 191989437)))
        (|Declare|
          %%
          |Order|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 105187748)))
        (|Declare|
          \0
          %
          ((|documentation| . " Identity for addition.
")
            (|symeNameCode| . 200089)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          +
          (|Apply| -> % %)
          ((|documentation| . " Identity function.
")
            (|default| . 1)
            (|symeNameCode| . 200084)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          +
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Addition.
")
            (|symeNameCode| . 200084)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          |zero?|
          (|Apply| -> % |Boolean|)
          ((|documentation| . " Test whether value equals 0.
")
            (|default| . 1)
            (|symeNameCode| . 206475020)
            (|symeTypeCode| . 884043277)))
        (|Declare|
          %%
          |AbelianMonoid|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 744293378)))
        (|Declare|
          %%
          |OrderedAbelianMonoid|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 383243686)))
        (|Declare|
          -
          (|Apply| -> % %)
          ((|documentation| . " Negation.
")
            (|symeNameCode| . 200086)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          -
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Subtraction.
")
            (|default| . 1)
            (|symeNameCode| . 200086)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          %%
          |AbelianGroup|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 269400384)))
        (|Declare|
          %%
          |OrderedAbelianGroup|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 555959524)))
        (|Declare|
          \1
          %
          ((|documentation| . " Identity for `*'
")
            (|symeNameCode| . 200090)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          *
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Multiplication
")
            (|symeNameCode| . 200083)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          ^
          (|Apply| -> (|Comma| % |Integer|) %)
          ((|documentation| . " Exponentiation or error
")
            (|symeNameCode| . 200135)
            (|symeTypeCode| . 455750953)))
        (|Declare|
          |coerce|
          (|Apply| -> |Integer| %)
          ((|symeNameCode| . 770345191) (|symeTypeCode| . 363839259)))
        (|Declare|
          |coerce|
          (|Apply| -> |SingleInteger| %)
          ((|symeNameCode| . 770345191) (|symeTypeCode| . 352135667)))
        (|Declare|
          %%
          |ArithmeticSystem|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 297185210)))
        (|Declare|
          %%
          |Monoid|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 656786807)))
        (|Declare|
          %%
          |Ring|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 118610639)))
        (|Declare|
          |abs|
          (|Apply| -> % %)
          ((|documentation| . " Absolute value.
")
            (|default| . 1)
            (|symeNameCode| . 315051633)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          |sign|
          (|Apply| -> % %)
          ((|documentation| . " -1, 0, or 1.
")
            (|default| . 1)
            (|symeNameCode| . 61935445)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          |negative?|
          (|Apply| -> % |Boolean|)
          ((|documentation| . " Test whether value is negative?
")
            (|default| . 1)
            (|symeNameCode| . 424301635)
            (|symeTypeCode| . 884043277)))
        (|Declare|
          |positive?|
          (|Apply| -> % |Boolean|)
          ((|documentation| . " Test whether value is positive?
")
            (|default| . 1)
            (|symeNameCode| . 733146723)
            (|symeTypeCode| . 884043277)))
        (|Declare|
          %%
          |OrderedRing|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 816910963)))
        (|Declare|
          |gcd|
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Greatest commond divisor.
")
            (|symeNameCode| . 318604649)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          |quo|
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Quotient leaving remainder.
")
            (|symeNameCode| . 318204816)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          |rem|
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Remainder.
")
            (|symeNameCode| . 318266239)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          |divide|
          (|Apply| -> (|Comma| % %) (|Comma| % %))
          ((|documentation| . " Quotient-remainder pair.
")
            (|default| . 1)
            (|symeNameCode| . 42114539)
            (|symeTypeCode| . 624266776)))
        (|Declare|
          %%
          |EuclideanDomain|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 78774180)))
        (|Declare|
          |integer|
          (|Apply| -> |Literal| %)
          ((|documentation| . " Integer-style literals.
")
            (|symeNameCode| . 477900237)
            (|symeTypeCode| . 794338558)))
        (|Declare|
          |even?|
          (|Apply| -> % |Boolean|)
          ((|documentation| . " Test whether the value is even.
")
            (|symeNameCode| . 498514682)
            (|symeTypeCode| . 884043277)))
        (|Declare|
          |odd?|
          (|Apply| -> % |Boolean|)
          ((|documentation| . " Test whether the value is odd.
")
            (|symeNameCode| . 665072666)
            (|symeTypeCode| . 884043277)))
        (|Declare|
          |single?|
          (|Apply| -> % |Boolean|)
          ((|documentation| . " Can a SingleInteger hold the value?
")
            (|symeNameCode| . 362464416)
            (|symeTypeCode| . 884043277)))
        (|Declare|
          |prev|
          (|Apply| -> % %)
          ((|documentation| . " Decrement the value by 1.
")
            (|symeNameCode| . 613807201)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          |next|
          (|Apply| -> % %)
          ((|documentation| . " Increment the value by 1.
")
            (|symeNameCode| . 782953315)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          |mod|
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Modulus.
")
            (|symeNameCode| . 318461307)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          |length|
          (|Apply| -> % |SingleInteger|)
          ((|documentation| . " Length in bits.
")
            (|symeNameCode| . 437828088)
            (|symeTypeCode| . 286270707)))
        (|Declare|
          |shift|
          (|Apply| -> (|Comma| % |SingleInteger|) %)
          ((|documentation| . " Shift by the a number of bits.
")
            (|symeNameCode| . 375083307)
            (|symeTypeCode| . 546428929)))
        (|Declare|
          |bit|
          (|Apply| -> (|Comma| % |SingleInteger|) |Boolean|)
          ((|documentation| . " Extract the desired bit.
")
            (|symeNameCode| . 315119482)
            (|symeTypeCode| . 212731410)))
        (|Declare|
          |retract|
          (|Apply| -> % |SingleInteger|)
          ((|documentation| . " Convert to SingleInteger, if can.
")
            (|symeNameCode| . 386811348)
            (|symeTypeCode| . 286270707)))
        (|Declare|
          |intToString|
          (|Apply| -> % |String|)
          ((|documentation| . " convert to a string
")
            (|symeNameCode| . 135709192)
            (|symeTypeCode| . 729041755)))
        (|Declare|
          %%
          |IntegerNumberSystem|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 265443874))))))
  (|Declare|
    |OrderedRing|
    (|Define|
      (|Declare| (|Label| |OrderedRing| ()) |Category|)
      (|With|
        (|Apply| |Join| |OrderedAbelianGroup| |Ring|)
        (|Sequence|
          (|Declare|
            |abs|
            (|Apply| -> % %)
            ((|documentation| . " Absolute value.
")
              (|default| . 1)
              (|symeNameCode| . 315051633)
              (|symeTypeCode| . 143998972)))
          (|Declare|
            |sign|
            (|Apply| -> % %)
            ((|documentation| . " -1, 0, or 1.
")
              (|default| . 1)
              (|symeNameCode| . 61935445)
              (|symeTypeCode| . 143998972)))
          (|Declare|
            |negative?|
            (|Apply| -> % |Boolean|)
            ((|documentation| . " Test whether value is negative?
")
              (|default| . 1)
              (|symeNameCode| . 424301635)
              (|symeTypeCode| . 884043277)))
          (|Declare|
            |positive?|
            (|Apply| -> % |Boolean|)
            ((|documentation| . " Test whether value is positive?
")
              (|default| . 1)
              (|symeNameCode| . 733146723)
              (|symeTypeCode| . 884043277)))
          (|Default|
            (|Sequence|
              (|Define|
                (|Declare|
                  |abs|
                  (|Apply|
                    ->
                    (|Declare|
                      |x|
                      %
                      ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
                    %)
                  ((|documentation| . " Absolute value.
")
                    (|default| . 1)
                    (|symeNameCode| . 315051633)
                    (|symeTypeCode| . 143998972)))
                (|Lambda|
                  (|Comma|
                    (|Declare|
                      |x|
                      %
                      ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433))))
                  %
                  (|Label| |abs| (|If| (|Test| (|Apply| > |x| \0)) |x| (|Apply| - |x|)))))
              (|Define|
                (|Declare|
                  |sign|
                  (|Apply|
                    ->
                    (|Declare|
                      |x|
                      %
                      ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
                    %)
                  ((|documentation| . " -1, 0, or 1.
")
                    (|default| . 1)
                    (|symeNameCode| . 61935445)
                    (|symeTypeCode| . 143998972)))
                (|Lambda|
                  (|Comma|
                    (|Declare|
                      |x|
                      %
                      ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433))))
                  %
                  (|Label|
                    |sign|
                    (|Sequence|
                      (|Exit| (|Test| (|Apply| > |x| \0)) \1)
                      (|Exit| (|Test| (|Apply| < |x| \0)) (|Apply| - \1))
                      \0))))
              (|Define|
                (|Declare|
                  |negative?|
                  (|Apply|
                    ->
                    (|Declare|
                      |x|
                      %
                      ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
                    |Boolean|)
                  ((|documentation| . " Test whether value is negative?
")
                    (|default| . 1)
                    (|symeNameCode| . 424301635)
                    (|symeTypeCode| . 884043277)))
                (|Lambda|
                  (|Comma|
                    (|Declare|
                      |x|
                      %
                      ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433))))
                  |Boolean|
                  (|Label| |negative?| (|Apply| < |x| \0))))
              (|Define|
                (|Declare|
                  |positive?|
                  (|Apply|
                    ->
                    (|Declare|
                      |x|
                      %
                      ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
                    |Boolean|)
                  ((|documentation| . " Test whether value is positive?
")
                    (|default| . 1)
                    (|symeNameCode| . 733146723)
                    (|symeTypeCode| . 884043277)))
                (|Lambda|
                  (|Comma|
                    (|Declare|
                      |x|
                      %
                      ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433))))
                  |Boolean|
                  (|Label| |positive?| (|Apply| > |x| \0)))))))))
    ((|documentation| .
        " `OrderedRing' provides arithmetic consistent with an ordering.

 Author: AXIOM-XL library
 Date Created: 1992-94
 Keywords: arithmetic, order
")
      (|symeNameCode| . 875657432)
      (|symeTypeCode| . 876065381)
      (|catExports|
        (|Declare|
          =
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Equality test.
")
            (|symeNameCode| . 200102)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          ~=
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Inequality test.
")
            (|default| . 1)
            (|symeNameCode| . 51509389)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          <<
          (|Apply| -> (|Comma| |TextWriter| %) |TextWriter|)
          ((|documentation| . " Basic output.
")
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 561215334)))
        (|Declare|
          <<
          (|Apply| -> % (|Apply| -> |TextWriter| |TextWriter|))
          ((|documentation| . " Basic output.
")
            (|default| . 1)
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 112505899)))
        (|Declare|
          |sample|
          %
          ((|documentation| . " Example element.
")
            (|default| . 1)
            (|symeNameCode| . 255806968)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          |hash|
          (|Apply| -> % |SingleInteger|)
          ((|documentation| . " Hashing function.
")
            (|default| . 1)
            (|symeNameCode| . 746853960)
            (|symeTypeCode| . 286270707)))
        (|Declare|
          |case|
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " for 'select' statements;
")
            (|default| . 1)
            (|symeNameCode| . 864625472)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          %%
          |BasicType|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 866929616)))
        (|Declare|
          >
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Greater than test.
")
            (|symeNameCode| . 200103)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          <
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Less than test.
")
            (|default| . 1)
            (|symeNameCode| . 200101)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          >=
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Greater than or equal test.
")
            (|default| . 1)
            (|symeNameCode| . 51492941)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          <=
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Less than or equal test.
")
            (|default| . 1)
            (|symeNameCode| . 51492427)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          |max|
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Maximum argument.
")
            (|default| . 1)
            (|symeNameCode| . 318461825)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          |min|
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Minimum argument.
")
            (|default| . 1)
            (|symeNameCode| . 318459775)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          >
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |x|
                %
                ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 200103)
            (|symeTypeCode| . 134984876)))
        (|Declare|
          <
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |x|
                %
                ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 200101)
            (|symeTypeCode| . 134984876)))
        (|Declare|
          >=
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |x|
                %
                ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 51492941)
            (|symeTypeCode| . 134984876)))
        (|Declare|
          <=
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |x|
                %
                ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 51492427)
            (|symeTypeCode| . 134984876)))
        (|Declare|
          >
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 200103)
            (|symeTypeCode| . 305073998)))
        (|Declare|
          <
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 200101)
            (|symeTypeCode| . 305073998)))
        (|Declare|
          >=
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 51492941)
            (|symeTypeCode| . 305073998)))
        (|Declare|
          <=
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 51492427)
            (|symeTypeCode| . 305073998)))
        (|Declare|
          >
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            |Boolean|)
          ((|default| . 1)
            (|symeNameCode| . 200103)
            (|symeTypeCode| . 191989437)))
        (|Declare|
          <
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            |Boolean|)
          ((|default| . 1)
            (|symeNameCode| . 200101)
            (|symeTypeCode| . 191989437)))
        (|Declare|
          >=
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            |Boolean|)
          ((|default| . 1)
            (|symeNameCode| . 51492941)
            (|symeTypeCode| . 191989437)))
        (|Declare|
          <=
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            |Boolean|)
          ((|default| . 1)
            (|symeNameCode| . 51492427)
            (|symeTypeCode| . 191989437)))
        (|Declare|
          %%
          |Order|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 105187748)))
        (|Declare|
          \0
          %
          ((|documentation| . " Identity for addition.
")
            (|symeNameCode| . 200089)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          +
          (|Apply| -> % %)
          ((|documentation| . " Identity function.
")
            (|default| . 1)
            (|symeNameCode| . 200084)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          +
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Addition.
")
            (|symeNameCode| . 200084)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          |zero?|
          (|Apply| -> % |Boolean|)
          ((|documentation| . " Test whether value equals 0.
")
            (|default| . 1)
            (|symeNameCode| . 206475020)
            (|symeTypeCode| . 884043277)))
        (|Declare|
          %%
          |AbelianMonoid|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 744293378)))
        (|Declare|
          %%
          |OrderedAbelianMonoid|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 383243686)))
        (|Declare|
          -
          (|Apply| -> % %)
          ((|documentation| . " Negation.
")
            (|symeNameCode| . 200086)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          -
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Subtraction.
")
            (|default| . 1)
            (|symeNameCode| . 200086)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          %%
          |AbelianGroup|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 269400384)))
        (|Declare|
          %%
          |OrderedAbelianGroup|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 555959524)))
        (|Declare|
          \1
          %
          ((|documentation| . " Identity for `*'
")
            (|symeNameCode| . 200090)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          *
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Multiplication
")
            (|symeNameCode| . 200083)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          ^
          (|Apply| -> (|Comma| % |Integer|) %)
          ((|documentation| . " Exponentiation or error
")
            (|symeNameCode| . 200135)
            (|symeTypeCode| . 455750953)))
        (|Declare|
          |coerce|
          (|Apply| -> |Integer| %)
          ((|symeNameCode| . 770345191) (|symeTypeCode| . 363839259)))
        (|Declare|
          |coerce|
          (|Apply| -> |SingleInteger| %)
          ((|symeNameCode| . 770345191) (|symeTypeCode| . 352135667)))
        (|Declare|
          %%
          |ArithmeticSystem|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 297185210)))
        (|Declare|
          %%
          |Monoid|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 656786807)))
        (|Declare|
          %%
          |Ring|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 118610639)))
        (|Declare|
          |abs|
          (|Apply| -> % %)
          ((|documentation| . " Absolute value.
")
            (|default| . 1)
            (|symeNameCode| . 315051633)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          |sign|
          (|Apply| -> % %)
          ((|documentation| . " -1, 0, or 1.
")
            (|default| . 1)
            (|symeNameCode| . 61935445)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          |negative?|
          (|Apply| -> % |Boolean|)
          ((|documentation| . " Test whether value is negative?
")
            (|default| . 1)
            (|symeNameCode| . 424301635)
            (|symeTypeCode| . 884043277)))
        (|Declare|
          |positive?|
          (|Apply| -> % |Boolean|)
          ((|documentation| . " Test whether value is positive?
")
            (|default| . 1)
            (|symeNameCode| . 733146723)
            (|symeTypeCode| . 884043277)))
        (|Declare|
          %%
          |OrderedRing|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 816910963))))))
  (|Declare|
    |OrderedAbelianGroup|
    (|Define|
      (|Declare| (|Label| |OrderedAbelianGroup| ()) |Category|)
      (|Apply| |Join| |OrderedAbelianMonoid| |AbelianGroup|))
    ((|documentation| .
        " `OrderedAbelianGroup' provides group operations consistent with an order.

 Author: AXIOM-XL library
 Date Created: 1992-94
 Keywords: arithmetic, order
")
      (|symeNameCode| . 614705993)
      (|symeTypeCode| . 66808413)
      (|catExports|
        (|Declare|
          =
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Equality test.
")
            (|symeNameCode| . 200102)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          ~=
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Inequality test.
")
            (|default| . 1)
            (|symeNameCode| . 51509389)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          <<
          (|Apply| -> (|Comma| |TextWriter| %) |TextWriter|)
          ((|documentation| . " Basic output.
")
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 561215334)))
        (|Declare|
          <<
          (|Apply| -> % (|Apply| -> |TextWriter| |TextWriter|))
          ((|documentation| . " Basic output.
")
            (|default| . 1)
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 112505899)))
        (|Declare|
          |sample|
          %
          ((|documentation| . " Example element.
")
            (|default| . 1)
            (|symeNameCode| . 255806968)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          |hash|
          (|Apply| -> % |SingleInteger|)
          ((|documentation| . " Hashing function.
")
            (|default| . 1)
            (|symeNameCode| . 746853960)
            (|symeTypeCode| . 286270707)))
        (|Declare|
          |case|
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " for 'select' statements;
")
            (|default| . 1)
            (|symeNameCode| . 864625472)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          %%
          |BasicType|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 866929616)))
        (|Declare|
          >
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Greater than test.
")
            (|symeNameCode| . 200103)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          <
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Less than test.
")
            (|default| . 1)
            (|symeNameCode| . 200101)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          >=
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Greater than or equal test.
")
            (|default| . 1)
            (|symeNameCode| . 51492941)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          <=
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Less than or equal test.
")
            (|default| . 1)
            (|symeNameCode| . 51492427)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          |max|
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Maximum argument.
")
            (|default| . 1)
            (|symeNameCode| . 318461825)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          |min|
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Minimum argument.
")
            (|default| . 1)
            (|symeNameCode| . 318459775)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          >
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |x|
                %
                ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 200103)
            (|symeTypeCode| . 134984876)))
        (|Declare|
          <
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |x|
                %
                ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 200101)
            (|symeTypeCode| . 134984876)))
        (|Declare|
          >=
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |x|
                %
                ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 51492941)
            (|symeTypeCode| . 134984876)))
        (|Declare|
          <=
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |x|
                %
                ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 51492427)
            (|symeTypeCode| . 134984876)))
        (|Declare|
          >
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 200103)
            (|symeTypeCode| . 305073998)))
        (|Declare|
          <
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 200101)
            (|symeTypeCode| . 305073998)))
        (|Declare|
          >=
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 51492941)
            (|symeTypeCode| . 305073998)))
        (|Declare|
          <=
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 51492427)
            (|symeTypeCode| . 305073998)))
        (|Declare|
          >
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            |Boolean|)
          ((|default| . 1)
            (|symeNameCode| . 200103)
            (|symeTypeCode| . 191989437)))
        (|Declare|
          <
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            |Boolean|)
          ((|default| . 1)
            (|symeNameCode| . 200101)
            (|symeTypeCode| . 191989437)))
        (|Declare|
          >=
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            |Boolean|)
          ((|default| . 1)
            (|symeNameCode| . 51492941)
            (|symeTypeCode| . 191989437)))
        (|Declare|
          <=
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            |Boolean|)
          ((|default| . 1)
            (|symeNameCode| . 51492427)
            (|symeTypeCode| . 191989437)))
        (|Declare|
          %%
          |Order|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 105187748)))
        (|Declare|
          \0
          %
          ((|documentation| . " Identity for addition.
")
            (|symeNameCode| . 200089)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          +
          (|Apply| -> % %)
          ((|documentation| . " Identity function.
")
            (|default| . 1)
            (|symeNameCode| . 200084)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          +
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Addition.
")
            (|symeNameCode| . 200084)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          |zero?|
          (|Apply| -> % |Boolean|)
          ((|documentation| . " Test whether value equals 0.
")
            (|default| . 1)
            (|symeNameCode| . 206475020)
            (|symeTypeCode| . 884043277)))
        (|Declare|
          %%
          |AbelianMonoid|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 744293378)))
        (|Declare|
          %%
          |OrderedAbelianMonoid|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 383243686)))
        (|Declare|
          -
          (|Apply| -> % %)
          ((|documentation| . " Negation.
")
            (|symeNameCode| . 200086)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          -
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Subtraction.
")
            (|default| . 1)
            (|symeNameCode| . 200086)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          %%
          |AbelianGroup|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 269400384)))
        (|Declare|
          %%
          |OrderedAbelianGroup|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 555959524))))))
  (|Declare|
    |OrderedAbelianMonoid|
    (|Define|
      (|Declare| (|Label| |OrderedAbelianMonoid| ()) |Category|)
      (|Apply| |Join| |Order| |AbelianMonoid|))
    ((|documentation| .
        " `OrderedAbelianMonoid' provides an addition consistent with an order.

 Author: AXIOM-XL library
 Date Created: 1992-94
 Keywords: arithmetic, order
")
      (|symeNameCode| . 441990155)
      (|symeTypeCode| . 829927901)
      (|catExports|
        (|Declare|
          =
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Equality test.
")
            (|symeNameCode| . 200102)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          ~=
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Inequality test.
")
            (|default| . 1)
            (|symeNameCode| . 51509389)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          <<
          (|Apply| -> (|Comma| |TextWriter| %) |TextWriter|)
          ((|documentation| . " Basic output.
")
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 561215334)))
        (|Declare|
          <<
          (|Apply| -> % (|Apply| -> |TextWriter| |TextWriter|))
          ((|documentation| . " Basic output.
")
            (|default| . 1)
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 112505899)))
        (|Declare|
          |sample|
          %
          ((|documentation| . " Example element.
")
            (|default| . 1)
            (|symeNameCode| . 255806968)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          |hash|
          (|Apply| -> % |SingleInteger|)
          ((|documentation| . " Hashing function.
")
            (|default| . 1)
            (|symeNameCode| . 746853960)
            (|symeTypeCode| . 286270707)))
        (|Declare|
          |case|
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " for 'select' statements;
")
            (|default| . 1)
            (|symeNameCode| . 864625472)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          %%
          |BasicType|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 866929616)))
        (|Declare|
          >
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Greater than test.
")
            (|symeNameCode| . 200103)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          <
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Less than test.
")
            (|default| . 1)
            (|symeNameCode| . 200101)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          >=
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Greater than or equal test.
")
            (|default| . 1)
            (|symeNameCode| . 51492941)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          <=
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Less than or equal test.
")
            (|default| . 1)
            (|symeNameCode| . 51492427)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          |max|
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Maximum argument.
")
            (|default| . 1)
            (|symeNameCode| . 318461825)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          |min|
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Minimum argument.
")
            (|default| . 1)
            (|symeNameCode| . 318459775)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          >
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |x|
                %
                ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 200103)
            (|symeTypeCode| . 134984876)))
        (|Declare|
          <
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |x|
                %
                ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 200101)
            (|symeTypeCode| . 134984876)))
        (|Declare|
          >=
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |x|
                %
                ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 51492941)
            (|symeTypeCode| . 134984876)))
        (|Declare|
          <=
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |x|
                %
                ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 51492427)
            (|symeTypeCode| . 134984876)))
        (|Declare|
          >
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 200103)
            (|symeTypeCode| . 305073998)))
        (|Declare|
          <
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 200101)
            (|symeTypeCode| . 305073998)))
        (|Declare|
          >=
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 51492941)
            (|symeTypeCode| . 305073998)))
        (|Declare|
          <=
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 51492427)
            (|symeTypeCode| . 305073998)))
        (|Declare|
          >
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            |Boolean|)
          ((|default| . 1)
            (|symeNameCode| . 200103)
            (|symeTypeCode| . 191989437)))
        (|Declare|
          <
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            |Boolean|)
          ((|default| . 1)
            (|symeNameCode| . 200101)
            (|symeTypeCode| . 191989437)))
        (|Declare|
          >=
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            |Boolean|)
          ((|default| . 1)
            (|symeNameCode| . 51492941)
            (|symeTypeCode| . 191989437)))
        (|Declare|
          <=
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            |Boolean|)
          ((|default| . 1)
            (|symeNameCode| . 51492427)
            (|symeTypeCode| . 191989437)))
        (|Declare|
          %%
          |Order|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 105187748)))
        (|Declare|
          \0
          %
          ((|documentation| . " Identity for addition.
")
            (|symeNameCode| . 200089)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          +
          (|Apply| -> % %)
          ((|documentation| . " Identity function.
")
            (|default| . 1)
            (|symeNameCode| . 200084)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          +
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Addition.
")
            (|symeNameCode| . 200084)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          |zero?|
          (|Apply| -> % |Boolean|)
          ((|documentation| . " Test whether value equals 0.
")
            (|default| . 1)
            (|symeNameCode| . 206475020)
            (|symeTypeCode| . 884043277)))
        (|Declare|
          %%
          |AbelianMonoid|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 744293378)))
        (|Declare|
          %%
          |OrderedAbelianMonoid|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 383243686))))))
  (|Declare|
    |FiniteField|
    (|Define|
      (|Declare| (|Label| |FiniteField| ()) |Category|)
      (|With|
        (|Apply| |Join| |Finite| |Field|)
        (|Sequence|
          (|Declare|
            |integer|
            (|Apply| -> |Literal| %)
            ((|symeNameCode| . 477900237) (|symeTypeCode| . 794338558)))
          (|Declare|
            |reduce|
            (|Apply| -> |SingleInteger| %)
            ((|symeNameCode| . 752904942) (|symeTypeCode| . 352135667)))
          (|Declare|
            |lift|
            (|Apply| -> % |SingleInteger|)
            ((|symeNameCode| . 683165523) (|symeTypeCode| . 286270707))))))
    ((|documentation| .
        " `FiniteField' provides arithmetic on a finite set.

 Author: AXIOM-XL library
 Date Created: 1992-94
 Keywords: arithmetic, field operations, division
")
      (|symeNameCode| . 373422278)
      (|symeTypeCode| . 953917863)
      (|catExports|
        (|Declare|
          =
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Equality test.
")
            (|symeNameCode| . 200102)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          ~=
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Inequality test.
")
            (|default| . 1)
            (|symeNameCode| . 51509389)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          <<
          (|Apply| -> (|Comma| |TextWriter| %) |TextWriter|)
          ((|documentation| . " Basic output.
")
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 561215334)))
        (|Declare|
          <<
          (|Apply| -> % (|Apply| -> |TextWriter| |TextWriter|))
          ((|documentation| . " Basic output.
")
            (|default| . 1)
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 112505899)))
        (|Declare|
          |sample|
          %
          ((|documentation| . " Example element.
")
            (|default| . 1)
            (|symeNameCode| . 255806968)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          |hash|
          (|Apply| -> % |SingleInteger|)
          ((|documentation| . " Hashing function.
")
            (|default| . 1)
            (|symeNameCode| . 746853960)
            (|symeTypeCode| . 286270707)))
        (|Declare|
          |case|
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " for 'select' statements;
")
            (|default| . 1)
            (|symeNameCode| . 864625472)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          %%
          |BasicType|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 866929616)))
        (|Declare|
          |#|
          |Integer|
          ((|documentation| . " Number of values in the type.
")
            (|symeNameCode| . 200076)
            (|symeTypeCode| . 425461576)))
        (|Declare|
          %%
          |Finite|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 50729328)))
        (|Declare|
          \0
          %
          ((|documentation| . " Identity for `+'
")
            (|symeNameCode| . 200089)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          +
          (|Apply| -> % %)
          ((|documentation| . " Identity.
")
            (|default| . 1)
            (|symeNameCode| . 200084)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          +
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Addition.
")
            (|symeNameCode| . 200084)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          -
          (|Apply| -> % %)
          ((|documentation| . " Negation.
")
            (|symeNameCode| . 200086)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          -
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Subtraction.
")
            (|default| . 1)
            (|symeNameCode| . 200086)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          \1
          %
          ((|documentation| . " Identity for `*'
")
            (|symeNameCode| . 200090)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          *
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Multiplication
")
            (|symeNameCode| . 200083)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          ^
          (|Apply| -> (|Comma| % |Integer|) %)
          ((|documentation| . " Exponentiation or error
")
            (|symeNameCode| . 200135)
            (|symeTypeCode| . 455750953)))
        (|Declare|
          |coerce|
          (|Apply| -> |Integer| %)
          ((|symeNameCode| . 770345191) (|symeTypeCode| . 363839259)))
        (|Declare|
          |coerce|
          (|Apply| -> |SingleInteger| %)
          ((|symeNameCode| . 770345191) (|symeTypeCode| . 352135667)))
        (|Declare|
          %%
          |ArithmeticSystem|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 297185210)))
        (|Declare|
          %%
          |Monoid|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 656786807)))
        (|Declare|
          |zero?|
          (|Apply| -> % |Boolean|)
          ((|documentation| . " Test whether value equals 0.
")
            (|default| . 1)
            (|symeNameCode| . 206475020)
            (|symeTypeCode| . 884043277)))
        (|Declare|
          %%
          |AbelianMonoid|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 744293378)))
        (|Declare|
          %%
          |AbelianGroup|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 269400384)))
        (|Declare|
          %%
          |Ring|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 118610639)))
        (|Declare|
          |gcd|
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Greatest commond divisor.
")
            (|default| . 1)
            (|symeNameCode| . 318604649)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          |quo|
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Quotient leaving remainder.
")
            (|default| . 1)
            (|symeNameCode| . 318204816)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          |rem|
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Remainder.
")
            (|default| . 1)
            (|symeNameCode| . 318266239)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          |divide|
          (|Apply| -> (|Comma| % %) (|Comma| % %))
          ((|documentation| . " Quotient-remainder pair.
")
            (|default| . 1)
            (|symeNameCode| . 42114539)
            (|symeTypeCode| . 624266776)))
        (|Declare|
          %%
          |EuclideanDomain|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 78774180)))
        (|Declare|
          /
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Division: a/b = a*inv(b).
")
            (|default| . 1)
            (|symeNameCode| . 200088)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          |\\|
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Division: a\\b = inv(a)*b
")
            (|default| . 1)
            (|symeNameCode| . 200133)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          |inv|
          (|Apply| -> % %)
          ((|documentation| . " Inverse.
")
            (|symeNameCode| . 318722696)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          %%
          |Group|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 372253109)))
        (|Declare|
          |unit?|
          (|Apply|
            ->
            (|Declare|
              |x|
              %
              ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
            |Boolean|)
          ((|default| . 1)
            (|symeNameCode| . 896181516)
            (|symeTypeCode| . 884043277)))
        (|Declare|
          %%
          |Field|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 627245452)))
        (|Declare|
          |integer|
          (|Apply| -> |Literal| %)
          ((|symeNameCode| . 477900237) (|symeTypeCode| . 794338558)))
        (|Declare|
          |reduce|
          (|Apply| -> |SingleInteger| %)
          ((|symeNameCode| . 752904942) (|symeTypeCode| . 352135667)))
        (|Declare|
          |lift|
          (|Apply| -> % |SingleInteger|)
          ((|symeNameCode| . 683165523) (|symeTypeCode| . 286270707)))
        (|Declare|
          %%
          |FiniteField|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 314675809))))))
  (|Declare|
    |Field|
    (|Define|
      (|Declare| (|Label| |Field| ()) |Category|)
      (|With|
        (|Apply| |Join| |EuclideanDomain| |Group|)
        (|Default|
          (|Sequence|
            (|Define|
              (|Declare|
                |gcd|
                (|Apply|
                  ->
                  (|Comma|
                    (|Declare|
                      |a|
                      %
                      ((|symeNameCode| . 200138) (|symeTypeCode| . 1015195433)))
                    (|Declare|
                      |b|
                      %
                      ((|symeNameCode| . 200139) (|symeTypeCode| . 1015195433))))
                  %)
                ((|default| . 1)
                  (|symeNameCode| . 318604649)
                  (|symeTypeCode| . 355597834)))
              (|Lambda|
                (|Comma|
                  (|Declare|
                    |a|
                    %
                    ((|symeNameCode| . 200138) (|symeTypeCode| . 1015195433)))
                  (|Declare|
                    |b|
                    %
                    ((|symeNameCode| . 200139) (|symeTypeCode| . 1015195433))))
                %
                (|Label|
                  |gcd|
                  (|Sequence|
                    (|Exit|
                      (|Test|
                        (|And| (|Test| (|Apply| |zero?| |a|)) (|Test| (|Apply| |zero?| |b|))))
                      \0)
                    \1))))
            (|Define|
              (|Declare|
                |quo|
                (|Apply|
                  ->
                  (|Comma|
                    (|Declare|
                      |a|
                      %
                      ((|symeNameCode| . 200138) (|symeTypeCode| . 1015195433)))
                    (|Declare|
                      |b|
                      %
                      ((|symeNameCode| . 200139) (|symeTypeCode| . 1015195433))))
                  %)
                ((|default| . 1)
                  (|symeNameCode| . 318204816)
                  (|symeTypeCode| . 355597834)))
              (|Lambda|
                (|Comma|
                  (|Declare|
                    |a|
                    %
                    ((|symeNameCode| . 200138) (|symeTypeCode| . 1015195433)))
                  (|Declare|
                    |b|
                    %
                    ((|symeNameCode| . 200139) (|symeTypeCode| . 1015195433))))
                %
                (|Label| |quo| (|Apply| / |a| |b|))))
            (|Define|
              (|Declare|
                |rem|
                (|Apply|
                  ->
                  (|Comma|
                    (|Declare|
                      |a|
                      %
                      ((|symeNameCode| . 200138) (|symeTypeCode| . 1015195433)))
                    (|Declare|
                      |b|
                      %
                      ((|symeNameCode| . 200139) (|symeTypeCode| . 1015195433))))
                  %)
                ((|default| . 1)
                  (|symeNameCode| . 318266239)
                  (|symeTypeCode| . 355597834)))
              (|Lambda|
                (|Comma|
                  (|Declare|
                    |a|
                    %
                    ((|symeNameCode| . 200138) (|symeTypeCode| . 1015195433)))
                  (|Declare|
                    |b|
                    %
                    ((|symeNameCode| . 200139) (|symeTypeCode| . 1015195433))))
                %
                (|Label| |rem| \0)))
            (|Define|
              (|Declare|
                |unit?|
                (|Apply|
                  ->
                  (|Declare|
                    |x|
                    %
                    ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
                  |Boolean|)
                ((|default| . 1)
                  (|symeNameCode| . 896181516)
                  (|symeTypeCode| . 884043277)))
              (|Lambda|
                (|Comma|
                  (|Declare|
                    |x|
                    %
                    ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433))))
                |Boolean|
                (|Label| |unit?| (|Not| (|Test| (|Apply| |zero?| |x|))))))))))
    ((|documentation| .
        " `Field' provides arithmetic with division.

 Author: AXIOM-XL library
 Date Created: 1992-94
 Keywords: arithmetic, field operations, division
")
      (|symeNameCode| . 685991921)
      (|symeTypeCode| . 949279247)
      (|catExports|
        (|Declare|
          \0
          %
          ((|documentation| . " Identity for `+'
")
            (|symeNameCode| . 200089)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          +
          (|Apply| -> % %)
          ((|documentation| . " Identity.
")
            (|default| . 1)
            (|symeNameCode| . 200084)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          +
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Addition.
")
            (|symeNameCode| . 200084)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          -
          (|Apply| -> % %)
          ((|documentation| . " Negation.
")
            (|symeNameCode| . 200086)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          -
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Subtraction.
")
            (|default| . 1)
            (|symeNameCode| . 200086)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          \1
          %
          ((|documentation| . " Identity for `*'
")
            (|symeNameCode| . 200090)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          *
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Multiplication
")
            (|symeNameCode| . 200083)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          ^
          (|Apply| -> (|Comma| % |Integer|) %)
          ((|documentation| . " Exponentiation or error
")
            (|symeNameCode| . 200135)
            (|symeTypeCode| . 455750953)))
        (|Declare|
          |coerce|
          (|Apply| -> |Integer| %)
          ((|symeNameCode| . 770345191) (|symeTypeCode| . 363839259)))
        (|Declare|
          |coerce|
          (|Apply| -> |SingleInteger| %)
          ((|symeNameCode| . 770345191) (|symeTypeCode| . 352135667)))
        (|Declare|
          %%
          |ArithmeticSystem|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 297185210)))
        (|Declare|
          =
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Equality test.
")
            (|symeNameCode| . 200102)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          ~=
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Inequality test.
")
            (|default| . 1)
            (|symeNameCode| . 51509389)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          <<
          (|Apply| -> (|Comma| |TextWriter| %) |TextWriter|)
          ((|documentation| . " Basic output.
")
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 561215334)))
        (|Declare|
          <<
          (|Apply| -> % (|Apply| -> |TextWriter| |TextWriter|))
          ((|documentation| . " Basic output.
")
            (|default| . 1)
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 112505899)))
        (|Declare|
          |sample|
          %
          ((|documentation| . " Example element.
")
            (|default| . 1)
            (|symeNameCode| . 255806968)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          |hash|
          (|Apply| -> % |SingleInteger|)
          ((|documentation| . " Hashing function.
")
            (|default| . 1)
            (|symeNameCode| . 746853960)
            (|symeTypeCode| . 286270707)))
        (|Declare|
          |case|
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " for 'select' statements;
")
            (|default| . 1)
            (|symeNameCode| . 864625472)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          %%
          |BasicType|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 866929616)))
        (|Declare|
          %%
          |Monoid|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 656786807)))
        (|Declare|
          |zero?|
          (|Apply| -> % |Boolean|)
          ((|documentation| . " Test whether value equals 0.
")
            (|default| . 1)
            (|symeNameCode| . 206475020)
            (|symeTypeCode| . 884043277)))
        (|Declare|
          %%
          |AbelianMonoid|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 744293378)))
        (|Declare|
          %%
          |AbelianGroup|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 269400384)))
        (|Declare|
          %%
          |Ring|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 118610639)))
        (|Declare|
          |gcd|
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Greatest commond divisor.
")
            (|default| . 1)
            (|symeNameCode| . 318604649)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          |quo|
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Quotient leaving remainder.
")
            (|default| . 1)
            (|symeNameCode| . 318204816)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          |rem|
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Remainder.
")
            (|default| . 1)
            (|symeNameCode| . 318266239)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          |divide|
          (|Apply| -> (|Comma| % %) (|Comma| % %))
          ((|documentation| . " Quotient-remainder pair.
")
            (|default| . 1)
            (|symeNameCode| . 42114539)
            (|symeTypeCode| . 624266776)))
        (|Declare|
          %%
          |EuclideanDomain|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 78774180)))
        (|Declare|
          /
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Division: a/b = a*inv(b).
")
            (|default| . 1)
            (|symeNameCode| . 200088)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          |\\|
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Division: a\\b = inv(a)*b
")
            (|default| . 1)
            (|symeNameCode| . 200133)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          |inv|
          (|Apply| -> % %)
          ((|documentation| . " Inverse.
")
            (|symeNameCode| . 318722696)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          %%
          |Group|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 372253109)))
        (|Declare|
          |unit?|
          (|Apply|
            ->
            (|Declare|
              |x|
              %
              ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
            |Boolean|)
          ((|default| . 1)
            (|symeNameCode| . 896181516)
            (|symeTypeCode| . 884043277)))
        (|Declare|
          %%
          |Field|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 627245452))))))
  (|Declare|
    |EuclideanDomain|
    (|Define|
      (|Declare| (|Label| |EuclideanDomain| ()) |Category|)
      (|With|
        |Ring|
        (|Sequence|
          (|Declare|
            |gcd|
            (|Apply| -> (|Comma| % %) %)
            ((|documentation| . " Greatest commond divisor.
")
              (|symeNameCode| . 318604649)
              (|symeTypeCode| . 355597834)))
          (|Declare|
            |quo|
            (|Apply| -> (|Comma| % %) %)
            ((|documentation| . " Quotient leaving remainder.
")
              (|symeNameCode| . 318204816)
              (|symeTypeCode| . 355597834)))
          (|Declare|
            |rem|
            (|Apply| -> (|Comma| % %) %)
            ((|documentation| . " Remainder.
")
              (|symeNameCode| . 318266239)
              (|symeTypeCode| . 355597834)))
          (|Declare|
            |divide|
            (|Apply| -> (|Comma| % %) (|Comma| % %))
            ((|documentation| . " Quotient-remainder pair.
")
              (|default| . 1)
              (|symeNameCode| . 42114539)
              (|symeTypeCode| . 624266776)))
          (|Default|
            (|Define|
              (|Declare|
                |divide|
                (|Apply|
                  ->
                  (|Comma|
                    (|Declare|
                      |a|
                      %
                      ((|symeNameCode| . 200138) (|symeTypeCode| . 1015195433)))
                    (|Declare|
                      |b|
                      %
                      ((|symeNameCode| . 200139) (|symeTypeCode| . 1015195433))))
                  (|Comma| % %))
                ((|documentation| . " Quotient-remainder pair.
")
                  (|default| . 1)
                  (|symeNameCode| . 42114539)
                  (|symeTypeCode| . 624266776)))
              (|Lambda|
                (|Comma|
                  (|Declare|
                    |a|
                    %
                    ((|symeNameCode| . 200138) (|symeTypeCode| . 1015195433)))
                  (|Declare|
                    |b|
                    %
                    ((|symeNameCode| . 200139) (|symeTypeCode| . 1015195433))))
                (|Comma| % %)
                (|Label|
                  |divide|
                  (|Comma| (|Apply| |quo| |a| |b|) (|Apply| |rem| |a| |b|)))))))))
    ((|documentation| .
        " `EuclideanDomain' provides ring operations and division with remainder.

 Author: AXIOM-XL library
 Date Created: 1992-94
 Keywords: arithmetic, division, greatest common divisor, Euclidean domain
")
      (|symeNameCode| . 137520649)
      (|symeTypeCode| . 857821563)
      (|catExports|
        (|Declare|
          \0
          %
          ((|documentation| . " Identity for `+'
")
            (|symeNameCode| . 200089)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          +
          (|Apply| -> % %)
          ((|documentation| . " Identity.
")
            (|default| . 1)
            (|symeNameCode| . 200084)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          +
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Addition.
")
            (|symeNameCode| . 200084)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          -
          (|Apply| -> % %)
          ((|documentation| . " Negation.
")
            (|symeNameCode| . 200086)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          -
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Subtraction.
")
            (|default| . 1)
            (|symeNameCode| . 200086)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          \1
          %
          ((|documentation| . " Identity for `*'
")
            (|symeNameCode| . 200090)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          *
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Multiplication
")
            (|symeNameCode| . 200083)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          ^
          (|Apply| -> (|Comma| % |Integer|) %)
          ((|documentation| . " Exponentiation or error
")
            (|symeNameCode| . 200135)
            (|symeTypeCode| . 455750953)))
        (|Declare|
          |coerce|
          (|Apply| -> |Integer| %)
          ((|symeNameCode| . 770345191) (|symeTypeCode| . 363839259)))
        (|Declare|
          |coerce|
          (|Apply| -> |SingleInteger| %)
          ((|symeNameCode| . 770345191) (|symeTypeCode| . 352135667)))
        (|Declare|
          %%
          |ArithmeticSystem|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 297185210)))
        (|Declare|
          =
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Equality test.
")
            (|symeNameCode| . 200102)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          ~=
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Inequality test.
")
            (|default| . 1)
            (|symeNameCode| . 51509389)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          <<
          (|Apply| -> (|Comma| |TextWriter| %) |TextWriter|)
          ((|documentation| . " Basic output.
")
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 561215334)))
        (|Declare|
          <<
          (|Apply| -> % (|Apply| -> |TextWriter| |TextWriter|))
          ((|documentation| . " Basic output.
")
            (|default| . 1)
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 112505899)))
        (|Declare|
          |sample|
          %
          ((|documentation| . " Example element.
")
            (|default| . 1)
            (|symeNameCode| . 255806968)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          |hash|
          (|Apply| -> % |SingleInteger|)
          ((|documentation| . " Hashing function.
")
            (|default| . 1)
            (|symeNameCode| . 746853960)
            (|symeTypeCode| . 286270707)))
        (|Declare|
          |case|
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " for 'select' statements;
")
            (|default| . 1)
            (|symeNameCode| . 864625472)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          %%
          |BasicType|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 866929616)))
        (|Declare|
          %%
          |Monoid|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 656786807)))
        (|Declare|
          |zero?|
          (|Apply| -> % |Boolean|)
          ((|documentation| . " Test whether value equals 0.
")
            (|default| . 1)
            (|symeNameCode| . 206475020)
            (|symeTypeCode| . 884043277)))
        (|Declare|
          %%
          |AbelianMonoid|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 744293378)))
        (|Declare|
          %%
          |AbelianGroup|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 269400384)))
        (|Declare|
          %%
          |Ring|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 118610639)))
        (|Declare|
          |gcd|
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Greatest commond divisor.
")
            (|symeNameCode| . 318604649)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          |quo|
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Quotient leaving remainder.
")
            (|symeNameCode| . 318204816)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          |rem|
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Remainder.
")
            (|symeNameCode| . 318266239)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          |divide|
          (|Apply| -> (|Comma| % %) (|Comma| % %))
          ((|documentation| . " Quotient-remainder pair.
")
            (|default| . 1)
            (|symeNameCode| . 42114539)
            (|symeTypeCode| . 624266776)))
        (|Declare|
          %%
          |EuclideanDomain|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 78774180))))))
  (|Declare|
    |Ring|
    (|Define|
      (|Declare| (|Label| |Ring| ()) |Category|)
      (|Apply| |Join| |ArithmeticSystem| |Monoid| |AbelianGroup|))
    ((|documentation| .
        " `Ring' provides the basic arithmetic operations of
 addition, subtraction and multiplication.

 Author: AXIOM-XL library
 Date Created: 1992-94
 Keywords: arithmetic, ring operations
")
      (|symeNameCode| . 177357108)
      (|symeTypeCode| . 31968837)
      (|catExports|
        (|Declare|
          \0
          %
          ((|documentation| . " Identity for `+'
")
            (|symeNameCode| . 200089)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          +
          (|Apply| -> % %)
          ((|documentation| . " Identity.
")
            (|default| . 1)
            (|symeNameCode| . 200084)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          +
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Addition.
")
            (|symeNameCode| . 200084)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          -
          (|Apply| -> % %)
          ((|documentation| . " Negation.
")
            (|symeNameCode| . 200086)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          -
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Subtraction.
")
            (|default| . 1)
            (|symeNameCode| . 200086)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          \1
          %
          ((|documentation| . " Identity for `*'
")
            (|symeNameCode| . 200090)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          *
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Multiplication
")
            (|symeNameCode| . 200083)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          ^
          (|Apply| -> (|Comma| % |Integer|) %)
          ((|documentation| . " Exponentiation or error
")
            (|symeNameCode| . 200135)
            (|symeTypeCode| . 455750953)))
        (|Declare|
          |coerce|
          (|Apply| -> |Integer| %)
          ((|symeNameCode| . 770345191) (|symeTypeCode| . 363839259)))
        (|Declare|
          |coerce|
          (|Apply| -> |SingleInteger| %)
          ((|symeNameCode| . 770345191) (|symeTypeCode| . 352135667)))
        (|Declare|
          %%
          |ArithmeticSystem|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 297185210)))
        (|Declare|
          =
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Equality test.
")
            (|symeNameCode| . 200102)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          ~=
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Inequality test.
")
            (|default| . 1)
            (|symeNameCode| . 51509389)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          <<
          (|Apply| -> (|Comma| |TextWriter| %) |TextWriter|)
          ((|documentation| . " Basic output.
")
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 561215334)))
        (|Declare|
          <<
          (|Apply| -> % (|Apply| -> |TextWriter| |TextWriter|))
          ((|documentation| . " Basic output.
")
            (|default| . 1)
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 112505899)))
        (|Declare|
          |sample|
          %
          ((|documentation| . " Example element.
")
            (|default| . 1)
            (|symeNameCode| . 255806968)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          |hash|
          (|Apply| -> % |SingleInteger|)
          ((|documentation| . " Hashing function.
")
            (|default| . 1)
            (|symeNameCode| . 746853960)
            (|symeTypeCode| . 286270707)))
        (|Declare|
          |case|
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " for 'select' statements;
")
            (|default| . 1)
            (|symeNameCode| . 864625472)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          %%
          |BasicType|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 866929616)))
        (|Declare|
          %%
          |Monoid|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 656786807)))
        (|Declare|
          |zero?|
          (|Apply| -> % |Boolean|)
          ((|documentation| . " Test whether value equals 0.
")
            (|default| . 1)
            (|symeNameCode| . 206475020)
            (|symeTypeCode| . 884043277)))
        (|Declare|
          %%
          |AbelianMonoid|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 744293378)))
        (|Declare|
          %%
          |AbelianGroup|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 269400384)))
        (|Declare|
          %%
          |Ring|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 118610639))))))
  (|Declare|
    |AbelianGroup|
    (|Define|
      (|Declare| (|Label| |AbelianGroup| ()) |Category|)
      (|With|
        |AbelianMonoid|
        (|Sequence|
          (|Declare|
            -
            (|Apply| -> % %)
            ((|documentation| . " Negation.
")
              (|symeNameCode| . 200086)
              (|symeTypeCode| . 143998972)))
          (|Declare|
            -
            (|Apply| -> (|Comma| % %) %)
            ((|documentation| . " Subtraction.
")
              (|default| . 1)
              (|symeNameCode| . 200086)
              (|symeTypeCode| . 355597834)))
          (|Default|
            (|Define|
              (|Declare|
                -
                (|Apply|
                  ->
                  (|Comma|
                    (|Declare|
                      |a|
                      %
                      ((|symeNameCode| . 200138) (|symeTypeCode| . 1015195433)))
                    (|Declare|
                      |b|
                      %
                      ((|symeNameCode| . 200139) (|symeTypeCode| . 1015195433))))
                  %)
                ((|documentation| . " Subtraction.
")
                  (|default| . 1)
                  (|symeNameCode| . 200086)
                  (|symeTypeCode| . 355597834)))
              (|Lambda|
                (|Comma|
                  (|Declare|
                    |a|
                    %
                    ((|symeNameCode| . 200138) (|symeTypeCode| . 1015195433)))
                  (|Declare|
                    |b|
                    %
                    ((|symeNameCode| . 200139) (|symeTypeCode| . 1015195433))))
                %
                (|Label| - (|Apply| + |a| (|Apply| - |b|)))))))))
    ((|documentation| .
        " `AbelianGroup' provides additive arithmetic with subtraction.

 Author: AXIOM-XL library
 Date Created: 1992-94
 Keywords: arithmetic, subtraction
")
      (|symeNameCode| . 328146853)
      (|symeTypeCode| . 783577833)
      (|catExports|
        (|Declare|
          =
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Equality test.
")
            (|symeNameCode| . 200102)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          ~=
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Inequality test.
")
            (|default| . 1)
            (|symeNameCode| . 51509389)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          <<
          (|Apply| -> (|Comma| |TextWriter| %) |TextWriter|)
          ((|documentation| . " Basic output.
")
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 561215334)))
        (|Declare|
          <<
          (|Apply| -> % (|Apply| -> |TextWriter| |TextWriter|))
          ((|documentation| . " Basic output.
")
            (|default| . 1)
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 112505899)))
        (|Declare|
          |sample|
          %
          ((|documentation| . " Example element.
")
            (|default| . 1)
            (|symeNameCode| . 255806968)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          |hash|
          (|Apply| -> % |SingleInteger|)
          ((|documentation| . " Hashing function.
")
            (|default| . 1)
            (|symeNameCode| . 746853960)
            (|symeTypeCode| . 286270707)))
        (|Declare|
          |case|
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " for 'select' statements;
")
            (|default| . 1)
            (|symeNameCode| . 864625472)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          %%
          |BasicType|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 866929616)))
        (|Declare|
          \0
          %
          ((|documentation| . " Identity for addition.
")
            (|symeNameCode| . 200089)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          +
          (|Apply| -> % %)
          ((|documentation| . " Identity function.
")
            (|default| . 1)
            (|symeNameCode| . 200084)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          +
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Addition.
")
            (|symeNameCode| . 200084)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          |zero?|
          (|Apply| -> % |Boolean|)
          ((|documentation| . " Test whether value equals 0.
")
            (|default| . 1)
            (|symeNameCode| . 206475020)
            (|symeTypeCode| . 884043277)))
        (|Declare|
          %%
          |AbelianMonoid|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 744293378)))
        (|Declare|
          -
          (|Apply| -> % %)
          ((|documentation| . " Negation.
")
            (|symeNameCode| . 200086)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          -
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Subtraction.
")
            (|default| . 1)
            (|symeNameCode| . 200086)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          %%
          |AbelianGroup|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 269400384))))))
  (|Declare|
    |AbelianMonoid|
    (|Define|
      (|Declare| (|Label| |AbelianMonoid| ()) |Category|)
      (|With|
        |BasicType|
        (|Sequence|
          (|Declare|
            \0
            %
            ((|documentation| . " Identity for addition.
")
              (|symeNameCode| . 200089)
              (|symeTypeCode| . 1015195433)))
          (|Declare|
            +
            (|Apply| -> % %)
            ((|documentation| . " Identity function.
")
              (|default| . 1)
              (|symeNameCode| . 200084)
              (|symeTypeCode| . 143998972)))
          (|Declare|
            +
            (|Apply| -> (|Comma| % %) %)
            ((|documentation| . " Addition.
")
              (|symeNameCode| . 200084)
              (|symeTypeCode| . 355597834)))
          (|Declare|
            |zero?|
            (|Apply| -> % |Boolean|)
            ((|documentation| . " Test whether value equals 0.
")
              (|default| . 1)
              (|symeNameCode| . 206475020)
              (|symeTypeCode| . 884043277)))
          (|Default|
            (|Define|
              (|Declare|
                +
                (|Apply|
                  ->
                  (|Declare|
                    |x|
                    %
                    ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
                  %)
                ((|documentation| . " Identity function.
")
                  (|default| . 1)
                  (|symeNameCode| . 200084)
                  (|symeTypeCode| . 143998972)))
              (|Lambda|
                (|Comma|
                  (|Declare|
                    |x|
                    %
                    ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433))))
                %
                (|Label| + |x|))))
          (|Default|
            (|Define|
              (|Declare|
                |zero?|
                (|Apply|
                  ->
                  (|Declare|
                    |x|
                    %
                    ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
                  |Boolean|)
                ((|documentation| . " Test whether value equals 0.
")
                  (|default| . 1)
                  (|symeNameCode| . 206475020)
                  (|symeTypeCode| . 884043277)))
              (|Lambda|
                (|Comma|
                  (|Declare|
                    |x|
                    %
                    ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433))))
                |Boolean|
                (|Label| |zero?| (|Apply| = |x| \0)))))
          (|Default|
            (|Define|
              (|Declare|
                |sample|
                %
                ((|default| . 1)
                  (|symeNameCode| . 255806968)
                  (|symeTypeCode| . 1015195433)))
              \0)))))
    ((|documentation| .
        " `AbelianMonoid' provides additive arithmetic.

 Author: AXIOM-XL library
 Date Created: 1992-94
 Keywords: arithmetic, addition
")
      (|symeNameCode| . 803039847)
      (|symeTypeCode| . 362738191)
      (|catExports|
        (|Declare|
          =
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Equality test.
")
            (|symeNameCode| . 200102)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          ~=
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Inequality test.
")
            (|default| . 1)
            (|symeNameCode| . 51509389)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          <<
          (|Apply| -> (|Comma| |TextWriter| %) |TextWriter|)
          ((|documentation| . " Basic output.
")
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 561215334)))
        (|Declare|
          <<
          (|Apply| -> % (|Apply| -> |TextWriter| |TextWriter|))
          ((|documentation| . " Basic output.
")
            (|default| . 1)
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 112505899)))
        (|Declare|
          |sample|
          %
          ((|documentation| . " Example element.
")
            (|default| . 1)
            (|symeNameCode| . 255806968)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          |hash|
          (|Apply| -> % |SingleInteger|)
          ((|documentation| . " Hashing function.
")
            (|default| . 1)
            (|symeNameCode| . 746853960)
            (|symeTypeCode| . 286270707)))
        (|Declare|
          |case|
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " for 'select' statements;
")
            (|default| . 1)
            (|symeNameCode| . 864625472)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          %%
          |BasicType|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 866929616)))
        (|Declare|
          \0
          %
          ((|documentation| . " Identity for addition.
")
            (|symeNameCode| . 200089)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          +
          (|Apply| -> % %)
          ((|documentation| . " Identity function.
")
            (|default| . 1)
            (|symeNameCode| . 200084)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          +
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Addition.
")
            (|symeNameCode| . 200084)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          |zero?|
          (|Apply| -> % |Boolean|)
          ((|documentation| . " Test whether value equals 0.
")
            (|default| . 1)
            (|symeNameCode| . 206475020)
            (|symeTypeCode| . 884043277)))
        (|Declare|
          %%
          |AbelianMonoid|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 744293378))))))
  (|Declare|
    |Group|
    (|Define|
      (|Declare| (|Label| |Group| ()) |Category|)
      (|With|
        |Monoid|
        (|Sequence|
          (|Declare|
            /
            (|Apply| -> (|Comma| % %) %)
            ((|documentation| . " Division: a/b = a*inv(b).
")
              (|default| . 1)
              (|symeNameCode| . 200088)
              (|symeTypeCode| . 355597834)))
          (|Declare|
            |\\|
            (|Apply| -> (|Comma| % %) %)
            ((|documentation| . " Division: a\\b = inv(a)*b
")
              (|default| . 1)
              (|symeNameCode| . 200133)
              (|symeTypeCode| . 355597834)))
          (|Declare|
            |inv|
            (|Apply| -> % %)
            ((|documentation| . " Inverse.
")
              (|symeNameCode| . 318722696)
              (|symeTypeCode| . 143998972)))
          (|Default|
            (|Define|
              (|Declare|
                /
                (|Apply|
                  ->
                  (|Comma|
                    (|Declare|
                      |a|
                      %
                      ((|symeNameCode| . 200138) (|symeTypeCode| . 1015195433)))
                    (|Declare|
                      |b|
                      %
                      ((|symeNameCode| . 200139) (|symeTypeCode| . 1015195433))))
                  %)
                ((|documentation| . " Division: a/b = a*inv(b).
")
                  (|default| . 1)
                  (|symeNameCode| . 200088)
                  (|symeTypeCode| . 355597834)))
              (|Lambda|
                (|Comma|
                  (|Declare|
                    |a|
                    %
                    ((|symeNameCode| . 200138) (|symeTypeCode| . 1015195433)))
                  (|Declare|
                    |b|
                    %
                    ((|symeNameCode| . 200139) (|symeTypeCode| . 1015195433))))
                %
                (|Label| / (|Apply| * |a| (|Apply| |inv| |b|))))))
          (|Default|
            (|Define|
              (|Declare|
                |\\|
                (|Apply|
                  ->
                  (|Comma|
                    (|Declare|
                      |a|
                      %
                      ((|symeNameCode| . 200138) (|symeTypeCode| . 1015195433)))
                    (|Declare|
                      |b|
                      %
                      ((|symeNameCode| . 200139) (|symeTypeCode| . 1015195433))))
                  %)
                ((|documentation| . " Division: a\\b = inv(a)*b
")
                  (|default| . 1)
                  (|symeNameCode| . 200133)
                  (|symeTypeCode| . 355597834)))
              (|Lambda|
                (|Comma|
                  (|Declare|
                    |a|
                    %
                    ((|symeNameCode| . 200138) (|symeTypeCode| . 1015195433)))
                  (|Declare|
                    |b|
                    %
                    ((|symeNameCode| . 200139) (|symeTypeCode| . 1015195433))))
                %
                (|Label| |\\| (|Apply| * (|Apply| |inv| |a|) |b|))))))))
    ((|documentation| .
        " `Group' provides multiplicative arithmetic with division.

 Author: AXIOM-XL library
 Date Created: 1992-94
 Keywords: arithmetic, group operations, multiplication, division
")
      (|symeNameCode| . 430999578)
      (|symeTypeCode| . 470995319)
      (|catExports|
        (|Declare|
          =
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Equality test.
")
            (|symeNameCode| . 200102)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          ~=
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Inequality test.
")
            (|default| . 1)
            (|symeNameCode| . 51509389)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          <<
          (|Apply| -> (|Comma| |TextWriter| %) |TextWriter|)
          ((|documentation| . " Basic output.
")
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 561215334)))
        (|Declare|
          <<
          (|Apply| -> % (|Apply| -> |TextWriter| |TextWriter|))
          ((|documentation| . " Basic output.
")
            (|default| . 1)
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 112505899)))
        (|Declare|
          |sample|
          %
          ((|documentation| . " Example element.
")
            (|symeNameCode| . 255806968)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          |hash|
          (|Apply| -> % |SingleInteger|)
          ((|documentation| . " Hashing function.
")
            (|default| . 1)
            (|symeNameCode| . 746853960)
            (|symeTypeCode| . 286270707)))
        (|Declare|
          |case|
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " for 'select' statements;
")
            (|default| . 1)
            (|symeNameCode| . 864625472)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          %%
          |BasicType|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 866929616)))
        (|Declare|
          \1
          %
          ((|documentation| . " Identity for multiplication.
")
            (|symeNameCode| . 200090)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          *
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Multiplication.
")
            (|symeNameCode| . 200083)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          ^
          (|Apply| -> (|Comma| % |Integer|) %)
          ((|documentation| . " Exponentiation or error
")
            (|symeNameCode| . 200135)
            (|symeTypeCode| . 455750953)))
        (|Declare|
          %%
          |Monoid|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 656786807)))
        (|Declare|
          /
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Division: a/b = a*inv(b).
")
            (|default| . 1)
            (|symeNameCode| . 200088)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          |\\|
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Division: a\\b = inv(a)*b
")
            (|default| . 1)
            (|symeNameCode| . 200133)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          |inv|
          (|Apply| -> % %)
          ((|documentation| . " Inverse.
")
            (|symeNameCode| . 318722696)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          %%
          |Group|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 372253109))))))
  (|Declare|
    |Monoid|
    (|Define|
      (|Declare| (|Label| |Monoid| ()) |Category|)
      (|With|
        |BasicType|
        (|Sequence|
          (|Declare|
            \1
            %
            ((|documentation| . " Identity for multiplication.
")
              (|symeNameCode| . 200090)
              (|symeTypeCode| . 1015195433)))
          (|Declare|
            *
            (|Apply| -> (|Comma| % %) %)
            ((|documentation| . " Multiplication.
")
              (|symeNameCode| . 200083)
              (|symeTypeCode| . 355597834)))
          (|Declare|
            ^
            (|Apply| -> (|Comma| % |Integer|) %)
            ((|documentation| . " Exponentiation or error
")
              (|symeNameCode| . 200135)
              (|symeTypeCode| . 455750953))))))
    ((|documentation| .
        " `Monoid' provides multiplicative arithmetic.

 Author: AXIOM-XL library
 Date Created: 1992-94
 Keywords: arithmetic, multiplication
")
      (|symeNameCode| . 715533276)
      (|symeTypeCode| . 802543469)
      (|catExports|
        (|Declare|
          =
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Equality test.
")
            (|symeNameCode| . 200102)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          ~=
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Inequality test.
")
            (|default| . 1)
            (|symeNameCode| . 51509389)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          <<
          (|Apply| -> (|Comma| |TextWriter| %) |TextWriter|)
          ((|documentation| . " Basic output.
")
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 561215334)))
        (|Declare|
          <<
          (|Apply| -> % (|Apply| -> |TextWriter| |TextWriter|))
          ((|documentation| . " Basic output.
")
            (|default| . 1)
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 112505899)))
        (|Declare|
          |sample|
          %
          ((|documentation| . " Example element.
")
            (|symeNameCode| . 255806968)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          |hash|
          (|Apply| -> % |SingleInteger|)
          ((|documentation| . " Hashing function.
")
            (|default| . 1)
            (|symeNameCode| . 746853960)
            (|symeTypeCode| . 286270707)))
        (|Declare|
          |case|
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " for 'select' statements;
")
            (|default| . 1)
            (|symeNameCode| . 864625472)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          %%
          |BasicType|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 866929616)))
        (|Declare|
          \1
          %
          ((|documentation| . " Identity for multiplication.
")
            (|symeNameCode| . 200090)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          *
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Multiplication.
")
            (|symeNameCode| . 200083)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          ^
          (|Apply| -> (|Comma| % |Integer|) %)
          ((|documentation| . " Exponentiation or error
")
            (|symeNameCode| . 200135)
            (|symeTypeCode| . 455750953)))
        (|Declare|
          %%
          |Monoid|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 656786807))))))
  (|Declare|
    |ArithmeticSystem|
    (|Define|
      (|Declare| (|Label| |ArithmeticSystem| ()) |Category|)
      (|With|
        ()
        (|Sequence|
          (|Declare|
            \0
            %
            ((|documentation| . " Identity for `+'
")
              (|symeNameCode| . 200089)
              (|symeTypeCode| . 1015195433)))
          (|Declare|
            +
            (|Apply| -> % %)
            ((|documentation| . " Identity.
")
              (|symeNameCode| . 200084)
              (|symeTypeCode| . 143998972)))
          (|Declare|
            +
            (|Apply| -> (|Comma| % %) %)
            ((|documentation| . " Addition.
")
              (|symeNameCode| . 200084)
              (|symeTypeCode| . 355597834)))
          (|Declare|
            -
            (|Apply| -> % %)
            ((|documentation| . " Negation.
")
              (|symeNameCode| . 200086)
              (|symeTypeCode| . 143998972)))
          (|Declare|
            -
            (|Apply| -> (|Comma| % %) %)
            ((|documentation| . " Subtraction.
")
              (|symeNameCode| . 200086)
              (|symeTypeCode| . 355597834)))
          (|Declare|
            \1
            %
            ((|documentation| . " Identity for `*'
")
              (|symeNameCode| . 200090)
              (|symeTypeCode| . 1015195433)))
          (|Declare|
            *
            (|Apply| -> (|Comma| % %) %)
            ((|documentation| . " Multiplication
")
              (|symeNameCode| . 200083)
              (|symeTypeCode| . 355597834)))
          (|Declare|
            ^
            (|Apply| -> (|Comma| % |Integer|) %)
            ((|documentation| . " Exponentiation or error
")
              (|symeNameCode| . 200135)
              (|symeTypeCode| . 455750953)))
          (|Declare|
            |coerce|
            (|Apply| -> |Integer| %)
            ((|symeNameCode| . 770345191) (|symeTypeCode| . 363839259)))
          (|Declare|
            |coerce|
            (|Apply| -> |SingleInteger| %)
            ((|symeNameCode| . 770345191) (|symeTypeCode| . 352135667))))))
    ((|documentation| .
        " `ArithmeticSystem' provides the basic aritmetic operations,
 without implying associativity, commutativity, etc.
")
      (|symeNameCode| . 355931679)
      (|symeTypeCode| . 788317889)
      (|catExports|
        (|Declare|
          \0
          %
          ((|documentation| . " Identity for `+'
")
            (|symeNameCode| . 200089)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          +
          (|Apply| -> % %)
          ((|documentation| . " Identity.
")
            (|symeNameCode| . 200084)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          +
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Addition.
")
            (|symeNameCode| . 200084)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          -
          (|Apply| -> % %)
          ((|documentation| . " Negation.
")
            (|symeNameCode| . 200086)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          -
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Subtraction.
")
            (|symeNameCode| . 200086)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          \1
          %
          ((|documentation| . " Identity for `*'
")
            (|symeNameCode| . 200090)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          *
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Multiplication
")
            (|symeNameCode| . 200083)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          ^
          (|Apply| -> (|Comma| % |Integer|) %)
          ((|documentation| . " Exponentiation or error
")
            (|symeNameCode| . 200135)
            (|symeTypeCode| . 455750953)))
        (|Declare|
          |coerce|
          (|Apply| -> |Integer| %)
          ((|symeNameCode| . 770345191) (|symeTypeCode| . 363839259)))
        (|Declare|
          |coerce|
          (|Apply| -> |SingleInteger| %)
          ((|symeNameCode| . 770345191) (|symeTypeCode| . 352135667)))
        (|Declare|
          %%
          |ArithmeticSystem|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 297185210))))))
  (|Declare|
    |OrderedFinite|
    (|Define|
      (|Declare| (|Label| |OrderedFinite| ()) |Category|)
      (|With|
        (|Apply| |Join| |Finite| |Order|)
        (|Sequence|
          (|Declare|
            |min|
            %
            ((|documentation| . " Minimum value belonging to the type.
")
              (|symeNameCode| . 318459775)
              (|symeTypeCode| . 1015195433)))
          (|Declare|
            |max|
            %
            ((|documentation| . " Maximum value belonging to the type.
")
              (|symeNameCode| . 318461825)
              (|symeTypeCode| . 1015195433))))))
    ((|documentation| .
        " `OrderedFinite' provides the minimum and maximum values for a finite type.

 Author: AXIOM-XL library
 Date Created: 1992-94
 Keywords: finite, minimum, maximum
")
      (|symeNameCode| . 53490041)
      (|symeTypeCode| . 544701037)
      (|catExports|
        (|Declare|
          =
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Equality test.
")
            (|symeNameCode| . 200102)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          ~=
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Inequality test.
")
            (|default| . 1)
            (|symeNameCode| . 51509389)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          <<
          (|Apply| -> (|Comma| |TextWriter| %) |TextWriter|)
          ((|documentation| . " Basic output.
")
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 561215334)))
        (|Declare|
          <<
          (|Apply| -> % (|Apply| -> |TextWriter| |TextWriter|))
          ((|documentation| . " Basic output.
")
            (|default| . 1)
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 112505899)))
        (|Declare|
          |sample|
          %
          ((|documentation| . " Example element.
")
            (|symeNameCode| . 255806968)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          |hash|
          (|Apply| -> % |SingleInteger|)
          ((|documentation| . " Hashing function.
")
            (|default| . 1)
            (|symeNameCode| . 746853960)
            (|symeTypeCode| . 286270707)))
        (|Declare|
          |case|
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " for 'select' statements;
")
            (|default| . 1)
            (|symeNameCode| . 864625472)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          %%
          |BasicType|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 866929616)))
        (|Declare|
          |#|
          |Integer|
          ((|documentation| . " Number of values in the type.
")
            (|symeNameCode| . 200076)
            (|symeTypeCode| . 425461576)))
        (|Declare|
          %%
          |Finite|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 50729328)))
        (|Declare|
          >
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Greater than test.
")
            (|symeNameCode| . 200103)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          <
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Less than test.
")
            (|default| . 1)
            (|symeNameCode| . 200101)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          >=
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Greater than or equal test.
")
            (|default| . 1)
            (|symeNameCode| . 51492941)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          <=
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Less than or equal test.
")
            (|default| . 1)
            (|symeNameCode| . 51492427)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          |max|
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Maximum argument.
")
            (|default| . 1)
            (|symeNameCode| . 318461825)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          |min|
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Minimum argument.
")
            (|default| . 1)
            (|symeNameCode| . 318459775)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          >
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |x|
                %
                ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 200103)
            (|symeTypeCode| . 134984876)))
        (|Declare|
          <
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |x|
                %
                ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 200101)
            (|symeTypeCode| . 134984876)))
        (|Declare|
          >=
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |x|
                %
                ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 51492941)
            (|symeTypeCode| . 134984876)))
        (|Declare|
          <=
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |x|
                %
                ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 51492427)
            (|symeTypeCode| . 134984876)))
        (|Declare|
          >
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 200103)
            (|symeTypeCode| . 305073998)))
        (|Declare|
          <
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 200101)
            (|symeTypeCode| . 305073998)))
        (|Declare|
          >=
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 51492941)
            (|symeTypeCode| . 305073998)))
        (|Declare|
          <=
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 51492427)
            (|symeTypeCode| . 305073998)))
        (|Declare|
          >
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            |Boolean|)
          ((|default| . 1)
            (|symeNameCode| . 200103)
            (|symeTypeCode| . 191989437)))
        (|Declare|
          <
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            |Boolean|)
          ((|default| . 1)
            (|symeNameCode| . 200101)
            (|symeTypeCode| . 191989437)))
        (|Declare|
          >=
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            |Boolean|)
          ((|default| . 1)
            (|symeNameCode| . 51492941)
            (|symeTypeCode| . 191989437)))
        (|Declare|
          <=
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            |Boolean|)
          ((|default| . 1)
            (|symeNameCode| . 51492427)
            (|symeTypeCode| . 191989437)))
        (|Declare|
          %%
          |Order|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 105187748)))
        (|Declare|
          |min|
          %
          ((|documentation| . " Minimum value belonging to the type.
")
            (|symeNameCode| . 318459775)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          |max|
          %
          ((|documentation| . " Maximum value belonging to the type.
")
            (|symeNameCode| . 318461825)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          %%
          |OrderedFinite|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 1068485396))))))
  (|Declare|
    |Order|
    (|Define|
      (|Declare| (|Label| |Order| ()) |Category|)
      (|With|
        |BasicType|
        (|Sequence|
          (|Declare|
            >
            (|Apply| -> (|Comma| % %) |Boolean|)
            ((|documentation| . " Greater than test.
")
              (|symeNameCode| . 200103)
              (|symeTypeCode| . 21900315)))
          (|Declare|
            <
            (|Apply| -> (|Comma| % %) |Boolean|)
            ((|documentation| . " Less than test.
")
              (|default| . 1)
              (|symeNameCode| . 200101)
              (|symeTypeCode| . 21900315)))
          (|Declare|
            >=
            (|Apply| -> (|Comma| % %) |Boolean|)
            ((|documentation| . " Greater than or equal test.
")
              (|default| . 1)
              (|symeNameCode| . 51492941)
              (|symeTypeCode| . 21900315)))
          (|Declare|
            <=
            (|Apply| -> (|Comma| % %) |Boolean|)
            ((|documentation| . " Less than or equal test.
")
              (|default| . 1)
              (|symeNameCode| . 51492427)
              (|symeTypeCode| . 21900315)))
          (|Declare|
            |max|
            (|Apply| -> (|Comma| % %) %)
            ((|documentation| . " Maximum argument.
")
              (|default| . 1)
              (|symeNameCode| . 318461825)
              (|symeTypeCode| . 355597834)))
          (|Declare|
            |min|
            (|Apply| -> (|Comma| % %) %)
            ((|documentation| . " Minimum argument.
")
              (|default| . 1)
              (|symeNameCode| . 318459775)
              (|symeTypeCode| . 355597834)))
          (|Default|
            (|Sequence|
              (|Define|
                (|Declare|
                  <
                  (|Apply|
                    ->
                    (|Comma|
                      (|Declare|
                        |x|
                        %
                        ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
                      (|Declare|
                        |y|
                        %
                        ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
                    |Boolean|)
                  ((|documentation| . " Less than test.
")
                    (|default| . 1)
                    (|symeNameCode| . 200101)
                    (|symeTypeCode| . 21900315)))
                (|Lambda|
                  (|Comma|
                    (|Declare|
                      |x|
                      %
                      ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
                    (|Declare|
                      |y|
                      %
                      ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
                  |Boolean|
                  (|Label| < (|Apply| > |y| |x|))))
              (|Define|
                (|Declare|
                  >=
                  (|Apply|
                    ->
                    (|Comma|
                      (|Declare|
                        |x|
                        %
                        ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
                      (|Declare|
                        |y|
                        %
                        ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
                    |Boolean|)
                  ((|documentation| . " Greater than or equal test.
")
                    (|default| . 1)
                    (|symeNameCode| . 51492941)
                    (|symeTypeCode| . 21900315)))
                (|Lambda|
                  (|Comma|
                    (|Declare|
                      |x|
                      %
                      ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
                    (|Declare|
                      |y|
                      %
                      ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
                  |Boolean|
                  (|Label| >= (|Not| (|Test| (|Apply| < |x| |y|))))))
              (|Define|
                (|Declare|
                  <=
                  (|Apply|
                    ->
                    (|Comma|
                      (|Declare|
                        |x|
                        %
                        ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
                      (|Declare|
                        |y|
                        %
                        ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
                    |Boolean|)
                  ((|documentation| . " Less than or equal test.
")
                    (|default| . 1)
                    (|symeNameCode| . 51492427)
                    (|symeTypeCode| . 21900315)))
                (|Lambda|
                  (|Comma|
                    (|Declare|
                      |x|
                      %
                      ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
                    (|Declare|
                      |y|
                      %
                      ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
                  |Boolean|
                  (|Label| <= (|Not| (|Test| (|Apply| > |x| |y|))))))
              (|Define|
                (|Declare|
                  |max|
                  (|Apply|
                    ->
                    (|Comma|
                      (|Declare|
                        |x|
                        %
                        ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
                      (|Declare|
                        |y|
                        %
                        ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
                    %)
                  ((|documentation| . " Maximum argument.
")
                    (|default| . 1)
                    (|symeNameCode| . 318461825)
                    (|symeTypeCode| . 355597834)))
                (|Lambda|
                  (|Comma|
                    (|Declare|
                      |x|
                      %
                      ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
                    (|Declare|
                      |y|
                      %
                      ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
                  %
                  (|Label| |max| (|If| (|Test| (|Apply| > |x| |y|)) |x| |y|))))
              (|Define|
                (|Declare|
                  |min|
                  (|Apply|
                    ->
                    (|Comma|
                      (|Declare|
                        |x|
                        %
                        ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
                      (|Declare|
                        |y|
                        %
                        ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
                    %)
                  ((|documentation| . " Minimum argument.
")
                    (|default| . 1)
                    (|symeNameCode| . 318459775)
                    (|symeTypeCode| . 355597834)))
                (|Lambda|
                  (|Comma|
                    (|Declare|
                      |x|
                      %
                      ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
                    (|Declare|
                      |y|
                      %
                      ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
                  %
                  (|Label| |min| (|If| (|Test| (|Apply| < |x| |y|)) |x| |y|))))))
          (|Default|
            (|Sequence|
              ()
              (|Define|
                (|Declare|
                  >
                  (|Apply|
                    ->
                    (|Comma|
                      (|Declare|
                        |x|
                        %
                        ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
                      (|Declare|
                        |y|
                        %
                        ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
                    (|Apply| |Cross| |Boolean| %))
                  ((|default| . 1)
                    (|symeNameCode| . 200103)
                    (|symeTypeCode| . 134984876)))
                (|Lambda|
                  (|Comma|
                    (|Declare|
                      |x|
                      %
                      ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
                    (|Declare|
                      |y|
                      %
                      ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
                  (|Apply| |Cross| |Boolean| %)
                  (|Label| > (|Comma| (|Apply| > |x| |y|) |y|))))
              (|Define|
                (|Declare|
                  <
                  (|Apply|
                    ->
                    (|Comma|
                      (|Declare|
                        |x|
                        %
                        ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
                      (|Declare|
                        |y|
                        %
                        ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
                    (|Apply| |Cross| |Boolean| %))
                  ((|default| . 1)
                    (|symeNameCode| . 200101)
                    (|symeTypeCode| . 134984876)))
                (|Lambda|
                  (|Comma|
                    (|Declare|
                      |x|
                      %
                      ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
                    (|Declare|
                      |y|
                      %
                      ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
                  (|Apply| |Cross| |Boolean| %)
                  (|Label| < (|Comma| (|Apply| < |x| |y|) |y|))))
              (|Define|
                (|Declare|
                  >=
                  (|Apply|
                    ->
                    (|Comma|
                      (|Declare|
                        |x|
                        %
                        ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
                      (|Declare|
                        |y|
                        %
                        ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
                    (|Apply| |Cross| |Boolean| %))
                  ((|default| . 1)
                    (|symeNameCode| . 51492941)
                    (|symeTypeCode| . 134984876)))
                (|Lambda|
                  (|Comma|
                    (|Declare|
                      |x|
                      %
                      ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
                    (|Declare|
                      |y|
                      %
                      ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
                  (|Apply| |Cross| |Boolean| %)
                  (|Label| >= (|Comma| (|Apply| >= |x| |y|) |y|))))
              (|Define|
                (|Declare|
                  <=
                  (|Apply|
                    ->
                    (|Comma|
                      (|Declare|
                        |x|
                        %
                        ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
                      (|Declare|
                        |y|
                        %
                        ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
                    (|Apply| |Cross| |Boolean| %))
                  ((|default| . 1)
                    (|symeNameCode| . 51492427)
                    (|symeTypeCode| . 134984876)))
                (|Lambda|
                  (|Comma|
                    (|Declare|
                      |x|
                      %
                      ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
                    (|Declare|
                      |y|
                      %
                      ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
                  (|Apply| |Cross| |Boolean| %)
                  (|Label| <= (|Comma| (|Apply| <= |x| |y|) |y|))))
              (|Define|
                (|Declare|
                  >
                  (|Apply|
                    ->
                    (|Comma|
                      (|Declare|
                        |bx|
                        (|Apply| |Cross| |Boolean| %)
                        ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
                      (|Declare|
                        |y|
                        %
                        ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
                    (|Apply| |Cross| |Boolean| %))
                  ((|default| . 1)
                    (|symeNameCode| . 200103)
                    (|symeTypeCode| . 305073998)))
                (|Lambda|
                  (|Comma|
                    (|Declare|
                      |bx|
                      (|Apply| |Cross| |Boolean| %)
                      ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
                    (|Declare|
                      |y|
                      %
                      ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
                  (|Apply| |Cross| |Boolean| %)
                  (|Label|
                    >
                    (|Sequence|
                      (|Assign| (|Comma| |b| |x|) |bx|)
                      (|Comma| (|And| (|Test| |b|) (|Test| (|Apply| > |x| |y|))) |y|)))))
              (|Define|
                (|Declare|
                  <
                  (|Apply|
                    ->
                    (|Comma|
                      (|Declare|
                        |bx|
                        (|Apply| |Cross| |Boolean| %)
                        ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
                      (|Declare|
                        |y|
                        %
                        ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
                    (|Apply| |Cross| |Boolean| %))
                  ((|default| . 1)
                    (|symeNameCode| . 200101)
                    (|symeTypeCode| . 305073998)))
                (|Lambda|
                  (|Comma|
                    (|Declare|
                      |bx|
                      (|Apply| |Cross| |Boolean| %)
                      ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
                    (|Declare|
                      |y|
                      %
                      ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
                  (|Apply| |Cross| |Boolean| %)
                  (|Label|
                    <
                    (|Sequence|
                      (|Assign| (|Comma| |b| |x|) |bx|)
                      (|Comma| (|And| (|Test| |b|) (|Test| (|Apply| < |x| |y|))) |y|)))))
              (|Define|
                (|Declare|
                  >=
                  (|Apply|
                    ->
                    (|Comma|
                      (|Declare|
                        |bx|
                        (|Apply| |Cross| |Boolean| %)
                        ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
                      (|Declare|
                        |y|
                        %
                        ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
                    (|Apply| |Cross| |Boolean| %))
                  ((|default| . 1)
                    (|symeNameCode| . 51492941)
                    (|symeTypeCode| . 305073998)))
                (|Lambda|
                  (|Comma|
                    (|Declare|
                      |bx|
                      (|Apply| |Cross| |Boolean| %)
                      ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
                    (|Declare|
                      |y|
                      %
                      ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
                  (|Apply| |Cross| |Boolean| %)
                  (|Label|
                    >=
                    (|Sequence|
                      (|Assign| (|Comma| |b| |x|) |bx|)
                      (|Comma| (|And| (|Test| |b|) (|Test| (|Apply| >= |x| |y|))) |y|)))))
              (|Define|
                (|Declare|
                  <=
                  (|Apply|
                    ->
                    (|Comma|
                      (|Declare|
                        |bx|
                        (|Apply| |Cross| |Boolean| %)
                        ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
                      (|Declare|
                        |y|
                        %
                        ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
                    (|Apply| |Cross| |Boolean| %))
                  ((|default| . 1)
                    (|symeNameCode| . 51492427)
                    (|symeTypeCode| . 305073998)))
                (|Lambda|
                  (|Comma|
                    (|Declare|
                      |bx|
                      (|Apply| |Cross| |Boolean| %)
                      ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
                    (|Declare|
                      |y|
                      %
                      ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
                  (|Apply| |Cross| |Boolean| %)
                  (|Label|
                    <=
                    (|Sequence|
                      (|Assign| (|Comma| |b| |x|) |bx|)
                      (|Comma| (|And| (|Test| |b|) (|Test| (|Apply| <= |x| |y|))) |y|)))))
              (|Define|
                (|Declare|
                  >
                  (|Apply|
                    ->
                    (|Comma|
                      (|Declare|
                        |bx|
                        (|Apply| |Cross| |Boolean| %)
                        ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
                      (|Declare|
                        |y|
                        %
                        ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
                    |Boolean|)
                  ((|default| . 1)
                    (|symeNameCode| . 200103)
                    (|symeTypeCode| . 191989437)))
                (|Lambda|
                  (|Comma|
                    (|Declare|
                      |bx|
                      (|Apply| |Cross| |Boolean| %)
                      ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
                    (|Declare|
                      |y|
                      %
                      ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
                  |Boolean|
                  (|Label|
                    >
                    (|Sequence|
                      (|Assign| (|Comma| |b| |x|) |bx|)
                      (|And| (|Test| |b|) (|Test| (|Apply| > |x| |y|)))))))
              (|Define|
                (|Declare|
                  <
                  (|Apply|
                    ->
                    (|Comma|
                      (|Declare|
                        |bx|
                        (|Apply| |Cross| |Boolean| %)
                        ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
                      (|Declare|
                        |y|
                        %
                        ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
                    |Boolean|)
                  ((|default| . 1)
                    (|symeNameCode| . 200101)
                    (|symeTypeCode| . 191989437)))
                (|Lambda|
                  (|Comma|
                    (|Declare|
                      |bx|
                      (|Apply| |Cross| |Boolean| %)
                      ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
                    (|Declare|
                      |y|
                      %
                      ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
                  |Boolean|
                  (|Label|
                    <
                    (|Sequence|
                      (|Assign| (|Comma| |b| |x|) |bx|)
                      (|And| (|Test| |b|) (|Test| (|Apply| < |x| |y|)))))))
              (|Define|
                (|Declare|
                  >=
                  (|Apply|
                    ->
                    (|Comma|
                      (|Declare|
                        |bx|
                        (|Apply| |Cross| |Boolean| %)
                        ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
                      (|Declare|
                        |y|
                        %
                        ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
                    |Boolean|)
                  ((|default| . 1)
                    (|symeNameCode| . 51492941)
                    (|symeTypeCode| . 191989437)))
                (|Lambda|
                  (|Comma|
                    (|Declare|
                      |bx|
                      (|Apply| |Cross| |Boolean| %)
                      ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
                    (|Declare|
                      |y|
                      %
                      ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
                  |Boolean|
                  (|Label|
                    >=
                    (|Sequence|
                      (|Assign| (|Comma| |b| |x|) |bx|)
                      (|And| (|Test| |b|) (|Test| (|Apply| >= |x| |y|)))))))
              (|Define|
                (|Declare|
                  <=
                  (|Apply|
                    ->
                    (|Comma|
                      (|Declare|
                        |bx|
                        (|Apply| |Cross| |Boolean| %)
                        ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
                      (|Declare|
                        |y|
                        %
                        ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
                    |Boolean|)
                  ((|default| . 1)
                    (|symeNameCode| . 51492427)
                    (|symeTypeCode| . 191989437)))
                (|Lambda|
                  (|Comma|
                    (|Declare|
                      |bx|
                      (|Apply| |Cross| |Boolean| %)
                      ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
                    (|Declare|
                      |y|
                      %
                      ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
                  |Boolean|
                  (|Label|
                    <=
                    (|Sequence|
                      (|Assign| (|Comma| |b| |x|) |bx|)
                      (|And| (|Test| |b|) (|Test| (|Apply| <= |x| |y|))))))))))))
    ((|documentation| .
        " `Order' provides operations for an order relation, `>', and its dual, `<'.

 Author: AXIOM-XL library
 Date Created: 1992-94
 Keywords: inequality, order
")
      (|symeNameCode| . 163934217)
      (|symeTypeCode| . 199250649)
      (|catExports|
        (|Declare|
          =
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Equality test.
")
            (|symeNameCode| . 200102)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          ~=
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Inequality test.
")
            (|default| . 1)
            (|symeNameCode| . 51509389)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          <<
          (|Apply| -> (|Comma| |TextWriter| %) |TextWriter|)
          ((|documentation| . " Basic output.
")
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 561215334)))
        (|Declare|
          <<
          (|Apply| -> % (|Apply| -> |TextWriter| |TextWriter|))
          ((|documentation| . " Basic output.
")
            (|default| . 1)
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 112505899)))
        (|Declare|
          |sample|
          %
          ((|documentation| . " Example element.
")
            (|symeNameCode| . 255806968)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          |hash|
          (|Apply| -> % |SingleInteger|)
          ((|documentation| . " Hashing function.
")
            (|default| . 1)
            (|symeNameCode| . 746853960)
            (|symeTypeCode| . 286270707)))
        (|Declare|
          |case|
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " for 'select' statements;
")
            (|default| . 1)
            (|symeNameCode| . 864625472)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          %%
          |BasicType|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 866929616)))
        (|Declare|
          >
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Greater than test.
")
            (|symeNameCode| . 200103)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          <
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Less than test.
")
            (|default| . 1)
            (|symeNameCode| . 200101)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          >=
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Greater than or equal test.
")
            (|default| . 1)
            (|symeNameCode| . 51492941)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          <=
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Less than or equal test.
")
            (|default| . 1)
            (|symeNameCode| . 51492427)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          |max|
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Maximum argument.
")
            (|default| . 1)
            (|symeNameCode| . 318461825)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          |min|
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Minimum argument.
")
            (|default| . 1)
            (|symeNameCode| . 318459775)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          >
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |x|
                %
                ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 200103)
            (|symeTypeCode| . 134984876)))
        (|Declare|
          <
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |x|
                %
                ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 200101)
            (|symeTypeCode| . 134984876)))
        (|Declare|
          >=
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |x|
                %
                ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 51492941)
            (|symeTypeCode| . 134984876)))
        (|Declare|
          <=
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |x|
                %
                ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 51492427)
            (|symeTypeCode| . 134984876)))
        (|Declare|
          >
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 200103)
            (|symeTypeCode| . 305073998)))
        (|Declare|
          <
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 200101)
            (|symeTypeCode| . 305073998)))
        (|Declare|
          >=
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 51492941)
            (|symeTypeCode| . 305073998)))
        (|Declare|
          <=
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            (|Apply| |Cross| |Boolean| %))
          ((|default| . 1)
            (|symeNameCode| . 51492427)
            (|symeTypeCode| . 305073998)))
        (|Declare|
          >
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            |Boolean|)
          ((|default| . 1)
            (|symeNameCode| . 200103)
            (|symeTypeCode| . 191989437)))
        (|Declare|
          <
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            |Boolean|)
          ((|default| . 1)
            (|symeNameCode| . 200101)
            (|symeTypeCode| . 191989437)))
        (|Declare|
          >=
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            |Boolean|)
          ((|default| . 1)
            (|symeNameCode| . 51492941)
            (|symeTypeCode| . 191989437)))
        (|Declare|
          <=
          (|Apply|
            ->
            (|Comma|
              (|Declare|
                |bx|
                (|Apply| |Cross| |Boolean| %)
                ((|symeNameCode| . 51500204) (|symeTypeCode| . 794582475)))
              (|Declare|
                |y|
                %
                ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
            |Boolean|)
          ((|default| . 1)
            (|symeNameCode| . 51492427)
            (|symeTypeCode| . 191989437)))
        (|Declare|
          %%
          |Order|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 105187748))))))
  (|Declare|
    |Finite|
    (|Define|
      (|Declare| (|Label| |Finite| ()) |Category|)
      (|With|
        |BasicType|
        (|Declare|
          |#|
          |Integer|
          ((|documentation| . " Number of values in the type.
")
            (|symeNameCode| . 200076)
            (|symeTypeCode| . 425461576)))))
    ((|documentation| .
        " `Finite' indicates that a type has only a finite number of values.

 Author: AXIOM-XL library
 Date Created: 1992-94
 Keywords: finite, cardinality
")
      (|symeNameCode| . 109475797)
      (|symeTypeCode| . 133866201)
      (|catExports|
        (|Declare|
          =
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Equality test.
")
            (|symeNameCode| . 200102)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          ~=
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Inequality test.
")
            (|default| . 1)
            (|symeNameCode| . 51509389)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          <<
          (|Apply| -> (|Comma| |TextWriter| %) |TextWriter|)
          ((|documentation| . " Basic output.
")
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 561215334)))
        (|Declare|
          <<
          (|Apply| -> % (|Apply| -> |TextWriter| |TextWriter|))
          ((|documentation| . " Basic output.
")
            (|default| . 1)
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 112505899)))
        (|Declare|
          |sample|
          %
          ((|documentation| . " Example element.
")
            (|symeNameCode| . 255806968)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          |hash|
          (|Apply| -> % |SingleInteger|)
          ((|documentation| . " Hashing function.
")
            (|default| . 1)
            (|symeNameCode| . 746853960)
            (|symeTypeCode| . 286270707)))
        (|Declare|
          |case|
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " for 'select' statements;
")
            (|default| . 1)
            (|symeNameCode| . 864625472)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          %%
          |BasicType|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 866929616)))
        (|Declare|
          |#|
          |Integer|
          ((|documentation| . " Number of values in the type.
")
            (|symeNameCode| . 200076)
            (|symeTypeCode| . 425461576)))
        (|Declare|
          %%
          |Finite|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 50729328))))))
  (|Declare|
    |FiniteLinearAggregate|
    (|Apply|
      ->
      (|Declare|
        s
        |Type|
        ((|symeNameCode| . 200124)
          (|symeTypeCode| . 547582661)
          (|domExports|)))
      (|Define|
        (|Declare| (|Label| |FiniteLinearAggregate| ()) |Category|)
        (|Apply|
          |Join|
          (|Apply| |FiniteAggregate| s)
          (|Apply| |LinearAggregate| s))))
    ((|documentation| .
        " `FiniteLinearAggregate(S)' provides operations for manipulating structures
  representing finite linear collections of values of type `S'.

 Author: AXIOM-XL library
 Date Created: 1992-94
 Keywords: aggregate, collection, container
")
      (|symeNameCode| . 1027647710)
      (|symeTypeCode| . 1044619069)
      (|catExports|
        (|Declare|
          =
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Equality test.
")
            (|symeNameCode| . 200102)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          ~=
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Inequality test.
")
            (|default| . 1)
            (|symeNameCode| . 51509389)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          <<
          (|Apply| -> (|Comma| |TextWriter| %) |TextWriter|)
          ((|documentation| . " Basic output.
")
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 561215334)))
        (|Declare|
          <<
          (|Apply| -> % (|Apply| -> |TextWriter| |TextWriter|))
          ((|documentation| . " Basic output.
")
            (|default| . 1)
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 112505899)))
        (|Declare|
          |sample|
          %
          ((|documentation| . " Example element.
")
            (|symeNameCode| . 255806968)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          |hash|
          (|Apply| -> % |SingleInteger|)
          ((|documentation| . " Hashing function.
")
            (|default| . 1)
            (|symeNameCode| . 746853960)
            (|symeTypeCode| . 286270707)))
        (|Declare|
          |case|
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " for 'select' statements;
")
            (|default| . 1)
            (|symeNameCode| . 864625472)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          %%
          |BasicType|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 866929616)))
        (|Declare|
          |empty?|
          (|Apply| -> % |Boolean|)
          ((|documentation| . " Is the element count zero?
")
            (|default| . 1)
            (|symeNameCode| . 506619364)
            (|symeTypeCode| . 884043277)))
        (|Declare|
          |generator|
          (|Apply| -> % (|Apply| |Generator| s))
          ((|documentation| . " Generic traversal of an aggregate.
")
            (|symeNameCode| . 113320568)
            (|symeTypeCode| . 228375914)))
        (|Declare|
          |map|
          (|Apply| -> (|Comma| (|Apply| -> s s) %) %)
          ((|documentation| . " Form new aggregate using function.
")
            (|default| . 1)
            (|symeNameCode| . 318461817)
            (|symeTypeCode| . 126341433)))
        (|Declare|
          %%
          (|Apply| |Aggregate| s)
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 71079667)))
        (|Declare|
          |#|
          (|Apply| -> % |SingleInteger|)
          ((|documentation| . " Count of the number of elements.
")
            (|symeNameCode| . 200076)
            (|symeTypeCode| . 286270707)))
        (|Declare|
          %%
          (|Apply| |FiniteAggregate| s)
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 663629000)))
        (|Declare|
          |empty|
          (|Apply| -> (|Comma|) %)
          ((|documentation| . " Construction with no values.
")
            (|default| . 1)
            (|symeNameCode| . 357262396)
            (|symeTypeCode| . 337587942)))
        (|Declare|
          |bracket|
          (|Apply| -> (|Apply| |Generator| s) %)
          ((|documentation| . " Construction from a generator.
")
            (|symeNameCode| . 44638651)
            (|symeTypeCode| . 472075114)))
        (|Declare|
          |bracket|
          (|Apply| -> (|Apply| |Tuple| s) %)
          ((|documentation| . " Construction from a tuple.
")
            (|symeNameCode| . 44638651)
            (|symeTypeCode| . 235561001)))
        (|Declare|
          |map|
          (|Apply| -> (|Comma| (|Apply| -> (|Comma| s s) s) % %) %)
          ((|documentation| . " Element-wise combination.
")
            (|default| . 1)
            (|symeNameCode| . 318461817)
            (|symeTypeCode| . 164382471)))
        (|Declare|
          |apply|
          (|Apply| -> (|Comma| % |SingleInteger|) s)
          ((|symeNameCode| . 306472243) (|symeTypeCode| . 546428975)))
        (|Declare|
          %%
          (|Apply| |LinearAggregate| s)
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 9379268)))
        (|Declare|
          %%
          (|Apply| |FiniteLinearAggregate| s)
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 639573913))))))
  (|Declare|
    |LinearAggregate|
    (|Apply|
      ->
      (|Declare|
        s
        |Type|
        ((|symeNameCode| . 200124)
          (|symeTypeCode| . 547582661)
          (|domExports|)))
      (|Define|
        (|Declare| (|Label| |LinearAggregate| ()) |Category|)
        (|With|
          (|Apply| |Aggregate| s)
          (|Sequence|
            (|Declare|
              |empty|
              (|Apply| -> (|Comma|) %)
              ((|documentation| . " Construction with no values.
")
                (|default| . 1)
                (|symeNameCode| . 357262396)
                (|symeTypeCode| . 337587942)))
            (|Declare|
              |bracket|
              (|Apply| -> (|Apply| |Generator| s) %)
              ((|documentation| . " Construction from a generator.
")
                (|symeNameCode| . 44638651)
                (|symeTypeCode| . 472075114)))
            (|Declare|
              |bracket|
              (|Apply| -> (|Apply| |Tuple| s) %)
              ((|documentation| . " Construction from a tuple.
")
                (|symeNameCode| . 44638651)
                (|symeTypeCode| . 235561001)))
            (|Declare|
              |map|
              (|Apply| -> (|Comma| (|Apply| -> (|Comma| s s) s) % %) %)
              ((|documentation| . " Element-wise combination.
")
                (|default| . 1)
                (|symeNameCode| . 318461817)
                (|symeTypeCode| . 164382471)))
            (|Declare|
              |apply|
              (|Apply| -> (|Comma| % |SingleInteger|) s)
              ((|symeNameCode| . 306472243) (|symeTypeCode| . 546428975)))
            (|Default|
              (|Sequence|
                (|Define|
                  (|Declare|
                    |empty|
                    (|Apply| -> (|Comma|) %)
                    ((|documentation| . " Construction with no values.
")
                      (|default| . 1)
                      (|symeNameCode| . 357262396)
                      (|symeTypeCode| . 337587942)))
                  (|Lambda| (|Comma|) % (|Label| |empty| (|Apply| |bracket|))))
                (|Define|
                  (|Declare|
                    |map|
                    (|Apply|
                      ->
                      (|Comma|
                        (|Declare|
                          |f|
                          (|Apply| -> s s)
                          ((|symeNameCode| . 200143) (|symeTypeCode| . 144019032)))
                        (|Declare|
                          |a|
                          %
                          ((|symeNameCode| . 200138) (|symeTypeCode| . 1015195433))))
                      %)
                    ((|default| . 1)
                      (|symeNameCode| . 318461817)
                      (|symeTypeCode| . 126341433)))
                  (|Lambda|
                    (|Comma|
                      (|Declare|
                        |f|
                        (|Apply| -> s s)
                        ((|symeNameCode| . 200143) (|symeTypeCode| . 144019032)))
                      (|Declare|
                        |a|
                        %
                        ((|symeNameCode| . 200138) (|symeTypeCode| . 1015195433))))
                    %
                    (|Label|
                      |map|
                      (|Apply| |bracket| (|Collect| (|Apply| |f| |x|) (|For| |x| |a| ()))))))
                (|Define|
                  (|Declare|
                    |map|
                    (|Apply|
                      ->
                      (|Comma|
                        (|Declare|
                          |f|
                          (|Apply| -> (|Comma| s s) s)
                          ((|symeNameCode| . 200143) (|symeTypeCode| . 343902356)))
                        (|Declare|
                          |a|
                          %
                          ((|symeNameCode| . 200138) (|symeTypeCode| . 1015195433)))
                        (|Declare|
                          |b|
                          %
                          ((|symeNameCode| . 200139) (|symeTypeCode| . 1015195433))))
                      %)
                    ((|documentation| . " Element-wise combination.
")
                      (|default| . 1)
                      (|symeNameCode| . 318461817)
                      (|symeTypeCode| . 164382471)))
                  (|Lambda|
                    (|Comma|
                      (|Declare|
                        |f|
                        (|Apply| -> (|Comma| s s) s)
                        ((|symeNameCode| . 200143) (|symeTypeCode| . 343902356)))
                      (|Declare|
                        |a|
                        %
                        ((|symeNameCode| . 200138) (|symeTypeCode| . 1015195433)))
                      (|Declare|
                        |b|
                        %
                        ((|symeNameCode| . 200139) (|symeTypeCode| . 1015195433))))
                    %
                    (|Label|
                      |map|
                      (|Apply|
                        |bracket|
                        (|Collect|
                          (|Apply| |f| |x| |y|)
                          (|For| |x| |a| ())
                          (|For| |y| |b| ()))))))))))))
    ((|documentation| .
        " `LinearAggregate(S)' provides operations for manipulating structures
  representing linear collections of values of type `S'.
!! For this release the constructors may generate errors if not given
!! suitable numbers of constituents.

 Author: AXIOM-XL library
 Date Created: 1992-94
 Keywords: aggregate, collection, container
")
      (|symeNameCode| . 31447049)
      (|symeTypeCode| . 321776257)
      (|catExports|
        (|Declare|
          =
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Equality test.
")
            (|symeNameCode| . 200102)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          ~=
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Inequality test.
")
            (|default| . 1)
            (|symeNameCode| . 51509389)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          <<
          (|Apply| -> (|Comma| |TextWriter| %) |TextWriter|)
          ((|documentation| . " Basic output.
")
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 561215334)))
        (|Declare|
          <<
          (|Apply| -> % (|Apply| -> |TextWriter| |TextWriter|))
          ((|documentation| . " Basic output.
")
            (|default| . 1)
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 112505899)))
        (|Declare|
          |sample|
          %
          ((|documentation| . " Example element.
")
            (|symeNameCode| . 255806968)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          |hash|
          (|Apply| -> % |SingleInteger|)
          ((|documentation| . " Hashing function.
")
            (|default| . 1)
            (|symeNameCode| . 746853960)
            (|symeTypeCode| . 286270707)))
        (|Declare|
          |case|
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " for 'select' statements;
")
            (|default| . 1)
            (|symeNameCode| . 864625472)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          %%
          |BasicType|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 866929616)))
        (|Declare|
          |empty?|
          (|Apply| -> % |Boolean|)
          ((|documentation| . " Is the element count zero?
")
            (|symeNameCode| . 506619364)
            (|symeTypeCode| . 884043277)))
        (|Declare|
          |generator|
          (|Apply| -> % (|Apply| |Generator| s))
          ((|documentation| . " Generic traversal of an aggregate.
")
            (|symeNameCode| . 113320568)
            (|symeTypeCode| . 228375914)))
        (|Declare|
          |map|
          (|Apply| -> (|Comma| (|Apply| -> s s) %) %)
          ((|documentation| . " Form new aggregate using function.
")
            (|default| . 1)
            (|symeNameCode| . 318461817)
            (|symeTypeCode| . 126341433)))
        (|Declare|
          %%
          (|Apply| |Aggregate| s)
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 71079667)))
        (|Declare|
          |empty|
          (|Apply| -> (|Comma|) %)
          ((|documentation| . " Construction with no values.
")
            (|default| . 1)
            (|symeNameCode| . 357262396)
            (|symeTypeCode| . 337587942)))
        (|Declare|
          |bracket|
          (|Apply| -> (|Apply| |Generator| s) %)
          ((|documentation| . " Construction from a generator.
")
            (|symeNameCode| . 44638651)
            (|symeTypeCode| . 472075114)))
        (|Declare|
          |bracket|
          (|Apply| -> (|Apply| |Tuple| s) %)
          ((|documentation| . " Construction from a tuple.
")
            (|symeNameCode| . 44638651)
            (|symeTypeCode| . 235561001)))
        (|Declare|
          |map|
          (|Apply| -> (|Comma| (|Apply| -> (|Comma| s s) s) % %) %)
          ((|documentation| . " Element-wise combination.
")
            (|default| . 1)
            (|symeNameCode| . 318461817)
            (|symeTypeCode| . 164382471)))
        (|Declare|
          |apply|
          (|Apply| -> (|Comma| % |SingleInteger|) s)
          ((|symeNameCode| . 306472243) (|symeTypeCode| . 546428975)))
        (|Declare|
          %%
          (|Apply| |LinearAggregate| s)
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 9379268))))))
  (|Declare|
    |FiniteAggregate|
    (|Apply|
      ->
      (|Declare|
        s
        |Type|
        ((|symeNameCode| . 200124)
          (|symeTypeCode| . 547582661)
          (|domExports|)))
      (|Define|
        (|Declare| (|Label| |FiniteAggregate| ()) |Category|)
        (|With|
          (|Apply| |Aggregate| s)
          (|Sequence|
            (|Declare|
              |#|
              (|Apply| -> % |SingleInteger|)
              ((|documentation| . " Count of the number of elements.
")
                (|symeNameCode| . 200076)
                (|symeTypeCode| . 286270707)))
            (|Default|
              (|Define|
                (|Declare|
                  |empty?|
                  (|Apply|
                    ->
                    (|Declare|
                      |a|
                      %
                      ((|symeNameCode| . 200138) (|symeTypeCode| . 1015195433)))
                    |Boolean|)
                  ((|default| . 1)
                    (|symeNameCode| . 506619364)
                    (|symeTypeCode| . 884043277)))
                (|Lambda|
                  (|Comma|
                    (|Declare|
                      |a|
                      %
                      ((|symeNameCode| . 200138) (|symeTypeCode| . 1015195433))))
                  |Boolean|
                  (|Label|
                    |empty?|
                    (|Sequence|
                      (|Sequence| (|Import| () |SingleInteger|) (|Import| () |Machine|))
                      (|CoerceTo|
                        (|Apply| = (|CoerceTo| (|Apply| |#| |a|) |SInt|) \0)
                        |Boolean|))))))))))
    ((|documentation| .
        " `FiniteAggregate(S)' provides operations for manipulating structures
  representing finite collections of values of type `S'.

 Author: AXIOM-XL library
 Date Created: 1992-94
 Keywords: aggregate, collection, container
")
      (|symeNameCode| . 852348173)
      (|symeTypeCode| . 502293527)
      (|catExports|
        (|Declare|
          =
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Equality test.
")
            (|symeNameCode| . 200102)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          ~=
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Inequality test.
")
            (|default| . 1)
            (|symeNameCode| . 51509389)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          <<
          (|Apply| -> (|Comma| |TextWriter| %) |TextWriter|)
          ((|documentation| . " Basic output.
")
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 561215334)))
        (|Declare|
          <<
          (|Apply| -> % (|Apply| -> |TextWriter| |TextWriter|))
          ((|documentation| . " Basic output.
")
            (|default| . 1)
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 112505899)))
        (|Declare|
          |sample|
          %
          ((|documentation| . " Example element.
")
            (|symeNameCode| . 255806968)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          |hash|
          (|Apply| -> % |SingleInteger|)
          ((|documentation| . " Hashing function.
")
            (|default| . 1)
            (|symeNameCode| . 746853960)
            (|symeTypeCode| . 286270707)))
        (|Declare|
          |case|
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " for 'select' statements;
")
            (|default| . 1)
            (|symeNameCode| . 864625472)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          %%
          |BasicType|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 866929616)))
        (|Declare|
          |empty?|
          (|Apply| -> % |Boolean|)
          ((|documentation| . " Is the element count zero?
")
            (|default| . 1)
            (|symeNameCode| . 506619364)
            (|symeTypeCode| . 884043277)))
        (|Declare|
          |generator|
          (|Apply| -> % (|Apply| |Generator| s))
          ((|documentation| . " Generic traversal of an aggregate.
")
            (|symeNameCode| . 113320568)
            (|symeTypeCode| . 228375914)))
        (|Declare|
          |map|
          (|Apply| -> (|Comma| (|Apply| -> s s) %) %)
          ((|documentation| . " Form new aggregate using function.
")
            (|symeNameCode| . 318461817)
            (|symeTypeCode| . 126341433)))
        (|Declare|
          %%
          (|Apply| |Aggregate| s)
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 71079667)))
        (|Declare|
          |#|
          (|Apply| -> % |SingleInteger|)
          ((|documentation| . " Count of the number of elements.
")
            (|symeNameCode| . 200076)
            (|symeTypeCode| . 286270707)))
        (|Declare|
          %%
          (|Apply| |FiniteAggregate| s)
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 663629000))))))
  (|Declare|
    |Aggregate|
    (|Apply|
      ->
      (|Declare|
        s
        |Type|
        ((|symeNameCode| . 200124)
          (|symeTypeCode| . 547582661)
          (|domExports|)))
      (|Define|
        (|Declare| (|Label| |Aggregate| ()) |Category|)
        (|With|
          |BasicType|
          (|Sequence|
            (|Declare|
              |empty?|
              (|Apply| -> % |Boolean|)
              ((|documentation| . " Is the element count zero?
")
                (|symeNameCode| . 506619364)
                (|symeTypeCode| . 884043277)))
            (|Declare|
              |generator|
              (|Apply| -> % (|Apply| |Generator| s))
              ((|documentation| . " Generic traversal of an aggregate.
")
                (|symeNameCode| . 113320568)
                (|symeTypeCode| . 228375914)))
            (|Declare|
              |map|
              (|Apply| -> (|Comma| (|Apply| -> s s) %) %)
              ((|documentation| . " Form new aggregate using function.
")
                (|symeNameCode| . 318461817)
                (|symeTypeCode| . 126341433)))
            (|Export| () s ())))))
    ((|documentation| .
        " `Aggregate(S)' provides operations for manipulating structures
  representing collections of values of type `S'.

 Author: AXIOM-XL library
 Date Created: 1992-94
 Keywords: aggregate, collection, container
")
      (|symeNameCode| . 442090040)
      (|symeTypeCode| . 128518755)
      (|catExports|
        (|Declare|
          =
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Equality test.
")
            (|symeNameCode| . 200102)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          ~=
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Inequality test.
")
            (|default| . 1)
            (|symeNameCode| . 51509389)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          <<
          (|Apply| -> (|Comma| |TextWriter| %) |TextWriter|)
          ((|documentation| . " Basic output.
")
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 561215334)))
        (|Declare|
          <<
          (|Apply| -> % (|Apply| -> |TextWriter| |TextWriter|))
          ((|documentation| . " Basic output.
")
            (|default| . 1)
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 112505899)))
        (|Declare|
          |sample|
          %
          ((|documentation| . " Example element.
")
            (|symeNameCode| . 255806968)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          |hash|
          (|Apply| -> % |SingleInteger|)
          ((|documentation| . " Hashing function.
")
            (|default| . 1)
            (|symeNameCode| . 746853960)
            (|symeTypeCode| . 286270707)))
        (|Declare|
          |case|
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " for 'select' statements;
")
            (|default| . 1)
            (|symeNameCode| . 864625472)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          %%
          |BasicType|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 866929616)))
        (|Declare|
          |empty?|
          (|Apply| -> % |Boolean|)
          ((|documentation| . " Is the element count zero?
")
            (|symeNameCode| . 506619364)
            (|symeTypeCode| . 884043277)))
        (|Declare|
          |generator|
          (|Apply| -> % (|Apply| |Generator| s))
          ((|documentation| . " Generic traversal of an aggregate.
")
            (|symeNameCode| . 113320568)
            (|symeTypeCode| . 228375914)))
        (|Declare|
          |map|
          (|Apply| -> (|Comma| (|Apply| -> s s) %) %)
          ((|documentation| . " Form new aggregate using function.
")
            (|symeNameCode| . 318461817)
            (|symeTypeCode| . 126341433)))
        (|Declare|
          %%
          (|Apply| |Aggregate| s)
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 71079667))))))
  (|Declare|
    |Conditional|
    (|Define|
      (|Declare| (|Label| |Conditional| ()) |Category|)
      (|With|
        |BasicType|
        (|Declare|
          |test|
          (|Apply| -> % |Boolean|)
          ((|documentation| . " Test used in conditional context.
")
            (|symeNameCode| . 5509732)
            (|symeTypeCode| . 884043277)))))
    ((|documentation| .
        " `Conditional' allows values to be used in conditional context,
 such as in an `if' or in a `while'.

 Author: AXIOM-XL library
 Date Created: 1992-94
 Keywords: test, conditional, generic
")
      (|symeNameCode| . 557178359)
      (|symeTypeCode| . 436267619)
      (|catExports|
        (|Declare|
          =
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Equality test.
")
            (|symeNameCode| . 200102)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          ~=
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Inequality test.
")
            (|default| . 1)
            (|symeNameCode| . 51509389)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          <<
          (|Apply| -> (|Comma| |TextWriter| %) |TextWriter|)
          ((|documentation| . " Basic output.
")
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 561215334)))
        (|Declare|
          <<
          (|Apply| -> % (|Apply| -> |TextWriter| |TextWriter|))
          ((|documentation| . " Basic output.
")
            (|default| . 1)
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 112505899)))
        (|Declare|
          |sample|
          %
          ((|documentation| . " Example element.
")
            (|symeNameCode| . 255806968)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          |hash|
          (|Apply| -> % |SingleInteger|)
          ((|documentation| . " Hashing function.
")
            (|default| . 1)
            (|symeNameCode| . 746853960)
            (|symeTypeCode| . 286270707)))
        (|Declare|
          |case|
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " for 'select' statements;
")
            (|default| . 1)
            (|symeNameCode| . 864625472)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          %%
          |BasicType|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 866929616)))
        (|Declare|
          |test|
          (|Apply| -> % |Boolean|)
          ((|documentation| . " Test used in conditional context.
")
            (|symeNameCode| . 5509732)
            (|symeTypeCode| . 884043277)))
        (|Declare|
          %%
          |Conditional|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 498431890))))))
  (|Declare|
    |Logic|
    (|Define|
      (|Declare| (|Label| |Logic| ()) |Category|)
      (|With|
        |BasicType|
        (|Sequence|
          (|Declare|
            ~
            (|Apply| -> % %)
            ((|documentation| . " Logical complement.
")
              (|symeNameCode| . 200167)
              (|symeTypeCode| . 143998972)))
          (|Declare|
            |/\\|
            (|Apply| -> (|Comma| % %) %)
            ((|documentation| . " Logical `meet', e.g. `and'.
")
              (|symeNameCode| . 51487581)
              (|symeTypeCode| . 355597834)))
          (|Declare|
            |\\/|
            (|Apply| -> (|Comma| % %) %)
            ((|documentation| . " Logical `join', e.g. `or'.
")
              (|default| . 1)
              (|symeNameCode| . 51500637)
              (|symeTypeCode| . 355597834)))
          (|Declare|
            |xor|
            (|Apply| -> (|Comma| % %) %)
            ((|documentation| . " `Exclusive or' 
")
              (|default| . 1)
              (|symeNameCode| . 317608340)
              (|symeTypeCode| . 355597834)))
          (|Default|
            (|Define|
              (|Declare|
                |\\/|
                (|Apply|
                  ->
                  (|Comma|
                    (|Declare|
                      |x|
                      %
                      ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
                    (|Declare|
                      |y|
                      %
                      ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
                  %)
                ((|documentation| . " Logical `join', e.g. `or'.
")
                  (|default| . 1)
                  (|symeNameCode| . 51500637)
                  (|symeTypeCode| . 355597834)))
              (|Lambda|
                (|Comma|
                  (|Declare|
                    |x|
                    %
                    ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
                  (|Declare|
                    |y|
                    %
                    ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
                %
                (|Label|
                  |\\/|
                  (|Apply| ~ (|Apply| |/\\| (|Apply| ~ |x|) (|Apply| ~ |y|)))))))
          (|Default|
            (|Define|
              (|Declare|
                |xor|
                (|Apply|
                  ->
                  (|Comma|
                    (|Declare|
                      |x|
                      %
                      ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
                    (|Declare|
                      |y|
                      %
                      ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
                  %)
                ((|documentation| . " `Exclusive or' 
")
                  (|default| . 1)
                  (|symeNameCode| . 317608340)
                  (|symeTypeCode| . 355597834)))
              (|Lambda|
                (|Comma|
                  (|Declare|
                    |x|
                    %
                    ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
                  (|Declare|
                    |y|
                    %
                    ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
                %
                (|Label|
                  |xor|
                  (|Apply|
                    |\\/|
                    (|Apply| |/\\| |x| (|Apply| ~ |y|))
                    (|Apply| |/\\| (|Apply| ~ |x|) |y|)))))))))
    ((|documentation| .
        " `Logic' provides the basic operations for lattices,
 e.g., boolean algebra.

 Author: AXIOM-XL library
 Date Created: 1992-94
 Keywords: logic, boolean
")
      (|symeNameCode| . 244796155)
      (|symeTypeCode| . 540506605)
      (|catExports|
        (|Declare|
          =
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Equality test.
")
            (|symeNameCode| . 200102)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          ~=
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Inequality test.
")
            (|default| . 1)
            (|symeNameCode| . 51509389)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          <<
          (|Apply| -> (|Comma| |TextWriter| %) |TextWriter|)
          ((|documentation| . " Basic output.
")
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 561215334)))
        (|Declare|
          <<
          (|Apply| -> % (|Apply| -> |TextWriter| |TextWriter|))
          ((|documentation| . " Basic output.
")
            (|default| . 1)
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 112505899)))
        (|Declare|
          |sample|
          %
          ((|documentation| . " Example element.
")
            (|symeNameCode| . 255806968)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          |hash|
          (|Apply| -> % |SingleInteger|)
          ((|documentation| . " Hashing function.
")
            (|default| . 1)
            (|symeNameCode| . 746853960)
            (|symeTypeCode| . 286270707)))
        (|Declare|
          |case|
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " for 'select' statements;
")
            (|default| . 1)
            (|symeNameCode| . 864625472)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          %%
          |BasicType|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 866929616)))
        (|Declare|
          ~
          (|Apply| -> % %)
          ((|documentation| . " Logical complement.
")
            (|symeNameCode| . 200167)
            (|symeTypeCode| . 143998972)))
        (|Declare|
          |/\\|
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Logical `meet', e.g. `and'.
")
            (|symeNameCode| . 51487581)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          |\\/|
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " Logical `join', e.g. `or'.
")
            (|default| . 1)
            (|symeNameCode| . 51500637)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          |xor|
          (|Apply| -> (|Comma| % %) %)
          ((|documentation| . " `Exclusive or' 
")
            (|default| . 1)
            (|symeNameCode| . 317608340)
            (|symeTypeCode| . 355597834)))
        (|Declare|
          %%
          |Logic|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 186049686))))))
  (|Declare|
    |BasicType|
    (|Define|
      (|Declare| (|Label| |BasicType| ()) |Category|)
      (|With|
        ()
        (|Sequence|
          (|Declare|
            =
            (|Apply| -> (|Comma| % %) |Boolean|)
            ((|documentation| . " Equality test.
")
              (|symeNameCode| . 200102)
              (|symeTypeCode| . 21900315)))
          (|Declare|
            ~=
            (|Apply| -> (|Comma| % %) |Boolean|)
            ((|documentation| . " Inequality test.
")
              (|default| . 1)
              (|symeNameCode| . 51509389)
              (|symeTypeCode| . 21900315)))
          (|Declare|
            <<
            (|Apply| -> (|Comma| |TextWriter| %) |TextWriter|)
            ((|documentation| . " Basic output.
")
              (|symeNameCode| . 51492426)
              (|symeTypeCode| . 561215334)))
          (|Declare|
            <<
            (|Apply| -> % (|Apply| -> |TextWriter| |TextWriter|))
            ((|documentation| . " Basic output.
")
              (|default| . 1)
              (|symeNameCode| . 51492426)
              (|symeTypeCode| . 112505899)))
          (|Declare|
            |sample|
            %
            ((|documentation| . " Example element.
")
              (|symeNameCode| . 255806968)
              (|symeTypeCode| . 1015195433)))
          (|Declare|
            |hash|
            (|Apply| -> % |SingleInteger|)
            ((|documentation| . " Hashing function.
")
              (|default| . 1)
              (|symeNameCode| . 746853960)
              (|symeTypeCode| . 286270707)))
          (|Declare|
            |case|
            (|Apply| -> (|Comma| % %) |Boolean|)
            ((|documentation| . " for 'select' statements;
")
              (|default| . 1)
              (|symeNameCode| . 864625472)
              (|symeTypeCode| . 21900315)))
          (|Default|
            (|Define|
              (|Declare|
                ~=
                (|Apply|
                  ->
                  (|Comma|
                    (|Declare|
                      |x|
                      %
                      ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
                    (|Declare|
                      |y|
                      %
                      ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
                  |Boolean|)
                ((|documentation| . " Inequality test.
")
                  (|default| . 1)
                  (|symeNameCode| . 51509389)
                  (|symeTypeCode| . 21900315)))
              (|Lambda|
                (|Comma|
                  (|Declare|
                    |x|
                    %
                    ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
                  (|Declare|
                    |y|
                    %
                    ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
                |Boolean|
                (|Label| ~= (|Not| (|Test| (|Apply| = |x| |y|)))))))
          (|Default|
            (|Define|
              (|Declare|
                |hash|
                (|Apply|
                  ->
                  (|Declare|
                    |x|
                    %
                    ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
                  |SingleInteger|)
                ((|documentation| . " Hashing function.
")
                  (|default| . 1)
                  (|symeNameCode| . 746853960)
                  (|symeTypeCode| . 286270707)))
              (|Lambda|
                (|Comma|
                  (|Declare|
                    |x|
                    %
                    ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433))))
                |SingleInteger|
                (|Label| |hash| (|CoerceTo| (|Qualify| \0 |Machine|) |SingleInteger|)))))
          (|Default|
            (|Define|
              (|Declare|
                <<
                (|Apply|
                  ->
                  (|Declare|
                    |x|
                    %
                    ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
                  (|Apply|
                    ->
                    (|Declare|
                      |p|
                      |TextWriter|
                      ((|symeNameCode| . 200153) (|symeTypeCode| . 124005847)))
                    |TextWriter|))
                ((|documentation| . " Basic output.
")
                  (|default| . 1)
                  (|symeNameCode| . 51492426)
                  (|symeTypeCode| . 112505899)))
              (|Lambda|
                (|Comma|
                  (|Declare|
                    |x|
                    %
                    ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433))))
                (|Apply|
                  ->
                  (|Declare|
                    |p|
                    |TextWriter|
                    ((|symeNameCode| . 200153) (|symeTypeCode| . 124005847)))
                  |TextWriter|)
                (|Lambda|
                  (|Comma|
                    (|Declare|
                      |p|
                      |TextWriter|
                      ((|symeNameCode| . 200153) (|symeTypeCode| . 124005847))))
                  |TextWriter|
                  (|Label| << (|Apply| << |p| |x|))))))
          (|Default|
            (|Define|
              (|Declare|
                |case|
                (|Apply|
                  ->
                  (|Comma|
                    (|Declare|
                      |x|
                      %
                      ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
                    (|Declare|
                      |y|
                      %
                      ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
                  |Boolean|)
                ((|documentation| . " for 'select' statements;
")
                  (|default| . 1)
                  (|symeNameCode| . 864625472)
                  (|symeTypeCode| . 21900315)))
              (|Lambda|
                (|Comma|
                  (|Declare|
                    |x|
                    %
                    ((|symeNameCode| . 200161) (|symeTypeCode| . 1015195433)))
                  (|Declare|
                    |y|
                    %
                    ((|symeNameCode| . 200162) (|symeTypeCode| . 1015195433))))
                |Boolean|
                (|Label| |case| (|Apply| = |x| |y|))))))))
    ((|documentation| .
        " `BasicType' is a basic category to which most types belong.

 Author: AXIOM-XL library
 Date Created: 1992-94
 Keywords: type
")
      (|symeNameCode| . 925676085)
      (|symeTypeCode| . 313485535)
      (|catExports|
        (|Declare|
          =
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Equality test.
")
            (|symeNameCode| . 200102)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          ~=
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " Inequality test.
")
            (|default| . 1)
            (|symeNameCode| . 51509389)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          <<
          (|Apply| -> (|Comma| |TextWriter| %) |TextWriter|)
          ((|documentation| . " Basic output.
")
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 561215334)))
        (|Declare|
          <<
          (|Apply| -> % (|Apply| -> |TextWriter| |TextWriter|))
          ((|documentation| . " Basic output.
")
            (|default| . 1)
            (|symeNameCode| . 51492426)
            (|symeTypeCode| . 112505899)))
        (|Declare|
          |sample|
          %
          ((|documentation| . " Example element.
")
            (|symeNameCode| . 255806968)
            (|symeTypeCode| . 1015195433)))
        (|Declare|
          |hash|
          (|Apply| -> % |SingleInteger|)
          ((|documentation| . " Hashing function.
")
            (|default| . 1)
            (|symeNameCode| . 746853960)
            (|symeTypeCode| . 286270707)))
        (|Declare|
          |case|
          (|Apply| -> (|Comma| % %) |Boolean|)
          ((|documentation| . " for 'select' statements;
")
            (|default| . 1)
            (|symeNameCode| . 864625472)
            (|symeTypeCode| . 21900315)))
        (|Declare|
          %%
          |BasicType|
          ((|default| . 1)
            (|symeNameCode| . 51482908)
            (|symeTypeCode| . 866929616)))))))
(|Sequence|)
