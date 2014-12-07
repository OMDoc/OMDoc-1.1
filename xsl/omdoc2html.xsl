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
  xmlns:exsl="http://exslt.org/common" 
  xmlns="http://www.w3.org/1999/xhtml" 
  exclude-result-prefixes="om dc omdoc exsl"
  version="1.0">  
<xsl:import href="omdoc2share.xsl"/>
<xsl:variable name="format" select="'html'"/>

<xsl:output method="xml" 
            indent="yes" 
            doctype-public="'-//W3C//DTD XHTML 1.0 Strict//EN'"/>

<xsl:strip-space elements="*"/>

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

<!-- 'css': determines the css-stylesheet to be connected
     with the html-output -->
<!-- <xsl:param name="css" select="'http://www.mathweb.org/omdoc/lib/omdoc-default.css'"/> -->
<!-- we now include this into the head directly, so that the result is more standalone -->
<xsl:param name="css"/> 

<!-- ============= omdoc basics ============= -->

<xsl:template name="with-document">
  <xsl:param name="content"/>
  <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html 
                PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
                       "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"&gt;
  </xsl:text>
 <xsl:text>&#xA;&#xA;</xsl:text>
  <html>
    <head>
      <xsl:if test="$css!=''"><link rel="stylesheet" type="text/css" href="{$css}"/></xsl:if>
      <xsl:call-template name="insert-default-css"/>
      <xsl:if test="/omdoc:omdoc/omdoc:metadata/dc:Title">
        <title><xsl:apply-templates select="/omdoc:omdoc/omdoc:metadata/dc:Title"/></title>
      </xsl:if>
    </head>
    <body>
      <xsl:copy-of select="$content"/>
    </body>
  </html>
</xsl:template>

<!-- #################### Text Elements ##################### -->

<xsl:template match="omdoc:omtext[@type='quote']">
 <div class="quote">
   <xsl:text>"</xsl:text>
   <xsl:apply-templates select="omdoc:CMP"/>
   <xsl:text>"</xsl:text>
   <div class="caption">
     <xsl:text>--</xsl:text><xsl:apply-templates select="omdoc:metadata/dc:Source"/>
   </div>
 </div>
</xsl:template>


<xsl:template match="omdoc:omtext">
 <xsl:text>&#xA;</xsl:text>
 <!-- AKO in theory this has to be replaced, but I don't seem 
      to be able to implement this correctly...
      <xsl:variable name="omtext_new">
        <xsl:for-each select="descendant::omdoc:CMP">
          <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:choose>
              <xsl:when test="contains(.,'&#x0A;')">
                <xsl:value-of select="substring-before(.,'&#x0A;')"/>
                <xsl:call-template name="do-nl"/>
                <xsl:value-of select="substring-after(.,'&#x0A;')"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of select="."/>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:copy>
        </xsl:for-each>
      </xsl:variable>
      <p>
        <xsl:apply-templates select="exsl:node-set($omtext_new)//omdoc:CMP"/>
      </p>
      -->
 <p>
   <xsl:choose>
     <!-- annotations have to be presented in a special size/color.
          Unfortunately, the enumeration isn't included, so ordered lists
          consisting of annotated omtexts, don't look so nice... -->
     <xsl:when test="@type='annote'">
       <div class="annotation">
         <xsl:apply-templates select="omdoc:CMP"/>
       </div>
     </xsl:when>
     <xsl:otherwise>
       <xsl:apply-templates select="omdoc:CMP"/>
     </xsl:otherwise>
   </xsl:choose>
 </p>
 <xsl:text>&#xA;</xsl:text>
</xsl:template>

