<!-- An XSL style sheet for creating POST representations from OMDoc
     Initial version 20000824 by Michael Kohlhase, 
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
  version="1.0">

<xsl:import href="omdoc2sys.xsl"/>
<xsl:strip-space elements="*"/>
<xsl:output method="text"/>


<xsl:template match="omdoc:CMP"><xsl:apply-templates/></xsl:template>

<xsl:template match="omdoc:FMP">
  <xsl:if test="om:OMOBJ"><xsl:text>  (conclusion </xsl:text></xsl:if>
  <xsl:apply-templates/>
  <xsl:if test="om:OMOBJ"><xsl:text>)</xsl:text></xsl:if>
</xsl:template>

<xsl:template match="omdoc:omtext">
  <xsl:call-template name="print-ccmp"/>
  <xsl:text>&#xA;&#xA;</xsl:text>
</xsl:template>

<!-- #################### Theory Elements ##################### -->

<xsl:template match="omdoc:theory">
  <xsl:variable name="Theory"><xsl:value-of select="@id"/></xsl:variable>
  <xsl:text>&#xA;(th~deftheory </xsl:text>
  <xsl:value-of select="@id"/>
  <xsl:text>&#xA;</xsl:text>
  <xsl:if test="omdoc:imports">
    <xsl:text>(uses </xsl:text>	  
    <xsl:value-of select="omdoc:imports/@from"/>
    <xsl:text>)&#xA;</xsl:text>	  
  </xsl:if>
  <xsl:if test="omdoc:metadata/dc:Title">
    <xsl:text>(help "</xsl:text>
    <xsl:value-of select="omdoc:metadata/dc:Title"/>
    <xsl:if test="omdoc:commonname">
      <xsl:text> / </xsl:text>
      <xsl:value-of select="omdoc:commonname"/>
    </xsl:if>
    <xsl:text>")</xsl:text>
  </xsl:if>
  <xsl:text>)&#xA;</xsl:text>
<xsl:apply-templates/>
</xsl:template>

