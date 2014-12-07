<?xml version="1.0" encoding="utf-8"?>
<!-- An XSL style sheet for creating html from OMDoc (Open 
     Mathematical Documents). 
     URL: http://www.mathweb.org/omdoc/xsl/omdoc2html.dtd

     Copyright (c) 2001 - 2002 Andrea and Michael Kohlhase, 

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

<!-- Remarks: -->
<!-- 1.) Language-dependent elements are: 
         - CMP
         - commonname
         - dc:Title 
         - dc:Subject
         - dc:Description
         - dc:Translator
-->
<!-- 2.) In the including program there has to be a global variable 
     "sw_crossref_allowed" with range "yes, no", so that it is defined here.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:om="http://www.openmath.org/OpenMath"
  xmlns:dc="http://purl.org/DC"
  xmlns:omdoc="http://www.mathweb.org/omdoc" 
  xmlns:saxon="http://icl.com/saxon" 
  version="1.0"
  exclude-result-prefixes="saxon om dc omdoc">

<xsl:import href="omdoc2share.xsl"/>

<!-- =============================== -->
<!-- declaration of input parameters -->
<!-- =============================== -->

<!--<xsl:param name="locale" select="'http://www.mathweb.org/src/mathweb/omdoc/lib/locale-default.xml'"/>-->
<xsl:param name="locale" select="'locale.xml'"/>
<xsl:param name="report-errors" select="'no'"/> 

<!-- 'css_file': determines the css-stylesheet to be connected
     with the html-output -->
<xsl:param name="css" select="'http://www.mathweb.org/src/mathweb/omdoc/lib/omdoc-default.css'"/>


<!-- =============================== -->
<!-- declaration of global variables -->
<!-- =============================== -->
<xsl:variable name="format" select="'html'"/>

<xsl:output method="html" indent="yes" cdata-section-elements = "script"/>

<xsl:strip-space elements="*"/>


<!-- ============= omdoc basics ============= -->
<xsl:template match="*" mode="omdocnode2html"/>

<xsl:template match="/" mode="omdocnode2html">
  <xsl:apply-templates mode="omdocnode2html"/>
</xsl:template>


<!-- =========== Text Elements =========== -->

<xsl:template match="omdoc:omdoc" mode="omdocnode2html">
  <xsl:variable name="title">
    <!-- Find the title with fallback-logic -->
    <!-- Remark: mode 'title' is given by the importing/including program,
         since fallback logic cannot be general, but depends on stylesheet. 
         -->
    <xsl:apply-templates select="." mode="title"/>
  </xsl:variable>
  <xsl:text>&#xA;&#xA;</xsl:text>
  <html>
    <head>
      <link rel="stylesheet" type="text/css" href="{$css}"/>
      <title>
        <xsl:value-of select="$title"/>
      </title>
    </head>
    <body>
      <!--  First the header (title, authors and date) -->
      <div>
        <xsl:if test="not($title='')">
          <h1>
            <xsl:value-of select="$title"/>
          </h1>
        </xsl:if>
        <xsl:if test="omdoc:metadata/dc:Creator">
          Author(s):
          <xsl:for-each select="omdoc:metadata/dc:Creator">
            <xsl:apply-templates mode="omdocnode2html"/>
          </xsl:for-each><br/>
        </xsl:if>
        <xsl:if test="omdoc:metadata/dc:Date">
          <xsl:call-template name="localize">
            <xsl:with-param name="key" select="'date'"/>
          </xsl:call-template>
          <xsl:text>: </xsl:text>
          <xsl:apply-templates select="omdoc:metadata/dc:Date" mode="omdocnode2html"/>
        </xsl:if>
      </div>
      <br/>
      <!-- Then apply the templates on the following elements -->
      <xsl:apply-templates select="child::node()[not(self::omdoc:metadata)]" mode="omdocnode2html"/>
    </body>
  </html>
</xsl:template>

<xsl:template match="omdoc:omgroup" mode="omdocnode2html">
  <xsl:call-template name="do-id-label"/>
  <xsl:apply-templates mode="omdocnode2html"/>
</xsl:template>

