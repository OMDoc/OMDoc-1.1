<?xml version="1.0" encoding="iso-8859-1"?>
<!-- This stylesheets transforms OmDoc into LaTeX input
     Initial Version: Michael Kohlhase 1999-09-07
     URL: http://www.mathweb.org/omdoc/xsl/omdoc2tex.dtd
     Comments are welcome! (send mail to kohlhase@mathweb.org)
     See the documentation and examples at http://www.mathweb.org/omdoc

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
 xmlns:func="http://exslt.org/functions" 
 extension-element-prefixes="func"
 xmlns:om="http://www.openmath.org/OpenMath"
 xmlns:dc="http://purl.org/DC"
 xmlns:omdoc="http://www.mathweb.org/omdoc"
 version="1.0">  

<xsl:import href="omdoc2share.xsl"/>
<xsl:variable name="format" select="'TeX'"/>

<xsl:output method="text"/>
<xsl:strip-space elements = "*"/> 

<!-- =============================== -->
<!-- declaration of input parameters -->
<!-- =============================== -->

<!-- 'TargetLanguage': default is en for xml:lang-attribute in 
     omdoc-output. It consists of whitespace separated, ordered list 
     of languages (example-call: TargetLanguage="en de fr")
     It is also valid in the imported stylesheets! 
     -->
<xsl:param name="TargetLanguage" select="'en'"/>
<!-- the format for the cross-references on the symbols -->
<xsl:param name="crossref-format" select="'html'"/>
<!-- 'usepackage': determines the LaTeX style files to be called. 
     This is a  comma-separated list of style files without the extension '.sty' -->
<xsl:param name="usepackage" select="'omdoc'"/>
<!-- the LaTeX document class -->
<xsl:param name="docclass" select="'article'"/>
<!-- the class, we support 'book', and 'article' -->
<xsl:param name="sectioning-model" select="'article'"/>

<!-- this template takes care of most of the characters that offend LaTeX -->
<xsl:template match="text()">
  <xsl:call-template name="safe">
    <xsl:with-param name="string" select="."/>
  </xsl:call-template>
</xsl:template>

<xsl:template name="with-document">
  <xsl:param name="content"/>
  <xsl:text>\documentclass{</xsl:text><xsl:value-of select="$docclass"/><xsl:text>}&#xA;</xsl:text>
  <xsl:text>\usepackage{</xsl:text><xsl:value-of select="$usepackage"/><xsl:text>}&#xA;</xsl:text>
  <xsl:text>\begin{document}&#xA;</xsl:text>
  <xsl:copy-of select="$content"/>
 <xsl:text>\end{document}&#xA;&#xA;</xsl:text>
</xsl:template>

<!-- #################### Text Elements ##################### -->

<xsl:template match="omdoc:omtext">
 <xsl:text>&#xA;&#xA;</xsl:text>
  <xsl:apply-templates select="omdoc:CMP"/>
</xsl:template>

<!-- this takes care of the section-like headings -->
<xsl:template match="omdoc:omdoc/omdoc:metadata|omdoc:omgroup/omdoc:metadata|omdoc:omtext/omdoc:metadata">
 <xsl:param name="level"/>
 <xsl:param name="prefix"/>
 <xsl:text>&#xA;&#xA;\</xsl:text><xsl:value-of select="omdoc:compute-section($level)"/>
 <xsl:text>{</xsl:text>
 <xsl:choose>
  <xsl:when test="dc:Title"><xsl:value-of select="dc:Title"/></xsl:when>
  <xsl:otherwise>
   <xsl:call-template name="warning">
    <xsl:with-param name="string" select="concat('no title specified in omgroup',@id)"/>
   </xsl:call-template>
   <xsl:text>No Title Specified</xsl:text>
  </xsl:otherwise>
 </xsl:choose>
 <xsl:text>}\label{</xsl:text><xsl:value-of select="../@id"/><xsl:text>}&#xA;</xsl:text>
</xsl:template>

<xsl:template match="omdoc:ref[@type='cite']">
 <xsl:param name="prefix"/>
 <xsl:text>(\ref{</xsl:text><xsl:value-of select="@xref"/><xsl:text>})</xsl:text>
</xsl:template>

<!-- we will take care of 'ednote' comments. -->
<xsl:template match="ignore[@type='ednote']">
 <xsl:text>\footnote{{\sc </xsl:text><xsl:apply-templates/><xsl:text>}}</xsl:text>
</xsl:template>

<!-- the omgroups only recurse, the templates for metadata do 
     the work of computing the sections -->
