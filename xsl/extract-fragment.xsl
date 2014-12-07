<?xml version="1.0" encoding="iso-8859-1"?>
<!-- Given an identity for the id parameter, this stylesheets extracts
     a fragment from the  OmDoc that can be presented in the normal 
     way.   -->

<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  version="1.0">
<xsl:param name="id"/>

<!-- normally, we just copy -->
<xsl:template match="*">
  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <xsl:apply-templates/>
  </xsl:copy>
</xsl:template>
<!-- except for the top-level one, where we start at $id -->
<xsl:template match="/">
  <xsl:apply-templates select="//*[@id=$id]"/>
</xsl:template>

  <!-- and for ref elements, there we follow the hyperlinks -->
  <xsl:template match="ref">
    <xsl:choose>
      <xsl:when test="@xref!=''">
        <xsl:variable name="it" select="//*[@id=$id]"/>
        <xsl:choose>
          <xsl:when test="$it"><xsl:apply-templates select="$it"/></xsl:when>
          <xsl:otherwise>
            <xsl:message>Could not find element with identity <xsl:value-of select="@xref"/> in this OMDoc!</xsl:message>
          </xsl:otherwise>
        </xsl:choose>"
      </xsl:when>
      <xsl:when test="@theory!='' and @name!=''">
        <!-- find the location and copy it -->
      </xsl:when>
      <xsl:otherwise>
        <xsl:message>Need 'theory' and 'name' attribute to be able to crossreference!</xsl:message>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
    
</xsl:stylesheet>
