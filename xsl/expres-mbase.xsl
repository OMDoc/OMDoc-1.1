<!-- An XSL style sheet for creating xsl style sheets for presenting 
     OpenMath Symbols from OMDoc presentation elements.
     Initial version 20000824 by Michael Kohlhase, 
     send bug-reports, patches, suggestions to omdoc@mathweb.org

     Copyright (c) 2000 - 2002 Michael Kohlhase, 

     This library is free software; you can redistribute it and/or
     modify it under the terms of the GNU Lesser General Public
     License as published by the Free Software Foundation; either
     version 2.1 of the License, or (at your option) any later version.

     This library is distributed in the hope that it will be useful,
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
     Lesser General Public License for more details.

     You should have received a copy of the GNU Lesser General Public
     License along with this library; if not, write to the Free Software
     Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:exsl="http://exslt.org/common" 
  xmlns:func="http://exslt.org/functions" 
  xmlns:saxon="http://icl.com/saxon" 
  extension-element-prefixes="func saxon"
  xmlns:out="output.xsl"
  xmlns:om="http://www.openmath.org/OpenMath"
  xmlns:omdoc="http://www.mathweb.org/omdoc"
  exclude-result-prefixes="xsl"
  version="1.0">

<xsl:param name="report-errors" select="'no'"/> 

<xsl:output method="xml" version="1.0" indent="yes"/>
<xsl:strip-space elements="*"/>

<xsl:namespace-alias stylesheet-prefix="out" result-prefix="xsl"/>

<xsl:variable name="here" select="/"/>

<!-- the top-level template prints the header of the XSL style sheet. -->

<xsl:template match="/">
 <xsl:text>&#xA;&#xA;</xsl:text>
 <xsl:comment>
  An XSL style sheet for presenting OpenMath Symbols used in the 
  OpenMath Document (OMDoc) <xsl:value-of select="omdoc:omdoc/@id"/>.omdoc.
 
  This XSL style file is automatically generated from an OMDoc document, do not edit!
 </xsl:comment>
 <xsl:text>&#xA;&#xA;</xsl:text>
 <out:stylesheet version="1.0"
  extension-element-prefixes="exsl"   
  exclude-result-prefixes="omdoc">
  <xsl:text>&#xA;&#xA;</xsl:text>
  <xsl:apply-templates/>
 </out:stylesheet>
 <xsl:text>&#xA;</xsl:text>
</xsl:template>

<!-- the default action is to do nothing on OMDoc elements -->
<xsl:template match="omdoc:*"/>
<!-- except on these, which may contain 'presentation', 'omstyle', 
     or 'ref' elements, which we must take into consideration -->
<xsl:template match="omdoc:omdoc|omdoc:omgroup|omdoc:theory">
 <xsl:apply-templates/>
</xsl:template>

<!-- ref pointers are followed, if they point to external documents -->
<xsl:template match="omdoc:ref">
 <xsl:apply-templates select="omdoc:get-uriref(@xref)"/>
</xsl:template>

<!-- the template for the OMDoc presentation element produces an XSL 
     template in two parts: 
     - first it makes the pattern of the template depending on the 
       parent element, 
     - and then the body depending on fixity and brackets. 
     The parameters 'name' and 'cd' are for treating referenced presentation elements
