<?xml version="1.0" encoding="utf-8"?>
<!-- An XSL style sheet for creating human-oriented output from 
     OMDoc (Open Mathematical Documents). It forms the basis for 
     the style sheets transforming OMDoc into html, mathml, TeX, 
     and Mathematica notebooks.
     URL: http://www.mathweb.org/omdoc/xsl/omdoc2share.xsl
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


<!-- Remarks: -->
<!-- 1.) Language-dependant elements are: 
         - CMP
         - commonname
         - dc:Title 
         - dc:Subject
         - dc:Description
         - dc:Translator
-->
<xsl:stylesheet 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:func="http://exslt.org/functions" 
 extension-element-prefixes="func"
 xmlns:om="http://www.openmath.org/OpenMath"
 xmlns:dc="http://purl.org/DC"
 xmlns:omdoc="http://www.mathweb.org/omdoc"
 exclude-result-prefixes="om dc"
 version="1.0">  

<xsl:import href="omdocutils.xsl"/>
<xsl:strip-space elements="*"/>

<!-- =============================== -->
<!-- declaration of input parameters -->
<!-- =============================== -->

<!-- 'TargetLanguage': default is en for xml:lang-attribute in 
     omdoc-output. It consists of whitespace separated, ordered list 
     of languages (example-call: TargetLanguage="en de fr")
     It is also valid in the imported stylesheets! 
     -->
<xsl:param name="TargetLanguage" select="'en'"/>

<!--<xsl:param name="locale" select="'http://www.mathweb.org/src/mathweb/omdoc/lib/locale-default.xml'"/>-->
<xsl:param name="locale" select="'../lib/locale-default.xml'"/>
<xsl:param name="report-errors" select="'no'"/> 

<!-- global variables -->
<xsl:variable name="here" select="/"/>
<!-- ============= omdoc basics ============= -->
<xsl:template match="*"/>

<!-- The root: Get the title and apply the omdoc-template 
     we do the title work here, since otherwise the \begin/end{document}
     show up when working on ref[@type='include'] nodes.-->
<xsl:template match="/">
  <xsl:if test="omdoc:omdoc/@version!='1.1'">
    <xsl:message>WARNING: applying an OMDoc 1.1 style sheet to an OMDoc <xsl:value-of select="omdoc:omdoc/@version"/> document!
    This need not be a problem, but can lead to unintened results.
    </xsl:message>
  </xsl:if>
  <xsl:text>&#xA;&#xA;</xsl:text>
  <xsl:comment>
    <xsl:call-template name="localize">
      <xsl:with-param name="key" select="'boilerplate'"/>
    </xsl:call-template>
  </xsl:comment>
  <xsl:text>&#xA;&#xA;</xsl:text>
  <xsl:call-template name="with-document">
    <xsl:with-param name="content">
      <xsl:call-template name="with-style">
        <xsl:with-param name="class" select="'titleblock'"/>
        <xsl:with-param name="display" select="'div'"/>
        <xsl:with-param name="content">
          <xsl:call-template name="titleblock">
            <xsl:with-param name="display" select="'div'"/>
          </xsl:call-template>
        </xsl:with-param>
      </xsl:call-template>
      <xsl:text>&#xA;&#xA;</xsl:text>
      <!-- we recurse skipping the level of omdoc, so we do not get the metadata
           information from this. -->
      <xsl:apply-templates select="omdoc:omdoc/*[local-name()!='metadata']">
        <xsl:with-param name="level" select="0"/>
        <xsl:with-param name="prefix" select="''"/>
      </xsl:apply-templates>
      <xsl:text>&#xA;&#xA;</xsl:text>
    </xsl:with-param>
  </xsl:call-template>
  <xsl:text>&#xA;</xsl:text>
</xsl:template>

<xsl:template name="titleblock">
  <xsl:param name="display" select="'div'"/>
  <xsl:param name="md" select="/omdoc:omdoc/omdoc:metadata"/>
  <xsl:call-template name="with-style">
    <xsl:with-param name="class" select="'title'"/>
    <xsl:with-param name="display" select="$display"/>
    <xsl:with-param name="content">
      <xsl:choose>
        <xsl:when test="$md/dc:Title">
          <xsl:apply-templates select="$md/dc:Title"/>
        </xsl:when>
        <xsl:otherwise><xsl:text>No Title Specified</xsl:text></xsl:otherwise>
      </xsl:choose>
    </xsl:with-param>
  </xsl:call-template>
  <xsl:call-template name="with-style">
    <xsl:with-param name="class" select="'authors'"/>
    <xsl:with-param name="display" select="$display"/>
    <xsl:with-param name="content">
      <xsl:choose>
        <xsl:when test="count($md/dc:Creator)&gt;0">
          <xsl:for-each select="$md/dc:Creator">
            <xsl:apply-templates/>
            <xsl:if test="position()!=last()"><xsl:text>, </xsl:text></xsl:if>
          </xsl:for-each>	
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>No Author Specified</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:with-param>
  </xsl:call-template>
    <xsl:if test="$md/dc:Date">
      <xsl:call-template name="with-style">
        <xsl:with-param name="class" select="'date'"/>
        <xsl:with-param name="display" select="$display"/>
        <xsl:with-param name="content">
          <xsl:value-of select="$md/dc:Date"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$md/dc:Subject">
      <xsl:call-template name="with-style">
        <xsl:with-param name="class" select="'subject'"/>
        <xsl:with-param name="display" select="$display"/>
        <xsl:with-param name="content">
          <xsl:value-of select="$md/dc:Subject"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="$md/dc:Description">
      <xsl:call-template name="with-style">
        <xsl:with-param name="class" select="'description'"/>
        <xsl:with-param name="display" select="$display"/>
        <xsl:with-param name="content">
          <xsl:value-of select="$md/dc:Description"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:if>