<xsl:template match="omdoc:omgroup">
 <xsl:param name="level"/>
 <xsl:param name="prefix"/>
 <xsl:variable name="number" select="omdoc:new-number($level,$prefix)"/>
 <xsl:apply-templates select="omdoc:metadata">
   <xsl:with-param name="level" select="$level"/>
   <xsl:with-param name="prefix" select="$number"/>
 </xsl:apply-templates>
 <xsl:if test="@type">
  <xsl:text>\begin{omgroup-</xsl:text><xsl:value-of select="@type"/><xsl:text>}&#xA;</xsl:text>
 </xsl:if>
 <xsl:for-each select="*[not(self::omdoc:metadata)]">
  <xsl:text>\item</xsl:text><xsl:value-of select="../@type"/><xsl:text> </xsl:text>
  <xsl:apply-templates select=".">
   <xsl:with-param name="level" select="$level + 1"/>
   <xsl:with-param name="prefix" select="$number"/>
  </xsl:apply-templates>
  <xsl:text>&#xA;</xsl:text>
 </xsl:for-each>
  <xsl:if test="@type">
  <xsl:text>\end{omgroup-</xsl:text><xsl:value-of select="@type"/><xsl:text>}&#xA;</xsl:text>
 </xsl:if>
</xsl:template>

<xsl:template match="omdoc:omgroup[@type='labeled-dataset']">
 <xsl:text>\begin{tabular}{c|</xsl:text>
 <xsl:for-each select="omdoc:omgroup[1]/*[position()!=1]"><xsl:text>c</xsl:text></xsl:for-each>
 <xsl:text>}&#xA;</xsl:text>
 <xsl:for-each select="omdoc:omgroup/*[1]">
  <xsl:apply-templates/>
  <xsl:if test="position()!=last()"><xsl:text> &amp; </xsl:text></xsl:if>
 </xsl:for-each>
 <xsl:text>\\\hline&#xA;</xsl:text>
 <xsl:for-each select="omdoc:omgroup[position()!=1 and position()!=last()]/*">
  <xsl:variable name="pos" select="position()"/>
  <xsl:apply-templates/>
  <xsl:text> &amp; </xsl:text>
  <xsl:for-each select="../omgroup[position()=last()]/*[position()=$pos]">
   <xsl:apply-templates select="."/>
   <xsl:if test="position()!=last()"><xsl:text> &amp; </xsl:text></xsl:if>
  </xsl:for-each>
  <xsl:if test="position()!=last()"><xsl:text>\\</xsl:text></xsl:if>
  <xsl:text>&#xA;</xsl:text>
 </xsl:for-each>
 <xsl:text>\end{tabular}&#xA;</xsl:text>
</xsl:template>
<xsl:template match="omdoc:FMP"/>
<xsl:template match="omdoc:FMP" mode="formal">
  <xsl:choose>
    <xsl:when test="om:OMOBJ"><xsl:call-template name="localize-self"/></xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="do-nl"/>
      <xsl:call-template name="localize">
        <xsl:with-param name="key" select="'FMP'"/>
      </xsl:call-template><xsl:text>: </xsl:text>
      <xsl:for-each select="omdoc:assumption">
        <xsl:apply-templates select="om:OMOBJ">
          <xsl:with-param name="id" select="@id"/>
        </xsl:apply-templates>
        <xsl:if test="position()!=last()"><xsl:text>, </xsl:text></xsl:if>
      </xsl:for-each>
      <xsl:text>$\vdash$</xsl:text>
      <xsl:apply-templates select="omdoc:conclusion/om:OMOBJ"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="omdoc:mc">
  <xsl:apply-templates select="omdoc:choice"/>
  <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
  <xsl:apply-templates select="omdoc:hint"/>
  <xsl:text disable-output-escaping="yes">&amp;</xsl:text>
  <xsl:apply-templates select="omdoc:answer"/>
  <xsl:text>\\\hline&#xA;</xsl:text>
</xsl:template>


<!-- here come the changes to omdoc2share.xsl functions that are specific to TeX-->

<xsl:template name="with-crossref">
  <xsl:param name="uri"/>
  <xsl:param name="print-form"/>
  <xsl:text>\href{</xsl:text>
  <xsl:value-of select='$uri'/>
  <xsl:text>}{</xsl:text>
  <xsl:copy-of select="$print-form"/>
  <xsl:text>} </xsl:text>
</xsl:template>

<xsl:template name="print-symbol">
 <xsl:param name="print-form"/>
 <xsl:param name="crossref-symbol" select="'yes'"/>
 <xsl:param name="uri"/>
 <!-- we do not know how to crossreference, so we do'nt -->
 <xsl:copy-of select="$print-form"/>
 <xsl:text> </xsl:text>