-->
<xsl:template match="omdoc:presentation">
 <xsl:param name="name" select="@for"/>
 <xsl:param name="cd">
  <xsl:choose>
   <xsl:when test="ancestor::omdoc:theory/@id">
    <xsl:value-of select="ancestor::omdoc:theory/@id"/> 
   </xsl:when>
   <xsl:when test="@theory"><xsl:value-of select="@theory"/></xsl:when>
   <xsl:otherwise>
    <xsl:message>unable to infer theory of presentation element <xsl:value-of select="@id"/>!</xsl:message>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:param>
 <xsl:variable name="xref" select="@xref"/>
 <xsl:variable name="file" select="substring-before($xref,'#')"/>
 <xsl:variable name="id" select="substring-after($xref,'#')"/>
 <xsl:variable name="req" select="@requires"/>
 <xsl:variable name="defs" select="//omdoc:private[@id=$req]/omdoc:data"/>
 <xsl:if test="$defs!=''">
  <out:text><xsl:value-of select="$defs"/><xsl:text>&#xA;</xsl:text></out:text>
 </xsl:if>
 <xsl:variable name="style-attrib">
  <xsl:choose>
   <xsl:when test="@style">
    <xsl:text> and @style='</xsl:text><xsl:value-of select="@style"/><xsl:text>'</xsl:text>
   </xsl:when>
   <xsl:otherwise><xsl:text> and not(@style)</xsl:text></xsl:otherwise>
  </xsl:choose>
 </xsl:variable>
 <xsl:choose>
  <xsl:when test="$xref!=''">
   <xsl:apply-templates 
    select="saxon:node-set(document($file,$here)//omdoc:presentation[@id=$id])">
    <xsl:with-param name="name" select="$name"/>
    <xsl:with-param name="cd" select="$cd"/>
   </xsl:apply-templates>
  </xsl:when>
  <xsl:when test="@parent='OMA'">
   <out:template priority="1" match="om:OMA[not(@xref) and om:OMS[position()=1 and @name='{$name}' and @cd='{$cd}'{$style-attrib}]]">
    <out:param name="prec" select="1000"/>
    <xsl:call-template name="do-inner"/>
   </out:template>
  </xsl:when>
  <xsl:when test="@parent='OMBIND'">
   <out:template priority="1" match="om:OMBIND[not(@xref) and om:OMS[position()=1 and @name='{$name}' and @cd='{$cd}'{$style-attrib}]]">
    <out:param name="prec" select="1000"/>
    <xsl:call-template name="do-inner"/>
   </out:template>
  </xsl:when>
  <xsl:when test="@parent='OMATTR'">
   <out:template priority="1" match="om:OMS[@name='{$name}' and @cd='{$cd}'{$style-attrib}]" mode="{@fixity}-attribute">
    <out:variable name="pos" select="position()"/>
    <xsl:call-template name="do-inner"/>
   </out:template>
  </xsl:when>
  <xsl:otherwise>
   <out:template priority="1" match="om:OMS[@name='{$name}' and @cd='{$cd}'{$style-attrib}]">
    <xsl:call-template name="do-inner"/>
   </out:template>
  </xsl:otherwise>
 </xsl:choose>
 <xsl:text>&#xA;&#xA;</xsl:text>
</xsl:template>

<xsl:template name="do-inner">
 <xsl:choose>
  <!-- if there are formats other than 'default' -->
  <xsl:when test="*[@format!='default']">
   <out:choose>
    <saxon:group select="*[@format!='default']" group-by="@format">
     <xsl:variable name="theformat" select="@format"/>
     <xsl:call-template name="do-one-format">
      <xsl:with-param name="theformat" select="@format"/>
      <xsl:with-param name="givens" select="saxon:node-set(../*[@format=$theformat])/@xml:lang"/>
      <xsl:with-param name="langcases">
       <saxon:item>
        <xsl:if test="@xml:lang">
         <out:when test="$valid-lang='{@xml:lang}'"><xsl:apply-templates select="."/></out:when>
        </xsl:if>
       </saxon:item>
      </xsl:with-param>
      <xsl:with-param name="ocase">
       <saxon:item>
        <xsl:if test="not(@xml:lang)"><xsl:apply-templates select="."/></xsl:if>
       </saxon:item>
      </xsl:with-param>
     </xsl:call-template>
    </saxon:group>
    <xsl:choose>
     <!-- if there is a default treatment, then use it -->
     <xsl:when  test="*[@format='default']">
      <out:otherwise>
       <xsl:call-template name="do-one-format">
        <xsl:with-param name="theformat" select="'default'"/>
        <xsl:with-param name="givens" select="saxon:node-set(*[@format='default'])/@xml:lang"/>
        <xsl:with-param name="langcases">
         <xsl:for-each select="*[@format='default' and @xml:lang]">
          <out:when test="$valid-lang='{@xml:lang}'"><xsl:apply-templates select="."/></out:when>
         </xsl:for-each>
        </xsl:with-param>
        <xsl:with-param name="ocase">
         <xsl:apply-templates select="*[@format='default' and not(@xml:lang)]"/>
        </xsl:with-param>
       </xsl:call-template>
      </out:otherwise>
     </xsl:when>
     <!-- if ther is no 'default' case, use a fallback treatment defined by the 
          main stylesheet for the format-->
     <xsl:otherwise>
      <out:otherwise>
       <out:apply-templates select="." mode="fallback"/>
      </out:otherwise>
     </xsl:otherwise>
    </xsl:choose>
   </out:choose>
  </xsl:when>
  <xsl:otherwise>
   <!-- there are only format='default' treatments -->
   <xsl:choose>
    <xsl:when  test="*[@format='default']">
     <xsl:call-template name="do-one-format">
      <xsl:with-param name="theformat" select="'default'"/>
      <xsl:with-param name="givens" select="saxon:node-set(*[@format='default'])/@xml:lang"/>
      <xsl:with-param name="langcases">
       <xsl:for-each select="*[@format='default' and @xml:lang]">
        <out:when test="$valid-lang='{@xml:lang}'"><xsl:apply-templates select="."/></out:when>
       </xsl:for-each>
      </xsl:with-param>
      <xsl:with-param name="ocase">
       <xsl:apply-templates select="*[@format='default' and not(@xml:lang)]"/>
      </xsl:with-param>
     </xsl:call-template>
    </xsl:when>
    <!-- if ther is no 'default' case, use a fallback treatment defined by the 
         main stylesheet for the format-->
    <xsl:otherwise>
     <out:apply-templates select="." mode="fallback"/>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:otherwise>
 </xsl:choose>