</xsl:template>

<xsl:template name="with-document">
  <xsl:param name="content"/>
  <!-- put the document initialization here -->
  <xsl:copy-of select="$content"/>
  <!-- put the document tail here -->
</xsl:template>

<xsl:template name="with-style">
  <xsl:param name="class"/> <!-- not considered here -->
  <xsl:param name="display"/> <!-- not considered here -->
  <xsl:param name="content"/>
  <xsl:copy-of select="$content"/>
</xsl:template>

<xsl:template match="omdoc:omdoc">
  <xsl:param name="level" select="0"/>
  <xsl:param name="prefix" select="''"/>
  <xsl:apply-templates>
    <xsl:with-param name="level" select="$level"/>
    <xsl:with-param name="prefix" select="$prefix"/>
  </xsl:apply-templates>
</xsl:template>

<!-- the omgroups only recurse, the templates for metadata do 
     the work of computing the sections -->
<xsl:template match="omdoc:omgroup">
  <xsl:param name="level"/>
  <xsl:param name="prefix"/>
  <xsl:variable name="number" select="omdoc:new-number($level,$prefix)"/>
  <xsl:apply-templates select="omdoc:metadata">
    <xsl:with-param name="level" select="$level"/>
    <xsl:with-param name="prefix" select="$number"/>
  </xsl:apply-templates>
  <xsl:apply-templates select="*[not(self::omdoc:metadata)]">
    <xsl:with-param name="level" select="$level + 1"/>
    <xsl:with-param name="prefix" select="$number"/>
  </xsl:apply-templates>
</xsl:template>

<xsl:template match="omdoc:ref[@type='include']">
 <xsl:param name="level"/>
 <xsl:param name="prefix"/>
 <xsl:variable name="number" select="omdoc:new-number($level,$prefix)"/>
 <xsl:variable name="doc" select="omdoc:get-uriref(@xref)"/>
 <xsl:apply-templates select="$doc/omdoc:metadata">
   <xsl:with-param name="level" select="$level"/>
   <xsl:with-param name="prefix" select="$number"/>
 </xsl:apply-templates>
 <xsl:apply-templates select="$doc/*[not(self::omdoc:metadata)]">
  <xsl:with-param name="level" select="$level + 1"/>
  <xsl:with-param name="prefix" select="omdoc:new-number($level,$prefix)"/>
 </xsl:apply-templates>
</xsl:template>

<xsl:template match="omdoc:ref[@type='cite']">
 <xsl:variable name="xref" select="@xref"/>
 <xsl:choose>
  <xsl:when test="omdoc:local-uri($xref)">
   <xsl:value-of select="$xref"/>
  </xsl:when>
  <xsl:otherwise>
   <xsl:value-of select="document(omdoc:url($xref),$here)/omdoc:omdoc/@id"/>
  </xsl:otherwise>
 </xsl:choose>
</xsl:template>

<xsl:template match="omdoc:metadata">
  <!-- just forwarding ... -->
  <!-- Remark: Since the metadata are language-dependant, 
       this named template contains "apply-templates" -->
  <xsl:call-template name="insert-simple-metadata"/>
</xsl:template>

<!-- ====================== Dublin Core Metadata ====================== -->

<xsl:template match="dc:Title|dc:Subject|dc:Description|dc:Source">
  <xsl:variable name="valid_language">
    <xsl:call-template name="test-valid-language"/>
  </xsl:variable>
  <xsl:if test="$valid_language='true'">
    <xsl:apply-templates/>
  </xsl:if>
</xsl:template>





<!-- =========== Text Elements =========== -->


<xsl:template match="omdoc:omtext">
  <xsl:variable name="type">
    <xsl:if test="@type!='general' and @type!='linkage'">
      <xsl:value-of select="@type"/>
    </xsl:if>
  </xsl:variable>
  <xsl:call-template name="with-formenv">
    <xsl:with-param name="type" select="$type"/>
    <xsl:with-param name="content">
      <xsl:apply-templates select="omdoc:CMP"/>
    </xsl:with-param>
  </xsl:call-template>
