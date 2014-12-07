<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:dc="http://purl.org/DC"
  xmlns:omdoc="http://www.mathweb.org/omdoc"
  version="1.0">

  <xsl:output method="html"/>
  <xsl:strip-space elements="*"/>

  <xsl:variable name="format" select="'html'"/>
  <xsl:variable name="here" select="/"/>

  <xsl:template match="/">
    <html>
      <body bgcolor="#FFFFFF">
      <xsl:apply-templates/>
    </body>
    </html>
  </xsl:template>

  <xsl:template match="omdoc:omdoc">
   <xsl:if test="count(omdoc:metadata/*) &gt; 0">
    <h1><xsl:value-of select="omdoc:metadata/dc:Title"/></h1>
    <p><xsl:value-of select="omdoc:metadata/dc:Creator"/>,
    <xsl:value-of select="omdoc:metadata/dc:Date[@action='updated']"/></p>
    <p><xsl:apply-templates select="omdoc:metadata/dc:Description"/></p>
   </xsl:if>
   <xsl:apply-templates/>
  </xsl:template>

<!-- the default action is to do nothing on OMDoc elements -->
<xsl:template match="omdoc:*"/>
<!-- except on these, which may contain 'presentation', 'omstyle', 
     or 'ref' elements, which we must take into consideration -->
<xsl:template match="omdoc:omgroup|omdoc:theory">
 <xsl:apply-templates/>
</xsl:template>

<!-- ref pointers are followed, if they point to external documents -->
<xsl:template match="omdoc:ref">
 <xsl:choose>
  <xsl:when test="contains(@xref,'http:')">
   <xsl:apply-templates select="document(@xref)/omdoc:omdoc"/>
  </xsl:when>
  <xsl:when test="contains(@xref,'file://')">
   <xsl:apply-templates select="document(substring-after(@xref,'file://'),$here)/omdoc:omdoc"/>
  </xsl:when>
  <xsl:when test="contains(@xref, '#')">
   <xsl:apply-templates select="document(@xref,$here)/omdoc:omdoc"/>
  </xsl:when>
 </xsl:choose> 
</xsl:template>


<xsl:template match="dc:Description">
 <xsl:apply-templates/>
</xsl:template>

<xsl:template match="omdoc:catalogue">
 <table border="1" cellpadding="1">
  <tr>
   <th>Name</th>
   <th>Description</th>
   <th>Formats</th>
   <th><a href="../../../xsl/expres.xsl">templates</a></th>
   <th><a href="../../../xsl/exincl.xsl">Includes</a></th></tr>
   <xsl:apply-templates/>
  </table>
 </xsl:template>
 
 <xsl:template match="omdoc:loc">
  <xsl:variable name="uri" select="@omdoc"/>
  <xsl:variable name="omdoc" select="document($uri)"/>
  <tr>
   <td><b><a href="{@theory}.omdoc"><xsl:value-of select="@theory"/></a></b></td>
   <td><font size="-1">
   <xsl:apply-templates select="document(@omdoc)/omdoc:omdoc/omdoc:metadata/dc:Description"/>
  </font></td>
  <td>
   <a href="{@theory}.html">html</a>,
   <a href="{@theory}.tex">LaTeX</a>,
   <a href="{@theory}.xml">MathML</a>,
   <a href="{@theory}.ps">PS</a>
  </td>
  <td><a href="{@theory}-tmpl.xsl"><xsl:value-of select="@theory"/>-tmpl.xsl</a></td>
  <td><a href="{@theory}Ihtml.xsl"><xsl:value-of select="@theory"/>-incl.xsl</a></td>
 </tr>
</xsl:template>

</xsl:stylesheet>