<!-- this takes care of the section-like headings -->
<xsl:template match="omdoc:omdoc/omdoc:metadata|
                     omdoc:omgroup/omdoc:metadata|
                     omdoc:omtext/omdoc:metadata">
 <xsl:param name="level"/>
 <xsl:param name="prefix"/>
 <xsl:text>&#xA;</xsl:text>
 <xsl:call-template name="with-heading">
   <xsl:with-param name="id" select="../@id"/>
   <xsl:with-param name="level" select="$level +1"/>
   <xsl:with-param name="content">
     <b><xsl:value-of select="$prefix"/>
     <xsl:if test="$prefix"><xsl:text>.</xsl:text></xsl:if><xsl:text> </xsl:text></b>
     <xsl:choose>
       <xsl:when test="dc:Title"><xsl:value-of select="dc:Title"/></xsl:when>
       <xsl:otherwise>
         <xsl:call-template name="warning">
           <xsl:with-param name="string" select="concat('no title specified in omgroup',@id)"/>
         </xsl:call-template>
         <xsl:text>No Title Specified</xsl:text>
       </xsl:otherwise>
     </xsl:choose>
   </xsl:with-param>
 </xsl:call-template>
 </xsl:template>

 <xsl:template name="with-heading">
   <xsl:param name="id"/>
   <xsl:param name="level"/>
   <xsl:param name="content"/>
   <xsl:element name="h{$level}">
     <xsl:if test="$id!=''">
       <xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
     </xsl:if>
     <xsl:copy-of select="$content"/>
   </xsl:element>
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

  <xsl:variable name="id" select="@id"/>
  <xsl:if test="@type='slide'
                and ../omdoc:private[@for=$id and @pto='migration']/omdoc:data/@href!=''">
    <div class="migration">
      Migration: Click <a href="{../omdoc:private[@for=$id]/omdoc:data/@href}">here</a> to see original slide</div>
  </xsl:if>
  <xsl:apply-templates select="*[not(self::omdoc:metadata)]">
    <xsl:with-param name="level" select="$level + 1"/>
    <xsl:with-param name="prefix" select="$number"/>
  </xsl:apply-templates>
</xsl:template>


<xsl:template match="omdoc:ref[@type='cite']">
 <xsl:param name="prefix"/>
 <a href="{@xref}"><xsl:value-of select="@xref"/></a>
</xsl:template>

<!-- we will take care of 'ednote' comments. -->
<xsl:template match="ignore[@type='ednote']">
  <div class="ednote"><xsl:apply-templates/></div>
</xsl:template>


<xsl:template match="omdoc:mc">
  <tr>
    <td><xsl:apply-templates select="omdoc:symbol"/></td>
    <td><xsl:apply-templates select="omdoc:choice"/></td>
    <td><xsl:apply-templates select="omdoc:hint"/></td>
    <td><xsl:apply-templates select="omdoc:answer"/></td>
  </tr>
</xsl:template>

<xsl:template match="omdoc:code">
  <xsl:choose>
    <xsl:when test="@type='js'">
      <SCRIPT LANGUAGE="JavaScript">
	<xsl:if test="omdoc:data[@href]">
	  <xsl:attribute name="src">
	    <xsl:value-of select="omdoc:data/@href"/>
	  </xsl:attribute>
	</xsl:if>
	<xsl:comment>
	  <xsl:apply-templates select="omdoc:data"/>
	  //
	</xsl:comment>
      </SCRIPT>
    </xsl:when>
  </xsl:choose>
  <!--  <xsl:apply-templates/> -->
</xsl:template>

<xsl:template match="omdoc:code" mode="show-image">
  <div class="code"><pre><xsl:value-of select="omdoc:data"/></pre></div>
</xsl:template>

<!-- finally, here come the stuff that has to be overdefined by the 
     individual formats, this one is for html -->

<xsl:template match="omdoc:omlet">
 <xsl:message>cannot deal with omlet of type <xsl:value-of select="@type"/></xsl:message>
</xsl:template>

<xsl:template match="omdoc:omlet[@type='link']">
 <a href="{@argstr}"><xsl:apply-templates/></a>
</xsl:template>

<xsl:template match="omdoc:omlet[   @type='image'
                                 or @type='code'
                                 or @type='graph'
                                 or @type='equation'
                                 or @type='clipart']">
  <xsl:variable name="uriref" select="@data"/>
  <xsl:apply-templates select="omdoc:get-uriref($uriref)" mode="show-image">
   <xsl:with-param name="width" select="@width"/>
   <xsl:with-param name="height" select="@height"/>
  </xsl:apply-templates>
  <xsl:variable name="function" select="@function"/>
  <xsl:apply-templates select="omdoc:get-uriref($function)" mode="show-image"/>
</xsl:template>