</xsl:template>


<xsl:template match="omdoc:CMP">
  <xsl:variable name="valid_language">
    <xsl:call-template name="test-valid-language"/>
  </xsl:variable>
  <xsl:if test="$valid_language='true'"><xsl:apply-templates/></xsl:if>
</xsl:template>


<xsl:template match="omdoc:with" mode="fallback"><xsl:apply-templates/></xsl:template>
<xsl:template match="omdoc:with"><xsl:apply-templates select="." mode="fallback"/></xsl:template>

<xsl:template match="omdoc:omgroup[@type='sequence']">
 <xsl:param name="level"/>
 <xsl:param name="prefix"/>
 <xsl:apply-templates select="omdoc:metadata">
   <xsl:with-param name="level" select="$level"/>
   <xsl:with-param name="prefix" select="omdoc:new-number($level,$prefix)"/>
 </xsl:apply-templates>
 <xsl:call-template name="with-list">
   <xsl:with-param name="content">
     <xsl:for-each select="child::node()[not(self::omdoc:metadata)]">
       <xsl:call-template name="with-list">
         <xsl:with-param name="content">
           <xsl:apply-templates select=".">
             <xsl:with-param name="level" select="$level + 1"/>
             <xsl:with-param name="prefix" select="omdoc:new-number($level,$prefix)"/>
           </xsl:apply-templates>
           <!--    <xsl:value-of select="."/> -->
         </xsl:with-param>
       </xsl:call-template>
     </xsl:for-each>
   </xsl:with-param>
 </xsl:call-template>
</xsl:template>

<xsl:template match="omdoc:omgroup[@type='itemize']">
  <xsl:param name="level"/>
  <xsl:param name="prefix"/>
  <xsl:call-template name="with-unordered-list">
    <xsl:with-param name="content">
      <xsl:for-each select="child::node()[not(self::omdoc:metadata)]">
        <xsl:variable name="content">
          <xsl:apply-templates select=".">
            <xsl:with-param name="level" select="$level + 1"/>
            <xsl:with-param name="prefix" select="omdoc:new-number($level,$prefix)"/>
          </xsl:apply-templates>
        </xsl:variable>
        <xsl:choose>
          <xsl:when test="not(self::omdoc:omgroup)">
            <xsl:call-template name="with-item">
              <xsl:with-param name="content" select="$content"/>
            </xsl:call-template>
          </xsl:when>
          <xsl:otherwise>
            <!-- If an omgroup is contained in an itemized group, 
                 then the heuristic approach is that the group is a
                 subgroup of the preceding item and has to be indented --> 
            <xsl:call-template name="with-unordered-list">      
              <xsl:with-param name="content" select="$content"/>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:for-each>
    </xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template match="omdoc:omgroup[@type='enumeration']">
  <xsl:param name="level"/>
  <xsl:param name="prefix"/>
  <xsl:apply-templates select="omdoc:metadata">
    <xsl:with-param name="level" select="$level + 1"/>
    <xsl:with-param name="prefix" select="omdoc:new-number($level,$prefix)"/>
  </xsl:apply-templates>
  <xsl:call-template name="with-list">
    <xsl:with-param name="content">
      <xsl:for-each select="child::node()[not(self::omdoc:metadata)]">
        <xsl:call-template name="with-item">
          <xsl:with-param name="content">
            <xsl:apply-templates select=".">
              <xsl:with-param name="level" select="$level + 1"/>
              <xsl:with-param name="prefix" select="omdoc:new-number($level,$prefix)"/>
            </xsl:apply-templates>
         </xsl:with-param>
       </xsl:call-template>
     </xsl:for-each>
   </xsl:with-param>
 </xsl:call-template>
</xsl:template>


<!-- we generally ingore 'ignore' elements -->
<xsl:template match="ignore"/>


<!-- ================= om:-matches ============================ -->
<!-- now comes the presentation for the generic OpenMath elements,
     we begin with those that have an 'xref' attribute. -->
<!-- If there is an xref attribute, we just apply the templates to the object referenced -->
<xsl:template match="om:OMATTR[@xref]|om:OMB[@xref]|om:OMF[@xref]|om:OMA[@xref]|
                     om:OMBIND[@xref]|om:OMI[@xref]|om:OMSTR[@xref]|om:OMOBJ[@xref]">
  <xsl:param name="id"/>
  <xsl:variable name="ref" select="@xref"/>
  <xsl:apply-templates select="//*[@id=$ref]">
    <xsl:with-param name="id" select="$id"/>
  </xsl:apply-templates>
</xsl:template>

