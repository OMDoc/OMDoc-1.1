<!-- An XSL style sheet for creating xsl style sheets for presenting 
     OpenMath Symbols from OMDoc presentation elements.

     Initial version 20000824 by Michael Kohlhase, 
     send bug-reports, patches, suggestions to omdoc@mathweb.org

     Copyright (c) 2000-2002 Michael Kohlhase, 

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
  xmlns:exsl="http://exslt.org/common" 
  xmlns:set="http://exslt.org/sets" 
  xmlns:out="output.xsl"
  xmlns:om="http://www.openmath.org/OpenMath"
  xmlns:omdoc="http://www.mathweb.org/omdoc"
  extension-element-prefixes="exsl set"
  exclude-result-prefixes="om omdoc exsl"
  version="1.0">

<xsl:import href="omdocutils.xsl"/>
<xsl:param name="report-errors" select="'no'"/> 
<xsl:param name="self"/> 

<xsl:output method="xml" version="1.0" indent="yes" standalone="yes"/>
<xsl:strip-space elements="*"/>

<xsl:namespace-alias stylesheet-prefix="out" result-prefix="xsl"/>

<xsl:variable name="here" select="/"/>

<!-- we first collect all of the document (including the sub-documents
     reference in the 'ref' nodes) into a variable. -->
<xsl:variable name="all">
 <xsl:apply-templates select="/" mode="all"/>
</xsl:variable>
<xsl:template match="*" mode="all">
  <xsl:copy><xsl:copy-of select="@*"/><xsl:apply-templates mode="all"/></xsl:copy>
</xsl:template>
<xsl:template match="omdoc:ref[@type='include']" mode="all">
 <xsl:variable name="uri" select="@xref"/>
 <xsl:apply-templates select="omdoc:get-uriref($uri)" mode="all"/>
</xsl:template>
<!-- do not look into OpenMath Error elements -->
<xsl:template match="om:OME" mode="all"/>

<!-- We collect the set of distinct symbols in the document -->
<xsl:variable name="cdus" select="set:distinct(exsl:node-set($all)/descendant::om:OMS/@cd)/.."/>

<!-- We build the local catalogue and put it in  a variable -->
<xsl:variable name="tree">
  <!-- we determine those symbols whose symbol definition is not 
       in this document and that do not have a namespace -->
  <xsl:variable name="todo"
    select="exsl:node-set($cdus)[not(@cd=exsl:node-set($all)//omdoc:theory/@id) and not(contains(@cd,':'))]"/>
 <catalogue>
  <!-- we recursively hunt down the locations in the catalogue -->
  <xsl:call-template name="make-external">
   <xsl:with-param name="todo" select="$todo"/>
   <xsl:with-param name="document" select="$all"/>
  </xsl:call-template>
  <!-- and then the ones we get from the namespaces -->
  <xsl:for-each select="$cdus[contains(@cd,':')]">
    <xsl:variable name="ns" select="substring-before(@cd,':')"/>
    <xsl:variable name="nsuri" select="namespace::*[local-name()=$ns]"/>
    <xsl:choose>
      <xsl:when test="$nsuri!=''">
        <loc theory="{@cd}" omdoc="{$nsuri}/{@cd}.omdoc"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:message>could not find namespace declaration for theory <xsl:value-of select="@cd"/>!</xsl:message>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:for-each>
 </catalogue>
</xsl:variable>
<xsl:variable name="href-cat" select="exsl:node-set($tree)"/> 

<!-- the top-level template prints the header of the xsl style sheet. -->
<xsl:template match="/">
 <xsl:text>&#xA;&#xA;</xsl:text>
 <xsl:comment>
  an xsl style sheet for presenting openmath symbols used in the 
  OMDoc document with id=<xsl:value-of select="/omdoc:omdoc/@id"/>.

  This xsl style file is automatically generated, do not edit!
 </xsl:comment>
 <xsl:text>&#xA;&#xA;</xsl:text>
 <out:stylesheet version="1.0">
  <xsl:text>&#xA;&#xA;</xsl:text>
  
  <out:variable name="tree">
   <xsl:copy-of select="$href-cat"/>
  </out:variable>
  <out:variable name="href-cat" select="$tree"/> 
  <xsl:text>&#xA;&#xA;</xsl:text>
  <out:include href="{$self}"/>
  <xsl:for-each 
   select="set:distinct($href-cat/catalogue/loc[@theory!='']/@omdoc)">
   <out:include href="{substring-before(.,'.omdoc')}-tmpl.xsl"/>
  </xsl:for-each>
 </out:stylesheet>
 <xsl:text>&#xA;</xsl:text>
</xsl:template>

<xsl:template match="*"/>


<!-- this procedure recursively examines the documents mentioned in the -->
<!-- 'catalogue' attribute of the 'omdoc' element and extracts the 'loc' elements -->
<xsl:template name="make-external">
  <xsl:param name="todo"/><!-- the symbols that still need a catalogue entry-->
  <xsl:param name="document"/><!-- the document that is searched for them -->
  <xsl:param name="prefix-URI"/><!-- the URI prefix that needs to be considered -->
 <!-- the catalogue in $document -->
 <xsl:variable name="local-cat" select="exsl:node-set($document)/omdoc:omdoc/omdoc:catalogue"/>
 <!-- those theories that are in the catalogue of the document specified by the -->
 <!-- parameter $document -->
 <xsl:variable name="incat" 
  select="$todo[@cd=$local-cat/omdoc:loc/@theory]"/>
 <xsl:variable name="rest" select="set:difference($todo,$incat)"/>    
 <xsl:for-each select="$incat">
  <xsl:variable name="cd" select="@cd"/>
  <xsl:variable name="uri" select="omdoc:effective-uri(exsl:node-set($local-cat)/omdoc:loc[@theory=$cd]/@omdoc,$prefix-URI)"/>
   <loc theory="{$cd}" omdoc="{$uri}"/>
 </xsl:for-each>
 <xsl:if test="$rest">
  <xsl:choose>
   <!-- if there is a catalogue specified in the <omdoc> element -->
   <xsl:when test="exsl:node-set($document)/omdoc:omdoc/@catalogue!=''">
    <xsl:variable name="cat-URI" select="exsl:node-set($document)/omdoc:omdoc/@catalogue"/>
    <xsl:variable name="prefix-from-cat" select="substring-before(exsl:node-set($cat-URI),omdoc:strip-prefix($cat-URI))"/>
    <xsl:variable name="prefix" select="omdoc:effective-uri($prefix-from-cat,$prefix-URI)"/>
    <xsl:message>Examining external catalogue <xsl:value-of select="$cat-URI"/> ...</xsl:message>
    <xsl:variable name="doc" select="document($cat-URI,$here)"/>
    <xsl:if test="not($doc)">
      <xsl:message>Could not find catalogue <xsl:value-of select="$cat-URI"/>!</xsl:message>
    </xsl:if>
    <xsl:call-template name="make-external">
     <xsl:with-param name="todo" select="$rest"/>
     <xsl:with-param name="document" select="$doc"/>
     <xsl:with-param name="prefix-URI" select="$prefix"/>
    </xsl:call-template>
   </xsl:when>
   <xsl:otherwise>
    <xsl:message>Cannot find locations for the theories 
    <xsl:for-each select="$rest">
     <xsl:value-of select="@cd"/>
     <xsl:if test="position()!=last()">,</xsl:if>
    </xsl:for-each>!</xsl:message>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:if>
</xsl:template>


</xsl:stylesheet>