<xsl:template match="omdoc:private" mode="show-image">
 <xsl:param name="width"/>
 <xsl:param name="height"/>
 <div id="{@id}" class="image">
   <xsl:choose>
     <xsl:when test="omdoc:data[@format='image/jpg']">
       <img src="{omdoc:data[@format='image/jpg']/@href}">
         <xsl:if test="$width">
           <xsl:attribute name="width"><xsl:value-of select="$width"/></xsl:attribute>
         </xsl:if>
         <xsl:if test="$height">
           <xsl:attribute name="height"><xsl:value-of select="$height"/></xsl:attribute>
         </xsl:if>
       </img>
     </xsl:when>
     <xsl:when test="omdoc:data[@format='image/gif']">
       <img src="{omdoc:data[@format='image/gif']/@href}">
         <xsl:if test="$width">
           <xsl:attribute name="width"><xsl:value-of select="$width"/></xsl:attribute>
         </xsl:if>
         <xsl:if test="$height">
           <xsl:attribute name="height"><xsl:value-of select="$height"/></xsl:attribute>
         </xsl:if>
       </img>
     </xsl:when>
     <xsl:when test="omdoc:data[@format='image/png']">
       <img src="{omdoc:data[@format='image/png']/@href}">
         <xsl:if test="$width">
           <xsl:attribute name="width"><xsl:value-of select="$width"/></xsl:attribute>
         </xsl:if>
         <xsl:if test="$height">
           <xsl:attribute name="height"><xsl:value-of select="$height"/></xsl:attribute>
         </xsl:if>
       </img>
     </xsl:when>
     <xsl:when test="omdoc:data[@format='application/emz']">
       <a href="{omdoc:data[@format = 'application/emz']/@href}">EMZ(TexPoint)</a>
     </xsl:when>
     <xsl:when test="omdoc:data[@format='application/pdf']">
       <a href="{omdoc:data[@format = 'application/pdf']/@href}">PDF</a>
     </xsl:when>
     <xsl:when test="omdoc:data[@format='application/postscript']">
       <a href="{omdoc:data[@format = 'application/postscript']/@href}">PS</a>
     </xsl:when>
     <xsl:when test="omdoc:data[@format='application/wmz']">
       <a href="{omdoc:data[@format = 'application/wmz']/@href}">WMZ(WindowsMetaFile)</a>
     </xsl:when>
     <xsl:when test="omdoc:data[@format='text/html']">
       <xsl:value-of disable-output-escaping="yes" select="omdoc:data[@format = 'text/html']"/>
     </xsl:when>
     <xsl:when test="omdoc:data[@format='application/omdoc+xml']">
       <pre>
         <xsl:apply-templates 
           select="omdoc:get-uriref(omdoc:data[@format = 'application/omdoc+xml']/@href)"
           mode="verbatimcopy-escaped"/>
       </pre>
     </xsl:when>
     <xsl:when test="omdoc:data[@format='text']">
   <pre>
    <xsl:choose>
     <xsl:when test="omdoc:data[@format='text']/@href">
      <xsl:apply-templates mode="verbatimcopy-escaped"
       select="omdoc:get-uriref(omdoc:data[@format = 'text']/@href)"/>
     </xsl:when>
     <xsl:otherwise>
      <xsl:apply-templates select="omdoc:data" mode="verbatimcopy-escaped"/>
     </xsl:otherwise>
    </xsl:choose>
   </pre>
  </xsl:when>
  <xsl:otherwise>
    <xsl:message>Data <xsl:value-of select="omdoc:data/@format"/> not suitable for inclusion as an image!</xsl:message>
  </xsl:otherwise>
 </xsl:choose>
<xsl:if test="omdoc:metadata/dc:Title">
  <div class="caption"><xsl:value-of select="omdoc:metadata/dc:Title"/></div>
</xsl:if>
</div>
</xsl:template>

<!-- #################### Table Elements ##################### -->

