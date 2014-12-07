<?xml version="1.0" encoding="utf-8"?>
<!-- An XSL style sheet for creating PVS representations from OMDoc
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
 xmlns:saxon="http://icl.com/saxon"
 extension-element-prefixes="saxon"
 xmlns:om="http://www.openmath.org/OpenMath"
 xmlns:dc="http://www.purl.org/DC"
 xmlns:omdoc="http://www.mathweb.org/omdoc"
 version="1.0">

<xsl:import href="omdoc2sys.xsl"/>
<xsl:variable name="format" select="'pvs'"/>
<xsl:param name="TargetLanguage" select="'en'"/>
<xsl:param name="report-errors" select="'yes'"/>
<xsl:output method="text"/>

<xsl:template match="omdoc:theory|omdoc:symbol|omdoc:assertion|omdoc:axiom">
  <xsl:variable name="privates">
    <xsl:for-each select="../omdoc:private/@replaces">
      <xsl:value-of select="."/><xsl:text> </xsl:text>
    </xsl:for-each>
  </xsl:variable>
  <xsl:if test="not(@id=saxon:tokenize($privates)) and (not(@generated-by) or @generated-by='')">
    <xsl:apply-templates select="." mode="doit"/>
  </xsl:if>
</xsl:template>

<xsl:template match="omdoc:theory" mode="doit">
  <xsl:value-of select="@id"/>
  <xsl:choose>
    <xsl:when test="omdoc:adt"><xsl:apply-templates select="omdoc:adt"/></xsl:when>
    <xsl:otherwise>
      <xsl:if test="imports">
        <xsl:variable name="partheo" select="omdoc:imports/@from"/>
        <xsl:text> [</xsl:text>
        <xsl:for-each select="../omdoc:theory[@id=$partheo]/omdoc:symbol">
          <xsl:value-of select="@id"/>
          <xsl:text>: </xsl:text>
          <xsl:apply-templates select="omdoc:type/om:OMOBJ"/>
          <xsl:if test="position()!=last()"><xsl:text>,</xsl:text></xsl:if>
        </xsl:for-each>
        <xsl:text>]</xsl:text>
      </xsl:if>
      <xsl:text>: THEORY&#xA; BEGIN&#xA;&#xA;</xsl:text>
      <xsl:apply-templates/>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:text>&#xA;&#xA; END </xsl:text>
  <xsl:value-of select="@id"/>
  <xsl:text>&#xA;&#xA;</xsl:text>
</xsl:template>

<xsl:template match="omdoc:symbol[@kind='type']" mode="doit">
  <xsl:text>  </xsl:text><xsl:value-of disable-output-escaping="yes" select="@id"/>
  <xsl:variable name="id" select="@id"/>
  <xsl:text>: </xsl:text>
  <xsl:apply-templates select="omdoc:type"/>
  <xsl:if test="../omdoc:definition[@for=$id]">
    <xsl:text> = </xsl:text>
    <xsl:apply-templates select="../omdoc:definition[@for=$id]/omdoc:FMP/om:OMOBJ"/>
  </xsl:if>
   <xsl:text>;&#xA;</xsl:text>
</xsl:template>

<xsl:template match="omdoc:data"><xsl:apply-templates/></xsl:template>

<xsl:template match="omdoc:symbol" mode="doit">
  <xsl:variable name="id" select="@id"/>
  <xsl:variable name="def" select="following-sibling::omdoc:definition[@for=$id and position()=1]"/>
  <xsl:variable name="type" select="$def/@type"/>
  <xsl:if test="omdoc:CMP[@xml:lang='en']">
    <xsl:call-template name="comment-lines">
      <xsl:with-param name="text" select="omdoc:CMP[@xml:lang='en']"/>
    </xsl:call-template>
  </xsl:if>
  <xsl:text>  </xsl:text>
  <xsl:value-of disable-output-escaping="yes" select="@id"/>
  <xsl:text>: </xsl:text>
  <xsl:if test="$type='recursive'"><xsl:text>RECURSIVE </xsl:text></xsl:if>
  <xsl:apply-templates select="omdoc:type[@system='pvs']"/>
  <xsl:if test="$def">
    <xsl:text> = </xsl:text>
    <xsl:choose>
      <xsl:when test="$type='simple' or $type='recursive'"><xsl:apply-templates select="$def/omdoc:FMP/om:OMOBJ/om:OMA/*[3]"/></xsl:when>
      <xsl:when test="$type='inductive'">
        <xsl:message>Error: PVS transformation cannot handle inducive definitions yet. </xsl:message>
      </xsl:when>
    </xsl:choose>
    <xsl:if test="$def/omdoc:measure">
      <xsl:text> MEASURE </xsl:text>
      <xsl:apply-templates select="$def/omdoc:measure"/>
      <xsl:if test="$def/omdoc:ordering">
        <xsl:text> BY </xsl:text>
        <xsl:apply-templates select="$def/omdoc:ordering"/>
      </xsl:if>
    </xsl:if>
  </xsl:if>
  <xsl:text>;&#xA;</xsl:text>
</xsl:template>

