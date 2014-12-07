%%%
%%% omcd parser semantics
%%%

declare F in F =

functor

import
   X('class': SemOMObj) at 'omobj.sem.ozf'
   
export
   'class': SemOMCD
   
define

   fun {Default E}
      Lab=E.name in
      Lab(E.content)
   end
   fun {Default1 E}
      Lab=E.name in
      Lab(E.content)
   end
   fun {Default2 E}
      Lab=E.name in
      Lab(E.content)
   end
   
   class SemOMCD
      from SemOMObj
      %% <!-- omcd.dtd -->
      %% <!-- ********************************************* -->
      %% <!--                                               -->
      %% <!-- DTD for OpenMath CD                           -->
      %% <!-- (c) EP24969 the ESPRIT OpenMath Consortium    -->
      %% <!-- date = 28.aug.1998                            -->
      %% <!-- author = s.buswell sb@stilo.demon.co.uk       -->
      %% <!--                                               -->
      %% <!-- edited by n.howgrave-graham 30.aug.98         -->
      %% <!-- edited by sb 4.sep.98                         -->
      %% <!-- edited by nh-g 4.sep.98                       -->
      %% <!-- edited by sb 1.nov.98                         -->
      %% <!-- edited by sb 1.nov.98                         -->
      %% <!-- edited by dpc 1999-04-13                      -->
      %% <!-- edited by dpc 1999-05-11  CDDate & CDVersion  -->
      %% <!--                                               -->
      %% <!--                                               -->
      %% <!-- ********************************************* -->
      
      %% <!ELEMENT CDComment      (#PCDATA) >
      meth 'make_CDComment'(E $)
         {Default E}
      end
   
      %% <!ELEMENT CDName         (#PCDATA) >
      meth 'make_CDName'(E $)
         {Default E}
      end

      %% <!ELEMENT CDURL          (#PCDATA) >
      meth 'make_CDURL'(E $)
         {Default E}
      end
      
      %% <!ELEMENT CDUses         (CDName)*  >
      meth 'make_CDUses'(E $)
         CDNames1 = {Map E.content fun {$ 'CDName'(VS)} VS end} in
         'CDUses'(CDNames1)
      end

      %% <!ENTITY % inhel        "(#PCDATA)" >
      %% <!ENTITY % inhel2       "(#PCDATA | OMOBJ)*" >
      
      %% <!ELEMENT CDReviewDate   %inhel; >
      meth 'make_CDReviewDate'(E $)
         {Default1 E}
      end
   
      %% <!ELEMENT CDDate         %inhel; >
      meth 'make_CDDate'(E $)
         {Default1 E}
      end
      
      %% <!ELEMENT CDVersion      %inhel; >
      meth 'make_CDVersion'(E $)
         {Default1 E}
      end
      
      %% <!ELEMENT CDStatus       %inhel; >
      meth 'make_CDStatus'(E $)
         {Default1 E}
      end
      
      %% <!ELEMENT Description    %inhel; >
      meth 'make_Description'(E $)
         {Default1 E}
      end
      
      %% <!ELEMENT Name           %inhel; >
      meth 'make_Name'(E $)
         {Default1 E}
      end

      %% <!ELEMENT Signature      %inhel; >
      meth 'make_Signature'(E $)
         {Default1 E}
      end
      
      %% <!ELEMENT Presentation   %inhel; >
      meth 'make_Presentation'(E $)
         {Default1 E}
      end
      
      %% <!ELEMENT CMP            %inhel; >
      meth 'make_CMP'(E $)
         {Default1 E}
      end
      
      %% <!-- include dtd for OM objects -->
      %% <!ENTITY  % omobjectdtd SYSTEM "omobj.dtd" >
      %% %omobjectdtd;
      
      %% <!ELEMENT FMP            %inhel2; >         <!-- allow embedded OM -->
      meth 'make_FMP'(E $)
         {Default2 E}
      end
      
      %% <!ELEMENT Example        %inhel2; >
      meth 'make_Example'(E $)
         {Default2 E}
      end
      
      %% <!ELEMENT CDDefinition    (CDComment | Name | Description  |
      %%                            Signature | Example | FMP |
      %%                           CMP | Presentation)* >
      meth 'make_CDDefinition'(E $)
         'CDDefinition'(E.content)
      end

      %% <!ELEMENT CD             (CDComment | CDName | Description |
      %%                          CDReviewDate | CDDate |CDVersion |
      %%                          CDStatus | CDURL | CDUses | CDDefinition |
      %% Example)* >
      meth 'make_CD'(E $)
         'CD'(E.content)
      end
      
      %% <!-- end of DTD for OM CD -->
   end
   
end