<!-- for all those that do not have xref, we have to define fallback templates.
     Unfortunately, we have to define two (xslt sucks for modes) for OMA, OMBIND, OMATTR
     - one without mode so that if there is no presentation at all for a symbol, 
       then this one can be applied
     - one with mode 'fallback', which can be called from the template generated by 
       expres.xsl. There we cannot just call the one without mode, since that would 
       result in an empty loop. -->
<xsl:template match="om:OMI[not(@xref)]|om:OMSTR[not(@xref)]">
 <xsl:apply-templates/>
</xsl:template>

<xsl:template match="om:OMOBJ[not(@xref)]">
 <xsl:apply-templates/>
</xsl:template>

<xsl:template match="om:OMA[not(@xref)]">
 <xsl:apply-templates select="." mode="fallback"/>
</xsl:template>

<xsl:template match="om:OMA" mode="fallback">
  <xsl:apply-templates select="*[1]"/>
  <xsl:text>(</xsl:text>
  <xsl:for-each select="*[position()!=1]">
    <xsl:apply-templates select="."/>
    <xsl:if test="position()!=last()"><xsl:text>,</xsl:text></xsl:if>
  </xsl:for-each>
  <xsl:text>)</xsl:text>
</xsl:template>

<xsl:template match="om:OMBIND[not(@xref)]">
  <xsl:apply-templates select="." mode="fallback"/>
</xsl:template>
<xsl:template match="om:OMBIND" mode="fallback">
  <xsl:text>(</xsl:text><xsl:apply-templates/><xsl:text>)</xsl:text>
</xsl:template>

<xsl:template match="om:OMF[not(@xref)]">
  <xsl:choose>
    <xsl:when test="@dec">
      <xsl:value-of select="format-number(@dec,'#')"/>
    </xsl:when>
    <xsl:when test="@hex">
      <xsl:value-of select="format-number(@hex,'#')"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="warning">
        <xsl:with-param name="string"
          select="'Must have xref, dec, or hex attribute to present an OMF'"/>
      </xsl:call-template>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="om:OMATTR[not(@xref)]">
 <!-- we process the attributes that act before -->
 <xsl:apply-templates select="om:OMATP/om:OMS[position() mod 2 =1]" mode="prefix-attribute"/>
 <!-- we process the body -->
 <xsl:apply-templates select="*[2]"/>
 <!-- we process the attributes that act after -->
 <xsl:apply-templates select="om:OMATP/om:OMS[(position() mod 2) = 1]" mode="postfix-attribute"/>
</xsl:template>

<!-- the fallback behavior for attributes is to do nothing -->
<xsl:template match="om:OMS" mode="prefix-attribute"/>
<xsl:template match="om:OMS" mode="postfix-attribute"/>

<xsl:template match="om:OMB[not(@xref)]">
  <xsl:call-template name="warning">
    <xsl:with-param name="string" select="'Not formatting OM Byte Array element!'"/>
  </xsl:call-template>
</xsl:template>

<!-- now come the elements that do not have an 'xref' attribute 
     per definitionem -->
<xsl:template name="do-OMS">
 <xsl:variable name="uri">
  <xsl:text>#</xsl:text><xsl:value-of select="@name"/>
 </xsl:variable>
 <xsl:call-template name="print-symbol">
  <xsl:with-param name="print-form"><xsl:value-of select="@name"/></xsl:with-param>
  <xsl:with-param name="uri">
   <xsl:value-of select="$uri"/>
  </xsl:with-param>
 </xsl:call-template>
</xsl:template>
<xsl:template match="om:OMS"><xsl:call-template name="do-OMS"/></xsl:template>
<xsl:template match="om:OMS" mode="fallback"><xsl:call-template name="do-OMS"/></xsl:template>

<xsl:template match="om:OMV"><xsl:call-template name="do-print-variable"/></xsl:template>

<xsl:template match="om:OMBVAR">
 <xsl:for-each select="*">
  <xsl:apply-templates select="."/>
  <xsl:if test="position()!=last()"><xsl:text>,</xsl:text></xsl:if>
 </xsl:for-each>
 <xsl:text>.</xsl:text>
</xsl:template>

<xsl:template match="om:OME">
  <xsl:text>OM Error</xsl:text>
  <xsl:call-template name="warning">
    <xsl:with-param name="string" select="'Not formatting OM Error element'"/>
  </xsl:call-template>
</xsl:template>




<!-- ================= mode "locale" ========================== -->
<xsl:template match="key/value" mode="locale">
  <xsl:variable name="valid_language">
    <xsl:call-template name="test-valid-language"/>
  </xsl:variable>
  <xsl:if test="$valid_language='true'">
    <xsl:apply-templates mode="locale"/>
  </xsl:if>
</xsl:template>


<!-- =========== Math Elements =========== -->