<xsl:template match="omdoc:axiom">
  <xsl:variable name="Id"><xsl:value-of select="@id"/></xsl:variable>
  <xsl:text>(th~defaxiom </xsl:text><xsl:value-of select="@id"/><xsl:text>&#xA;</xsl:text>
  <xsl:text>  (in </xsl:text><xsl:value-of select="../@id"/>
  <xsl:text>)&#xA;  (formula </xsl:text>
  <xsl:apply-templates select="omdoc:FMP"/><xsl:text>)&#xA;</xsl:text>
  <xsl:text>  (help "</xsl:text>
  <xsl:call-template name="print-cmp"/>
  <xsl:text>"))&#xA;&#xA;</xsl:text>
</xsl:template>


<xsl:template match="omdoc:assertion">
  <xsl:choose>
    <xsl:when test="@type = 'theorem'">
	<xsl:text>(th~deftheorem </xsl:text>
    </xsl:when>	  
    <xsl:otherwise>
	<xsl:text>(th~defproblem </xsl:text>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:value-of select="@id"/>
  <xsl:text>&#xA;</xsl:text>
  <xsl:text>  (in </xsl:text> 
    <xsl:value-of select="@theory"/>
  <xsl:text>)&#xA;</xsl:text>
  <xsl:apply-templates select="." mode="inner"/>
  <xsl:text>)&#xA;&#xA;</xsl:text>
</xsl:template>

<xsl:template match="omdoc:assertion" mode="inner">
  <xsl:variable name="Id"><xsl:value-of select="@id"/></xsl:variable>
  <xsl:if test="omdoc:symbol">
    <xsl:text>  (constants </xsl:text> 
    <xsl:apply-templates select="omdoc:symbol"/>
    <xsl:text>)&#xA;</xsl:text>
  </xsl:if>
  <xsl:apply-templates select="omdoc:FMP"/>
  <xsl:if test="omdoc:CMP[not(xml:lang) or xml:lang='en']">
    <xsl:text>  (help "</xsl:text>
    <xsl:call-template name="print-cmp"/>
    <xsl:text>")&#xA;</xsl:text>
  </xsl:if>
</xsl:template>

<xsl:template match="omdoc:assumption">
  <xsl:text>  (assumption </xsl:text>
  <xsl:value-of select="@id"/>
  <xsl:text> </xsl:text>
  <xsl:apply-templates select="om:OMOBJ"/>
  <xsl:text>)&#xA;</xsl:text>
</xsl:template>

<xsl:template match="omdoc:conclusion">
  <xsl:text>  (conclusion Conc </xsl:text>
  <xsl:apply-templates select="om:OMOBJ"/>
  <xsl:text>)&#xA;</xsl:text>
</xsl:template>

<!-- ################ Proofs ################-->

<xsl:template match="omdoc:proof">
  <xsl:variable name="for" select="@for"/>
  <xsl:variable name="id" select="@id"/>
  <xsl:call-template name="print-cmp"/>
  <xsl:text>(pds&#xA;  (problem </xsl:text>
  <xsl:value-of select="$for"/>
  <xsl:text>)&#xA;</xsl:text>
  <xsl:text>  (in </xsl:text>
  <xsl:value-of select="@theory"/>
  <xsl:text>)&#xA;</xsl:text>
  <xsl:text>  (declarations&#xA;</xsl:text>
  <xsl:text>    (type-variables )&#xA;</xsl:text>
  <xsl:text>    (type-constants </xsl:text>
  <xsl:apply-templates select="omdoc:symbol[@kind='type']"/>
  <xsl:text>)&#xA;</xsl:text>
  <xsl:text>    (constants </xsl:text>
  <xsl:apply-templates select="omdoc:symbol[@kind='object']"/>
  <xsl:text>)&#xA;</xsl:text>
  <xsl:text>    (variables )&#xA;</xsl:text>
  <xsl:text>    (meta-variables )</xsl:text>
  <xsl:text>)&#xA;</xsl:text>
  <xsl:apply-templates select="../omdoc:private[@for=$id]" mode="proof"/>
  <xsl:apply-templates select="//omdoc:assertion[@id=$for]" mode="inner"/>
  <xsl:text>&#xA;  (nodes&#xA;</xsl:text>
  <xsl:apply-templates select="child::node()[not(self::CMP)]"/>
  <xsl:text>))&#xA;&#xA;</xsl:text>-->
</xsl:template>

<xsl:template match="omdoc:private" mode="proof">
  <xsl:text>  (</xsl:text>
  <xsl:value-of select="@type"/>
  <xsl:text> </xsl:text>
  <xsl:value-of select="omdoc:data"/>
  <xsl:text>)&#xA;</xsl:text>
</xsl:template>

<xsl:template match="omdoc:metacomment"><xsl:call-template name="print-ccmp"/></xsl:template>

<xsl:template match="omdoc:hypothesis">
  <xsl:call-template name="print-ccmp"/>
  <xsl:text>    (</xsl:text><xsl:value-of select="@id"/>
  <xsl:text> (</xsl:text><xsl:value-of select="@id"/><xsl:text>)</xsl:text>
  <xsl:apply-templates select="omdoc:FMP"/>
  <xsl:text>(0 ("HYP" () () "grounded" () ())))&#xA;</xsl:text>
</xsl:template>

<xsl:template match="omdoc:derive">
  <xsl:call-template name="print-ccmp"/>
  <xsl:text>    (</xsl:text><xsl:value-of select="@id"/>
  <xsl:text> (</xsl:text><xsl:apply-templates select="omdoc:premise"/><xsl:text>)</xsl:text>
  <xsl:apply-templates select="omdoc:FMP"/>
  <xsl:text>(0 (</xsl:text>
  <xsl:apply-templates select="omdoc:method"/>
  <xsl:text>(</xsl:text>
  <xsl:for-each select="*">
    <xsl:apply-templates/>
    <xsl:if test="position()!=last()"><xsl:text> </xsl:text></xsl:if>
  </xsl:for-each>
  <xsl:text>) (</xsl:text>
  <xsl:apply-templates select="omdoc:premise"/>
  <xsl:text>) "grounded" () ())))&#xA;</xsl:text>
</xsl:template>

<xsl:template match="omdoc:conclude">
  <xsl:variable name="for" select="../@for"/>
  <xsl:call-template name="print-ccmp"/>
  <xsl:text>    (</xsl:text><xsl:value-of select="@id"/>
  <xsl:text> (</xsl:text><xsl:apply-templates select="omdoc:premise"/><xsl:text>)</xsl:text>
  <xsl:apply-templates select="//omdoc:assertion[@id=$for]/omdoc:FMP"/>
  <xsl:text>(0 (</xsl:text>
  <xsl:apply-templates select="omdoc:method"/>
  <xsl:text>(</xsl:text>
  <xsl:for-each select="*">
    <xsl:apply-templates/>
    <xsl:if test="position()!=last()"><xsl:text> </xsl:text></xsl:if>
  </xsl:for-each>
  <xsl:text>) (</xsl:text>
  <xsl:for-each select="omdoc:premise/@href">
    <xsl:apply-templates/>
    <xsl:if test="position()!=last()"><xsl:text> </xsl:text></xsl:if>
  </xsl:for-each>
  <xsl:text>) "grounded" () ())))&#xA;</xsl:text>
</xsl:template>

<xsl:template match="method"><xsl:apply-templates/></xsl:template>

<!-- ################ Symbols ################ -->

<xsl:template match="omdoc:type">
  <xsl:apply-templates select="om:OMOBJ"/>
</xsl:template>

<xsl:template match="omdoc:symbol[@scope='local']">
  <xsl:text>(</xsl:text>
  <xsl:choose>
    <xsl:when test="omdoc:commonname">
      <xsl:value-of select="omdoc:commonname"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="@id"/>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:text> </xsl:text>
  <xsl:apply-templates select="omdoc:type"/>
  <xsl:text>) </xsl:text>
</xsl:template>

<xsl:template match="omdoc:symbol[@scope='global']">
  <xsl:variable name="Id"><xsl:value-of select="@id"/></xsl:variable>
    <xsl:choose>
      <xsl:when test="@kind = 'type'">
        <xsl:text>(th~deftype </xsl:text>
	<xsl:choose>
	  <xsl:when test="omdoc:commonname">
	    <xsl:value-of select="omdoc:commonname"/>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:value-of select="@id"/>
	  </xsl:otherwise>
	</xsl:choose>
        <xsl:text>&#xA;</xsl:text>
        <xsl:text>  (in </xsl:text> 
          <xsl:value-of select="../@id"/>
        <xsl:text>)</xsl:text>
	<xsl:if test="omdoc:type">
	  <xsl:text>&#xA;</xsl:text>
	  <xsl:text>  (arguments </xsl:text>
	  <xsl:number value="count(descendant::om:OMV)"/>  
	  <xsl:text>)</xsl:text>
	</xsl:if>
      </xsl:when>
      <xsl:when test="../omdoc:definition[@for = $Id]">
	<xsl:text>(th~defdef </xsl:text>
	<xsl:choose>
	  <xsl:when test="omdoc:commonname">
	    <xsl:value-of select="omdoc:commonname"/>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:value-of select="@id"/>
	  </xsl:otherwise>
	</xsl:choose>
        <xsl:text>&#xA;</xsl:text>
        <xsl:text>  (in </xsl:text> 
          <xsl:value-of select="../@id"/>
        <xsl:text>)</xsl:text>
	<xsl:value-of select="../omdoc:private[@for = $Id]/data"/>
        <xsl:text>&#xA;  (definition </xsl:text>
          <xsl:apply-templates select="../omdoc:definition[@for = $Id]/FMP"/>
        <xsl:text>)&#xA;</xsl:text>
        <xsl:text>  (help "</xsl:text>
          <xsl:apply-templates select="../omdoc:definition[@for = $Id]/CMP"/>
        <xsl:text>")</xsl:text>
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>(th~defconstant </xsl:text>
	<xsl:choose>
	  <xsl:when test="omdoc:commonname">
	    <xsl:value-of select="omdoc:commonname"/>
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:value-of select="@id"/>
	  </xsl:otherwise>
	</xsl:choose>
        <xsl:text>&#xA;</xsl:text>
        <xsl:text>  (in </xsl:text> 
          <xsl:value-of select="../@id"/>
        <xsl:text>)</xsl:text>
	<xsl:value-of select="../omdoc:private[@for = $Id]/data"/>
        <xsl:text>&#xA;  (type </xsl:text>
          <xsl:apply-templates select="omdoc:type"/>
        <xsl:text>)&#xA;</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:text>)&#xA;&#xA;</xsl:text>
</xsl:template>

<!-- ################ OpenMath ################-->

<xsl:template match="om:OMOBJ"><xsl:apply-templates/></xsl:template>

<xsl:template match="om:OMA|om:OMBIND">
  <xsl:text>(</xsl:text><xsl:apply-templates/><xsl:text>)</xsl:text>
</xsl:template>

<xsl:template match="om:OMS|om:OMV"><xsl:value-of select="@name"/><xsl:text> </xsl:text></xsl:template>

<xsl:template match="om:OMBVAR"><xsl:apply-templates/></xsl:template>

<xsl:template match="om:OMBIND[om:OMS[@name='all-types' and @cd='POST']]">
  <xsl:text>(all-types </xsl:text>
    <xsl:apply-templates select="om:OMBVAR/om:OMV"/>
    <xsl:apply-templates select="*[3]"/>
  <xsl:text>)</xsl:text>
</xsl:template>

<xsl:template match="om:OMA[om:OMS[@name='funtype' and @cd='mltt']]">
  <xsl:text>(</xsl:text>
    <xsl:apply-templates select="*[3]"/>
    <xsl:text> </xsl:text>
    <xsl:apply-templates select="*[2]"/>
  <xsl:text>)</xsl:text>
</xsl:template>

<xsl:template match="om:OMS[@name='lambda' and @cd='mltt']">
  <xsl:text>lam </xsl:text>
</xsl:template>

<xsl:template match="om:OMATTR[om:OMATP[om:OMS[@name='type' and @cd='mltt']]]">
 <xsl:text>(</xsl:text>
  <xsl:apply-templates select="*[2]"/>
  <xsl:text> </xsl:text>
  <xsl:apply-templates select="om:OMATP/*[2]"/>
  <xsl:text>)</xsl:text>
</xsl:template>


<xsl:template name="print-cmp">
  <xsl:choose>
    <xsl:when test="CMP[xml:lang='en']">
      <xsl:apply-templates select="CMP[xml:lang='en']"/>
    </xsl:when>
    <xsl:when test="CMP[not(xml:lang)]">
      <xsl:apply-templates select="CMP[not(xml:lang)]"/>
    </xsl:when>
  </xsl:choose>
</xsl:template>

<xsl:template name="print-ccmp">
  <xsl:if test="CMP[not(xml:lang) or xml:lang='en']">
    <xsl:text>#|</xsl:text>
    <xsl:call-template name="print-cmp"/>
    <xsl:text>|#&#xA;</xsl:text>
  </xsl:if>
</xsl:template>

<xsl:template name="bcomment"><xsl:text>;;; </xsl:text></xsl:template>

</xsl:stylesheet>