<xsl:template match="omdoc:omgroup[@type='sequence']" mode="omdocnode2html">
  <xsl:call-template name="do-begin-list"/>
  <xsl:for-each select="omdoc:omtext">
    <xsl:call-template name="do-begin-list"/>
    <xsl:value-of select="."/>
    <xsl:call-template name="do-end-list"/>
  </xsl:for-each>
  <xsl:call-template name="do-end-list"/>
</xsl:template>

<xsl:template match="omdoc:omtext" mode="omdocnode2html">
  <xsl:variable name="type">
    <xsl:if test="@type!='general' and @type!='linkage'">
      <xsl:value-of select="@type"/>
    </xsl:if>
  </xsl:variable>
  <xsl:call-template name="do-begin-formenv">
    <xsl:with-param name="type" select="$type"/>
   </xsl:call-template>
  <xsl:call-template name="do-nl"/>
  <xsl:apply-templates select="omdoc:CMP" mode="omdocnode2html"/>
  <xsl:call-template name="do-end-formenv"/>
</xsl:template>


<xsl:template match="omdoc:CMP" mode="omdocnode2html">
  <xsl:variable name="valid_language">
    <xsl:call-template name="test-valid-language"/>
  </xsl:variable>
  <xsl:if test="$valid_language='true'">
    <xsl:apply-templates mode="omdocnode2html"/>
  </xsl:if>
</xsl:template>


<xsl:template match="omdoc:ref" mode="omdocnode2html">
  <xsl:choose>
    <!-- If content of the refnode is not empty,
         then we don't use it as a reference, but put it out. -->
    <xsl:when test="node()!=''">
      <xsl:apply-templates mode="omdocnode2html"/>
    </xsl:when>
    <!-- The variable sw_crossref_allowed is supposed to be a global variable
         in the importing or including program. -->
    <xsl:when test="$sw_crossref_allowed='yes'">
      <a class='special'>
        <xsl:attribute name="href">
          <xsl:if test="//*[@id=current()/@xref]">#</xsl:if>
          <xsl:value-of select="@xref"/>
        </xsl:attribute>
        <xsl:apply-templates mode="omdocnode2html"/>
      </a>
    </xsl:when>
    <xsl:otherwise>
      <!--      <xsl:apply-templates mode="omdocnode2html"/> -->
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<!-- ref within omgroups show the structure of the text, right now we ignore them -->
<xsl:template match="omdoc:ref[parent::omdoc:omgroup]" mode="omdocnode2html"/>
  


<xsl:template match="omdoc:mc" mode="omdocnode2html">
  <tr>
    <td>
      <xsl:apply-templates select="omdoc:symbol" mode="omdocnode2html"/>
    </td>
    <td>
      <xsl:apply-templates select="omdoc:choice" mode="omdocnode2html"/>
    </td>
    <td>
      <xsl:apply-templates select="omdoc:hint" mode="omdocnode2html"/>
    </td>
    <td>
      <xsl:apply-templates select="omdoc:answer" mode="omdocnode2html"/>
    </td>
  </tr>
</xsl:template>

<xsl:template match="omdoc:code" mode="omdocnode2html">
  <xsl:choose>
    <xsl:when test="@type='js'">
      <SCRIPT LANGUAGE="JavaScript">
	<xsl:if test="omdoc:data[@href]">
	  <xsl:attribute name="src">
	    <xsl:value-of select="omdoc:data/@href"/>
	  </xsl:attribute>
	</xsl:if>
        <xsl:comment>
          <xsl:apply-templates select="omdoc:data" mode="omdocnode2html"/>
	  //
	</xsl:comment>
      </SCRIPT>
    </xsl:when>
  </xsl:choose>
  <xsl:apply-templates mode="omdocnode2html"/>
</xsl:template>


<xsl:template match="omdoc:pattern|omdoc:value" mode="omdocnode2html">
  <xsl:apply-templates mode="omdocnode2html"/>
</xsl:template>

<!-- ================== Theory structure ========================= -->

<xsl:template match="omdoc:axiom-inclusion|omdoc:theory-inclusion|omdoc:path-just|omdoc:assertion-just|omdoc:decomposition" mode="omdocnode2html"/>


<!--  =================== Theory elements ======================== -->
<xsl:template match="omdoc:theory" mode="omdocnode2html">
  <xsl:apply-templates mode="omdocnode2html"/>
</xsl:template>

