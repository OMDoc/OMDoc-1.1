<?xml version="1.0" encoding="utf-8"?>
<!-- An XSL style sheet for creating html from OMDoc (Open Mathematical Documents). 
     URL: http://www.mathweb.org/omdoc/xsl/omdoc2html.dtd
     send bug-reports, patches, suggestions to omdoc@mathweb.org

     Copyright (c)  2002 Andrea Kohlhase, 

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
  version="1.1"> 
<xsl:include href="omdoc2html.xsl"/>

<xsl:output method="xml" 
            indent="yes" 
            doctype-public="'-//W3C//DTD XHTML 1.0 Strict//EN'"/>

<xsl:strip-space elements="* omdoc:*"/>
<xsl:variable name="omdoc_id" select="omdoc:omdoc/@id"/>

<xsl:variable name="slides" select="//omdoc:omgroup[@type='slide']"/>

<xsl:template match="/">
  <html>
    <head>
      <title>HTML REDIRECT</title>
      <meta http-equiv="refresh" content="0; URL={concat($omdoc_id,'-slide-1.html')}"/>
    </head>
  </html>
  <xsl:message>counted <xsl:value-of select="count($slides)"/> slides</xsl:message>
  <xsl:for-each select="$slides">
    <xsl:message>Writing slide <xsl:value-of select="position()"/></xsl:message>
    <xsl:document 
      href="{concat(concat($omdoc_id,concat('-slide-',position())),'.html')}" 
      encoding="ISO-8859-1">
      <xsl:call-template name="with-document">
        <xsl:with-param name="content">
          <table width="100%" border="0" cellspacing="0" cellpadding="10">
            <tr>
              <td colspan="2">                
                <xsl:call-template name="slide-head">
                  <xsl:with-param name="id" select="position()"/>
                </xsl:call-template>
              </td>
            </tr>
            <tr>
              <td valign="top"><xsl:call-template name="create-navigation"/></td>
              <td valign="top">
                <xsl:apply-templates select="*[local-name()!='metadata']">
                  <xsl:with-param name="level" select="0"/>
                  <xsl:with-param name="prefix" select="''"/>
                </xsl:apply-templates>
              </td>
            </tr>
          </table>
        </xsl:with-param>
      </xsl:call-template>
    </xsl:document>
  </xsl:for-each>
</xsl:template>


<xsl:template name="create-navigation">
  <xsl:variable name="pos" select="position()"/>
  <table border="0" cellspacing="0" cellpadding="2">
    <xsl:for-each select="$slides[position() &lt; $pos]">
      <tr>
        <td>
          <a href="{concat(concat($omdoc_id,concat('-slide-',position())),'.html')}">
            <xsl:value-of select="concat(position(),'. ')"/>
            <xsl:apply-templates select="omdoc:metadata/dc:Title[@xml:lang=$TargetLanguage]"/>
          </a>
        </td>
      </tr>
    </xsl:for-each>
    <tr>
      <td>
        <xsl:value-of select="concat($pos,'. ')"/>
        <xsl:apply-templates select="omdoc:metadata/dc:Title[@xml:lang=$TargetLanguage]"/>
      </td>
    </tr>
    <xsl:for-each select="$slides[position() &gt; $pos]">
      <tr>
        <td>
          <xsl:variable name="cpos" select="position() + $pos"/>
          <a href="{concat(concat($omdoc_id,concat('-slide-',$cpos)),'.html')}">
            <xsl:value-of select="concat($cpos,'. ')"/>
            <xsl:apply-templates select="omdoc:metadata/dc:Title[@xml:lang=$TargetLanguage]"/>
          </a>
        </td>
      </tr>
    </xsl:for-each>
  </table>
</xsl:template>
  
<xsl:template name="slide-head">
  <xsl:param name="id"/>
  <div style="height:1em">
    <span style="position:relative;top:50%;font-style:bold"> 
    <xsl:choose>
      <xsl:when test="position() - 1 > 0">
        <a href="{concat(concat($omdoc_id,concat('-slide-',position() - 1)),'.html')}">&lt;&lt;</a>
      </xsl:when>
      <xsl:otherwise>
        <a href="{concat(concat($omdoc_id,concat('-slide-',last())),'.html')}">&lt;&lt;&lt;&lt;</a>
      </xsl:otherwise>
    </xsl:choose>
    </span>
    <span class="courseinfo">
      <xsl:call-template name="titleblock">
        <xsl:with-param name="display" select="'span'"/> 
      </xsl:call-template>
    </span>
    <span style="position:relative;left:92%;top:50%;font-style:bold"> 
    <xsl:choose>
      <xsl:when test="position()=last()">
        <a href="{concat(concat($omdoc_id,concat('-slide-',1)),'.html')}">&gt;&gt;&gt;&gt;</a>
      </xsl:when>
      <xsl:otherwise>        
         <a href="{concat(concat($omdoc_id,concat('-slide-',position() + 1)),'.html')}">&gt;&gt;</a>
       </xsl:otherwise>
     </xsl:choose>
   </span>
 </div>
</xsl:template>

<xsl:template name="insert-local-css">
  <xsl:text>
    span[class="courseinfo"] span[class="title"] {display:inline;font-style:bold;border-style:none;color:red}
    span[class="courseinfo"] span[class="authors"] {display:inline;font-variant:small-caps;padding:0pt;border-style:none}
    span[class="courseinfo"] span[class="date"] {display:inline;padding:0pt;border-style:none}
    span[class="courseinfo"] {position:absolute;left:20%;top:40pt;font-style:bold;width:60%;display:block;border-style:none;padding:0pt}
  </xsl:text>
</xsl:template>

</xsl:stylesheet>




