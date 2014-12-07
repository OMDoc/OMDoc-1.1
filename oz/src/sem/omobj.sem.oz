%%%
%%% omobj parser semantics
%%%

functor

import
   Compiler
      
export
   'class': SemOMObj
   
define
   
   VS2S = VirtualString.toString

   proc {CheckAttribs E LegalAttribs}
      {ForAll {Arity E.attribs}
       proc {$ Attr}
          if {Member Attr LegalAttribs}==false then
             raise illegalAttribute(Attr expected:LegalAttribs 'in':E) end
          end
       end}
   end
   proc {CheckEmpty E}
      if {Arity E.attribs}\=nil then
         raise notEmpty(E) end
      end
   end
   
   class SemOMObj
      %% <!-- DTD for OM Objects - sb 29.10.98 -->
      %% <!-- sb 3.2.99 -->
      
      %% <!--
      %%      general list of embeddable elements
      %%       : excludes OMATP as this is only embeddable in OMATTR
      %%       : excludes OMBVAR as this is only embeddable in OMBIND
      %% -->
      %%
      %% <!ENTITY % omel "OMS | OMV | OMI | OMB | OMSTR
      %%                                 | OMF | OMA | OMBIND | OME
      %%                                 | OMATTR ">
      
      %% <!-- things which can be variables -->
      %%
      %% <!ENTITY % omvar "OMV | OMATTR" >

      %% <!-- symbol -->
      %% <!ELEMENT OMS EMPTY>
      %% <!ATTLIST OMS name CDATA #REQUIRED
      %%               cd   CDATA #REQUIRED >
      meth 'make_OMS'(E $)
         {CheckAttribs E [name cd]}  
         A=E.attribs in
         'OMS'(name: {VS2S A.name}
               cd:   {VS2S A.cd})
      end
      
      %% <!-- variable -->
      %% <!ELEMENT OMV EMPTY>
      %% <!ATTLIST OMV name CDATA #REQUIRED >
      meth 'make_OMV'(E $)
         {CheckAttribs E [name]}
         A=E.attribs in
         'OMV'(name: {VS2S A.name})
      end
      
      %% <!-- integer -->
      %% <!ELEMENT OMI (#PCDATA) >
      meth 'make_OMI'(E $)
         {CheckEmpty E}
         VS = E.content
         S0 = {VirtualString.toString VS}
         S1 = S0 %{Map S0 fun {$ C} if C==&- then &~ else C end end}
         S2 = {List.dropWhile S1 fun {$ C} C==&0 end}
         S3 = if {All S2 Char.isSpace} andthen {Member &0 S1} then "0"
              else S2 end
         I  = {StringToInt S3}                            
      in
         'OMI'(I)
      end
      
      %% <!-- byte array -->
      %% <!ELEMENT OMB (#PCDATA) >
      meth 'make_OMB'(E $)
         {CheckEmpty E}
         VS = E.content
         BS = {VirtualString.toByteString VS}
      in
         'OMB'(BS)
      end

      %% <!-- string -->
      %% <!ELEMENT OMSTR (#PCDATA) >    
      meth 'make_OMSTR'(E $)
         {CheckEmpty E}
         VS = E.content
         BS = {VirtualString.toByteString VS}
      in
         'OMSTR'(BS)
      end
      
      %% <!-- floating point -->
      %% <!ELEMENT OMF EMPTY>
      %% <!ATTLIST OMF dec CDATA #IMPLIED
      %%               hex CDATA #IMPLIED>
      meth 'make_OMF'(E $)
         {CheckAttribs E [dec hex]}
         A=E.attribs
         Dec = {CondSelect A dec unit}
         Hex = {CondSelect A hex unit}
      in
         case Dec#Hex
         of unit#unit then
            raise omParser('OMF' missingValue) end
         [] _#unit then
            S0 = {VirtualString.toString Dec}
            S1 = {Map S0 fun {$ C} if C==&- then &~ else C end end}
            S2 = if {Member &. S1} then S1
                 else {VirtualString.toString S1#"."}
                 end
            F  = {String.toFloat S2}
         in
            'OMF'(F)   
         [] unit#_ then
            F = {Compiler.virtualStringToValue "0x"#Hex} in
            'OMF'(F)
         else
            raise omParser('OMF' twoValues) end
         end
      end

      %% <!-- apply constructor -->
      %% <!ELEMENT OMA (%omel;)+ >
      meth 'make_OMA'(E $)
         {CheckEmpty E}
         F|Args = E.content in
         'OMA'(F Args)
      end

      %% <!-- binding constructor & variable -->
      %% <!ELEMENT OMBIND ((%omel;), OMBVAR, (%omel;)) >
      %% <!ELEMENT OMBVAR (%omvar;)+ >
      meth 'make_OMBVAR'(E $)
         {CheckEmpty E}
         E.content
      end
      meth 'make_OMBIND'(E $)
         {CheckEmpty E}
         E1#Vars#E2 = E.content in
         'OMBIND'(E1 Vars E2)
      end

      %% <!-- error -->
      %% <!ELEMENT OME (OMS, (%omel;)* ) >
      meth 'make_OME'(E $)
         {CheckEmpty E}
         Sym#L = E.content in
         'OME'(Sym L)
      end
      
      %% <!-- attribution constructor & attribute pair constructor -->
      %% <!ELEMENT OMATTR (OMATP, (%omel;)) >
      %% <!ELEMENT OMATP (OMS, (%omel;))+ >
      meth 'make_OMATTR'(E $)
         {CheckEmpty E}
         AList#El = E.content in
         'OMATTR'(AList El)
      end
      meth 'make_OMATP'(E $)
         {CheckEmpty E}
         E.content
      end
      
      %% <!-- OM object constructor -->
      %% <!ELEMENT OMOBJ (%omel;) >
      meth 'make_OMOBJ'(E $)
         {CheckEmpty E}
         El = E.content in
         'OMOBJ'(El)
      end
   end
   
end
