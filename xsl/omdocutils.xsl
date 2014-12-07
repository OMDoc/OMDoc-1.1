<?xml version="1.0" encoding="utf-8"?>
<!-- Utilities for OMDoc XSL style sheets. 
     URL: http://www.mathweb.org/omdoc/xsl/omdocutils.dtd
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


<xsl:stylesheet 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:func="http://exslt.org/functions" 
  extension-element-prefixes="func"
  xmlns:omdoc="http://www.mathweb.org/omdoc"
 version="1.0">  

<xsl:variable name="here" select="/"/>

<!-- this function constructs the effective URI. If the in the uri first argument
     is relative, we prefix it with the second argument, 
     if it is absolute, we take it as it is. -->
<func:function name="omdoc:effective-uri">
 <xsl:param name="uri"/>
 <xsl:param name="prefix"/>
 <xsl:choose>
  <xsl:when test="contains($uri,'://')"><func:result select="$uri"/></xsl:when>
  <xsl:otherwise><func:result select="concat($prefix,$uri)"/></xsl:otherwise>
 </xsl:choose>
</func:function>

<!-- this function computes the valid language from a set of given languages
     it is the first among those in $TargetLanguage that is also in 
     $given -->
<func:function name="omdoc:comp-valid-language">
 <xsl:param name="given"/>
 <xsl:param name="langs"/>
 <xsl:choose>
  <xsl:when test="$langs=''"><func:result select="''"/></xsl:when>
  <xsl:otherwise>
   <xsl:variable name="first">
    <xsl:choose>
     <xsl:when test="contains($langs,' ')">
      <xsl:value-of select="substring-before($langs,' ')"/>
     </xsl:when>
     <xsl:otherwise><xsl:value-of select="$langs"/></xsl:otherwise>
    </xsl:choose>
   </xsl:variable>
   <xsl:variable name="rest">
    <xsl:choose>
     <xsl:when test="contains($langs,' ')">
      <xsl:value-of select="substring-after($langs,' ')"/>
     </xsl:when>
     <xsl:otherwise><xsl:value-of select="''"/></xsl:otherwise>
    </xsl:choose>
   </xsl:variable>
   <xsl:choose>
    <xsl:when test="contains($given,$first)"><func:result select="$first"/></xsl:when>
    <xsl:otherwise>
     <func:result select="omdoc:comp-valid-language($given,$rest)"/>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:otherwise>
 </xsl:choose>
</func:function>

<!-- this function computes an URIref for cross-referencing given 
     - the URI of the OMDoc document that contains the definition
     - the id of the symbol in question
     - file extension of the format generated from the OMDoc -->
<func:function name="omdoc:crossref">
 <xsl:param name="uri"/>
 <xsl:param name="id"/>
 <xsl:param name="ext"/>
 <xsl:choose>
  <xsl:when test="$uri=''"><func:result select="concat('#',$id)"/></xsl:when>
  <xsl:otherwise>
   <func:result select="concat(substring-before($uri,'.omdoc'),'.',$ext,'#',$id)"/>
  </xsl:otherwise>
 </xsl:choose>
</func:function>

<xsl:template name="error">
  <xsl:param name="string"/>
  <xsl:if test="$report-errors!='no'">
    <xsl:message>Error: <xsl-value-of select="$string"/></xsl:message>
  </xsl:if>
</xsl:template>

<xsl:template name="warning">
  <xsl:param name="string"/>
  <xsl:if test="$report-errors!='no'">
    <xsl:message>Warning: <xsl-value-of select="$string"/></xsl:message>
  </xsl:if>
</xsl:template>


<!-- %%%%%%%%%%%%%%%%%%%%%%%% to be specialized %%%%%%%%%%%%%%%%%%%%%%%%%
     the following template are just a generic one that should be defined
     in the style sheets that inherit form this one. -->

<!-- 'do-nl' does a format-specific newline -->
<xsl:template name="do-nl"/>

<!--  'safe' escapes any offending charaters in a safe way -->
<xsl:template name="safe">
 <xsl:param name="string"/>
 <xsl:value-of select="$string"/>
</xsl:template>

<xsl:template name="print-fence">
 <xsl:param name="fence"/>
 <xsl:value-of select="$fence"/>
</xsl:template>

<xsl:template name="print-separator">
 <xsl:param name="separator"/>
 <xsl:value-of select="$separator"/>
</xsl:template>

<!-- these templates take care of format-specific argument grouping -->
<xsl:template name="barg-group"/>
<xsl:template name="earg-group"/>

<!-- this function takes an OMDoc (relative) URI Reference as input and 
     gives back the nodeset  referenced by this URI. -->