<xsl:template match="omdoc:assumption|omdoc:conclusion">
  <xsl:call-template name="localize-self"/>
</xsl:template>

<xsl:template match="omdoc:FMP">
  <xsl:choose>
    <xsl:when test="om:OMOBJ"><xsl:call-template name="localize-self"/></xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="do-nl"/>
      <xsl:call-template name="localize">
        <xsl:with-param name="key" select="'FMP'"/>
      </xsl:call-template><xsl:text>: </xsl:text>
      <xsl:for-each select="omdoc:assumption">
        <xsl:apply-templates select="om:OMOBJ">
          <xsl:with-param name="id" select="@id"/>
        </xsl:apply-templates>
        <xsl:if test="position()!=last()"><xsl:text>, </xsl:text></xsl:if>
      </xsl:for-each>
      <xsl:text>|-</xsl:text>
      <xsl:apply-templates select="omdoc:conclusion/om:OMOBJ"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="omdoc:assertion">
 <xsl:call-template name="with-formenv">
  <xsl:with-param name="type" select="@type"/>
  <xsl:with-param name="content"><xsl:apply-templates/></xsl:with-param>
 </xsl:call-template>
</xsl:template>

<xsl:template match="omdoc:proof">
  <xsl:call-template name="with-formenv">
    <xsl:with-param name="content">
      <xsl:apply-templates select="omdoc:CMP"/>
      <xsl:call-template name="with-list">
        <xsl:with-param name="content">
          <xsl:apply-templates select="child::node()[not(self::omdoc:CMP)]"/>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template match="omdoc:proofobject">
  <xsl:call-template name="warning">
    <xsl:with-param name="string" select="'Not presenting proofobject'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="omdoc:metacomment">
  <xsl:call-template name="with-item">
    <xsl:with-param name="content"><xsl:apply-templates/></xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template match="omdoc:derive|omdoc:conclude|omdoc:hypothesis">
  <!-- proofstep -->
  <xsl:call-template name="with-item">
    <xsl:with-param name="id" select="@id"/>
    <xsl:with-param name="content">
      <!--  <xsl:call-template name="with-bold">
           <xsl:with-param name="content">
             <xsl:call-template name="localize">
               <xsl:with-param name="key" select="local-name()"/>
             </xsl:call-template>
           </xsl:with-param>
         </xsl:call-template/> -->
       <xsl:choose>
         <xsl:when test="local-name()='conclude' or local-name()='derive'">
           <xsl:apply-templates select="omdoc:CMP"/>
           <xsl:apply-templates select="omdoc:FMP"/>
           <xsl:text> </xsl:text>
           <!-- justification -->
           <xsl:if test="omdoc:method">
             <xsl:call-template name="localize">
               <xsl:with-param name="key" select="'proven-by'"/>
             </xsl:call-template>
             <xsl:text> </xsl:text>
             <xsl:apply-templates select="omdoc:method"/>
           </xsl:if>
           <xsl:if test="omdoc:premise">
             <xsl:call-template name="localize">
               <xsl:with-param name="key" select="'from-premises'"/>
             </xsl:call-template>
             <xsl:text> </xsl:text>
             <xsl:apply-templates select="omdoc:premise"/>
           </xsl:if>
           <xsl:if test="omdoc:proof">
             <xsl:apply-templates select="omdoc:proof"/>
           </xsl:if>
         </xsl:when>
         <xsl:otherwise>
           <xsl:apply-templates/>
         </xsl:otherwise>
       </xsl:choose>
     </xsl:with-param>
   </xsl:call-template>
 </xsl:template>
     
<xsl:template match="omdoc:method">
 <xsl:value-of select="@xref"/>
 <xsl:if test="*">
  <xsl:text>(</xsl:text>
  <xsl:call-template name="localize">
   <xsl:with-param name="key" select="'on-parameters'"/>
  </xsl:call-template>
  <xsl:text> </xsl:text>
  <xsl:for-each  select="*">
   <xsl:apply-templates select="."/>
   <xsl:if test="position()!=last()"><xsl:text>, </xsl:text></xsl:if>
  </xsl:for-each>
  <xsl:text>)</xsl:text>
 </xsl:if>
</xsl:template>

<xsl:template match="omdoc:premise">
  <xsl:variable name="xref" select="@xref"/>
  <xsl:variable name="local" select="//*[@id=$xref]"/>
  <xsl:call-template name="with-crossref">
    <xsl:with-param name="uri">
      <xsl:text>#</xsl:text><xsl:value-of select="@xref"/>
    </xsl:with-param>
    <xsl:with-param name="content">
      <xsl:choose>
        <xsl:when test="$local/@id!=''"><xsl:value-of select="$local/@id"/></xsl:when>
        <xsl:otherwise>
          <xsl:variable name="external" select="document(@xref)//*[@id=$xref]"/>
          <xsl:choose>
            <xsl:when test="$external!=''">
              <xsl:value-of select="$external"/>
            </xsl:when>
            <xsl:otherwise><xsl:value-of select="generate-id()"/></xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template match="omdoc:example">
  <xsl:call-template name="with-formenv">
    <xsl:with-param name="type">
      <xsl:choose>
        <xsl:when test="@type='against'"><xsl:value-of select="'counterexample'"/></xsl:when>
        <xsl:otherwise><xsl:value-of select="'example'"/></xsl:otherwise>
      </xsl:choose>
    </xsl:with-param>
    <xsl:with-param name="content"><xsl:apply-templates/></xsl:with-param>
  </xsl:call-template>