</xsl:template>

<!-- this template generates the case for one specific format in a template. 
     it takes three parameters, 
     'theformat' is the format string, it is a |-separated list of format specifiers
     'givens' is a node-stet of languages given for this format
     'langcases' is an xslt fragment that handles the language cases -->
<xsl:template name="do-one-format">
 <xsl:param name="theformat"/>
 <xsl:param name="givens"/>
 <xsl:param name="langcases"/>
 <xsl:param name="ocase"/>
 <!-- the set of languages given for this format as a whitespace-separated list -->
 <xsl:variable name="given">
  <xsl:text>'</xsl:text>
  <xsl:for-each select="$givens">
   <xsl:value-of select="."/>
   <xsl:if test="position()!=last()"><xsl:text> </xsl:text></xsl:if>
  </xsl:for-each>
  <xsl:text>'</xsl:text>
 </xsl:variable>
 <xsl:variable name="inner">
  <xsl:choose>
   <xsl:when test="$langcases!=''">
    <out:variable name="valid-lang" select="omdoc:comp-valid-language({$given},$TargetLanguage)"/>
    <out:choose>
     <xsl:copy-of select="$langcases"/>
     <out:otherwise>
      <xsl:choose>
       <xsl:when test="count($ocase) &gt; 0"><xsl:copy-of select="$ocase"/></xsl:when>
       <xsl:otherwise>
        <out:message>presentation lacks fallback case.</out:message>
       </xsl:otherwise>
      </xsl:choose>
     </out:otherwise>
    </out:choose>
   </xsl:when>
   <xsl:when test="count($ocase) &gt; 0"><xsl:copy-of select="$ocase"/></xsl:when>
   <xsl:otherwise>
    <out:message>presentation lacks fallback case.</out:message>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:variable>
 <xsl:choose>
  <xsl:when test="$theformat!='default'">
   <out:when test="{omdoc:format-disjunction($theformat)}">
    <xsl:copy-of select="$inner"/>
   </out:when>
  </xsl:when>
  <xsl:otherwise><xsl:copy-of select="$inner"/></xsl:otherwise>
 </xsl:choose>
</xsl:template>

