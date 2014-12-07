<?xml version="1.0" encoding="iso-8859-1"?>
<!-- An XSL style sheet for creating html from OMDoc (Open Mathematical Documents). 
     URL: http://www.mathweb.org/omdoc/xsl/omdoc2html.dtd
     send bug-reports, patches, suggestions to omdoc@mathweb.org 

     Copyright (c) 2000 - 2002 Michael Kohlhase, 

     This library is free software; you can redistribute it and/or
     modify it under the terms of the GNU Lesser General Public
     License as published by the Free Software Foundation; either
     version 2.1 of the License, or (at your option) any later version.

     This library is distributed in the hope that it will be useful,
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
     Lesser General Public License for more details.

     You should have received a copy of the GNU Lesser General Public
     License along with this library; if not, write to the Free Software
     Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:om="http://www.openmath.org/OpenMath"
  xmlns:dc="http://purl.org/DC"
  xmlns:omdoc="http://www.mathweb.org/omdoc"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns="http://www.w3.org/1998/Math/MathML"
  exclude-result-prefixes="om dc omdoc xsl"
  version="1.0">  

<xsl:import href="omdoc2html.xsl"/>
<xsl:variable name="format" select="'pmml'"/>

<xsl:output method="xml" 
            version="1.0"
            standalone="yes"
            indent="yes" 
            doctype-public="'-//W3C//DTD XHTML 1.0 Strict//EN' 'mathml.dtd'"/>

<xsl:strip-space elements="*"/>

<!-- if this parameter is not the empty string, then presentation is only for mozilla, 
     circumventing the need of universal stylesheet -->
<xsl:param name="mozonly"/>

<xsl:template match="/">
  <xsl:if test="omdoc:omdoc/@version!='1.1'">
    <xsl:message>WARNING: applying an OMDoc 1.1 style sheet to an OMDoc <xsl:value-of select="omdoc:omdoc/@version"/> document!
    This need not be a problem, but can lead to unintened results.
    </xsl:message>
  </xsl:if>
 <xsl:text>&#xA;</xsl:text>
 <xsl:if test="$mozonly=''">
  <xsl:processing-instruction name="xml-stylesheet"> type="text/xsl" href="mathml.xsl"</xsl:processing-instruction>
 </xsl:if>
 <xsl:text>&#xA;&#xA;</xsl:text>
 <xsl:text>&lt;!DOCTYPE html
    PUBLIC "-//W3C//DTD XHTML 1.1 plus MathML 2.0//EN"
           "http://www.w3.org/TR/MathML2/dtd/xhtml-math11-f.dtd"&gt;
</xsl:text>
 <xsl:text>&#xA;&#xA;</xsl:text>
 <xsl:comment>
  <xsl:call-template name="localize">
   <xsl:with-param name="key" select="'boilerplate'"/>
  </xsl:call-template>
 </xsl:comment>
 <xsl:text>&#xA;&#xA;</xsl:text>
 <html xmlns="http://www.w3.org/1999/xhtml"
       xmlns:pref="http://www.w3.org/2002/Math/preference"
       pref:renderer="mathplayer-dl"
       xmlns:xlink="http://www.w3.org/1999/xlink">
  <head>
   <link rel="stylesheet" type="text/css" href="{$css}"/>
   <title>
    <xsl:apply-templates select="omdoc:omdoc/omdoc:metadata/dc:Title"/>
   </title>
  </head>
  <body>
   <xsl:apply-templates select="omdoc:omdoc"/>
  </body>
 </html>
 <xsl:text>&#xA;&#xA;</xsl:text>
</xsl:template>


<xsl:template match="om:OMOBJ[not(@xref)]">
  <xsl:param name="id"/>
  <xsl:element name="math">
    <xsl:if test="@id!=''">
      <xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
    </xsl:if>
    <!-- if we do the transformation only for mozilla, then we do not want to generate the 
         semantics element -->
    <xsl:choose>
      <xsl:when test="$mozonly=''">
        <semantics>
          <mrow><xsl:apply-templates/></mrow>
          <annotation-xml encoding="OpenMath"><xsl:copy-of select="."/></annotation-xml>
        </semantics>
      </xsl:when>
      <xsl:otherwise><mrow><xsl:apply-templates/></mrow></xsl:otherwise>
    </xsl:choose>
  </xsl:element>
</xsl:template>

<xsl:template match="om:OMA[not(@xref)]">
 <mrow>
  <xsl:apply-templates select="*[1]"/>
  <mrow>
   <mo fence="true">(</mo><mrow>
   <xsl:for-each select="*[position()!=1]">
    <xsl:apply-templates select="."/>
    <xsl:if test="position()!=last()"><mo separator="true">,</mo></xsl:if>
   </xsl:for-each>
  </mrow><mo fence="true">)</mo>
 </mrow>
</mrow>
</xsl:template>

<xsl:template match="om:OMBIND">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="om:OMBVAR">
  <mrow>
    <xsl:for-each select="*">
      <xsl:apply-templates select="."/>
      <xsl:if test="not(position()=last())"><mo seaparator="true">,</mo></xsl:if>
    </xsl:for-each>
  </mrow>
</xsl:template>

<xsl:template match="om:OMSTR[not(@xref)]">
  <mtext><xsl:apply-templates/></mtext>
</xsl:template>

<xsl:template match="om:OMI[not(@xref)]">
 <mn><xsl:apply-templates/></mn>
</xsl:template>

<xsl:template match="om:OMF[not(@xref)]">
  <mn>
    <xsl:choose>
      <xsl:when test="@dec"><xsl:value-of select="format-number(@dec,'#')"/></xsl:when>
      <xsl:when test="@hex"><xsl:value-of select="format-number(@hex,'#')"/></xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="warning">
          <xsl:with-param name="string"
            select="'Must have xref, dec, or hex attribute to present an OMF'"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </mn>
</xsl:template>

<xsl:template match="omdoc:requation">
 <math>
  <mrow>
   <xsl:apply-templates select="omdoc:pattern/*/*"/>
   <mo>=</mo>
   <xsl:apply-templates select="omdoc:value/*/*"/>
  </mrow>
 </math>
</xsl:template>


<!-- docu see omdoc2share.xsl -->
<xsl:template name="print-symbol">
 <xsl:param name="print-form"/>
 <xsl:param name="crossref-symbol" select="'yes'"/>
 <xsl:param name="uri"/>
 <xsl:choose>
  <xsl:when test="$uri!='' and ($crossref-symbol='yes' or $crossref-symbol='all')">
   <mo xlink:href="{$uri}"><xsl:copy-of select="$print-form"/></mo>
  </xsl:when>
  <xsl:otherwise><xsl:copy-of select="$print-form"/></xsl:otherwise>
 </xsl:choose>
</xsl:template>


<xsl:template name="print-fence">
  <xsl:param name="fence"/>
  <mo fence="true"><xsl:value-of select="$fence"/></mo>
</xsl:template>

<xsl:template name="print-separator">
  <xsl:param name="separator"/>
  <mo separator="true"><xsl:value-of select="$separator"/></mo>
</xsl:template>

<!-- these templates take care of format-specific argument grouping -->
<xsl:template name="barg-group">
 <xsl:text disable-output-escaping="yes">&#xA;&lt;mrow&gt;</xsl:text>
</xsl:template>
<xsl:template name="earg-group">
 <xsl:text disable-output-escaping="yes">&#xA;&lt;/mrow&gt;&#xA;</xsl:text>
</xsl:template>

<xsl:template name="do-print-variable">
  <mi><xsl:value-of select="@name"/></mi>
</xsl:template>

</xsl:stylesheet>



