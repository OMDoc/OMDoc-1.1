<?xml version="1.0" encoding="iso-8859-1"?>
<!-- An XSL style sheet for creating html from OMDoc (Open Mathematical Documents). 
     URL: http://www.mathweb.org/omdoc/xsl/omdoc2html.dtd

     Copyright (c) 2002 Michael Kohlhase, 

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
  xmlns="http://www.w3.org/1998/Math/MathML"
  exclude-result-prefixes="om dc omdoc xsl"
  version="1.0">  

<xsl:import href="omdoc2html.xsl"/>
<xsl:variable name="format" select="'cmml'"/>

<xsl:output method="xml" 
            version="1.0"
            standalone="yes"
            indent="yes" 
            doctype-public="'-//W3C//DTD XHTML 1.0 Strict//EN' 'mathml.dtd'"/>

<xsl:strip-space elements="*"/>

<xsl:template match="/">
 <xsl:text>&#xA;</xsl:text>
 <xsl:processing-instruction name="xml-stylesheet"> type="text/xsl" href="http://www.w3.org/Math/XSL/mathml.xsl</xsl:processing-instruction>
 <xsl:text>&#xA;&#xA;</xsl:text>
 <xsl:comment>
  <xsl:call-template name="localize">
   <xsl:with-param name="key" select="'boilerplate'"/>
  </xsl:call-template>
 </xsl:comment>
 <xsl:text>&#xA;&#xA;</xsl:text>
 <html  xmlns="http://www.w3.org/1999/xhtml"
        xmlns:pref="http://www.w3.org/2002/Math/preference"
        pref:renderer="mathplayer-dl"
         xmlns:m="http://www.w3.org/1998/Math/MathML">
  <head>
   <!--   <link rel="stylesheet" type="text/css" href="{$css}"/> -->
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
 <math xmlns="http://www.w3.org/1998/Math/MathML">
   <xsl:apply-templates/>
 </math>
</xsl:template>

<xsl:template match="om:OMA[not(@xref)]">
  <apply>
   <xsl:apply-templates/>
  </apply>
</xsl:template>
sdfsdfsdfsdf
<xsl:template match="om:OMBVAR">
 <xsl:for-each select="*">
  <bvar><xsl:apply-templates/></bvar>
 </xsl:for-each>
</xsl:template>
sdfsdfsdfsdfsdfsdfsdfsdfNPNPN
<xsl:template match="om:OMATTppR"><xsl:apply-templates select="*[2]"/></xsl:template>

<xsl:template match="om:OMSTR[not(@xref)]">
  <mtext><xsl:apply-templates/></mtext>
</xsl:template>

<xsl:template match="om:OMS">
 <csymbol DefinitionURL="{@cd}#{@name}"/>
</xsl:template>

<xsl:template match="om:OMI[not(@xref)]">
 <cn><xsl:apply-templates/></cn>
</xsl:template>

<xsl:template match="om:OMF[not(@xref)]">
  <cn>
    <xsl:choose>
      <xsl:when test="@dec"><xsl:value-of select="format-number(@dec,'#')"/></xsl:when>
      <xsl:when test="@hex"><xsl:value-of select="format-number(@hex,'#')"/></xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="warning">
          <xsl:with-param name="string"
            select="'Must have xref, dec, or hex attirbute to present an OMF'"/>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </cn>
</xsl:template>

<xsl:template match="omdoc:requation" mode="format">
 <math xmlns="http://www.w3.org/1998/Math/MathML">
   <xsl:apply-templates select="." mode="inner"/>
 </math>

</xsl:template>


<xsl:template name="do-print-variable">
  <ci><xsl:value-of select="@name"/></ci>
</xsl:template>

<!-- these templates take care of format-specific argument grouping -->
<xsl:template name="barg-group"/>
<xsl:template name="earg-group"/>

</xsl:stylesheet>



