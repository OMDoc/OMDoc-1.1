<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:om="http://www.openmath.org/OpenMath"
  xmlns:dc="http://purl.org/DC"
  version="1.0">

  <xsl:strip-space elements="*"/>
  <xsl:output method="text"/>

<xsl:template match="/">
<xsl:text>;;;This file is automatically generated, do not edit</xsl:text>
<xsl:text>&#xA;&#xA;</xsl:text>
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="omdoc"><xsl:apply-templates/></xsl:template>

<!-- everything is disregarded, if we do not have an explicit rule for it -->
<xsl:template match="*"/>
<xsl:template match="CMP"><xsl:apply-templates/></xsl:template>

<xsl:template match="FMP">
  <xsl:if test="om:OMOBJ"><xsl:text>  (conclusion </xsl:text></xsl:if>
  <xsl:apply-templates/>
  <xsl:if test="om:OMOBJ"><xsl:text>)</xsl:text></xsl:if>
</xsl:template>

<xsl:template match="omtext">
  <xsl:call-template name="print-ccmp"/>
  <xsl:text>&#xA;&#xA;</xsl:text>
</xsl:template>

<!-- #################### Theory Elements ##################### -->
<xsl:template match="theory">
  <xsl:variable name="Theory"><xsl:value-of select="@id"/></xsl:variable>
<xsl:text>&#xA;THEORY(&#xA;THEORYNAME(</xsl:text>
  <xsl:value-of select="@id"/>
  <xsl:text>),&#xA;LOGICNAME(hol+eq),&#xA;(</xsl:text>
  <xsl:apply-templates select="symbol[@type='sort']"/>
  <xsl:text>),&#xA;(),&#xA;(</xsl:text>
  <xsl:apply-templates select="symbol[@type='object']"/>
  <xsl:text>),&#xA;(),&#xA;(),&#xA;()&#xA;)&#xA;</xsl:text>
  <xsl:for-each select="imports">
    <xsl:apply-templates/>
  </xsl:for-each>
</xsl:template>

<xsl:template match="axiom">
<xsl:variable name="Id"><xsl:value-of select="@id"/></xsl:variable>
<xsl:text>(th~defaxiom </xsl:text>
  <xsl:value-of select="@id"/>
  <xsl:text>&#xA;</xsl:text>
  <xsl:text>  (in </xsl:text> 
    <xsl:value-of select="../@id"/>
  <xsl:text>)&#xA;  (formula </xsl:text>
  <xsl:apply-templates select="FMP"/>
  <xsl:text>)&#xA;  (help "</xsl:text>
    <xsl:call-template name="print-cmp"/>
  <xsl:text>"))&#xA;&#xA;</xsl:text>
</xsl:template>


<!-- #################### Math Elements ##################### -->

<xsl:template match="symbol">
  <xsl:choose>
    <xsl:when test="@type = 'sort'">
      <xsl:text>SORTDECL(SORT(SYMBOLNAME(</xsl:text>
      <xsl:value-of select="@id"/>
      <xsl:text>),THEORYNAME(</xsl:text>
      <xsl:value-of select="../@id"/>
        <xsl:text>),</xsl:text> 
	<xsl:choose>
	  <xsl:when  test="signature">
	    <xsl:number value="count(descendant::om:OMV)"/>  
	  </xsl:when>
	  <xsl:otherwise>
	  <xsl:text>0</xsl:text>
	</xsl:otherwise>
	</xsl:choose>
	<xsl:text>),empty)</xsl:text>
      </xsl:when>
    <xsl:when test="@type = 'object'">
      <xsl:text>CONSTDECL(CONST(SYMBOLNAME(</xsl:text>
      <xsl:value-of select="@id"/>
      <xsl:text>),THEORYNAME(</xsl:text>
      <xsl:value-of select="../@id"/>
        <xsl:text>),</xsl:text> 
	<xsl:choose>
	  <xsl:when test="signature">
	    <xsl:number value="count(descendant::om:OMV)"/>
	  </xsl:when>
	  <xsl:otherwise>
	  <xsl:text>0</xsl:text>
	</xsl:otherwise>
	</xsl:choose>
	<xsl:text>),empty)</xsl:text>
      </xsl:when>
    </xsl:choose>
    <xsl:variable name="Type"><xsl:value-of select="@type"/></xsl:variable>
    <xsl:choose>
      <xsl:when test="count(following-sibling::symbol[attribute::type=$Type]) > 0">
        <xsl:text>,&#xA; </xsl:text>
      </xsl:when>	
    </xsl:choose>