<xsl:template match="omdoc:symbol" mode="omdocnode2html">
  <xsl:call-template name="do-begin-formenv"/>
  <xsl:variable name="id" select="@id"/>
  <xsl:for-each select="../omdoc:definition[@for=$id]">
    <xsl:call-template name="cr-def"/>
  </xsl:for-each>
  <xsl:for-each select="//omdoc:alternative-def[@for=$id]">
    <xsl:call-template name="cr-def"/>
  </xsl:for-each>
  <xsl:apply-templates select="child::node()[not(self::omdoc:CMP or self::omdoc:commonname)]" mode="omdocnode2html"/>
  <xsl:call-template name="do-nl"/>
  <xsl:apply-templates select="omdoc:CMP" mode="omdocnode2html"/>
  <xsl:call-template name="do-end-formenv"/>
</xsl:template>

<xsl:template match="omdoc:proof/omdoc:symbol" mode="omdocnode2html"/>

<xsl:template match="omdoc:commonname" mode="omdocnode2html">
  <xsl:param name="sw_simple" select="'no'"/>
  <xsl:variable name="valid_language">
    <xsl:call-template name="test-valid-language"/>
  </xsl:variable>
  <xsl:if test="$valid_language='true'">
    <xsl:choose>
      <xsl:when test="$sw_simple='yes'">
        <xsl:value-of select="."/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="localize-self-br"/>
        <xsl:text>&#xA;</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:if>
</xsl:template>

<xsl:template match="omdoc:signature" mode="omdocnode2html"/>

<xsl:template match="omdoc:type" mode="omdocnode2html">
  <xsl:call-template name="do-nl"/>
  <xsl:call-template name="localize">
    <xsl:with-param name="key" select="'type'"/>
  </xsl:call-template>
  <xsl:text> (</xsl:text>
  <xsl:value-of select="@system"/>
  <xsl:text>): </xsl:text>
  <xsl:apply-templates mode="omdocnode2html"/>
</xsl:template>

<xsl:template match="omdoc:axiom" mode="omdocnode2html">
  <xsl:call-template name="do-begin-formenv"/>
  <xsl:call-template name="do-nl"/>
  <xsl:apply-templates mode="omdocnode2html"/>
  <xsl:call-template name="do-end-formenv"/>
</xsl:template>

<xsl:template match="omdoc:definition|omdoc:alternative-def" mode="omdocnode2html">
  <xsl:call-template name="do-begin-formenv"/>
  <xsl:apply-templates mode="omdocnode2html"/>
  <xsl:call-template name="do-end-formenv"/>
</xsl:template>

<xsl:template match="omdoc:requation"  mode="omdocnode2html">
  <xsl:call-template name="do-nl"/>
  <em>
    <xsl:apply-templates select="omdoc:pattern" mode="omdocnode2html"/>
    <xsl:text>=</xsl:text>
    <xsl:apply-templates select="omdoc:value" mode="omdocnode2html"/>
  </em>
</xsl:template>


<!-- ================== abstract datatypes ======================= -->

<xsl:template match="omdoc:adt|omdoc:sortdef|omdoc:constructor|omdoc:argument|omdoc:insort|omdoc:selector" mode="omdocnode2html"/>

<!-- =================== inheritance ============================= -->

<xsl:template match="omdoc:imports|omdoc:morphism|omdoc:inclusion" mode="omdocnode2html"/>

<!--  ================== Auxiliary elements ====================== -->

<xsl:template match="omdoc:exercise" mode="omdocnode2html">
  <xsl:call-template name="do-begin-formenv"/>
  <xsl:call-template name="do-nl"/>
  <xsl:apply-templates select="child::node()[not(self::omdoc:mc)]" mode="omdocnode2html"/>
  <xsl:if test="omdoc:mc">
    <xsl:call-template name="do-begin-mcgroup"/>
    <xsl:apply-templates select="omdoc:mc" mode="omdocnode2html"/>
    <xsl:call-template name="do-end-mcgroup"/>
  </xsl:if>
  <xsl:call-template name="do-end-formenv"/>
</xsl:template>

<xsl:template match="omdoc:hint" mode="omdocnode2html">
  <xsl:call-template name="localize-self"/>
  <xsl:apply-templates mode="omdocnode2html"/>
</xsl:template>

<xsl:template match="omdoc:solution" mode="omdocnode2html">
  <xsl:call-template name="localize-self"/>
  <xsl:apply-templates mode="omdocnode2html"/>