<xsl:template match="omdoc:omgroup[@type='labeled-dataset']">
 <xsl:param name="level"/>
 <xsl:param name="prefix"/>
 <xsl:text>&#xA;</xsl:text>
 <p>
   <xsl:choose>
     <xsl:when test="parent::node()[@type='itemize'] or parent::node()[@type='enumeration'] or parent::node()[@type='sequence']">
       <table align="char" border="1" cellspacing="1" cellpadding="1">
         <xsl:apply-templates select="*[not(self::omdoc:metadata)]" mode="table"/>
       </table>
     </xsl:when>
     <xsl:otherwise>
       <table align="center" border="1" cellspacing="1" cellpadding="1">
         <xsl:apply-templates select="*[not(self::omdoc:metadata)]" mode="table"/>
       </table>
     </xsl:otherwise>
   </xsl:choose>
   <xsl:if test="omdoc:metadata/dc:Title and omdoc:metadata/dc:Title!='(No title specified)'">
     <th><xsl:apply-templates select="omdoc:metadata/dc:Title"/></th> 
   </xsl:if>
 </p>
</xsl:template>

<xsl:template match="omdoc:omgroup[@type='dataset']" mode="table">
  <tr>
    <xsl:for-each select="omdoc:omgroup[@type='dataset']">
      <td>
        <!--        <xsl:value-of select="child::node()"/> -->
        <xsl:apply-templates select="child::node()"/>
      </td>
    </xsl:for-each>
  </tr>
</xsl:template>


<!-- ================= om:-matches ============================ -->
<!-- All of these templates overdefine the ones in omdoc2share -->
<xsl:template match="om:OMOBJ[not(@xref)]">
  <xsl:param name="id"/>
  <div class="math">
    <xsl:if test="$id!=''">
      <xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
    </xsl:if>
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="om:OMSTR[not(@xref)]"><tt><xsl:apply-templates/></tt></xsl:template>

<!-- ================ do-* named templates (for output styling) ===== -->

<xsl:template name="with-list">
  <xsl:param name="content"/>
  <ol><xsl:copy-of select="$content"/></ol>
</xsl:template>

<xsl:template name="with-unordered-list">
  <xsl:param name="content"/>
  <ul><xsl:copy-of select="$content"/></ul>
</xsl:template>

<xsl:template name="with-item">
  <xsl:param name="content"/>
  <li><xsl:copy-of select="$content"/></li>
</xsl:template>

<xsl:template name="with-bold">
  <xsl:param name="content"/>
  <b><xsl:copy-of select="$content"/></b>
</xsl:template>

<!-- docu see omdoc2share.xsl -->
<xsl:template name="print-symbol">
 <xsl:param name="print-form"/>
 <xsl:param name="crossref-symbol" select="'yes'"/>
 <xsl:param name="uri"/>
 <xsl:choose>
  <xsl:when test="$uri!='' and ($crossref-symbol='yes' or $crossref-symbol='all')">
   <a href="{$uri}"><xsl:value-of disable-output-escaping="yes" select="$print-form"/></a>
  </xsl:when>
  <xsl:otherwise><xsl:copy-of select="$print-form"/></xsl:otherwise>
 </xsl:choose>
</xsl:template>

<xsl:template name="with-crossref">
  <xsl:param name="uri"/>
  <xsl:param name="content"/>
  <a href="{$uri}"><xsl:copy-of select="$content"/></a>
</xsl:template>

<xsl:template name="do-nl">
  <br/><xsl:text>&#xA;</xsl:text>
</xsl:template>


<xsl:template name="with-omdocenv">
  <xsl:param name="type" select="'Unknown'"/>
  <xsl:param name="id"/>
  <xsl:param name="content"/>
  <xsl:variable name="class">
    <xsl:choose>
      <xsl:when test="local-name()='omtext' and not($type='')">
        <xsl:value-of select='$type'/>
      </xsl:when>
      <xsl:when test="local-name()='omtext'">
        <xsl:text>normaltext</xsl:text>
      </xsl:when>
      <xsl:when test="local-name()='example' and $type='counterexample'">
        <xsl:text>counterexample</xsl:text>
      </xsl:when>
      <xsl:when test="local-name()='assertion' and $type='false-conjecture'">
        <xsl:value-of select="$type"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="local-name()"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <div class="{$class}">
    <xsl:if test="$id!=''">
      <xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
    </xsl:if>
    <xsl:copy-of select="$content"/>
  </div>
</xsl:template>

<xsl:template name="with-mcgroup">
  <xsl:param name="content"/>
  <table border="1"><xsl:copy-of select="content"/></table>
</xsl:template>

