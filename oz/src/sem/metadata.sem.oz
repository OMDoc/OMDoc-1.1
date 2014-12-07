%%
%% metadata parser semantics
%%

functor

import
   %% XVS at 'file:///home/afranke/import/mathweb/xmlparser/src/XVS.ozf'

export
   'class': SemMetadata
   
define

   VS2A = VirtualString.toAtom
   %% VS2BS = VirtualString.toByteString

   %% old:        BS = {VS2BS E.content}
   %% instead of: ANY = E.content
   fun {Single Lab E}
      ANY = E.content in
      Lab(ANY)
   end

   fun {Opt X}
      case X of nil
      then unit
      else X
      end
   end

   class SemMetadata
      
      %% <!-- DTD for OMDoc Metadata - MiKo 17.8.99 -->
      
      %% <!-- this DTD is based on the Core Metadata model of the
      %%      Dublin Metadata initiative (http://purl.org/dc) -->

      %% <!ENTITY % dcdata "Contributor | Creator | Translator
      %%             | Subject | Title  
      %%             | Description | Publisher | Date | Type 
      %%             | Format | Identifier | Source | Language 
      %%             | Relation | Coverage | Rights">
      %%
      %% %% old: <!ENTITY % otherdata "depends-on | private">
      %%
      %% <!ELEMENT metadata ((%dcdata;)*,extradata?)>
     
      meth 'make_metadata'(E $)
         DCData # Extradata = E.content in
         'metadata'(items:     DCData
                    extradata: {Opt Extradata})
      end
      
      %%<!ELEMENT Contributor (#PCDATA)> 
      %%<!ATTLIST Creator role (aut|aqt|aft|aui|ant|clb|edt|ths|trc|trl) "aut">
      meth 'make_Contributor'(E $)
         ANY = E.content in
         'contributor'(ANY role:{VS2A {CondSelect E.attribs role 'aut'}})
      end

      %%<!ELEMENT Title (#PCDATA)>
      %%<!ATTLIST Title %langmatter;>
      meth 'make_Title'(E $)
         ANY = E.content in
         'title'(ANY lang:{VS2A {CondSelect E.attribs 'xml:lang' 'eng'}})
      end
      
      %%<!ELEMENT Creator (#PCDATA)> 
      %%<!ATTLIST Creator role (aut|aqt|aft|aui|ant|clb|edt|ths|trc|trl) "aut">
      meth 'make_Creator'(E $)
         ANY = E.content in
         'creator'(ANY role:{VS2A {CondSelect E.attribs role 'aut'}})
      end

      %% <!ELEMENT Translator (#PCDATA)> 
      %% <!ATTLIST Translator %langmatter;>
      meth 'make_Translator'(E $)
         ANY = E.content in
         'translator'(ANY lang:{VS2A {CondSelect E.attribs 'xml:lang' 'eng'}})
      end
      
      %% <!ELEMENT Subject (#PCDATA)> 
      meth 'make_Subject'(E $)
         {Single 'subject' E}
      end

   
      %% <!ELEMENT Description (#PCDATA)> 
      meth 'make_Description'(E $)
         {Single 'description' E}
      end
      
      %% <!ELEMENT Publisher (#PCDATA)> 
      meth 'make_Publisher'(E $)
         {Single 'publisher' E}
      end

      %% <!ELEMENT Date (#PCDATA)>
      %% <!ATTLIST Date action NMTOKEN #IMPLIED>
      meth 'make_Date'(E $)
         ANY = E.content in
         case {CondSelect E.attribs action unit}
         of unit   then 'date'(ANY)
         [] Action then 'date'(ANY action:{VS2A Action})
         end
      end

      %% <!ELEMENT Type (#PCDATA)> 
      meth 'make_Type'(E $)
         {Single 'type' E}
      end

      %% <!ELEMENT Format (#PCDATA)> 
      meth 'make_Format'(E $)
         {Single 'format' E}
      end

      %% <!ELEMENT Identifier (#PCDATA)> 
      %% <!ATTLIST Identifier scheme NMTOKEN "ISBN">
      meth 'make_Identifier'(E $)
         ANY = E.content in
         'identifier'(ANY scheme:{VS2A {CondSelect E.attribs scheme 'ISBN'}})
      end

      %% <!ELEMENT Source (#PCDATA)> 
      meth 'make_Source'(E $)
         {Single 'source' E}
      end
      
      %% <!ELEMENT Language (#PCDATA)> 
      meth 'make_Language'(E $)
         {Single 'format' E}
      end
      
      %% <!ELEMENT Relation (#PCDATA)> 
      meth 'make_Relation'(E $)
         {Single 'relation' E}
      end
      
      %% <!ELEMENT Coverage (#PCDATA)> 
      meth 'make_Coverage'(E $)
         {Single 'coverage' E}
      end
      
      %% <!ELEMENT Rights (#PCDATA)> 
      meth 'make_Rights'(E $)
         {Single 'rights' E}
      end

      %% <!ELEMENT extradata ANY>
      meth 'make_extradata'(E $)
         extradata(E.content)
      end
      
      %% <!ELEMENT depends-on ANY>
      meth 'make_depends-on'(E $)
         %% implemented as <!ELEMENT depends-on (tref*)>         
         'depends-on'({Filter E.content fun {$ X} {Label X}==tref end})
      end
      meth 'ANY'(E $)
         if E.content==nil
         then E.attribs
         else {AdjoinAt E.attribs 1 E.content}
         end
      end
   end
   
end