</xsl:template>

<!--  =================== Theory elements ======================== -->
<xsl:template match="omdoc:theory">
 <xsl:param name="level"/>
 <xsl:param name="prefix"/>
 <xsl:apply-templates>
  <xsl:with-param name="level" select="$level"/>
  <xsl:with-param name="prefix" select="$prefix"/>
 </xsl:apply-templates>
</xsl:template>

<xsl:template match="omdoc:symbol[@scope!='local']">
  <xsl:variable name="id" select="@id"/>
  <xsl:call-template name="with-formenv">
    <xsl:with-param name="content">
      <xsl:for-each select="../omdoc:definition[@for=$id]">
        <xsl:call-template name="cr-def"/>
      </xsl:for-each>
      <xsl:for-each select="//omdoc:alternative[@for=$id]">
        <xsl:call-template name="cr-def"/>
      </xsl:for-each>
      <xsl:apply-templates select="child::node()[not(self::omdoc:CMP or self::omdoc:commonname)]"/>
      <xsl:call-template name="do-nl"/>
      <xsl:apply-templates select="omdoc:CMP"/>
    </xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template match="omdoc:proof/omdoc:symbol"/>

<xsl:template match="omdoc:commonname">
  <xsl:param name="simple" select="'no'"/>
  <xsl:variable name="valid_language">
    <xsl:call-template name="test-valid-language"/>
  </xsl:variable>
  <xsl:if test="$valid_language='true'">
    <xsl:choose>
      <xsl:when test="$simple='yes'">
        <xsl:call-template name="safe">
          <xsl:with-param name="string" select="."/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="localize-self"/>
        <xsl:text>&#xA;</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:if>
</xsl:template>

<xsl:template match="omdoc:type">
  <xsl:call-template name="do-nl"/>
  <xsl:call-template name="localize">
    <xsl:with-param name="key" select="'type'"/>
  </xsl:call-template>
  <xsl:text> (</xsl:text><xsl:value-of select="@system"/><xsl:text>): </xsl:text>
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="omdoc:axiom|omdoc:definition|omdoc:alternative">
  <xsl:call-template name="with-formenv">
    <xsl:with-param name="content"><xsl:apply-templates/></xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template match="omdoc:requation">
  <xsl:call-template name="do-nl"/>
  <xsl:apply-templates select="omdoc:pattern"/>
  <xsl:text>=</xsl:text>
  <xsl:apply-templates select="omdoc:value"/>
</xsl:template>

<xsl:template match="omdoc:pattern|omdoc:value"><xsl:apply-templates/></xsl:template>


<!-- ================== Theory structure ========================= -->
<!-- for the moment we disregard them -->
<xsl:template match="omdoc:axiom-inclusion|omdoc:theory-inclusion|omdoc:path-just|omdoc:obligation|omdoc:decomposition"/>

<!-- ================== abstract datatypes ======================= -->
<!-- for the moment we disregard them -->

<xsl:template match="omdoc:adt|omdoc:sortdef|omdoc:constructor|omdoc:argument|omdoc:insort|omdoc:selector"/>

<!-- =================== inheritance ============================= -->

<xsl:template match="omdoc:imports|omdoc:morphism|omdoc:inclusion"/>

<!--  ================== Auxiliary elements ====================== -->

<xsl:template match="omdoc:exercise">
  <xsl:call-template name="with-formenv">
    <xsl:with-param name="content">
      <xsl:apply-templates select="*[local-name()!='mc']"/>
      <xsl:if test="omdoc:mc">
        <xsl:call-template name="with-mcgroup">
          <xsl:with-param name="content"><xsl:apply-templates select="omdoc:mc"/></xsl:with-param>
        </xsl:call-template>
      </xsl:if>
    </xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template match="omdoc:hint">
  <xsl:call-template name="localize-self"/>
  <!-- <input type=button value="Hint!" name="onClick"/> -->
</xsl:template>

<xsl:template match="omdoc:solution">
  <xsl:call-template name="localize-self"/>
</xsl:template>


<xsl:template match="omdoc:choice|omdoc:answer"><xsl:apply-templates/></xsl:template>