</xsl:template>


<xsl:template match="omdoc:choice" mode="omdocnode2html">
  <xsl:apply-templates mode="omdocnode2html"/>
</xsl:template>

<xsl:template match="omdoc:answer" mode="omdocnode2html">
  <xsl:apply-templates mode="omdocnode2html"/>
</xsl:template>

<xsl:template match="omdoc:omlet[@type='java']" mode="omdocnode2html">
 <xsl:value-of select="text()" disable-output-escaping="yes"/>
</xsl:template>

<xsl:template match="omdoc:omlet[@type='js']" mode="omdocnode2html">
 <xsl:variable name="function" select="attribute::function"/>
 <xsl:apply-templates mode="omdocnode2html"/>
</xsl:template>

<xsl:template match="omdoc:omlet[@type='oz']" mode="omdocnode2html">
  <xsl:call-template name="do-begin-crossref">
    <xsl:with-param name="uri" select="//omdoc:code[@id=current()/@function]/omdoc:data/@href"/>
  </xsl:call-template>
  <xsl:apply-templates mode="omdocnode2html"/>
  <xsl:call-template name="do-end-crossref"/>
</xsl:template>

<xsl:template match="omdoc:private" mode="omdocnode2html">
  <xsl:apply-templates mode="omdocnode2html"/>
</xsl:template>

<xsl:template match="omdoc:output|omdoc:effect" mode="omdocnode2html">
  <xsl:call-template name="localize-self-br"/>
  <xsl:apply-templates mode="omdocnode2html"/>
  <xsl:text>&#xA;</xsl:text>
</xsl:template>

<xsl:template match="omdoc:presentation" mode="omdocnode2html"/>


<!-- ================= om:-matches ============================ -->
<!-- This is the entrypoint for the om:-matches in this code -->
<xsl:template match="om:OMOBJ" mode="omdocnode2html">
  <xsl:apply-templates select="."/>
</xsl:template>

<!-- All of these templates overdefine the ones in omdoc2share -->
<xsl:template match="om:OMOBJ[not(@xref)]|om:OMSTR[not(@xref)]">
  <em>
    <xsl:apply-templates/>
  </em>
</xsl:template>



<!-- ================= mode "locale" ========================== -->
<xsl:template match="key/value" mode="locale">
  <xsl:variable name="valid_language">
    <xsl:call-template name="test-valid-language"/>
  </xsl:variable>
  <xsl:if test="$valid_language='true'">
    <xsl:apply-templates mode="locale"/>
  </xsl:if>
</xsl:template>




<!-- =========== Math Elements =========== -->

<xsl:template match="omdoc:assumption|omdoc:conclusion" mode="omdocnode2html">
  <xsl:call-template name="localize-self-br"/>
  <xsl:apply-templates mode="omdocnode2html"/>
  <xsl:text>&#xA;</xsl:text>
</xsl:template>

<xsl:template match="omdoc:FMP" mode="omdocnode2html">
  <xsl:choose>
    <xsl:when test="om:OMOBJ">
      <xsl:call-template name="localize-self-br"/>
      <xsl:apply-templates mode="omdocnode2html"/>
      <xsl:text>&#xA;</xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <xsl:call-template name="do-nl"/>
      <xsl:call-template name="localize">
        <xsl:with-param name="key" select="'FMP'"/>
      </xsl:call-template>
      <xsl:text>: </xsl:text>
      <xsl:for-each select="omdoc:assumption">
        <xsl:call-template name="do-id-label"/>
        <xsl:apply-templates select="om:OMOBJ" mode="omdocnode2html"/>
        <xsl:if test="position()!=last()"><xsl:text>, </xsl:text></xsl:if>
      </xsl:for-each>
      <xsl:text>|-</xsl:text>
      <xsl:apply-templates select="omdoc:conclusion/om:OMOBJ" mode="omdocnode2html"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="omdoc:assertion" mode="omdocnode2html">
  <xsl:call-template name="do-begin-formenv">
    <xsl:with-param name="type" select="@type"/>
  </xsl:call-template>
  <xsl:call-template name="do-nl"/>
  <xsl:apply-templates mode="omdocnode2html"/>
  <xsl:call-template name="do-end-formenv"/>