<!--<xsl:template match="FMP"><xsl:message>fmp</xsl:message></xsl:template>-->

<xsl:template match="omdoc:type|omdoc:measure|omdoc:ordering">
 <xsl:apply-templates/>
</xsl:template>

<!-- for the moment we do not need them, since we do it in the symbol case -->
<xsl:template match="omdoc:definition"/>

<xsl:template match="om:OMOBJ">
 <xsl:apply-templates/>
</xsl:template>

<xsl:template match="om:OMS|om:OMV"><xsl:value-of disable-output-escaping="yes" select="@name"/></xsl:template>

<xsl:template match="om:OMA">
  <xsl:apply-templates select="*[1]"/>
  <xsl:text>(</xsl:text>
  <xsl:for-each select="*[position()!=1]">
    <xsl:apply-templates select="."/>
    <xsl:if test="position()!=last()">
      <xsl:text>,</xsl:text>
    </xsl:if>
  </xsl:for-each>
  <xsl:text>)</xsl:text>
</xsl:template>

<xsl:template match="om:OMBIND">
  <xsl:text>(</xsl:text>
  <xsl:value-of select="*[1]/@name"/>
  <xsl:text>(</xsl:text>
  <xsl:apply-templates select="om:OMBVAR"/>
  <xsl:text>): </xsl:text>
  <xsl:apply-templates select="*[3]"/>
  <xsl:text>)</xsl:text>
</xsl:template>

<xsl:template match="om:OMBVAR">
  <xsl:for-each select="*">
    <xsl:apply-templates select="."/>    
    <xsl:if test="position()!=last()"><xsl:text>, </xsl:text></xsl:if>
  </xsl:for-each>
</xsl:template>

<xsl:template match="om:OMATTR">
  <xsl:apply-templates select="*[2]"/>
  <xsl:if test="om:OMATP/om:OMS[@cd='pvs' and @name='type']">
    <xsl:text>: </xsl:text>
    <xsl:apply-templates select="om:OMATP/om:OMS[@cd='pvs' and @name='type']/following-sibling::node()"/>
  </xsl:if>
  <xsl:if test="position()!=last()"><xsl:text>,</xsl:text></xsl:if>
</xsl:template>

<xsl:template name="bcomment"><xsl:text>%%% </xsl:text></xsl:template>

<xsl:template match="omdoc:private"/>

<xsl:template match="om:OMI"><xsl:apply-templates/></xsl:template>

<xsl:template match="om:OMSTR">
  <xsl:text>"</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>"</xsl:text>
</xsl:template>

<xsl:template match="omdoc:assertion[@type='obligation']|omdoc:imports"/>

<xsl:template match="omdoc:assertion" mode="doit">
  <xsl:value-of select="@id"/>
  <xsl:text>: </xsl:text>
  <xsl:value-of select="translate(@type,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
  <xsl:text> </xsl:text>
  <xsl:apply-templates select="omdoc:FMP/om:OMOBJ"/>
  <xsl:text>;&#xA;</xsl:text>
</xsl:template>

<xsl:template match="omdoc:axiom" mode="doit">
  <xsl:value-of select="@id"/>
  <xsl:text>: AXIOM </xsl:text>
  <xsl:apply-templates select="omdoc:FMP/om:OMOBJ"/>
  <xsl:text>;&#xA;</xsl:text>
</xsl:template>

<xsl:template match="omdoc:adt">
  <xsl:if test="omdoc:imports">
    <xsl:variable name="partheo" select="omdoc:imports/@from"/>
    <xsl:text> [</xsl:text>
    <xsl:for-each select="../omdoc:theory[@id=$partheo]/omdoc:symbol">
      <xsl:value-of select="@id"/>
      <xsl:text>: </xsl:text>
      <xsl:apply-templates select="omdoc:type/om:OMOBJ"/>
      <xsl:if test="position()!=last()"><xsl:text>,</xsl:text></xsl:if>
    </xsl:for-each>
    <xsl:text>]</xsl:text>
  </xsl:if>
  <xsl:text>: DATATYPE&#xA; BEGIN&#xA;&#xA;</xsl:text>
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="omdoc:sortdef"><xsl:apply-templates/></xsl:template>

<xsl:template match="omdoc:constructor">
  <xsl:text>  </xsl:text>
  <xsl:value-of select="@id"/>
  <xsl:if test="omdoc:argument">
    <xsl:text>(</xsl:text>
    <xsl:for-each select="omdoc:argument">
      <xsl:apply-templates select="."/>
      <xsl:if test="position()!=last()"><xsl:text>, </xsl:text></xsl:if>
    </xsl:for-each>
    <xsl:text>)</xsl:text>
  </xsl:if>
  <xsl:text>: </xsl:text>
  <xsl:value-of select="omdoc:recognizer/@id"/>
  <xsl:text>&#xA;</xsl:text>
</xsl:template>

<xsl:template match="omdoc:argument">
  <xsl:value-of select="omdoc:selector/@id"/>
  <xsl:text>: </xsl:text>
  <xsl:value-of select="@sort"/>
</xsl:template>
</xsl:stylesheet>
