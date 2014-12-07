<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xt="http://www.jclark.com/xt"
                xmlns:dc="http://purl.org/DC"
		version="1.0"
                extension-element-prefixes="xt">

<xsl:strip-space
           elements = "signature" /> 
<xsl:output method="xml"/>

<!-- the default behavior is that everything (for instance OMOBJects)
     are copied verbatim. This is overridden later by the other rules
  -->
  <xsl:template match="*"><xsl:copy-of select="."/></xsl:template>

<xsl:template match="/">
  <xsl:comment>
    This Open Math Signature file is automatically generated from the OpenMath Document
    "<xsl:value-of select="omdoc/metadata/Title"/>", do not edit!
    </xsl:comment>
    <xsl:apply-templates/>
</xsl:template>

<xsl:template match="omdoc">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="metadata"></xsl:template>

<xsl:template match="theory">
  <xsl:element name="CDSignatures">
    <xsl:attribute name="type">
      <xsl:text>POST</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="cd">
      <xsl:value-of select="@id"/>
    </xsl:attribute>
    <xsl:text>&#xA;</xsl:text>
    <xsl:element name="CDMPURL">
      <xsl:text>Not Specified</xsl:text>
    </xsl:element>
    <xsl:text>&#xA;</xsl:text>
    <xsl:element name="CDMPReviewDate">
      <xsl:text>Not Specified</xsl:text>
    </xsl:element>
    <xsl:text>&#xA;</xsl:text>
    <xsl:element name="CDMPStatus">
      <xsl:text>Experimental</xsl:text>
    </xsl:element>
    <xsl:text>&#xA;</xsl:text>
    <xsl:element name="CDSDate">
      <xsl:apply-templates select="../metadata/Date"/>
    </xsl:element>
    <xsl:text>&#xA;</xsl:text>
    <xsl:element name="CDSComment">
      <xsl:text>Title:</xsl:text>
      <xsl:apply-templates select="../metadata/Title"/>
      <xsl:text>&#xA;Author:</xsl:text>
      <xsl:apply-templates select="../metadata/Creator"/>
      <xsl:text>&#xA;</xsl:text>
    </xsl:element>
    <xsl:text>&#xA;</xsl:text>
    <xsl:apply-templates/>
    <xsl:text>&#xA;</xsl:text>
  </xsl:element>
</xsl:template>

<!-- The OMOBJ in the signature Slots of symbols are literally copied into the DefMP
     elements -->

<xsl:template match="symbol">
  <xsl:element name="Signature">
    <xsl:apply-templates select="signature/om:OMOBJ"/>
  </xsl:element>
</xsl:template>

<!-- we do not want to see the rest -->

<xsl:template match="imports"></xsl:template>
<xsl:template match="definition"></xsl:template>
<xsl:template match="assertion"></xsl:template>
<xsl:template match="axiom"></xsl:template>
<xsl:template match="commonname"></xsl:template>
<xsl:template match="omtext"></xsl:template>
<xsl:template match="omnote"></xsl:template>
<xsl:template match="linkage"></xsl:template>
<xsl:template match="proof"></xsl:template>
<xsl:template match="exercise"></xsl:template>
<xsl:template match="example"></xsl:template>
<xsl:template match="omlet"></xsl:template>

</xsl:stylesheet>