</xsl:template>

<xsl:template match="omdoc:proof" mode="omdocnode2html">
  <xsl:call-template name="do-begin-formenv"/>
  <xsl:call-template name="do-nl"/>
  <xsl:apply-templates select="omdoc:CMP" mode="omdocnode2html"/>
  <xsl:call-template name="do-begin-list"/>
  <xsl:apply-templates select="child::node()[not(self::omdoc:CMP)]" mode="omdocnode2html"/>
  <xsl:call-template name="do-end-list"/>
  <xsl:call-template name="do-end-formenv"/>
</xsl:template>

<xsl:template match="omdoc:proofobject" mode="omdocnode2html">
  <xsl:call-template name="warning">
    <xsl:with-param name="string" select="'Not presenting proofobject'"/>
  </xsl:call-template>
</xsl:template>

<xsl:template match="omdoc:metacomment" mode="omdocnode2html">
  <xsl:call-template name="do-begin-item"/>
  <xsl:apply-templates mode="omdocnode2html"/>
  <xsl:call-template name="do-end-item"/>
</xsl:template>

<xsl:template match="omdoc:derive|omdoc:conclude|omdoc:hypothesis" mode="omdocnode2html">
  <!-- proofstep -->
  <xsl:call-template name="do-id-label"/>
  <xsl:call-template name="do-begin-item"/>
  <xsl:call-template name="do-begin-bold"/>
  <xsl:call-template name="localize">
    <xsl:with-param name="key" select="local-name()"/>
  </xsl:call-template>
  <xsl:call-template name="do-end-bold"/>
  <xsl:choose>
    <xsl:when test="local-name()='conclude' or local-name()='derive'">
      <xsl:apply-templates select="omdoc:CMP" mode="omdocnode2html"/>
      <xsl:apply-templates select="omdoc:FMP" mode="omdocnode2html"/>
      <xsl:text> </xsl:text>
      <!-- justification -->
      <xsl:if test="omdoc:method">
        <xsl:call-template name="localize">
          <xsl:with-param name="key" select="'proven-by'"/>
        </xsl:call-template>
        <xsl:text> </xsl:text>
        <xsl:apply-templates select="omdoc:method" mode="omdocnode2html"/>
      </xsl:if>
      <xsl:if test="premise">
        <xsl:call-template name="localize">
          <xsl:with-param name="key" select="'from-premises'"/>
        </xsl:call-template>
        <xsl:text> </xsl:text>
        <xsl:apply-templates select="omdoc:premise" mode="omdocnode2html"/>
      </xsl:if>
      <xsl:if test="proof">
        <xsl:apply-templates select="omdoc:proof" mode="omdocnode2html"/>
      </xsl:if>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates mode="omdocnode2html"/>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:call-template name="do-end-item"/>
</xsl:template>

<xsl:template match="omdoc:method" mode="omdocnode2html">
  <xsl:apply-templates select="om:OMSTR|omdoc:ref" mode="omdocnode2html"/>
  <xsl:if test="omdoc:parameter">
    <xsl:text>(</xsl:text>
    <xsl:call-template name="localize">
      <xsl:with-param name="key" select="'on-parameters'"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:for-each  select="omdoc:parameter">
      <xsl:apply-templates select="." mode="omdocnode2html"/>
      <xsl:if test="position()!=last()">
        <xsl:text>, </xsl:text>
      </xsl:if>
    </xsl:for-each>
    <xsl:text>)</xsl:text>
  </xsl:if>
</xsl:template>

<xsl:template match="omdoc:parameter" mode="omdocnode2html">
  <xsl:apply-templates mode="omdocnode2html"/>
</xsl:template>

<xsl:template match="omdoc:premise" mode="omdocnode2html">
  <xsl:variable name="href" select="@href"/>
  <xsl:variable name="local" select="//*[@id=$href]"/>
  <xsl:call-template name="do-begin-crossref">
    <xsl:with-param name="uri">
      <xsl:text>#</xsl:text><xsl:value-of select="@href"/>
    </xsl:with-param>
  </xsl:call-template>
  <xsl:choose>
    <xsl:when test="$local/@id!=''">
      <xsl:value-of select="$local/@id"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:variable name="external" select="document(@href)//*[@id=$href]"/>
      <xsl:choose>
        <xsl:when test="$external!=''">
          <xsl:value-of select="$external"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="generate-id()"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:call-template name="do-end-crossref"/>