</xsl:template>

<xsl:template name="do-print-variable">
  <xsl:text>{</xsl:text><xsl:value-of select="@name"/><xsl:text>}</xsl:text>
</xsl:template>


<!-- finally, here come the stuff that has to be overdefined by the 
     individual formats, this one is for html -->

<xsl:template match="omdoc:omlet">
 <xsl:message>cannot deal with omlet of type <xsl:value-of select="@type"/></xsl:message>
 <xsl:apply-templates/>
</xsl:template>

<xsl:template match="omdoc:omlet[@type='link']">
  <xsl:text>{\ref{</xsl:text>
  <xsl:apply-templates/>
  <xsl:text>}}</xsl:text>
</xsl:template>

<xsl:template match="omdoc:omlet[@type='figure']">
  <xsl:variable name="uriref" select="@data"/>
  <xsl:apply-templates select="omdoc:get-uriref($uriref)" mode="show-figure"/>
</xsl:template>

<xsl:template match="omdoc:private" mode="show-figure">
 \begin{figure}
 \begin{center}
 <xsl:choose>
  <xsl:when test="omdoc:data[@format='application/postscript']">
   <xsl:text>\includegraphics{</xsl:text>
   <xsl:value-of select="omdoc:data[@format = 'application/postscript']/@href"/>
   <xsl:text>}&#xA;</xsl:text>
  </xsl:when>
  <xsl:when test="omdoc:data[@format='image/jpg']">
   <xsl:text>\includegraphics{</xsl:text>
   <xsl:value-of select="omdoc:data[@format = 'image/jpg']/@href"/>
   <xsl:text>}&#xA;</xsl:text>
  </xsl:when>
  <xsl:when test="omdoc:data[@format='image/gif']">
   <xsl:text>\includegraphics{</xsl:text>
   <xsl:value-of select="omdoc:data[@format = 'image/gif']/@href"/>
   <xsl:text>}&#xA;</xsl:text>
  </xsl:when>
  <xsl:when test="omdoc:data[@format='application/pdf']">
   <xsl:text>\includegraphics{</xsl:text>
   <xsl:value-of select="omdoc:data[@format = 'application/pdf']/@href"/>
   <xsl:text>}&#xA;</xsl:text>
  </xsl:when>
  <xsl:when test="omdoc:data[@format='application/omdoc+xml']">
    <xsl:variable name="uriref" select="omdoc:data[@format = 'application/omdoc+xml']/@href"/>
    <xsl:text>\begin{small}&#xA;</xsl:text>
    <xsl:text>\begin{verbatim}</xsl:text>
      <xsl:apply-templates 
       select="omdoc:get-uriref(omdoc:data[@format = 'application/omdoc+xml']/@href)"
       mode="verbatimcopy"/>
      <xsl:text>\end{verbatim}&#xA;</xsl:text>
      <xsl:text>\end{small}&#xA;</xsl:text>
  </xsl:when>
  <xsl:otherwise>
   <xsl:message>Data not suitable for inclusion as a figure!</xsl:message>
  </xsl:otherwise>
 </xsl:choose>
 <xsl:if test="omdoc:metadata/dc:Title">
  <xsl:text>\caption{</xsl:text>
  <xsl:value-of select="omdoc:metadata/dc:Title"/>
  <xsl:text>}\label{</xsl:text>
  <xsl:value-of select="@id"/>
  <xsl:text>}&#xA;</xsl:text>
 </xsl:if>
 <xsl:text>\end{center}&#xA;\end{figure}&#xA;</xsl:text>
</xsl:template>

<!-- ================= om:-matches ============================ -->
<!-- All of these templates overdefine the ones in omdoc2share -->
<xsl:template match="om:OMOBJ[not(@xref)]">
  <xsl:param name="id"/>
  <xsl:choose>
    <xsl:when test="$id!=''">
      <xsl:call-template name="with-crossref">
        <xsl:with-param name="content">
          <xsl:text>$</xsl:text><xsl:apply-templates/><xsl:text>$</xsl:text>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
      <xsl:text>$</xsl:text><xsl:apply-templates/><xsl:text>$</xsl:text>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="om:OMSTR[not(@xref)]">
  <xsl:text>{\mbox{</xsl:text><xsl:apply-templates/><xsl:text>}}</xsl:text>
</xsl:template>


<xsl:template name="with-list">
  <xsl:param name="content"/>
  <xsl:text>&#xA;\begin{enumerate}&#xA;</xsl:text>
  <xsl:copy-of select="$content"/>
  <xsl:text>&#xA;\end{enumerate}&#xA;</xsl:text>
