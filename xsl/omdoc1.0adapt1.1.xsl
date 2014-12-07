<?xml version="1.0" encoding="utf-8"?>
<!-- this is a style sheet that serves as a seed to transforming an 
     OMDoc from version 1.0 to 1.1. It copies everything verbatim, except
     those templates that have been changed.

     Initial version 20000824 by Michael Kohlhase, 
     send bug-reports, patches, suggestions to omdoc@mathweb.org

     NOTE, that this style sheet will eliminate comments and put in all 
     default values for attributes that are specified in the DTD.

     To get around the comment problems, put those you want to preserve 
     into 'ignore' elements, the second one is actually a plus, since 
     it makes the whole thing more explicit.

     The main problem in this is to move the 'private' elements out of the
     'assertion', 'axiom', 'exercise', 'hint', 'solution', and 'answer' 
     elements to the top level, exchanging the dominance-based reference 
     mechanism for a crossreference-based one. We do this by going over 
     the omdoc twice. First time in general mode (augmenting where necessary
     the elements above with an 'id' attribute generated from the path  
     (by the 'pref' parameter)) and the second time in the 'private' mode. 
     Here the 'pref' parameter is used to cross-reference, whenever there was 
     no original 'id' attribute (we use the 'alist' parameter to record this).

     Copyright (c) 2001 - 2002 Michael Kohlhase, 

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
 xsl:extension-element-prefixes="saxon str"
 xmlns:saxon="http://icl.com/saxon" 
 xmlns:str="http://exslt.org/strings" 
 xmlns:dc="http://www.purl.org/DC" 
 version="1.0">
 
<!-- this parameter makes the new identifiers unique -->
<xsl:param name="prefix" select="'omdoc1.0adapt1.1-'"/>
<!-- this parameter allows to specify a local dtd -->
<xsl:param name="dtd"/>

<xsl:output method="xml" indent="yes" cdata-section-elements="data signature"/>
<xsl:strip-space elements="*"/>

<xsl:template match="/">
  <xsl:text>&#xA;&#xA;</xsl:text>
  <saxon:doctype xsl:extension-element-prefixes="saxon"
    xmlns:dtd="http://icl.com/saxon/dtd" xsl:exclude-result-prefixes="dtd">
    <xsl:choose>
      <xsl:when test="$dtd=''">
        <dtd:doctype name="omdoc" system="http://www.mathweb.org/omdoc/dtd/omdoc1.1.dtd"/>
      </xsl:when>
      <xsl:otherwise>
        <dtd:doctype name="omdoc" system="{$dtd}"/>
      </xsl:otherwise>
    </xsl:choose>
  </saxon:doctype>
  <xsl:text>&#xA;&#xA;</xsl:text>
  <xsl:apply-templates>
    <xsl:with-param name="pref" select="concat($prefix,position())"/>
  </xsl:apply-templates>
  <xsl:text>&#xA;&#xA;</xsl:text>
</xsl:template>

<!-- this template copies the element with all its attributes and recurses 
     it does not copy private elements, -->
<xsl:template match="text()|*">
  <xsl:param name="pref"/>
  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <xsl:apply-templates select="text()|*[local-name()!='private']">
      <xsl:with-param name="pref" select="concat($pref,position())"/>
    </xsl:apply-templates>
  </xsl:copy>
</xsl:template>

<xsl:template match="omdoc">
  <xsl:param name="pref"/>
  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <xsl:apply-templates>
      <xsl:with-param name="pref" select="concat($pref,position())"/>
    </xsl:apply-templates>
    <xsl:apply-templates 
      select="*[local-name()!='omgroup' and local-name!='theory']" 
      mode="private">
      <xsl:with-param name="pref" select="concat($pref,position())"/>
    </xsl:apply-templates>
  </xsl:copy>
</xsl:template>

<xsl:template match="omgroup|theory">
  <xsl:param name="pref"/>
  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <xsl:apply-templates>
      <xsl:with-param name="pref" select="concat($pref,position())"/>
    </xsl:apply-templates>
    <xsl:apply-templates 
      select="*[local-name()!='omgroup' and local-name()!='theory']" 
      mode="private">
      <xsl:with-param name="pref" select="concat($pref,position())"/>
    </xsl:apply-templates>
  </xsl:copy>
</xsl:template>

<!-- we have a mode 'private', which only copies the private elements, 
     but keeps track of the path in the $pref parameter -->
<xsl:template match="*" mode="private">
  <xsl:param name="pref"/>
  <xsl:param name="alist"/>
  <xsl:apply-templates select="*" mode="private">
    <xsl:with-param name="pref" select="concat($pref,position())"/>
    <xsl:with-param name="alist" select="$alist"/>
  </xsl:apply-templates>
</xsl:template>

<xsl:template match="hint|assertion|solution|answer|choice|exercise|assertion|axiom" mode="private">
  <xsl:param name="pref"/>
  <xsl:param name="alist"/>
  <xsl:choose>
    <xsl:when test="not(@id)">
      <xsl:apply-templates mode="private">
        <xsl:with-param name="pref" select="concat($pref,position())"/>
        <xsl:with-param name="alist" select="$alist"/>
      </xsl:apply-templates>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates mode="private">
        <xsl:with-param name="pref" select="concat($pref,position())"/>
        <xsl:with-param name="alist" select="concat(@id,' ',$pref,position(),' ',$alist)"/>
      </xsl:apply-templates>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- of course the 'private' elements themselves are copied -->
