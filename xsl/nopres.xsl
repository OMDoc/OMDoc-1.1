<?xml version="1.0" encoding="utf-8"?>

<!-- An XSL style sheet for warning about missing presentation elements 
     in OMDoc theory files. It generates the local catalogue, reads all 
     the files and reports on missing presentation elements.
     Copyright (c) 2000, 2001 Michael Kohlhase, 
     This style sheet is released under the Gnu Public License
     Initial version 2001-5-15 by Michael Kohlhase, 
     send bug-reports, patches, suggestions to omdoc@mathweb.org
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:omdoc="http://www.mathweb.org/omdoc" 
  version="1.0">

<xsl:output method="html" indent="yes"/>
<xsl:variable name="here" select="/"/>

<xsl:template match="/">
  <html>
    <body bgcolor="#FFFFFF">
      <xsl:apply-templates/>
    </body>
  </html>
</xsl:template>

<xsl:template match="omdoc:omdoc">
  <h1>Missing presentation elements</h1>
  <table>
    <tr><th>theory</th><th>elements</th></tr>
    <xsl:apply-templates select="omdoc:catalogue"/>
  </table>
</xsl:template>

<xsl:template match="omdoc:catalogue">
 <xsl:apply-templates/>
</xsl:template>

<xsl:template match="omdoc:loc">
  <xsl:variable name="thy" select="@theory"/>
  <xsl:variable name="theory" select="document(@omdoc,$here)//omdoc:theory[@id=$thy]"/>
  <xsl:variable name="missing">
    <xsl:for-each select="$theory/omdoc:symbol">
      <xsl:variable name="name" select="@id"/>
      <xsl:if test="not(../omdoc:presentation[@for=$name])">
        <xsl:value-of select="$name"/>
        <xsl:text> </xsl:text>
      </xsl:if>
    </xsl:for-each>
  </xsl:variable>
  <xsl:if test="$missing!=''">
    <tr><td><xsl:value-of select="@theory"/></td><td><xsl:value-of select="$missing"/></td></tr>  
  </xsl:if>
</xsl:template>

</xsl:stylesheet>
