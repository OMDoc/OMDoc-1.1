%%%
%%% cdgroup parser semantics
%%%

declare F in F =

functor

import

export
   'class': SemCDGroup

define

   fun {Default E}
      Lab=E.name in
      Lab(E.content)
   end

   class SemCDGroup
      %% <!-- CDgroup.dtd -->
      %% <!-- ********************************************* -->
      %% <!--                                               -->
      %% <!-- DTD for OpenMath CD group                     -->
      %% <!-- (c) EP24969 the ESPRIT OpenMath Consortium    -->
      %% <!-- date = 18.Feb.1999                            -->
      %% <!-- author = s.buswell sb@stilo.demon.co.uk       -->
      %% <!--                                               -->
      %% <!--                                               -->
      %% <!-- available at                                  -->
      %% <!-- http://www.nag.co.uk/~something here David~  -->
      %% <!--                                               -->
      %% <!-- ********************************************* -->
      
      %% <!-- info on the CD group itself -->
      
      %% <!ELEMENT CDGroupName      (#PCDATA) >
      meth 'make_CDGroupName'(E $)
         {Default E}
      end
      
      %% <!ELEMENT CDGroupVersion     (#PCDATA) >
      meth 'make_CDGroupVersion'(E $)
         {Default E}
      end

      %% <!ELEMENT CDGroupURL          (#PCDATA) >
      meth 'make_CDGroupURL'(E $)
         {Default E}
      end
      
      %% <!ELEMENT CDGroupDescription  (#PCDATA) >
      meth 'make_CDGroupDescription'(E $)
         {Default E}
      end
      
      %% <!-- info on the CDs in the group  -->
      
      %% <!ELEMENT CDComment     (#PCDATA) >
      meth 'make_CDComment'(E $)
         {Default E}
      end

      %% <!ELEMENT CDGroupMember (CDName, CDVersion?, CDURL?) >
      meth 'make_CDGroupMember'(E $)
         N#V#Url = E.content in
         'CDGroupMember'(name:N version:V url:Url)
      end
      
      %% <!ELEMENT CDName     (#PCDATA) >
      meth 'make_CDName'(E $)
         {Default E}
      end

      %% <!ELEMENT CDVersion     (#PCDATA) >
      meth 'make_CDVersion'(E $)
         {Default E}
      end

      %% <!ELEMENT CDURL         (#PCDATA) >
      meth 'make_CDURL'(E $)
         {Default E}
      end

      %% <!-- structure of the group -->
      %% <!ELEMENT CDGroup  (CDGroupName, CDGroupVersion, CDGroupURL,
      %% CDGroupDescription,
      %%      (CDGroupMember  | CDComment )* ) >
      meth 'make_CDGroup'(E $)
         N#V#Url#D#L = E.content in
         'CDGroup'(name:N version:V url:Url description:D L)
      end

      %% <!-- end of DTD for OM CDGroup -->
   end
end