<xsl:template match="omdoc:use[../@parent='OMA' or ../@parent='OMBIND']">
 <xsl:variable name="fixity" select="omdoc:fixity()"/>
 <xsl:choose>
  <xsl:when test="$fixity='prefix' or $fixity='postfix'">
   <xsl:call-template name="print-prepost"/>
  </xsl:when>
  <xsl:when test="$fixity='infix'"><xsl:call-template name="print-infix"/></xsl:when>
  <xsl:when test="$fixity='assoc'"><xsl:call-template name="print-assoc"/></xsl:when>
  <xsl:otherwise><xsl:message>Unrecognized fixity!</xsl:message></xsl:otherwise>
 </xsl:choose>
</xsl:template>

<xsl:template match="omdoc:use[../@parent='OMATTR']">
 <xsl:if test="omdoc:bracket-style()='lisp'"><xsl:call-template name="print-lbrack"/></xsl:if>
 <xsl:call-template name="print-crossref-symbol"/>
 <xsl:if test="omdoc:bracket-style()='math'"><xsl:call-template name="print-lbrack"/></xsl:if>
 <xsl:if test="@larg-group!=''">
  <out:text disable-output-escaping="yes"><xsl:value-of select="@larg-group"/></out:text>
 </xsl:if>
 <out:apply-templates select="../*[position()=$pos+1]"/>
 <xsl:if test="@rarg-group!=''">
  <out:text disable-output-escaping="yes"><xsl:value-of select="@rarg-group"/></out:text>
 </xsl:if>
 <xsl:call-template name="print-rbrack"/>
</xsl:template>

<xsl:template match="omdoc:use[not(../@parent)]">
  <xsl:call-template name="print-crossref-symbol"/>
</xsl:template>

<!-- This template composes the treatment for an argument of a
     function. It basically takes care of the argument bracketing
     specified in larg-group and rarg-group. -->
<xsl:template name="do-arg">
 <xsl:param name="path"/>
 <xsl:if test="@larg-group!=''">
  <out:text disable-output-escaping="yes"><xsl:value-of select="@larg-group"/></out:text>
 </xsl:if>
 <out:apply-templates select="{$path}">
  <xsl:if test="../@precedence"><out:with-param name="prec" select="{../@precedence}"/></xsl:if>
 </out:apply-templates>
 <xsl:if test="@rarg-group">
  <out:text disable-output-escaping="yes"><xsl:value-of select="@rarg-group"/></out:text>
 </xsl:if>
</xsl:template>


<xsl:template match="omdoc:presentation/omdoc:xslt">
 <xsl:value-of select="." disable-output-escaping="yes"/>
</xsl:template>

<xsl:template match="omdoc:omstyle/omdoc:xslt">
 <out:when test="{omdoc:format-disjunction(@format)}">
  <xsl:apply-templates/>
 </out:when>
</xsl:template>

<!-- the next set of templates prints the crossref-symbol, i.e. if the 
     crossref-symbol switch is 't', then it constructs the crossref, 
     whereever possible, (depending on the format).
     It calls the template 'print-symbol' with the right format, so that this
     can be overwritten by another style sheet  -->

<xsl:template name="print-crossref-symbol">
 <xsl:variable name="cd" select="../../@id"/>
 <xsl:variable name="name" select="../@for"/>
 <!-- <xsl:message>Print-crossref-symbol(<xsl:value-of select="$name"/>,<xsl:value-of select="@format"/>)=<xsl:value-of select="string(.)"/></xsl:message>-->
 <xsl:variable name="sym">
  <xsl:if test="string(.)!=''">
   <out:call-template name="print-symbol">
    <out:with-param name="print-form">
     <xsl:value-of disable-output-escaping="yes" select="."/>
    </out:with-param>
    <out:with-param name="crossref-symbol" select="'{omdoc:crossref-symbol()}'"/>
    <out:with-param name="uri" select="'showSymbol?name={$name}&amp;cd={$cd}'"/>
   </out:call-template>
  </xsl:if>
 </xsl:variable>
 <xsl:choose>
  <xsl:when test="@element and string(.)!='' and not(../@parent)">
   <xsl:copy-of select="omdoc:start-tag(@element,@attributes)"/>
   <xsl:copy-of select="$sym"/>
   <xsl:copy-of select="omdoc:end-tag(@element)"/>
  </xsl:when>
  <xsl:when test="@element and string(.)='' and not(../@parent)">
   <xsl:copy-of select="omdoc:empty-element(@element,@attributes)"/>
  </xsl:when>
  <xsl:otherwise>
   <xsl:copy-of select="$sym"/>
  </xsl:otherwise>
 </xsl:choose>