</xsl:template>

<xsl:template match="omdoc:example" mode="omdocnode2html">
  <xsl:call-template name="do-begin-formenv"/>
  <xsl:apply-templates mode="omdocnode2html"/>
  <xsl:call-template name="do-end-formenv"/>
</xsl:template>



<!-- ================ do-* named templates (for output styling) ===== -->

<xsl:template name="do-id-label">
  <xsl:if test="@id!=''">
    <a name="{@id}"/>
  </xsl:if>
</xsl:template>

<xsl:template name="do-begin-formenv">
  <xsl:param name="type" select="local-name()"/>
  <xsl:variable name="ffor">
    <xsl:if test="//*[@id=current()/@for]">#</xsl:if>
    <xsl:value-of select="@for"/>
  </xsl:variable>
  <xsl:call-template name="do-id-label"/>
  <xsl:call-template name="do-begin-omdocenv">
    <xsl:with-param name='type'>
      <xsl:if test="local-name()='omtext'">
	<xsl:value-of select="$type"/>
      </xsl:if>
    </xsl:with-param>
  </xsl:call-template>
  <xsl:call-template name="do-begin-bold"/>
  <xsl:if test="not($type='')">
    <xsl:call-template name="localize">
      <xsl:with-param name="key" select="$type"/>
    </xsl:call-template>
  </xsl:if>
  <xsl:call-template name="do-end-bold"/>
  <xsl:if test="$ffor!=''">
    <xsl:text> </xsl:text>
    <xsl:call-template name="localize">
      <xsl:with-param name="key" select="'for'"/>
    </xsl:call-template>
    <xsl:text> </xsl:text>
    <xsl:call-template name="do-begin-crossref">
      <xsl:with-param name="uri" select="$ffor"/>
    </xsl:call-template>
    <xsl:value-of select="@for"/>
    <xsl:call-template name="do-end-crossref"/>
    <xsl:text> </xsl:text>
  </xsl:if>
  <xsl:call-template name="insert-simple-metadata"/>
</xsl:template>

<xsl:template name="do-end-formenv">
  <xsl:call-template name="do-end-omdocenv"/>
</xsl:template>

<xsl:template name="do-begin-list">
  <xsl:text disable-output-escaping="yes">&#xA;&lt;ol&gt;</xsl:text>
</xsl:template>

<xsl:template name="do-end-list">
  <xsl:text disable-output-escaping="yes">&#xA;&lt;/ol&gt;&#xA;</xsl:text>
</xsl:template>

<xsl:template name="do-begin-item">
  <xsl:text disable-output-escaping="yes">&#xA;&lt;li&gt;&#xA;</xsl:text>
</xsl:template>

<xsl:template name="do-end-item">
  <xsl:text disable-output-escaping="yes">&#xA;&lt;/li&gt;&#xA;</xsl:text>
</xsl:template>

<xsl:template name="do-begin-bold">
  <xsl:text disable-output-escaping="yes">&lt;b&gt;</xsl:text>
</xsl:template>

<xsl:template name="do-end-bold">
  <xsl:text disable-output-escaping="yes">&lt;/b&gt;</xsl:text>
</xsl:template>

<xsl:template name="do-begin-crossref">
  <xsl:param name="uri"/>
  <xsl:choose>
    <!-- The variable sw_crossref_allowed is supposed to be a global variable
         in the importing or including program. -->
    <xsl:when test="$sw_crossref_allowed='yes'">
      <xsl:text disable-output-escaping="yes">&lt;a href="</xsl:text>
      <xsl:value-of select="$uri"/>
      <xsl:text disable-output-escaping="yes">"&gt;</xsl:text>
    </xsl:when>
  </xsl:choose>
</xsl:template>

<xsl:template name="do-end-crossref">
  <xsl:choose>
    <!-- The variable sw_crossref_allowed is supposed to be a global variable
         in the importing or including program. -->
    <xsl:when test="$sw_crossref_allowed='yes'">
      <xsl:text disable-output-escaping="yes">&lt;/a&gt;</xsl:text>
    </xsl:when>
  </xsl:choose>
</xsl:template>