<func:function name="omdoc:get-uriref">
 <xsl:param name="uriref"/>
 <xsl:variable name="uri" select="substring-before($uriref,'#')"/>
 <xsl:variable name="fragment" select="substring-after($uriref,'#')"/>
 <xsl:choose>
  <!-- bare ID syntax, i.e. no #, so both are empty, so it must be in this document -->
  <xsl:when test="$fragment='' and $uri=''">
   <func:result select="//*[@id=$uriref]"/>
  </xsl:when>
  <xsl:when test="$fragment=''">
   <func:result select="document($uri,$here)/omdoc:omdoc"/>
  </xsl:when>
  <xsl:when test="contains($fragment,'byctx')">
   <xsl:variable name="arg" 
    select="substring-before(substring-after('byctx(',$fragment),')')"/>
   <xsl:variable name="theory">
    <xsl:choose>
     <xsl:when test="contains($arg,'@')">
      <xsl:value-of select="substring-before($arg,'@')"/>
     </xsl:when>
     <xsl:otherwise>
      <xsl:value-of select="self::ancestor[local-name()='theory']/@id"/>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:variable>
   <xsl:variable name="name">
    <xsl:choose>
     <xsl:when test="contains($arg,'@')">
      <xsl:value-of select="substring-after($arg,'@')"/>
     </xsl:when>
     <xsl:otherwise><xsl:value-of select="$arg"/></xsl:otherwise>
    </xsl:choose>
   </xsl:variable>
   <xsl:choose>
    <xsl:when test="$uri=''">
     <func:result select="//theory[@id=$theory]/*[@id=$name]"/>
    </xsl:when>
    <xsl:otherwise>
     <func:result select="document($uri,$here)//theory[@id=$theory]/*[@id=$name]"/>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:when>
  <xsl:otherwise>
   <xsl:choose>
    <xsl:when test="$uri=''">
     <func:result select="//*[@id=$fragment]"/>
    </xsl:when>
    <xsl:otherwise>
     <func:result select="document($uri,$here)//*[@id=$fragment]"/>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:otherwise>
 </xsl:choose>
</func:function>


<!-- this function takes an OMDoc (relative) URI Reference as input and 
     returns true, iff it is local to the document -->
<func:function name="omdoc:local-uri">
 <xsl:param name="uriref"/>
 <xsl:choose>
  <xsl:when test="substring-before($uriref,'#')=''">
   <func:result select="'true'"/>
  </xsl:when>
  <xsl:otherwise><func:result select="'false'"/></xsl:otherwise>
 </xsl:choose>
</func:function>

<!-- this function strips off the path prefix and only leaves the file name -->
<func:function name="omdoc:strip-prefix">
 <xsl:param name="uri"/>
 <xsl:choose>
  <xsl:when test="contains($uri,'/')">
   <func:result select="omdoc:strip-prefix(substring-after($uri,'/'))"/>
  </xsl:when>
  <xsl:otherwise>
   <func:result select="$uri"/>
  </xsl:otherwise>
 </xsl:choose>
</func:function>

<!-- this two templates provide verbatim copying with our without escaping, 
     even in html and text output modes -->
<xsl:template match="text()" mode="verbatimcopy">
 <xsl:value-of select="."/>
</xsl:template>

<xsl:template match="*" mode="verbatimcopy">
 <xsl:param name="indent" select="''"/>
 <xsl:text>&#xA;</xsl:text><xsl:value-of select="$indent"/>
 <xsl:text disable-output-escaping="yes">&lt;</xsl:text>
 <xsl:value-of select="local-name()"/>
 <xsl:text> </xsl:text>
 <xsl:for-each select="@*">
  <xsl:value-of select="name()"/>
  <xsl:text>="</xsl:text><xsl:value-of select="."/><xsl:text>"</xsl:text>
  <xsl:if test="position()!=last()"><xsl:text> </xsl:text></xsl:if>
 </xsl:for-each>
 <xsl:text disable-output-escaping="yes">&gt;</xsl:text>
 <xsl:apply-templates select="*|text()" mode="verbatimcopy">
  <xsl:with-param name="indent" select="concat($indent,' ')"/>
 </xsl:apply-templates>
 <xsl:value-of select="$indent"/>
 <xsl:text disable-output-escaping="yes">&lt;/</xsl:text>
 <xsl:value-of select="local-name()"/>
 <xsl:text disable-output-escaping="yes">&gt;&#xA;</xsl:text>
</xsl:template>


<xsl:template match="text()" mode="verbatimcopy-escaped">
 <xsl:value-of select="."/>
</xsl:template>

<xsl:template match="omdoc:data" mode="verbatimcopy-escaped"><xsl:apply-templates/></xsl:template>

<xsl:template match="*" mode="verbatimcopy-escaped">
 <xsl:param name="indent" select="''"/>
 <xsl:text>&#xA;</xsl:text><xsl:value-of select="$indent"/>
 <xsl:text disable-output-escaping="no">&lt;</xsl:text>
 <xsl:value-of select="local-name()"/>
 <xsl:text> </xsl:text>
 <xsl:for-each select="@*">
  <xsl:value-of select="name()"/>
  <xsl:text>="</xsl:text><xsl:value-of select="."/><xsl:text>"</xsl:text>
  <xsl:if test="position()!=last()"><xsl:text> </xsl:text></xsl:if>
 </xsl:for-each>
 <xsl:text disable-output-escaping="no">&gt;</xsl:text>
 <xsl:apply-templates select="*|text()" mode="verbatimcopy-escaped">
  <xsl:with-param name="indent" select="concat($indent,' ')"/>
  <xsl:with-param name="escaping" select="no"/>
 </xsl:apply-templates>
 <xsl:value-of select="$indent"/>
 <xsl:text disable-output-escaping="no">&lt;/</xsl:text>
 <xsl:value-of select="local-name()"/>
 <xsl:text disable-output-escaping="no">&gt;&#xA;</xsl:text>
</xsl:template>

</xsl:stylesheet>



