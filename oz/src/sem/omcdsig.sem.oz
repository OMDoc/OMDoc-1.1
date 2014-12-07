%%%
%%% omcdsig parser semantics
%%%

declare F in F =

functor

import
   X('class': SemOMObj) at 'omobj.sem.ozf'
   
export
   'class': SemOMCDSig

define
   
   fun {Default E}
      Lab=E.name in
      Lab(E.content)
   end

   class SemOMCDSig
      from SemOMObj
      %% <!-- omcds.dtd -->
      %% <!-- ********************************************* -->
      %% <!--                                               -->
      %% <!-- DTD for OpenMath CD Signatures                -->
      %% <!-- (c) EP24969 the ESPRIT OpenMath Consortium    -->
      %% <!-- David Carlisle 1999-04-13                     -->
      %% <!--                                               -->
      %% <!--                                               -->
      %% <!-- ********************************************* -->
      
      %% <!-- include dtd for OM objects -->
      %% <!ENTITY  % omobjectdtd SYSTEM "omobj.dtd" >
      %% %omobjectdtd;
      
      %% <!ELEMENT CDComment      (#PCDATA) >
      meth 'make_CDComment'(E $)
         {Default E}
      end

      %% <!ELEMENT CDSComment      (#PCDATA) >
      meth 'make_CDSComment'(E $)
         {Default E}
      end

      %% <!ELEMENT CDSReviewDate    (#PCDATA) >
      meth 'make_CDSReviewDate'(E $)
         {Default E}
      end

      %% <!ELEMENT CDSStatus    (#PCDATA) >
      meth 'make_CDSStatus'(E $)
         {Default E}
      end
      
      %% <!ELEMENT CDSignatures   (CDComment |CDSComment | CDSReviewDate |
      %%                          CDSStatus | signature )* >
      %% <!ATTLIST CDSignatures cd CDATA #REQUIRED
      %%                        type CDATA #REQUIRED >
      meth 'make_CDSignatures'(E $)
         'CDSignatures'(cd:CD type:Type) = E.attribs in
         'CDSignatures'(E.content cd:CD type:Type)
      end
      
      %% <!ELEMENT signature      (OMOBJ) >
      %% <!ATTLIST  signature  name CDATA #REQUIRED >
      meth 'make_signature'(E $)
         'signature'(name:Name) = E.attribs in
         'signature'(E.content name:Name)
      end

      %% <!-- end of DTD for OM CD Signatures -->
   end

end