<xsl:template match="private" mode="private">
  <xsl:param name="pref"/>
  <xsl:param name="alist"/>
  <xsl:copy>
    <xsl:copy-of select="@*[local-name()!='classid' and local-name()!='codebase']"/>
    <xsl:if test="@classid or @codebase">
     <xsl:message>
      Deleting attribute '<xsl:value-of select="local-name()"/>' on 'private' element, where it does not make sense!
     </xsl:message>
    </xsl:if>
    <xsl:attribute name="for">
      <xsl:choose>
        <xsl:when test="contains($alist,string($pref))">
          <xsl:value-of select="substring-before($alist,concat(' ',$pref))"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$pref"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
    <xsl:apply-templates/>
  </xsl:copy>
</xsl:template>



<xsl:template match="hint|assertion|solution|answer|choice">
  <xsl:param name="pref"/>
  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <xsl:if test="not(@id)">
      <xsl:attribute name="id">
        <xsl:value-of select="concat($pref,position())"/>
      </xsl:attribute>
      <xsl:apply-templates select="*[local-name()!='private']">
        <xsl:with-param name="pref" select="concat($pref,position())"/>
      </xsl:apply-templates>
    </xsl:if>
  </xsl:copy>
</xsl:template>

<!-- the stuff that also changes -->


<xsl:template match="signature">
  <xsl:message>
    Wrapping deprecated 'signature' element into 'ignore' element.
  </xsl:message>
  <ignore comment="element deprecated in OMDoc1.1">
    <xsl:text disable-output-escaping="yes">&#xA;&lt;![CDATA[</xsl:text>
    <xsl:copy-of select="."/>
    <xsl:text disable-output-escaping="yes">]]&gt;&#xA;</xsl:text>
  </ignore>
</xsl:template>

<xsl:template match="selector">
  <xsl:copy>
    <xsl:copy-of select="@*[local-name()!='type']"/>
    <xsl:choose>
      <xsl:when test="@type='total'">
        <xsl:attribute name="total">
          <xsl:text>yes</xsl:text>
        </xsl:attribute>
      </xsl:when>
      <xsl:when test="@type='partial'">
        <xsl:attribute name="total">
          <xsl:text>no</xsl:text>
        </xsl:attribute>
      </xsl:when>
    </xsl:choose>
    <xsl:apply-templates/>
  </xsl:copy>
</xsl:template>

<xsl:template match="hypothesis">
  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <xsl:message>
      Attribute 'discharged-in' missing in 'hypothesis' <xsl:value-of select="@id"/>!
    </xsl:message>
    <xsl:attribute name="discharged-in">
      <xsl:text>***missing***</xsl:text>
    </xsl:attribute>
    <xsl:apply-templates/>
  </xsl:copy>
</xsl:template>

<xsl:template match="sortdef">
  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <xsl:message>
      Attribute 'id' missing in 'sortdef' element in 'adt' <xsl:value-of select="../@id"/>!
    </xsl:message>
    <xsl:attribute name="id">
      <xsl:text>***missing***</xsl:text>
    </xsl:attribute>
    <xsl:apply-templates/>
  </xsl:copy>
</xsl:template>

<!-- rename alternative-def elements to alternative-->
<xsl:template match="alternative-def">
 <xsl:param name="pref"/>
 <alternative>
  <xsl:copy-of select="@*"/>
  <xsl:apply-templates select="text()|*[local-name()!='private']">
   <xsl:with-param name="pref" select="concat($pref,position())"/>
  </xsl:apply-templates>
 </alternative>
</xsl:template>

<!-- put the OMOBJ in a paramter element directly there -->
<xsl:template match="parameter">
 <xsl:apply-templates select="OMOBJ"/>
</xsl:template>

<!-- Translator does not exist any more, use Contributor -->
<xsl:template match="dc:Translator">
 <Contributor role="trl" xml:lang="{@xml:lang}">
  <xsl:apply-templates/>
 </Contributor>
</xsl:template>


<xsl:template match="dc:Coverage">
 <xsl:message>
  Dubline Core Element Coverage deprecated in OMDoc1.1 deleting!
 </xsl:message>
</xsl:template>

<xsl:template match="assertion-just">
 <xsl:variable name="assertions" select="str:tokenize(@ids,' ')"/>
 <xsl:for-each select="$assertion">
  <xsl:message>
   Need to specify the axiom of definition in theory <xsl:value-of select="../@from"/>, 
   that induces the assertion <xsl:value-of select="$assertion"/> as a proof obligation.
   Please replace the keyword 'MISSING' in the result by the appropriate value!
  </xsl:message>
  <obligation induced-by="MISSING" assertion="{.}"/>
 </xsl:for-each>
</xsl:template>

<xsl:template math="theory-inclusion">
 <xsl:copy>
  <xsl:choose>
   <xsl:when test="@timestamp and metadata">
    <metadata>
     <xsl:apply-templates select="metadata/*"/>
     <Date><xsl:apply-templates select="@timestamp"/></Date>
    </metadata>
   </xsl:when>
   <xsl:otherwise>
    <xsl:apply-templates select="metadata"/>
   </xsl:otherwise>
  </xsl:choose>
  <xsl:copy-of select="@*[local-name()!=timestamp]"/>
  <xsl:apply-templates select="text()|*[local-name()!='decomposition' and 
                                        local-name()!='metadata']"/>
 </xsl:copy>
 <xsl:copy>
  <xsl:attribute name="for" select="@id"/>
  <xsl:copy-of select="@*"/>
 </xsl:copy>
</xsl:template>

<!-- do the timestamp treatment for other theory stuff -->
</xsl:stylesheet>