<xsl:template match="omdoc:omlet[@type='java']">
 <xsl:value-of select="text()" disable-output-escaping="yes"/>
</xsl:template>

<xsl:template match="omdoc:omlet[@type='js']">
 <xsl:variable name="function" select="attribute::function"/>
 <xsl:apply-templates/>
</xsl:template>

<xsl:template match="omdoc:omlet[@type='oz']">
  <xsl:call-template name="with-crossref">
    <xsl:with-param name="uri" select="//omdoc:code[@id=current()/@function]/omdoc:data/@href"/>
    <xsl:with-param name="content"><xsl:apply-templates/></xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template match="omdoc:private"><xsl:apply-templates/></xsl:template>


<xsl:template match="omdoc:output|omdoc:effect|omdoc:output">
  <xsl:call-template name="localize-self"/>
</xsl:template>

<xsl:template match="omdoc:presentation"/>

<!-- ===== here come the named templates ===== -->

<xsl:template name="test-valid-language">
  <xsl:variable name="nodename"><xsl:value-of  select="local-name()"/></xsl:variable>
  <xsl:variable name="language"><xsl:value-of  select="@xml:lang"/></xsl:variable>
  <xsl:variable name="siblings-nodeset" select="preceding-sibling::node()[local-name()=$nodename]|following-sibling::node()[local-name()=$nodename]"/>
  <!-- Test, whether this node is among the wanted ones (in terms of language). -->
  <xsl:if test="contains($TargetLanguage,$language)">
    <!-- Test, whether other nodes don't have higher priority language-values -->
    <xsl:if test="not($siblings-nodeset[contains(substring-before($TargetLanguage,$language),@xml:lang)])">
      <!-- Test, whether this node is the only valid one (in terms 
           of language). If not, it is nevertheless a valid one and will 
           be written to the result-tree-->
      <xsl:if test="$language=$siblings-nodeset/@xml:lang">
        <xsl:call-template name="localized-error">
          <xsl:with-param name="key" select="'two-cmp-error'"/>
          <xsl:with-param name="id" select="../@id"/>
        </xsl:call-template>
      </xsl:if>
      <xsl:value-of select="true()"/>
    </xsl:if> 
  </xsl:if>
</xsl:template>



<xsl:template name="localized-error">
  <xsl:param name="key"/>
  <xsl:param name="id"/>
  <xsl:if test="$report-errors!='no'">
    <xsl:variable name="error_message">
      <xsl:call-template name="localize">
        <xsl:with-param name="key" select="$key"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:message>
      <xsl:choose>
        <xsl:when test="$error_message=''">
          <xsl:call-template name="warning">
            <xsl:with-param name="string">
              <xsl:text>Could not find the localized error message for </xsl:text>
              <xsl:value-of select="$key"/>
              <xsl:text>.&#xA;Tried languages:'</xsl:text>
              <xsl:value-of select="$TargetLanguage"/>
              <xsl:text>'.</xsl:text>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$error_message"/>
          <xsl:value-of select="$id"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:message>
  </xsl:if>
</xsl:template>

<xsl:template name="localize-self">
  <xsl:call-template name="localize">
    <xsl:with-param name="key" select="local-name()"/>
  </xsl:call-template>
  <xsl:text> </xsl:text>
  <xsl:apply-templates/>
  <xsl:text>&#xA;</xsl:text>
</xsl:template>

<xsl:template name="with-formenv">
  <xsl:param name="type" select="local-name()"/>
  <xsl:param name="content"/>
  <xsl:variable name="ffor">
    <xsl:if test="//*[@id=current()/@for]">
      <xsl:text>#</xsl:text>
      <xsl:call-template name="safe">
        <xsl:with-param name="string" select="@for"/>
      </xsl:call-template>
    </xsl:if>
  </xsl:variable>
  <xsl:call-template name="with-omdocenv">
    <xsl:with-param name="id" select="@id"/>
    <xsl:with-param name='type'>
      <xsl:if test="local-name()='omtext'">
        <xsl:value-of select="$type"/>
      </xsl:if>
      <xsl:if test="local-name()='example' and $type='counterexample'">
        <xsl:value-of select="$type"/>
      </xsl:if>
      <xsl:if test="local-name()='assertion' and $type='false-conjecture'">
        <xsl:value-of select="$type"/>
      </xsl:if>
    </xsl:with-param>
    <xsl:with-param name="content">
      <xsl:if test="$type!=''">
        <xsl:call-template name="with-bold">
          <xsl:with-param name="content">
            <xsl:call-template name="localize">
              <xsl:with-param name="key" select="$type"/>
            </xsl:call-template>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:if>
      <xsl:if test="$ffor!=''">
        <xsl:text> </xsl:text>
        <xsl:call-template name="localize">
          <xsl:with-param name="key" select="'for'"/>
        </xsl:call-template>
        <xsl:text> </xsl:text>
        <xsl:call-template name="with-crossref">
          <xsl:with-param name="uri" select="$ffor"/>
          <xsl:with-param name="content">
            <xsl:if test="@for and @for!=''">
              <xsl:call-template name="safe">
                <xsl:with-param name="string" select="@for"/>
              </xsl:call-template>
            </xsl:if>
          </xsl:with-param>
        </xsl:call-template>
        <xsl:text> </xsl:text>
      </xsl:if>
      <!-- Remark: Since the metadata are language-dependant, 
           this named template contains "apply-templates" -->
      <xsl:call-template name="insert-simple-metadata"/>
      <xsl:copy-of select="$content"/>
    </xsl:with-param>
  </xsl:call-template>