</xsl:template>

<!-- the next template makes style sheet stuff for printing a 
     function of on n arguments, depending on the fixity, bracket-style,
     and separator attributes:
     prefix and lisp:  (f 1 2 3)
     postfix and lisp: (1 2 3 f)
     prefix and math:  f(1,2,3)
     postfix and math: (1,2,3)f -->

<xsl:template name="print-prepost">
 <out:call-template name="barg-group"/>
 <xsl:if test="omdoc:fixity()='prefix'">
  <xsl:if test="omdoc:bracket-style()='lisp'"><xsl:call-template name="print-lbrack"/></xsl:if>
  <xsl:call-template name="print-crossref-symbol"/>
 </xsl:if>
 <xsl:if test="omdoc:bracket-style()='math' or omdoc:fixity()='postfix'">
  <xsl:call-template name="print-lbrack"/>
 </xsl:if>
 <out:for-each select="*[position()!=1]">
  <xsl:call-template name="do-arg">
   <xsl:with-param name="path" select="'.'"/>
  </xsl:call-template>
  <out:if test="position()!=last()">
   <out:text disable-output-escaping="yes"><xsl:value-of select="../@separator"/></out:text>
  </out:if>
 </out:for-each>
 <xsl:if test="omdoc:bracket-style()='math' or omdoc:fixity()='prefix'">
  <xsl:call-template name="print-rbrack"/>
 </xsl:if>
 <xsl:if test="omdoc:fixity()='postfix'">
  <xsl:call-template name="print-crossref-symbol"/>
  <xsl:if test="omdoc:bracket-style()='lisp'"><xsl:call-template name="print-rbrack"/></xsl:if>
 </xsl:if>
 <out:call-template name="earg-group"/>
</xsl:template>

<xsl:template name="print-assoc">
 <out:call-template name="barg-group"/>
 <xsl:call-template name="print-lbrack"/>
 <out:for-each select="*[position()!=1]">
  <xsl:call-template name="do-arg">
   <xsl:with-param name="path" select="'.'"/>
  </xsl:call-template>
  <out:if test="position()!=last()">
   <xsl:call-template name="print-crossref-symbol"/>
  </out:if>
 </out:for-each>
 <xsl:call-template name="print-rbrack"/>
 <out:call-template name="earg-group"/>
</xsl:template>


<xsl:template name="print-infix">
 <out:call-template name="barg-group"/>
 <xsl:call-template name="print-lbrack"/>
 <xsl:call-template name="do-arg">
  <xsl:with-param name="path" select="'*[2]'"/>
 </xsl:call-template>
 <xsl:call-template name="print-crossref-symbol"/>
 <xsl:call-template name="do-arg">
  <xsl:with-param name="path" select="'*[3]'"/>
 </xsl:call-template>
 <xsl:call-template name="print-rbrack"/>
 <out:call-template name="earg-group"/>
</xsl:template>

<!-- the next templates makes the style sheet stuff for printing a bracket -->
<xsl:template name="print-rbrack">
 <xsl:choose>
  <xsl:when test="@element"><xsl:copy-of select="omdoc:end-tag(@element)"/></xsl:when>
  <xsl:when test="../@precedence">
   <out:if test="not($prec &gt;{../@precedence})"><xsl:call-template name="print-rbrack-inner"/></out:if>
  </xsl:when>
  <xsl:otherwise><xsl:call-template name="print-rbrack-inner"/></xsl:otherwise>
 </xsl:choose>
</xsl:template>

<xsl:template name="print-lbrack">
 <xsl:choose>
  <xsl:when test="@element">
   <xsl:copy-of select="omdoc:start-tag(@element,@attributes)"/>
  </xsl:when>
  <xsl:when test="../@precedence">
   <out:if test="not($prec &gt;{../@precedence})"><xsl:call-template name="print-lbrack-inner"/></out:if>
  </xsl:when>
  <xsl:otherwise><xsl:call-template name="print-lbrack-inner"/></xsl:otherwise>
 </xsl:choose>