<xsl:template name="do-print-variable">
  <xsl:value-of select="@name"/>
</xsl:template>

<xsl:template name="localize-self">
  <div class="{local-name()}">
    <xsl:if test="@id">
      <xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
    </xsl:if>
    <xsl:call-template name="localize">
      <xsl:with-param name="key" select="local-name()"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:apply-templates/>
  </div>
  <xsl:text>&#xA;</xsl:text>
</xsl:template>

<xsl:template name="with-style">
  <xsl:param name="class"/>
  <xsl:param name="style"/>
  <xsl:param name="display" select="'div'"/>
  <xsl:param name="content"/>
  <xsl:choose>
    <xsl:when test="$display='div'">
      <div>
        <xsl:if test="$class!=''">
          <xsl:attribute name="class"><xsl:value-of select="$class"/></xsl:attribute>
        </xsl:if>
        <xsl:if test="$style!=''">
          <xsl:attribute name="style"><xsl:value-of select="$style"/></xsl:attribute>
        </xsl:if>
        <xsl:copy-of select="$content"/></div>
      </xsl:when>
      <xsl:when test="$display='span'">
        <span>
          <xsl:if test="$class!=''">
            <xsl:attribute name="class"><xsl:value-of select="$class"/></xsl:attribute>
          </xsl:if>
          <xsl:if test="$style!=''">
            <xsl:attribute name="style"><xsl:value-of select="$style"/></xsl:attribute>
          </xsl:if>
          <xsl:copy-of select="$content"/>
        </span>
      </xsl:when>
      <xsl:otherwise>
        <xsl:message terminate="yes">Unrecognized value of display in template with-style</xsl:message>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

<xsl:template name="insert-default-css">
  <xsl:param name="local-css"/>
  <style type="text/css">
body {margin:5mm 10mm 5mm 10mm;
      background-color:#c6ddf8;color:black;
      font-family:helvetica;font-size:medium;}

a.special:visited {color:black;text-decoration:none;}
a.special:link {color:black;text-decoration:none;}
a.special:active {color:black;text-decoration:none;}
a.special:hover {color:black;text-decoration:none;}

a:hover {color:#151b7e;}
a:visited {color:black;}
a:link {color:#151b7e;}

td {font-size:normal;font-family:helvetica;}

h2 {color:blue;}

/* all div elements inherit this */
div{width:95%;padding:10pt;align=center;
    margin-top:4pt;margin-bottom:4pt;
    border-color:#222222;border-width:2pt;border-style:inset;}

div[class="math"]{font-style=oblique}

div[class="titleblock"]{width:95%;align:center;fontsize:large;font-weight:bold}
div[class="author"],div[class="date"],div[class="subject"],div[class="description"]
      {width:85%,align:center;fontsize:medium;}
div[class="author"]{font-variant:small-caps}
div[class="subject"]{font-style:italic}

div[class="text"],div[class="normaltext"],div[class="axiom"],div[class="symbol"]
      {background-color:#93a8f8;align:center;}
div[class="assertion"],div[class="false-conjecture"]{border-color:black;}
div[class="proof"],div[class="counterexample"],div[class="example"]
      {margin-left:30pt;width:88%;}

div[class="assertion"]{background-color:#e5e5e4;}
div[class="false-conjecture"]{background-color:#CC3300;}
div[class="definition"]{background-color:#e5e5e1;}
div[class="example"]{background-color:#7289f0;}
div[class="counterexample"]{background-color:#CC3300;}
div[class="text"]{margin-left:30pt;}
div[class="proof"]{background-color:#90b3fc;}
div[class="exercise"]{background-color:#5a7ffc;margin-left:30pt;}
div[class="code"]{font-family:courier;background-color:#ffa964;width:60%;}

div[class="migration"]{color:red;font-size:smaller}
div[class="quote"]{font-size:larger;width:80%;font-family:sans-serif}
div[class="caption"]{font-size:smaller;font-style:italic;align:right}
div[class="annotation"]{font-size=smaller;color:gray}
div[class="ednote"]{font-size:smaller;background-color:red}
    <xsl:call-template name="insert-local-css"/>
  </style>
</xsl:template>

<xsl:template name="insert-local-css"/>

</xsl:stylesheet>