</xsl:template>

<xsl:template name="with-unordered-list">
  <xsl:param name="content"/>
  <xsl:text>&#xA;\begin{itemize}&#xA;</xsl:text>
  <xsl:copy-of select="$content"/>
  <xsl:text>&#xA;\end{itemize}&#xA;</xsl:text>
</xsl:template>

<xsl:template name="with-item">
  <xsl:param name="content"/>
  <xsl:text>&#xA;\item{}</xsl:text>
  <xsl:copy-of select="$content"/>
</xsl:template>

<xsl:template name="with-bold">
  <xsl:param name="content"/>
  <xsl:text>{\bf </xsl:text>
  <xsl:copy-of select="$content"/>
  <xsl:text>}</xsl:text>
</xsl:template>

<xsl:template name="do-nl"><xsl:text>\par{}&#xA;</xsl:text></xsl:template>

<xsl:template name="with-math">
  <xsl:param name="content"/>
  <xsl:text>\(</xsl:text>
  <xsl:copy-of select="$content"/>
  <xsl:text>\)</xsl:text>
</xsl:template>

<xsl:template name="with-style">
  <xsl:param name="class"/>
  <xsl:param name="style"/>
  <xsl:param name="display" select="'div'"/>
  <xsl:param name="content"/>
  <xsl:text>\begin{</xsl:text>
  <xsl:value-of select="concat($display,$class)"/>
  <xsl:text>}{</xsl:text>
  <xsl:value-of select="$style"/>
  <xsl:text>}&#xA;</xsl:text>
  <xsl:copy-of select="$content"/>
  <xsl:text>\end{</xsl:text>
  <xsl:value-of select="concat($display,$class)"/>
  <xsl:text>}&#xA;</xsl:text>
</xsl:template>

<xsl:template name="with-omdocenv">
  <xsl:param name="id"/>
  <xsl:param name="content"/>
  <xsl:text>&#xA;\begin{omdocenv}{</xsl:text>
  <xsl:value-of select="local-name()"/><!-- type -->
  <xsl:text>}{</xsl:text>
  <xsl:value-of select="$id"/>         <!-- label -->
  <xsl:text>}</xsl:text>
  <xsl:copy-of select="$content"/>     <!-- the third arg to \begin{omdocenv} -->
  <xsl:text>&#xA;</xsl:text>           <!-- is supplied in the content -->
  <xsl:text>\end{omdocenv}</xsl:text>
</xsl:template>

<xsl:template name="with-mcgroup">
  <xsl:param name="content"/>
  <xsl:text>\begin{center}\begin{tabular}{|l|l|l|}\hline&#xA;</xsl:text>
  <xsl:copy-of select="$content"/>
  <xsl:text>\end{tabular}&#xA;\end{center}&#xA;</xsl:text>
</xsl:template>

<xsl:template name="safe">
  <xsl:param name="string"/>
  <xsl:value-of disable-output-escaping="yes" select="translate($string,'_&amp;','- ')"/>
</xsl:template>

<!-- these templates take care of format-specific argument grouping -->
<xsl:template name="barg-group"><xsl:text>{</xsl:text></xsl:template>
<xsl:template name="earg-group"><xsl:text>}</xsl:text></xsl:template>


<!-- this function computes the next level of headings down -->
<func:function name="omdoc:compute-section">
 <xsl:param name="level"/>
 <!-- first we normalize the level command to 'book', which has max sectioning commands -->
 <xsl:variable name="nlevel">
  <xsl:choose>
   <xsl:when test="$sectioning-model='book'"><xsl:value-of select="$level"/></xsl:when>
   <xsl:when test="$sectioning-model='article'"><xsl:value-of select="$level + 1"/></xsl:when>
   <xsl:otherwise>
    <xsl:message><xsl:value-of select="$sectioning-model"/> is not a known sectioning model!</xsl:message>
   </xsl:otherwise>
  </xsl:choose>
 </xsl:variable>
 <xsl:choose>
  <xsl:when test="$nlevel='0'"><func:result select="'chapter'"/></xsl:when>
  <xsl:when test="$nlevel='1'"><func:result select="'section'"/></xsl:when>
  <xsl:when test="$nlevel='2'"><func:result select="'subsection'"/></xsl:when>
  <xsl:when test="$nlevel='3'"><func:result select="'subsubsection'"/></xsl:when>
  <xsl:when test="$nlevel='4'"><func:result select="'paragraph'"/></xsl:when>
  <xsl:when test="$nlevel='5'"><func:result select="'subparragraph'"/></xsl:when>
 </xsl:choose>
</func:function>

</xsl:stylesheet>
