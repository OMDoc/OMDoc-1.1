<?xml version="1.0" encoding="utf-8"?>
<!-- this is a style sheet that serves as a seed to transforming an 
     OMDoc between versions. It copies everything verbatim, except 
     those templates that are explicitly defined. 
     NOTE, that this style sheet will eliminate comments and put in all 
     default values for attributes that are specified in the DTD.

     To get around the comment problems, put those you want to preserve 
     into <ignore> elements, the second one is actually a plus, since 
     it makes the whole thing more explicit.
     -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

<xsl:output method="xml" indent="yes" cdata-section-elements="data"/>
<xsl:strip-space elements="*"/>

<xsl:text disable-output-escaping="yes">&#xA;&lt;!DOCTYPE omdoc SYSTEM "http://www.mathweb.org/omdoc/dtd/omdoc.dtd" []&gt;&#xA;&#xA;</xsl:text>


<xsl:template match="*">
  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <xsl:apply-templates/>
  </xsl:copy>
</xsl:template>

</xsl:stylesheet>
