<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

  <xsl:output method="text"/>

  <xsl:template match="*">
    <xsl:copy-of select="."/>
  </xsl:template>

  <xsl:template match="preOMDoc">
    <xsl:apply-templates/>
    <xsl:text disable-output-escaping="yes">&lt;/theory&gt;</xsl:text>
  </xsl:template>

  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>

  <xsl:template match="item_type">
    <xsl:variable name="val" select="[1]"/>
    <xsl:choose>
      <xsl:when test="[1] and $val='CATEGORY'">
        <xsl:text disable-output-escaping="yes">&lt;theory id="</xsl:text>
        <xsl:value-of select="self::following-sibling/[1]"/>
        <xsl:text disable-output-escaping="yes">"&gt;</xsl:text>
      </xsl:when>
      <xsl:when test="$val='CATEGORY'">
        <xsl:text disable-output-escaping="yes">&lt;/theory&gt;&#xA;&lt;theory id="</xsl:text>
        <xsl:value-of select="self::following-sibling/[1]"/>
        <xsl:text disable-output-escaping="yes">"&gt;</xsl:text>
      </xsl:when>
    
</xsl:stylesheet>
