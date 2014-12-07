<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:om="http://www.openmath.org/OpenMath"
  xmlns:dc="http://www.purl.org/DC"
  version="1.0">

  <xsl:import href="../../../xsl/omdoc2pvs.xsl"/>
  <xsl:import href="../pvs4pvs.xsl"/>
<xsl:output method="text"/>

<xsl:template match="/">
  <xsl:for-each select="/omdoc/catalogue/loc[@theory!='pvs']">
    <xsl:message>
      examining <xsl:value-of select="@omdoc"/>
    </xsl:message>
    <xsl:apply-templates select="document(@omdoc)/omdoc"/>
  </xsl:for-each>
</xsl:template>
</xsl:stylesheet>
