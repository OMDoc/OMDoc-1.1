%%%
%%% xsl parser semantics
%%%

declare F in F =

functor

import

export
   'class': SemXSL
   
define

   fun {Default E}
      case E.model of 'EMPTY' then E.attribs
      else 
         {AdjoinAt E.attribs 1 E.content}
      end
   end
   
   class SemXSL
      %% <!-- DTD for XSL annotations in OpenMath documents 
      %%      - copied from the XSLT working Draft of August 13.
      %%      - Michael Kohlhase 1999-09-07 
      %%      - take the real xsl DTD eventually -->

      %% <!-- BEGIN changes by MiKo to make this run -->

      %% <!ENTITY % result-elements "">

      %% <!-- END changes by MiKo to make this run -->

      %%     <!ENTITY % char-instructions "
      %%       | xsl:apply-templates
      %%       | xsl:call-template
      %%       | xsl:apply-imports
      %%       | xsl:for-each
      %%       | xsl:value-of
      %%       | xsl:copy-of
      %%       | xsl:number
      %%       | xsl:choose
      %%       | xsl:if
      %%       | xsl:text
      %%       | xsl:copy
      %%       | xsl:variable
      %%       | xsl:message
      %%     ">

      %%     <!ENTITY % instructions "
      %%       %char-instructions;
      %%       | xsl:processing-instruction
      %%       | xsl:comment
      %%       | xsl:element
      %%       | xsl:attribute
      %%     ">

      %%     <!ENTITY % char-template "
      %%      (#PCDATA
      %%       %char-instructions;)*
      %%     ">

      %%     <!ENTITY % template "
      %%      (#PCDATA
      %%       %instructions;
      %%       %result-elements;)*
      %%     ">

      %%     <!-- Used for the type of an attribute value that is a URI reference.-->
      %%     <!ENTITY % URI "CDATA">

      %%     <!-- Used for the type of an attribute value that is a pattern.-->
      %%     <!ENTITY % pattern "CDATA">

      %%     <!-- Used for the type of an attribute value that is an
      %%          attribute value template.-->
      %%     <!ENTITY % avt "CDATA">

      %%     <!-- Used for the type of an attribute value that is a QName; the prefix
      %%          gets expanded by the XSLT processor. -->
      %%     <!ENTITY % qname "NMTOKEN">

      %%     <!-- Like qname but a whitespace-separated list of QNames. -->
      %%     <!ENTITY % qnames "NMTOKENS">

      %%     <!-- Used for the type of an attribute value that is an expression.-->
      %%     <!ENTITY % expr "CDATA">

      %%     <!-- Used for the type of an attribute value that consists
      %%          of a single character.-->
      %%     <!ENTITY % char "CDATA">

      %%     <!-- Used for the type of an attribute value that is a priority. -->
      %%     <!ENTITY % priority "NMTOKEN">

      %%     <!ENTITY % space-att "xml:space (default|preserve) #IMPLIED">

      %%     <!-- This may be overridden to customize the set of elements allowed
      %%     at the top-level. -->

      %%     <!ENTITY % non-xsl-top-level "">

      %%     <!ENTITY % top-level "
      %%      (xsl:import*,
      %%       (xsl:include
      %%       | xsl:strip-space
      %%       | xsl:preserve-space
      %%       | xsl:output
      %%       | xsl:key
      %%       | xsl:locale
      %%       | xsl:attribute-set
      %%       | xsl:variable
      %%       | xsl:param
      %%       | xsl:template
      %%       %non-xsl-top-level;)*)
      %%     ">

      %%     <!ENTITY % top-level-atts '
      %%       extension-element-prefixes CDATA #IMPLIED
      %%       id ID #IMPLIED
      %%       xmlns:xsl CDATA #FIXED "http://www.w3.org/XSL/Transform/1.0"
      %%       %space-att;
      %%     '>

      %%     <!-- This entity is defined for use in the ATTLIST declaration
      %%     for result elements. -->

      %%     <!ENTITY % result-element-atts '
      %%       xsl:extension-element-prefixes CDATA #IMPLIED
      %%       xsl:use-attribute-sets %qnames; #IMPLIED
      %%     '>

      %%     <!ELEMENT xsl:stylesheet %top-level;>
      %%     <!ATTLIST xsl:stylesheet %top-level-atts;>
      meth 'make_xsl:stylesheet'(E $)
         {Default E}
      end

      %%     <!ELEMENT xsl:transform %top-level;>
      %%     <!ATTLIST xsl:transform %top-level-atts;>
      meth 'make_xsl:transform'(E $)
         {Default E}
      end
      
      %%     <!ELEMENT xsl:import EMPTY>
      %%     <!ATTLIST xsl:import href %URI; #REQUIRED>
      meth 'make_xsl:import'(E $)
         E.attribs
      end
      
      %%     <!ELEMENT xsl:include EMPTY>
      %%     <!ATTLIST xsl:include href %URI; #REQUIRED>
      meth 'make_xsl:include'(E $)
         E.attribs
      end

      %%     <!ELEMENT xsl:strip-space EMPTY>
      %%     <!ATTLIST xsl:strip-space elements CDATA #REQUIRED>
      meth 'make_xsl:strip-space'(E $)
         E.attribs
      end

      %%     <!ELEMENT xsl:preserve-space EMPTY>
      %%     <!ATTLIST xsl:preserve-space elements CDATA #REQUIRED>
      meth 'make_xsl:preserve-space'(E $)
         E.attribs
      end

      %%     <!ELEMENT xsl:output EMPTY>
      %%     <!ATTLIST xsl:output
      %%       method %qname; #IMPLIED
      %%       version NMTOKEN #IMPLIED
      %%       encoding NMTOKEN #IMPLIED
      %%       xml-declaration (yes|no) #IMPLIED
      %%       standalone (yes|no) #IMPLIED
      %%       doctype-public CDATA #IMPLIED
      %%       doctype-system CDATA #IMPLIED
      %%       cdata-section-elements %qnames; "bla"
      %%       indent (yes|no) #IMPLIED
      %%       media-type CDATA #IMPLIED
      %%     >
      meth 'make_xsl:output'(E $)
         E.attribs
      end

      %%     <!ELEMENT xsl:key EMPTY>
      %%     <!ATTLIST xsl:key
      %%       name %qname; #REQUIRED
      %%       match %pattern; #REQUIRED
      %%       use %expr; #REQUIRED
      %%     >
      meth 'make_xsl:key'(E $)
         E.attribs
      end

      %%     <!ELEMENT xsl:locale EMPTY>
      %%     <!ATTLIST xsl:locale
      %%       name %qname; #IMPLIED
      %%       decimal-separator %char; "."
      %%       grouping-separator %char; ","
      %%       minus-sign %char; "-"
      %%       percent %char; "%"
      %%       zero-digit %char; "0"
      %%       digit %char; "#"
      %%       pattern-separator %char; ";"
      %%     >
      meth 'make_xsl:locale'(E $)
         E.attribs
      end
      
      %%     <!ELEMENT xsl:template
      %%      (#PCDATA
      %%       %instructions;
      %%       %result-elements;
      %%       | xsl:param)*
      %%     >
      %%     <!ATTLIST xsl:template
      %%       match %pattern; #IMPLIED
      %%       name %qname; #IMPLIED
      %%       priority %priority; #IMPLIED
      %%       mode %qname; #IMPLIED
      %%       %space-att;
      %%     >
      meth 'make_xsl:template'(E $)
         {Default E}
      end
      
      %%     <!ELEMENT xsl:value-of EMPTY>
      %%     <!ATTLIST xsl:value-of
      %%       select %expr; #REQUIRED
      %%       disable-output-escaping (yes|no) "no"
      %%     >
      meth 'make_xsl:value-of'(E $)
         E.attribs
      end

      %%     <!ELEMENT xsl:copy-of EMPTY>
      %%     <!ATTLIST xsl:copy-of select %expr; #REQUIRED>
      meth 'make_xsl:copy-of'(E $)
         E.attribs
      end

      %%     <!ELEMENT xsl:number EMPTY>
      %%     <!ATTLIST xsl:number
      %%        level (single|multiple|any) "single"
      %%        count %pattern; #IMPLIED
      %%        from %pattern; #IMPLIED
      %%        value %expr; #IMPLIED
      %%        format %avt; '1'
      %%        lang %avt; #IMPLIED
      %%        letter-value %avt; #IMPLIED
      %%        grouping-separator%avt; #IMPLIED
      %%        grouping-size %avt; #IMPLIED
      %%     >
      meth 'make_xsl:number'(E $)
         E.attribs
      end

      %%     <!ELEMENT xsl:apply-templates (xsl:sort|xsl:with-param)*>
      %%     <!ATTLIST xsl:apply-templates
      %%       select %expr; "node()"
      %%       mode %qname; #IMPLIED
      %%     >
      meth 'make_xsl:apply-templates'(E $)
         {Default E}
      end

      %%     <!ELEMENT xsl:apply-imports EMPTY>
      meth 'make_xsl:apply-imports'(E $)
         'xsl:apply-imports'
      end
      
      %%     <!-- xsl:sort cannot occur after any other elements or
      %%     any non-whitespace character -->

      %%     <!ELEMENT xsl:for-each
      %%      (#PCDATA
      %%       %instructions;
      %%       %result-elements;
      %%       | xsl:sort)*
      %%     >
      %%     <!ATTLIST xsl:for-each
      %%       select %expr; #REQUIRED
      %%       %space-att;
      %%     >
      meth 'make_xsl:for-each'(E $)
         {Default E}
      end
      
      %%     <!ELEMENT xsl:sort EMPTY>
      %%     <!ATTLIST xsl:sort
      %%       select %expr; "."
      %%       lang %avt; #IMPLIED
      %%       data-type %avt; "text"
      %%       order %avt; "ascending"
      %%       case-order %avt; #IMPLIED
      %%     >
      meth 'make_xsl:sort'(E $)
         E.attribs
      end

      %%     <!ELEMENT xsl:if %template;>
      %%     <!ATTLIST xsl:if
      %%       test %expr; #REQUIRED
      %%       %space-att;
      %%     >
      meth 'make_xsl:if'(E $)
         {Default E}
      end
      
      %%     <!ELEMENT xsl:choose (xsl:when+, xsl:otherwise?)>
      %%     <!ATTLIST xsl:choose %space-att;>
      meth 'make_xsl:choose'(E $)
         {Default E}
      end

      %%     <!ELEMENT xsl:when %template;>
      %%     <!ATTLIST xsl:when
      %%       test %expr; #REQUIRED
      %%       %space-att;
      %%     >
      meth 'make_xsl:when'(E $)
         {Default E}
      end

      %%     <!ELEMENT xsl:otherwise %template;>
      %%     <!ATTLIST xsl:otherwise %space-att;>
      meth 'make_xsl:otherwise'(E $)
         {Default E}
      end

      %%     <!ELEMENT xsl:attribute-set (xsl:attribute)*>
      %%     <!ATTLIST xsl:attribute-set
      %%       name %qname; #REQUIRED
      %%       use-attribute-sets %qnames; #IMPLIED
      %%     >
      meth 'make_xsl:attribute-set'(E $)
         {Default E}
      end

      %%     <!ELEMENT xsl:call-template (xsl:with-param)*>
      %%     <!ATTLIST xsl:call-template
      %%       name %qname; #REQUIRED
      %%     >
      meth 'make_xsl:call-template'(E $)
         {Default E}
      end

      %%     <!ELEMENT xsl:with-param %template;>
      %%     <!ATTLIST xsl:with-param
      %%       name %qname; #REQUIRED
      %%       select %expr; #IMPLIED
      %%     >
      meth 'make_xsl:with-param'(E $)
         {Default E}
      end

      %%     <!ELEMENT xsl:variable %template;>
      %%     <!ATTLIST xsl:variable 
      %%       name %qname; #REQUIRED
      %%       select %expr; #IMPLIED
      %%     >
      meth 'make_xsl:variable'(E $)
         {Default E}
      end

      %%     <!ELEMENT xsl:param %template;>
      %%     <!ATTLIST xsl:param 
      %%       name %qname; #REQUIRED
      %%       select %expr; #IMPLIED
      %%     >
      meth 'make_xsl:param'(E $)
         {Default E}
      end

      %%     <!ELEMENT xsl:text (#PCDATA)>
      %%     <!ATTLIST xsl:text
      %%       disable-output-escaping (yes|no) "no"
      %%     >
      meth 'make_xsl:text'(E $)
         {Default E}
      end

      %%     <!ELEMENT xsl:processing-instruction %char-template;>
      %%     <!ATTLIST xsl:processing-instruction 
      %%       name %avt; #REQUIRED
      %%       %space-att;
      %%     >
      meth 'make_xsl:processing-instruction'(E $)
         {Default E}
      end

      %%     <!ELEMENT xsl:element %template;>
      %%     <!ATTLIST xsl:element 
      %%       name %avt; #REQUIRED
      %%       namespace %avt; #IMPLIED
      %%       use-attribute-sets %qnames; #IMPLIED
      %%       %space-att;
      %%     >
      meth 'make_xsl:element'(E $)
         {Default E}
      end

      %%     <!ELEMENT xsl:attribute %char-template;>
      %%     <!ATTLIST xsl:attribute 
      %%       name %avt; #REQUIRED
      %%       namespace %avt; #IMPLIED
      %%       %space-att;
      %%     >
      meth 'make_xsl:attribute'(E $)
         {Default E}
      end

      %%     <!ELEMENT xsl:comment %char-template;>
      %%     <!ATTLIST xsl:comment %space-att;>
      meth 'make_xsl:comment'(E $)
         {Default E}
      end

      %%     <!ELEMENT xsl:copy %template;>
      %%     <!ATTLIST xsl:copy
      %%       %space-att;
      %%       use-attribute-sets %qnames; #IMPLIED
      %%     >
      meth 'make_xsl:copy'(E $)
         {Default E}
      end
      
      %%     <!ELEMENT xsl:message %template;>
      %%     <!ATTLIST xsl:message %space-att;>
      meth 'make_xsl:message'(E $)
         {Default E}
      end

      %%     <!ELEMENT xsl:fallback %template;>
      %%     <!ATTLIST xsl:fallback %space-att;>
      meth 'make_xsl:fallback'(E $)
         {Default E}
      end
   end

end