</xsl:template>

<xsl:template name="print-lbrack-inner">
 <xsl:variable name="open">
  <xsl:choose>
   <xsl:when test="@lbrack=''"><xsl:value-of select="''"/></xsl:when>
   <xsl:when test="not(@lbrack)"><xsl:value-of select="../@lbrack"/></xsl:when>
   <xsl:otherwise><xsl:value-of select="@lbrack"/></xsl:otherwise>
  </xsl:choose>
 </xsl:variable>
 <xsl:if test="$open!=''">
  <out:call-template name="print-fence">
   <out:with-param name="fence"><xsl:value-of select="$open"/></out:with-param>
  </out:call-template>
 </xsl:if>
</xsl:template>

<xsl:template name="print-rbrack-inner">
 <xsl:variable name="close">
  <xsl:choose>
   <xsl:when test="@rbrack=''"><xsl:value-of select="''"/></xsl:when>
   <xsl:when test="not(@rbrack)"><xsl:value-of select="../@rbrack"/></xsl:when>
   <xsl:otherwise><xsl:value-of select="@rbrack"/></xsl:otherwise>
  </xsl:choose>
 </xsl:variable>
 <xsl:if test="$close!=''">
  <out:call-template name="print-fence">
   <out:with-param name="fence"><xsl:value-of select="$close"/></out:with-param>
  </out:call-template>
 </xsl:if>
</xsl:template>

<!-- the template for the OMDoc style element produces anL template -->
<xsl:template match="omdoc:omstyle">
 <out:template match="omdoc:{@element}[@style='{@style}']">
  <out:choose>
   <xsl:apply-templates/>
   <out:otherwise>
    <out:apply-templates select="." mode="fallback"/>
   </out:otherwise>
  </out:choose>
 </out:template>
 <xsl:text>&#xA;&#xA;</xsl:text>
</xsl:template>

<!-- we give the right namespace for the element elements -->
<xsl:template match="omdoc:presentation/omdoc:style">
 <xsl:choose>
  <xsl:when test="contains(@format,'html')">
   <xsl:apply-templates>
    <xsl:with-param name="xmlns" select="'http://www.w3.org/1999/xhtml'"/>     
   </xsl:apply-templates>
  </xsl:when>
  <xsl:when test="contains(@format,'pmml')">
   <xsl:apply-templates>
    <xsl:with-param name="xmlns" select="'http://www.w3.org/1998/Math/MathML'"/>
   </xsl:apply-templates>
  </xsl:when>
  <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
 </xsl:choose>
</xsl:template>

<!-- we give the right namespace for the element elements -->
<xsl:template match="omdoc:omstyle/omdoc:style">
 <out:when test="{omdoc:format-disjunction(@format)}">
  <xsl:choose>
   <xsl:when test="contains(@format,'html') or contains(@format,'pmml')">
    <xsl:apply-templates>
     <xsl:with-param name="xmlns" select="'http://www.w3.org/1999/xhtml'"/>     
    </xsl:apply-templates>
   </xsl:when>
   <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
  </xsl:choose>
 </out:when>
</xsl:template>

<xsl:template match="omdoc:element">
 <xsl:param name="xmlns"/>
 <xsl:choose>
  <xsl:when test="$xmlns!=''">
   <out:element name="{@name}" namespace="{$xmlns}">
    <xsl:apply-templates><xsl:with-param name="xmlns" select="$xmlns"/></xsl:apply-templates>
   </out:element>
  </xsl:when>
  <xsl:otherwise><out:element name="{@name}"><xsl:apply-templates/></out:element></xsl:otherwise>
 </xsl:choose>
</xsl:template>

<xsl:template match="omdoc:text">
 <out:text disable-output-escaping="yes"><xsl:apply-templates/></out:text>
</xsl:template>

<xsl:template match="omdoc:attribute">
 <out:attribute name="{@name}"><xsl:apply-templates/></out:attribute>
</xsl:template>

