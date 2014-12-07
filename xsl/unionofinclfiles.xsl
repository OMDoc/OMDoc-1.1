<?xml version="1.0" encoding="UTF-8"?>
<!-- An XSL style sheet for presenting course material represented in
     OMDoc (Open Mathematical Documents). 
     URL: http://www.mathweb.org/omdoc/xsl/omdoc2html.dtd
     Copyright (c) 2001 Andrea Kohlhase, ALL RIGHTS RESERVED
     send bug-reports, patches, suggestions to omdoc@mathweb.org -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:saxon="http://icl.com/saxon" 
  xmlns:out="output.xsl"
  xmlns:om="http://www.openmath.org/OpenMath"
  xmlns:dc="http://www.purl.org/DC" 
  xmlns:omdoc="http://www.mathweb.org/omdoc"
  extension-element-prefixes="saxon"
  version="1.0">

<xsl:variable name="here" select="/"/>

<xsl:output method="xml" indent="yes"/>
<xsl:strip-space elements="*"/>
<xsl:namespace-alias stylesheet-prefix="out" result-prefix="xsl"/>

<xsl:template match="/">
  <xsl:variable name="list">
    <xsl:text>listinclfiles.tmp</xsl:text>
  </xsl:variable>
  
  <xsl:variable name="ListOfInclFiles">
    <xsl:copy-of select="document($list, $here)"/>
  </xsl:variable>

  <xsl:variable name="incl_tree">
    <xsl:for-each select="$ListOfInclFiles/list/incl">
      <xsl:variable name="inclfile_name">
        <xsl:value-of select="."/>
      </xsl:variable> 

      <xsl:variable name="inclfile">
        <xsl:copy-of select="document($inclfile_name,$here)"/>
      </xsl:variable>

      <xsl:copy-of select="$inclfile//catalogue/loc"/>
      <xsl:copy-of select="$inclfile//*[local-name()='include']"/>
    </xsl:for-each>
  </xsl:variable>

  <xsl:variable name="unified_incl_tree">
    <xsl:copy-of select="saxon:distinct($incl_tree/loc/@theory)/.."/>
    <xsl:copy-of select="saxon:distinct($incl_tree/*[local-name()='include']/@href)/.."/>
  </xsl:variable>

  <xsl:variable name="unified_incl_doc">
    <xsl:text>&#xA;&#xA;</xsl:text>
    <out:stylesheet 
      xmlns:exslt="http://exslt.org/common" 
      version="1.0" 
      extension-element-prefixes="exslt">
      <xsl:text>&#xA;&#xA;</xsl:text>
      <out:variable name="tree">
        <catalogue>
          <xsl:copy-of select="$unified_incl_tree/loc"/>
        </catalogue>
      </out:variable>
      <out:variable name="href-cat" select="exslt:node-set($tree)"/> 
      <xsl:text>&#xA;&#xA;</xsl:text>
      
      <xsl:copy-of select="$unified_incl_tree/*[local-name()='include']"/>
      
    </out:stylesheet>
    <xsl:text>&#xA;</xsl:text>
  </xsl:variable>

  <xsl:document href="unifiedincl.xsl">
    <xsl:copy-of select="$unified_incl_doc"/>
  </xsl:document>

</xsl:template>

</xsl:stylesheet>




