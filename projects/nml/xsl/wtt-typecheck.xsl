<!-- An XSL style sheet for typechecking OpenMath objects in OMDoc 
     Copyright (c) 2001 Michael Kohlhase, 
     This style sheet is released under the Gnu Public License
     Initial version 2001-0426 by Michael Kohlhase, 
     send bug-reports, patches, suggestions to omdoc@mathweb.org
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:saxon="http://icl.com/saxon" 
  xmlns:set="http://exslt.org/sets" 
  xmlns:exsl="http://exslt.org/common" 
  extension-element-prefixes="saxon set exsl"
  xmlns:om="http://www.openmath.org/OpenMath"
  version="1.0">

<xsl:output method="xml" version="1.0" indent="yes"/>
<xsl:strip-space elements="*"/>

<!-- Generally, we just recurse  -->
<xsl:template match="*"><xsl:apply-templates/></xsl:template>

<!-- the keys are only for efficiency -->
<xsl:key name="OMSs" match="//om:OMS" use="@cd"/>


<!-- for OMS we print the CD, so we can keep the messages simple -->
<xsl:template match="om:OMS">
  <xsl:value-of select="@cd"/>
  <xsl:if test="position()!=last()"><xsl:text>, </xsl:text></xsl:if>
</xsl:template>

<xsl:template match="theory"><xsl:apply-templates/></xsl:template>

<!-- we will first find a set of symbols, whose cd attributes are unique:
    'cdus' for 'cd-unique-symbols', and split them into local and 
    external ones. -->
<xsl:variable name="cdus" select="set:distinct(//om:OMS/@cd)/.."/>
<!-- fallback: <xsl:variable name="cdus" select="//om:OMS[not(@cd=preceding::om:OMS/@cd)]"/>-->
<xsl:variable name="locals" select="$cdus[@cd=//theory/@id]"/>
<!-- then we build the local catalogue and put it in  a variable -->
<xsl:variable name="tree">
  <xsl:call-template name="build-signature">
    <xsl:with-param name="externals" select="$cdus[not(@cd=//theory/@id)]"/>
  </xsl:call-template>
</xsl:variable>
<xsl:variable name="signature" select="exsl:node-set($tree)"/> 
<xsl:variable name="here" select="/"/>

<xsl:template match="/">
  <xsl:comment>
    This log file is created by the type checker for the
    STS Type system (OpenMath Simple Type System). 
  </xsl:comment> 
  <xsl:text>&#xA;&#xA;</xsl:text>
  <xsl:copy-of select="$tree"/>
  <xsl:text>&#xA;&#xA;</xsl:text>
 <xsl:message>Retrieved type information. Starting type-checking, ...</xsl:message>
 <xsl:apply-templates select="//om:OMOBJ"/>
</xsl:template>

<!-- the tamplates for OMA does two things, 
     a) it checks for well-typedness of the application
     b) it returns the appropriate type -->

<xsl:template match="om:OMA">
  <xsl:choose>
    <!-- first we test whether the OMA has more than one child, 
         and give warnings in the log file if not -->
    <xsl:when test="count(*)=0">
      <xsl:message>Empty application found! </xsl:message>
      <xsl:text>Found empty OMA on line </xsl:text>
      <xsl:value-of select="saxon:line-number()"/>
      <xsl:text>!</xsl:text>
    </xsl:when>
    <xsl:when test="count(*)=1">
      <xsl:message>Unit OMA found! </xsl:message>
      <xsl:text>Unit OMA on line</xsl:text>
      <xsl:value-of select="saxon:line-number()"/>
      <xsl:text>!</xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <!-- we retrieve the type of the function -->
      <xsl:variable name="cd" select="*[position()=1]/@cd"/>
      <xsl:variable name="name" select="*[position()=1]/@name"/>
      <xsl:variable name="funtype" 
        select="$signature/signature/thy[@name=$cd]/type-for[@name=$name]/*[1]"/>
      <xsl:choose>
        <!-- and test whether it is the STS function type mapsto -->
        <xsl:when test="not($funtype/OMA/OMS[position()=1 and 
                                             @cd='sts' and 
                                             @name='mapsto'])">
          <xsl:message>found OMA, where function is not of non-function type</xsl:message>
          <xsl:text>OMA where function is not of function type in line</xsl:text>
          <xsl:value-of select="saxon:line-number()"/>
          <xsl:text>!</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <!-- we compute the argument types of the type and the types of the arguents -->
          <xsl:variable name="typeargs">
            <args>
              <xsl:for-each select="$funtype/OMA/*[position() &gt; 1]">
                <xsl:copy-of select="."/>
              </xsl:for-each>
            </args>
          </xsl:variable>
          <xsl:variable name="argtypes">
            <args>
              <xsl:apply-templates/>
            </args>
          </xsl:variable>
          <xsl:variable name="OMAOK">
            <xsl:call-template name="compare-args">
              <xsl:with-param name="typeargs" select="$typeargs"/>
              <xsl:with-param name="argtypes" select="$argtypes"/>
            </xsl:call-template>
          </xsl:variable>
          <xsl:choose>
            <xsl:when test="$OMAOK='true'">
              <xsl:copy-of select="$funtype/OMA/*[position() = 1]"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:message>found OMA where argument types do not match up</xsl:message>
              <xsl:text>OMA where argument types do not match up in line</xsl:text>
              <xsl:value-of select="saxon:line-number()"/>
              <xsl:text>!</xsl:text>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- This template checks whether the argument types match up -->
