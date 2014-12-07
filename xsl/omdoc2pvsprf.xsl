<!-- An XSL style sheet for creating POST representations from OMDoc
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

<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:str="http://exslt.org/strings" 
 extension-element-prefixes="str"
 xmlns:om="http://www.openmath.org/OpenMath"
 xmlns:dc="http://www.purl.org/DC"
 version="1.0">

<xsl:output method="text"/>

<xsl:strip-space elements="*"/>

<xsl:template match="*"/>

<xsl:template match="/|omdoc"><xsl:apply-templates/></xsl:template>

<xsl:template match="theory">
  <xsl:if test="not(@id=str:tokenize(../private/@replaces))">
    <xsl:text>(|</xsl:text>
    <xsl:value-of select="@id"/>
    <xsl:text>| </xsl:text>
    <xsl:apply-templates/>
    <xsl:text>)</xsl:text>
  </xsl:if>
</xsl:template>

<xsl:template match="private[@pto='pvs' and @type='proofscript']">
  <xsl:text>(|</xsl:text>
  <xsl:value-of select="@id"/>
  <xsl:text>| "" </xsl:text>
  <xsl:value-of  select="normalize-space(substring-after(data,'('))"/>
</xsl:template>
</xsl:stylesheet>