</xsl:template>

<xsl:template name="cr-def">
  <xsl:text>(</xsl:text>
  <xsl:call-template name="with-crossref">
    <xsl:with-param name="uri">
      <xsl:text>#</xsl:text><xsl:value-of select="@id"/>
    </xsl:with-param>
    <xsl:with-param name="content">
      <xsl:call-template name="localize">
        <xsl:with-param name="key" select="'definition'"/>
      </xsl:call-template>
      <!--  <xsl:text> </xsl:text><xsl:value-of select="position()"/> -->
    </xsl:with-param>
  </xsl:call-template>
  <xsl:text>)</xsl:text>
</xsl:template>


<xsl:template name="insert-simple-metadata">
  <xsl:variable name="simple-metadata">
    <xsl:choose>
      <xsl:when test="omdoc:metadata/dc:Title">
        <xsl:apply-templates select="omdoc:metadata/dc:Title"/>
      </xsl:when>
      <xsl:when test="omdoc:commonname">
        <xsl:apply-templates select="omdoc:commonname">
          <xsl:with-param name="simple" select="'yes'"/>
        </xsl:apply-templates>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="safe">
          <xsl:with-param name="string" select="@id"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:if test="$simple-metadata!=''">
    <xsl:text> (</xsl:text>
    <xsl:value-of select="$simple-metadata"/>
    <xsl:text>) </xsl:text>
  </xsl:if> 
  <xsl:if test="omdoc:metadata/dc:Creator">
    <xsl:text> [</xsl:text>
    <xsl:apply-templates select="omdoc:metadata/dc:Creator"/>
    <xsl:text>] </xsl:text>
  </xsl:if>
</xsl:template>

<!-- This template will print a symbol based on the specification given by
     the parameters 'print-form', 'cd', 'name', and 'crossref-symbol'.
     It facilitates printing symbols with crossreferences to their definitions.
     If 'crossref-symbol' has the value 't', then it will look up the URL of the 
     presentation of the defining OMDoc (as specified by the catalogue mechanism 
     for the theory 'cd'), and print the value of 'print-form' with a hyperlink 
     (if the format permits) to the determined URL. -->
<xsl:template name="print-symbol">
 <xsl:param name="print-form"/>
 <xsl:param name="crossref-symbol" select="'yes'"/>
 <xsl:param name="uri"/>
 <!-- we do not know how to crossreference, so we do'nt -->
 <xsl:copy-of select="$print-form"/>
</xsl:template>

<xsl:variable name="loc" select="document($locale)"/>
<!-- this template looks up the value of the 'key' parameter for the given 
     $TargetLanguage-list, otherwise it gives a localized error message -->
<xsl:template name="localize">
 <xsl:param name="key" select="'no-value-error'"/>
 <xsl:variable name="result">
  <xsl:apply-templates select="$loc/locale/key[@name=$key]/value" mode="locale"/>
 </xsl:variable>
 <xsl:choose>
  <xsl:when test="not($result='')">
   <xsl:value-of select="$result"/>
  </xsl:when>
  <xsl:when test="$result=''">
   <xsl:call-template name="localized-error">
    <xsl:with-param name="key" select="'no-value-error'"/>
    <xsl:with-param name="id" select="$key"/>
   </xsl:call-template>
  </xsl:when>
 </xsl:choose>
</xsl:template>

<!-- this function returns a string that is used as the last component of the 
     numbering scheme for OMDoc elements in documents. It can depend on the level -->
<func:function name="omdoc:local-number">
 <xsl:param name="level"/><!-- not used yet -->
 <func:result><xsl:number level="single" count="omdoc:omgroup|omdoc:ref"/></func:result>
</func:function>

<func:function name="omdoc:new-number">
 <xsl:param name="level"/>
 <xsl:param name="prefix"/>
 <xsl:choose>
  <xsl:when test="$prefix=''">
   <func:result select="omdoc:local-number()"/>
  </xsl:when>
  <xsl:otherwise>
   <func:result select="concat($prefix,'.',omdoc:local-number())"/>
  </xsl:otherwise>
 </xsl:choose>
</func:function>

</xsl:stylesheet>


