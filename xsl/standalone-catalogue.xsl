<!-- An XSL style sheet for creating a standalone omdoc catalogue.
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
 xmlns:set="http://exslt.org/strings" 
 xmlns:om="http://www.openmath.org/OpenMath"
 extension-element-prefixes="str"
 xmlns:out="output.xsl"
 version="1.0">

<xsl:import href="omdoc-helpers.xsl"/>

<xsl:output method="xml"
  version="1.0"
  indent="yes"
  standalone="yes"/>

<xsl:strip-space elements="*"/>

<!-- the keys are only for efficiency -->
<xsl:key name="om:OMSs" match="//OMS" use="@cd"/>
<xsl:variable name="cdus" select="set:distinct(//om:OMS/@cd)/.."/>
<!-- <xsl:variable name="cdus" select="//om:OMS[not(@cd=preceding::OMS/@cd)]"/>-->
<xsl:variable name="externals" select="$cdus[not(@cd=//theory/@id)]"/>
<xsl:variable name="locals" select="$cdus[@cd=//theory/@id]"/>
<!-- then we build the local catalogue and put it in  a variable -->

<xsl:template match="/">
  <xsl:text>&#xA;&#xA;</xsl:text>
  <xsl:comment>
    A standalone omdoc catalogue, generated for inclusion.
  </xsl:comment>
  <xsl:text>&#xA;&#xA;</xsl:text>
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="omdoc">
  <catalogue>
    <xsl:call-template name="make-external">
      <xsl:with-param name="externals" select="$externals"/>
      <xsl:with-param name="document" select="/"/>
    </xsl:call-template>
  </catalogue>
</xsl:template>


<xsl:template match="om:OMS"><xsl:value-of select="@cd"/><xsl:text>,</xsl:text></xsl:template>

<xsl:template name="make-external">
  <xsl:param name="externals"/>
  <xsl:param name="document"/>
  <xsl:variable name="incat" 
    select="$externals[@cd=$document/omdoc/catalogue/loc/@theory]"/>
  <xsl:variable name="rest" select="set:difference($externals,$incat)"/>    
    <!--   select="$externals[@cd!=$document/omdoc/catalogue/loc/@theory]"/>-->
  <xsl:for-each select="$incat">
    <xsl:variable name="cd" select="@cd"/>
    <loc theory="{$cd}" omdoc="{$document/omdoc/catalogue/loc[@theory=$cd]/@omdoc}"/>
  </xsl:for-each>
  <xsl:if test="$rest">
    <xsl:choose>
      <!-- if there is a catalogue specified in the <omdoc> element -->
      <xsl:when test="$document/omdoc/@catalogue!=''">
        <xsl:variable name="file">
          <xsl:call-template name="load-omdoc">
            <xsl:with-param name="uri" select="$document/omdoc/@catalogue"/>
          </xsl:call-template>
        </xsl:variable>
        <!-- if we have loaded the external catalogue file successfully  -->
        <xsl:if test="$file">
          <xsl:call-template name="make-external">
            <xsl:with-param name="externals" select="$rest"/>
            <xsl:with-param name="document"
              select="document($file)"/>
          </xsl:call-template>
        </xsl:if>
      </xsl:when>
      <xsl:otherwise>
        <xsl:message>Cannot find locatations for the theories 
        <xsl:apply-templates select="$rest"/>!</xsl:message>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:if>
</xsl:template>
</xsl:stylesheet>