</xsl:template>

<xsl:template match="assertion">
  <xsl:choose>
    <xsl:when test="@type = 'theorem'">
	<xsl:text>(th~deftheorem </xsl:text>
    </xsl:when>	  
    <xsl:otherwise>
	<xsl:text>(th~defproblem </xsl:text>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:value-of select="@id"/>
  <xsl:text>&#xA;</xsl:text>
  <xsl:text>  (in </xsl:text> 
    <xsl:value-of select="@theory"/>
  <xsl:text>)&#xA;</xsl:text>
  <xsl:apply-templates select="assumption"/>
  <xsl:apply-templates select="conclusion"/>
  <xsl:text>(help "</xsl:text>
    <xsl:apply-templates select="CMP"/>
  <xsl:text>"))&#xA;&#xA;</xsl:text>
</xsl:template>

<xsl:template match="assumption">
  <xsl:text>  (assumption </xsl:text>
  <xsl:value-of select="@id"/>
  <xsl:text> </xsl:text>
  <xsl:apply-templates select="om:OMOBJ"/>
  <xsl:text>)&#xA;</xsl:text>
</xsl:template>

<xsl:template match="conclusion">
  <xsl:text>  (conclusion Conc </xsl:text>
  <xsl:apply-templates select="FMP"/>
  <xsl:text>)&#xA;</xsl:text>
</xsl:template>

<!-- ************ OMOBJ, remove to somewhere *************** -->

<xsl:template match="om:OMOBJ"><xsl:apply-templates/></xsl:template>

<xsl:template match="om:OMA|om:OMBIND">
  <xsl:text>(</xsl:text><xsl:apply-templates/><xsl:text>)</xsl:text>
</xsl:template>

<xsl:template match="om:OMS|om:OMV"><xsl:value-of select="@name"/><xsl:text> </xsl:text></xsl:template>

<xsl:template match="om:OMBVAR"><xsl:apply-templates/></xsl:template>

<xsl:template match="om:OMBIND[om:OMS[@name='all-types' and @cd='POST']]">
  <xsl:text>(all-types </xsl:text>
    <xsl:apply-templates select="om:OMBVAR/om:OMV"/>
    <xsl:apply-templates select="*[3]"/>
  <xsl:text>)</xsl:text>
</xsl:template>

<xsl:template match="om:OMA[om:OMS[@name='funtype' and @cd='mltt']]">
  <xsl:text>(</xsl:text>
    <xsl:apply-templates select="*[3]"/>
    <xsl:text> </xsl:text>
    <xsl:apply-templates select="*[2]"/>
  <xsl:text>)</xsl:text>
</xsl:template>

<xsl:template match="om:OMS[@name='lambda' and @cd='mltt']">
  <xsl:text>lam </xsl:text>
</xsl:template>

<xsl:template match="om:OMATTR[om:OMATP[om:OMS[@name='type' and @cd='mltt']]]">
 <xsl:text>(</xsl:text>
  <xsl:apply-templates select="*[2]"/>
  <xsl:text> </xsl:text>
  <xsl:apply-templates select="om:OMATP/*[2]"/>
  <xsl:text>)</xsl:text>
</xsl:template>


<xsl:template name="print-cmp">
  <xsl:choose>
    <xsl:when test="CMP[xml:lang='en']">
      <xsl:apply-templates select="CMP[xml:lang='en']"/>
    </xsl:when>
    <xsl:when test="CMP[not(xml:lang)]">
      <xsl:apply-templates select="CMP[not(xml:lang)]"/>
    </xsl:when>
  </xsl:choose>
</xsl:template>

<xsl:template name="print-ccmp">
  <xsl:if test="CMP[not(xml:lang) or xml:lang='en']">
    <xsl:text>#|</xsl:text>
    <xsl:call-template name="print-cmp"/>
    <xsl:text>|#&#xA;</xsl:text>
  </xsl:if>
</xsl:template>

</xsl:stylesheet>