<xsl:template match="omdoc:value-of">
 <out:value-of select="{@select}"/>
</xsl:template>

<xsl:template match="omdoc:recurse">
 <xsl:choose>
  <xsl:when test="@select">
   <out:apply-templates select="{@select}">
    <xsl:if test="ancestor::omdoc:presentation[@precedence]">
     <out:with-param name="prec" select="{ancestor::omdoc:presentation/@precedence}"/>
    </xsl:if>
   </out:apply-templates>
  </xsl:when>
  <xsl:otherwise>
   <out:apply-templates>
    <xsl:if test="ancestor::omdoc:presentation[@precedence]">
     <out:with-param name="prec" select="{ancestor::omdoc:presentation/@precedence}"/>
    </xsl:if>
   </out:apply-templates>
  </xsl:otherwise>
 </xsl:choose>
</xsl:template>

<!-- the next set of functions compute the valid attribute value, taking into account that 
     the attributes on the 'use' element overwrite the ones on the 'presentation' element -->
<func:function name="omdoc:bracket-style">
 <xsl:choose>
  <xsl:when test="@bracket-style"><func:result select="@bracket-style"/></xsl:when>
  <xsl:otherwise><func:result select="../@bracket-style"/></xsl:otherwise>
 </xsl:choose>
</func:function>

<func:function name="omdoc:fixity">
 <xsl:choose>
  <xsl:when test="@fixity"><func:result select="@fixity"/></xsl:when>
  <xsl:otherwise><func:result select="../@fixity"/></xsl:otherwise>
 </xsl:choose>
</func:function>

<func:function name="omdoc:start-tag">
 <xsl:param name="element"/>
 <xsl:param name="attributes"/>
 <func:result>
  <out:text disable-output-escaping="yes">
   <xsl:text>&lt;</xsl:text>
   <xsl:value-of select="$element"/>
   <xsl:if test="$attributes!=''">
    <xsl:text> </xsl:text>
    <xsl:value-of select="$attributes" disable-output-escaping="yes"/>
   </xsl:if>
   <xsl:text>&gt;</xsl:text>
  </out:text>
 </func:result>
</func:function>

<func:function name="omdoc:empty-element">
 <xsl:param name="element"/>
 <xsl:param name="attributes"/>
 <func:result>
  <out:text disable-output-escaping="yes">
   <xsl:text>&lt;</xsl:text>
   <xsl:value-of select="$element"/>
   <xsl:if test="$attributes!=''">
    <xsl:text> </xsl:text>
    <xsl:value-of select="$attributes" disable-output-escaping="yes"/>
   </xsl:if>
   <xsl:text>/&gt;</xsl:text>
  </out:text>
 </func:result>
</func:function>

<func:function name="omdoc:end-tag">
 <xsl:param name="element"/>
 <func:result>
  <out:text disable-output-escaping="yes">
   <xsl:text>&lt;/</xsl:text><xsl:value-of select="$element"/><xsl:text>&gt;</xsl:text>
  </out:text>
 </func:result>
</func:function>

<func:function name="omdoc:crossref-symbol">
 <xsl:choose>
  <xsl:when test="@crossref-symbol"><func:result select="@crossref-symbol"/></xsl:when>
  <xsl:otherwise><func:result select="../@crossref-symbol"/></xsl:otherwise>
 </xsl:choose>
</func:function>

<func:function name="omdoc:format-disjunction">
 <xsl:param name="theformat"/>
 <xsl:choose>
  <xsl:when test="contains($theformat,'|')">
   <func:result>
    <xsl:text>$format='</xsl:text>
    <xsl:value-of select="substring-before($theformat,'|')"/>
    <xsl:text>' or </xsl:text>
    <xsl:value-of select="omdoc:format-disjunction(substring-after($theformat,'|'))"/>
   </func:result>
  </xsl:when>
  <xsl:otherwise>
   <func:result>
    <xsl:text>$format='</xsl:text>
    <xsl:value-of select="$theformat"/>
    <xsl:text>'</xsl:text>
   </func:result>
  </xsl:otherwise>
 </xsl:choose>
</func:function>
</xsl:stylesheet>