<xsl:template name="do-nl">
  <xsl:text disable-output-escaping="yes">&lt;br&gt;&#xA;</xsl:text>
</xsl:template>


<xsl:template name="do-begin-omdocenv">
  <xsl:param name="type"/>
  <xsl:text disable-output-escaping="yes">&lt;div class="</xsl:text>
  <xsl:choose>
    <xsl:when test="local-name()='omtext' and not($type='')"><xsl:value-of select="$type"/></xsl:when>
    <xsl:when test="local-name()='omtext'">normaltext</xsl:when>
    <xsl:otherwise><xsl:value-of select="local-name()"/></xsl:otherwise>
  </xsl:choose>
  <xsl:text disable-output-escaping="yes">"&gt;&#xA;</xsl:text>
</xsl:template>

<xsl:template name="do-end-omdocenv">
  <xsl:text disable-output-escaping="yes">&#xA;&lt;/div&gt;&#xA;</xsl:text>
</xsl:template>

<xsl:template name="do-begin-mcgroup">
  <xsl:text disable-output-escaping="yes">&#xA;&lt;table border="1"&gt;&#xA;</xsl:text>
</xsl:template>

<xsl:template name="do-end-mcgroup">
  <xsl:text disable-output-escaping="yes">&#xA;&lt;/table&gt;&#xA;</xsl:text>
</xsl:template>


<xsl:template name="do-crossref">
  <xsl:param name="uri"/>
  <xsl:param name="print-form"/>
  <a href="{$uri}"><xsl:copy-of select="$print-form"/></a>
</xsl:template>

<xsl:template name="do-print-variable">
  <em><xsl:value-of select="@name"/></em>
</xsl:template>

<!-- ===== here come the named templates (most from omdoc2share.xsl) ===== -->

<xsl:template name="test-valid-language">
  <xsl:variable name="nodename">
    <xsl:value-of  select="local-name()"/>
  </xsl:variable>
  <!-- If language-attribute doesn't exist (f.ex. if dtd not available), 
       assume it is value of $DefaultLanguage -->
  <xsl:variable name="language">
    <xsl:choose>
      <xsl:when test="@xml:lang">
        <xsl:value-of  select="@xml:lang"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$DefaultLanguage"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="siblings-nodeset" select="preceding-sibling::node()[local-name()=$nodename]|following-sibling::node()[local-name()=$nodename]"/>
  <!-- Test, whether this node is among the wanted ones
       (in terms of language). -->
  <xsl:if test="contains($TargetLanguage,$language)">
    <!-- Test, whether other nodes don't have higher priority 
         language-values -->
    <xsl:if test="not($siblings-nodeset[
                  (@xml:lang and contains(substring-before($TargetLanguage,$language),@xml:lang))
                  or (not(@xml:lang) and contains(substring-before($TargetLanguage,$language),$DefaultLanguage))])">
      <!-- Test, whether this node is the only valid one (in terms 
           of language). If not, it is nevertheless a valid one and will 
           be written to the result-tree-->
      <xsl:if test="$language=$siblings-nodeset/@xml:lang or ($language=$DefaultLanguage and $siblings-nodeset[not(@xml:lang)])">
        <xsl:call-template name="localized-error">
          <xsl:with-param name="key" select="'two-cmp-error'"/>
          <xsl:with-param name="id" select="../@id"/>
        </xsl:call-template>
      </xsl:if>
      <xsl:value-of select="true()"/>
    </xsl:if> 
  </xsl:if>
</xsl:template>



<xsl:template name="insert-simple-metadata">
  <xsl:text>(</xsl:text>
  <xsl:choose>
    <xsl:when test="omdoc:metadata/dc:Title">
      <xsl:apply-templates select="omdoc:metadata/dc:Title" mode="omdocnode2html"/>
    </xsl:when>
    <xsl:when test="omdoc:commonname">
      <xsl:apply-templates select="omdoc:commonname" mode="omdocnode2html">
        <xsl:with-param name="sw_simple" select="'yes'"/>
      </xsl:apply-templates>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="@id"/>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:text>)</xsl:text>
  <xsl:if test="omdoc:metadata/dc:Creator">
    <xsl:text>[</xsl:text>
    <xsl:value-of select="omdoc:metadata/dc:Creator"/>
    <xsl:text>]</xsl:text>
  </xsl:if>