<xsl:template name="compare-args">
  <xsl:param name="typeargs"/>  
  <xsl:param name="argtypes"/>  
  <xsl:choose>
    <xsl:when test="count($typeargs/args/*) = 0 and count($argtypes/args/*) = 0">
      <xsl:text>true</xsl:text>
    </xsl:when>
    <xsl:when test="count($typeargs/args/*)&gt;0 and count($argtypes/args/*)&gt;0">
      <xsl:variable name="recursive">
        <xsl:call-template name="compare-args">
          <xsl:with-param name="typeargs">
            <args><xsl:copy-of select="$typeargs/args/*[position()!=1]"/></args>
          </xsl:with-param>
          <xsl:with-param name="argtypes">
            <args><xsl:copy-of select="$argtypes/args/*[position()!=1]"/></args>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="this">
        <xsl:call-template name="equal-trees">
          <xsl:with-param name="a">
            <xsl:copy-of select="$typeargs/args/*[1]"/>
          </xsl:with-param>
          <xsl:with-param name="b">
            <xsl:copy-of select="$argtypes/args/*[1]"/>
          </xsl:with-param>
        </xsl:call-template>
      </xsl:variable>
      <xsl:choose>
        <xsl:when test="$recursive='true' and $this='true'">
          <xsl:text>true</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>false</xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
      <xsl:message>
        compute-args with lists of different lengths
      </xsl:message>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- XXXXXXXXXX this has to be changed XXXXXXXX -->
<xsl:template name="equal-trees">
  <xsl:text>true</xsl:text>
</xsl:template>

<!-- %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     %%%  the recursive templates for building the signature start here  %%%%%
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  -->
    

<!-- this template will build a local catalogue of URIs for crossreferencing the 
     symbols in print-symbol. It goes through all CDs of the symbols used in the 
     omdoc, and then for each of those through all names, and builds a catalogue, 
     in which print-symbol can later look up the hrefs. -->
<xsl:template name="build-signature">
  <xsl:param name="externals"/>
  <signature>
    <xsl:call-template name="make-external">
      <xsl:with-param name="externals" select="$externals"/>
      <xsl:with-param name="document" select="/"/>
    </xsl:call-template>
  </signature>
</xsl:template>

<xsl:template name="make-external">
  <xsl:param name="externals"/>
  <xsl:param name="document"/>
  <xsl:variable name="incat" 
    select="$externals[@cd=$document/omdoc/catalogue/loc/@theory]"/>
  <xsl:variable name="rest" select="set:difference($externals,$incat)"/>    
  <xsl:for-each select="$incat">
    <xsl:variable name="cd" select="@cd"/>
    <xsl:variable name="omduri" select="$document/omdoc/catalogue/loc[@theory=$cd]/@omdoc"/>
    <xsl:variable name="syms" select="set:distinct(key('OMSs',$cd)/@name)/.."/>
    <xsl:if test="$omduri!=''">
      <thy name="{$cd}" omdoc="{$omduri}">
        <xsl:variable name="omdoc" select="document($omduri)"/>
        <xsl:variable name="omsyms" select="$omdoc/omdoc/theory/symbol"/>
        <xsl:for-each select="$syms">
          <xsl:variable name="name" select="@name"/>
          <type-for name="{$name}">
            <xsl:copy-of select="$omsyms[@id=$name]/type[@system='sts']/om:OMOBJ/*[1]"/>
          </type-for>
        </xsl:for-each>
      </thy>
    </xsl:if>
  </xsl:for-each>
  <xsl:if test="$rest">
    <xsl:choose>
      <!-- if there is a catalogue specified in the <omdoc> element -->
      <xsl:when test="$document/omdoc/@catalogue!=''">
        <xsl:call-template name="make-external">
          <xsl:with-param name="externals" select="$rest"/>
          <xsl:with-param name="document"
            select="document($document/omdoc/@catalogue,$document)"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:message>Cannot find locations for the theories 
        <xsl:for-each select="$rest">
          <xsl:value-of select="@cd"/>
          <xsl:if test="position()!=last()">,</xsl:if>
        </xsl:for-each>!</xsl:message>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:if>
</xsl:template>


</xsl:stylesheet>





