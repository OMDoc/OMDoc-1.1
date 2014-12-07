<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:om="http://www.openmath.org/OpenMath"
  xmlns:dc="http://purl.org/DC"
  version="1.0">

<xsl:import xref="omdoc2sys.xsl"/>
<xsl:strip-space elements="*"/>
<xsl:output method="text"/>

<xsl:template match="omdoc:CMP"><xsl:apply-templates/></xsl:template>

<xsl:template match="omdoc:FMP">
  <xsl:if test="om:OMOBJ"><xsl:text>  (conclusion </xsl:text></xsl:if>
  <xsl:apply-templates/>
  <xsl:if test="om:OMOBJ"><xsl:text>)</xsl:text></xsl:if>
</xsl:template>

<xsl:template match="omdoc:omtext">
  <xsl:call-template name="print-ccmp"/>
  <xsl:text>&#xA;&#xA;</xsl:text>
</xsl:template>

<!-- #################### Theory Elements ##################### -->
<xsl:template match="omdoc:theory"><xsl:apply-templates/></xsl:template>


<xsl:template match="omdoc:assertion">
  <xsl:text>query </xsl:text>
  <xsl:value-of select="@id"/>
  <xsl:apply-templates/>
</xsl:template>

<!-- do something about assumptions here, or in lclam -->

<xsl:template match="omdoc:conclusion"><xsl:apply-templates/></xsl:template>

<!-- ################ OpenMath ################-->
<xsl:template match="om:OMOBJ"><xsl:apply-templates/></xsl:template>

<xsl:template match="om:OMA">
  <xsl:text> (app</xsl:text><xsl:apply-templates/><xsl:text>)</xsl:text>
</xsl:template>

<xsl:template match="om:OMBIND[om:OMS[@name='lambda' and @cd='mltt']]">
  <xsl:text> (abs</xsl:text><xsl:apply-templates/><xsl:text>)</xsl:text>
</xsl:template>

<xsl:template match="om:OMBIND[om:OMS[@name='forall']]">
  <xsl:text>(app (otype_of forall ((</xsl:text>
  <xsl:apply-templates select="om:OMATTR/om:OMATP"/>
  <xsl:text> arrow bool) arrow bool))</xsl:text>
    <xsl:apply-templates/>
  <xsl:text>)</xsl:text>
</xsl:template>

<!-- special case for forall and exists, this only works for unary quantifiers -->

<xsl:template match="om:OMA[om:OMS[@name='forall']]">
  <xsl:text> (app (otype_of forall ((</xsl:text>
  <xsl:apply-templates select="om:OMBIND/om:OMBVAR/om:OMATTR/om:OMATP/*[2]"/>
  <xsl:text> arrow bool) arrow bool)) (abs</xsl:text>
  <xsl:apply-templates select="om:OMBIND/om:OMBVAR/om:OMATTR/*[2]"/>
  <xsl:text>\</xsl:text>
  <xsl:apply-templates select="om:OMBIND/*[3]"/>
  <xsl:text>))</xsl:text>
</xsl:template>

<xsl:template match="om:OMA[om:OMS[@name='exists']]">
  <xsl:text> (app (otype_of exists ((</xsl:text>
  <xsl:apply-templates select="om:OMBIND/om:OMBVAR/om:OMATTR/om:OMATP/*[2]"/>
  <xsl:text> arrow bool) arrow bool)) (abs</xsl:text>
  <xsl:apply-templates select="om:OMBIND/om:OMBVAR/om:OMATTR/*[2]"/>
  <xsl:text>\</xsl:text>
  <xsl:apply-templates select="om:OMBIND/*[3]"/>
  <xsl:text>))</xsl:text>
</xsl:template>

<xsl:template match="om:OMS|om:OMV">
  <xsl:value-of select="@name"/><xsl:text> </xsl:text>
</xsl:template>

<xsl:template match="om:OMBVAR">
   <xsl:apply-templates/><xsl:text>\</xsl:text>
</xsl:template>

<xsl:template match="om:OMBIND[om:OMS[@name='all-types' and @cd='post']]">
  <xsl:text>(all-types </xsl:text>
    <xsl:apply-templates select="om:OMBVAR/om:OMV"/>
    <xsl:apply-templates select="*[3]"/>
  <xsl:text>)</xsl:text>
</xsl:template>

<xsl:template match="om:OMATTR"><xsl:apply-templates select="*[2]"/></xsl:template>

</xsl:stylesheet>