</xsl:template>

<!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
<!-- +++++++++++ Language Dependence ++++++++++++++++++++ -->
<!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++ -->

<xsl:variable name="loc" select="document($locale)"/>
<!-- this template looks up the value of the 'key' parameter for the given 
     $TargetLanguage-list, otherwise it gives a localized error message -->
<xsl:template name="localize">
  <xsl:param name="key" select="'no-key-error'"/>
  <xsl:variable name="result">
    <xsl:apply-templates select="$loc/locale/key[@name=$key]/value" mode="locale"/>
  </xsl:variable>
  <xsl:choose>
    <xsl:when test="not($result='')">
      <xsl:value-of select="$result"/>
    </xsl:when>
    <xsl:when test="$result=''">
      <xsl:call-template name="localized-error">
        <xsl:with-param name="key" select="'no-value-error'"/>
        <xsl:with-param name="id" select="$key"/>
      </xsl:call-template>
    </xsl:when>
  </xsl:choose>
</xsl:template>

<xsl:template name="localize-self-br">
  <xsl:call-template name="do-nl"/>
  <xsl:if test="@id">
    <xsl:call-template name="do-id-label"/>
  </xsl:if>
  <xsl:call-template name="localize">
    <xsl:with-param name="key" select="local-name()"/>
  </xsl:call-template>
  <xsl:text> </xsl:text>
  <xsl:apply-templates mode="omdocnode2html"/>
</xsl:template>

<xsl:template name="localize-self">
  <xsl:if test="@id"><xsl:call-template name="do-id-label"/></xsl:if>
  <xsl:call-template name="localize">
    <xsl:with-param name="key" select="local-name()"/>
  </xsl:call-template>
  <xsl:text> </xsl:text>
</xsl:template>

<!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
<!-- +++++++++++ Errorhandling       ++++++++++++++++++++ -->
<!-- +++++++++++ Language Dependence ++++++++++++++++++++ -->
<!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++ -->

<xsl:template name="localized-error">
  <xsl:param name="key"/>
  <xsl:param name="id"/>
  <xsl:if test="$report-errors!='no'">
    <xsl:message>
      <xsl:variable name="error_message">
        <xsl:call-template name="localize">
          <xsl:with-param name="key" select="$key"/>
        </xsl:call-template>
      </xsl:variable>
      <xsl:choose>
        <xsl:when test="$error_message=''">
          <xsl:call-template name="warning">
            <xsl:with-param name="string">
              <xsl:text>Could not find the localized error message for </xsl:text>
              <xsl:value-of select="$key"/>
              <xsl:text>.&#xA;Tried languages:'</xsl:text>
              <xsl:value-of select="$TargetLanguage"/>
              <xsl:text>'.</xsl:text>
            </xsl:with-param>
          </xsl:call-template>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$error_message"/>
          <xsl:value-of select="$id"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:message>
  </xsl:if>
</xsl:template>

<!-- not yet used -->
<xsl:template name="error">
  <xsl:param name="string"/>
  <xsl:if test="$report-errors!='no'">
    <xsl:message>Error: <xsl-value-of select="$string"/></xsl:message>
  </xsl:if>
</xsl:template>

<!-- not yet used -->
<xsl:template name="warning">
  <xsl:param name="string"/>
  <xsl:if test="$report-errors!='no'">
    <xsl:message>
      <xsl:text>Warning: </xsl:text>
      <xsl:value-of select="$string"/>
    </xsl:message>
  </xsl:if>
</xsl:template>


<!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++ -->
<!-- +++++++++++++ otherwise   ++++++++++++++++++++++++++ -->
<!-- ++++++++++++++++++++++++++++++++++++++++++++++++++++ -->

<!-- Dublin Core Metadata -->
<xsl:template match="dc:Title|dc:Subject|dc:Description|dc:Translator" mode="omdocnode2html">
  <xsl:variable name="valid_language">
    <xsl:call-template name="test-valid-language"/>
  </xsl:variable>
  <xsl:if test="$valid_language='true'">
    <xsl:apply-templates mode="omdocnode2html"/>
  </xsl:if>
</xsl:template>

<xsl:template match="dc:Creator" mode="omdocnode2html">
  <xsl:apply-templates mode="omdocnode2html"/>
</xsl:template>



</xsl:stylesheet>




