<!-- An XSL style sheet for creating TPS representations from OMDoc
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
  xmlns:dc="http://www.purl.org/DC"
  xmlns:omdoc="http://www.mathweb.org/omdoc"
  version="1.0">

<xsl:import href="omdoc2sys.xsl"/>

<xsl:strip-space elements = "*"/> 

<xsl:output method="text"/>

<xsl:template match="omdoc:assertion">
  <xsl:text>&#xA;(:name </xsl:text><xsl:value-of select="@id"/>
  <xsl:text>&#xA;:type GWFF</xsl:text>
  <xsl:text>&#xA;:context </xsl:text>
  <xsl:choose>
    <xsl:when test="@theory"><xsl:value-of select="@theory"/></xsl:when>
    <xsl:when test="local-name(..)='theory'"><xsl:value-of select="../@id"/></xsl:when>
    <xsl:otherwise>
      <xsl:message>
        <xsl:text>No Theory specified for assertion </xsl:text>
        <xsl:value-of select="@id"/>
        <xsl:text>!</xsl:text>
      </xsl:message>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:text>&#xA;:keywords NIL</xsl:text>
  <xsl:text>&#xA;:provability </xsl:text>
  <xsl:call-template name="make-provability">
    <xsl:with-param name="assid" select="@id"/>
    <xsl:with-param name="theory" select="../@id"/>
  </xsl:call-template>
  <xsl:text>&#xA;:proof-date </xsl:text>
  <xsl:call-template name="make-proof-date">
    <xsl:with-param name="assid" select="@id"/>
  </xsl:call-template>
  <xsl:text>&#xA;:description </xsl:text>
  <xsl:call-template name="make-ass-formula"/>
  <xsl:text>&#xA;:needed-objects </xsl:text>
  <xsl:call-template name="make-needed-objects"/>
  <xsl:text>&#xA;:mhelp "</xsl:text>
  <xsl:apply-templates select="CMP"/>
  <xsl:text>"&#xA;:other-attributes </xsl:text>
  <xsl:call-template name="make-other-attribs"/>
  <xsl:text>&#xA;:other-remarks "")&#xA;&#xA;</xsl:text>
</xsl:template>

<xsl:template name="make-provability">
  <xsl:param name="assid"/><xsl:param name="theory"/> 
  <xsl:text>"</xsl:text>
  <xsl:if test="../omdoc:proof[@for=$assid]">
    <xsl:text>Proof </xsl:text>
    <xsl:value-of select="../omdoc:proof[@for=$assid]"/>
    <xsl:text>registered in theory</xsl:text>
    <xsl:value-of select="$theory"/>
  </xsl:if>
  <xsl:text>"</xsl:text>
</xsl:template>

<xsl:template name="make-proof-date">
  <xsl:param name="assid"/>
  <xsl:text>"</xsl:text>
  <xsl:value-of select="../omdoc:proof[@for=$assid]/omdoc:metadata/dc:Date"/>
  <xsl:text>"</xsl:text>
</xsl:template>
  
<xsl:template name="make-ass-formula">
  <xsl:choose>
    <xsl:when test="omdoc:FMP/omdoc:conclusion">
      <xsl:text>[</xsl:text>
      <xsl:for-each select="omdoc:FMP/omdoc:assumption">
        <xsl:apply-templates/>
        <xsl:text> implies </xsl:text>
      </xsl:for-each>
      <xsl:apply-templates select="omdoc:FMP/omdoc:conclusion"/>
      <xsl:text>]</xsl:text>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates select="omdoc:FMP"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="omdoc:definition">
  <xsl:text>&#xA;(:name </xsl:text><xsl:value-of select="@id"/>
  <xsl:text>&#xA;:type ABBR</xsl:text>
  <xsl:text>&#xA;:context </xsl:text>
  <xsl:value-of select="../@id"/>
  <xsl:text>&#xA;:keywords NIL</xsl:text>
  <xsl:text>&#xA;:provability NIL</xsl:text>
  <xsl:text>&#xA;:proof-date NIL</xsl:text>
  <xsl:text>&#xA;:description </xsl:text>
  <xsl:call-template name="make-simple-definition"/>
  <xsl:text>&#xA;:needed-objects </xsl:text>
  <xsl:call-template name="make-needed-objects"/>
  <xsl:text>&#xA;:mhelp "</xsl:text>
  <xsl:apply-templates select="omdoc:CMP"/>
  <xsl:text>"&#xA;:other-attributes </xsl:text>
  <xsl:call-template name="make-other-attribs"/>
  <xsl:text>&#xA;:other-remarks "")&#xA;&#xA;</xsl:text>
</xsl:template>



<xsl:template name="make-other-attribs">
  <xsl:text>(</xsl:text>
  <xsl:if test="omdoc:FMP//om:OMATP/om:OMV">
    <xsl:text>(TYPELIST (</xsl:text>
    <xsl:for-each select="omdoc:FMP//om:OMATP/om:OMV">
      <xsl:text>"</xsl:text><xsl:apply-templates/><xsl:text>"</xsl:text>
      <xsl:if test="position()!=last()"><xsl:text> </xsl:text></xsl:if>
    </xsl:for-each>
    <xsl:text>))</xsl:text>
  </xsl:if>
  <xsl:text>)</xsl:text>
</xsl:template>
  
<xsl:template name="make-needed-objects">
  <xsl:text>(</xsl:text>
  <xsl:for-each select="omdoc:FMP//om:OMS">
    <xsl:apply-templates select="." mode="needed"/>
    <xsl:if test="position()!=last()"><xsl:text> </xsl:text></xsl:if>
  </xsl:for-each>
  <xsl:text>)</xsl:text>
</xsl:template>

<xsl:template name="make-simple-definition">
  <xsl:choose>
    <xsl:when test="@type='simple'">
      <xsl:apply-templates select="omdoc:FMP"/>
    </xsl:when>
    <xsl:otherwise>
      <xsl:message>Cannot transform definition of type <xsl:value-of select="@type"/>!</xsl:message>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="omdoc:FMP"><xsl:apply-templates/></xsl:template>
<xsl:template match="omdoc:conclusion"><xsl:apply-templates/></xsl:template>
<xsl:template match="om:OMOBJ"><xsl:apply-templates/></xsl:template>

<!-- TPS does not have n-ary applications -->
<xsl:template match="om:OMA">
  <xsl:text>[</xsl:text>
  <xsl:for-each select="*">
    <xsl:apply-templates select="."/>
    <xsl:if test="position()!=last()"><xsl:text> </xsl:text></xsl:if>
  </xsl:for-each>
  <xsl:text>]</xsl:text>
</xsl:template>

<xsl:template match="om:OMBIND">
  <xsl:variable name="binder">
    <xsl:apply-templates select="*[position()=1]"/>
  </xsl:variable>
  <xsl:for-each select="om:OMBVAR/om:OMV|om:OMBVAR/om:OMATTR">
    <xsl:text>[</xsl:text>
    <xsl:value-of select="$binder"/>
    <xsl:text> </xsl:text>
    <xsl:call-template name="write-typed-variable"/>
    <xsl:text> . </xsl:text>
  </xsl:for-each>
  <xsl:apply-templates select="*[position()=3]"/>
  <xsl:for-each select="om:OMBVAR/om:OMV|om:OMBVAR/om:OMATTR">
    <xsl:text>]</xsl:text>
  </xsl:for-each>
</xsl:template>

<xsl:template match="om:OMS"><xsl:value-of select="@name"/></xsl:template>
<xsl:template match="om:OMS" mode="needed"><xsl:value-of select="@name"/></xsl:template>
<xsl:template match="om:OMV"><xsl:value-of select="@name"/></xsl:template>

<!-- generally, we ignore attribuitions -->
<xsl:template match="om:OMATTR"><xsl:apply-templates select="*[2]"/></xsl:template>

<xsl:template name="write-typed-variable">
  <xsl:choose>
    <xsl:when test="local-name()='OMV'"><xsl:apply-templates select="."/></xsl:when>
    <!-- otherwise we must be in an OMATTR -->
    <xsl:when test="om:OMATP/om:OMS[@cd='mltt' and @name='type']">
      <xsl:apply-templates select="*[2]"/>
      <xsl:text>(</xsl:text>
      <xsl:apply-templates select="om:OMATP/om:OMS[@cd='mltt' and @name='type']/following-sibling::node()"/>
      <xsl:text>)</xsl:text>
    </xsl:when>
    <xsl:otherwise><xsl:apply-templates/></xsl:otherwise>
  </xsl:choose>
</xsl:template>


<!-- transformations for the types -->

<xsl:template match="om:OMS[@cd='mltt' and @name='bool']">
  <xsl:text>O</xsl:text>
</xsl:template>
<xsl:template match="om:OMS[@cd='mltt' and @name='bool']" mode="needed"/>

<xsl:template match="om:OMS[@cd='mltt' and @name='prop']">
  <xsl:text>O</xsl:text>
</xsl:template>
<xsl:template match="om:OMS[@cd='mltt' and @name='prop']" mode="needed"/>

<xsl:template match="om:OMS[@cd='mltt' and @name='ind']">
  <xsl:text>I</xsl:text>
</xsl:template>
<xsl:template match="om:OMS[@cd='mltt' and @name='ind']" mode="needed"/>

<xsl:template match="om:OMA[om:OMS[@cd='mltt' and @name='funtype']]">
  <xsl:text>(</xsl:text>
  <xsl:apply-templates select="*[3]"/><xsl:apply-templates select="*[2]"/>
  <xsl:text>)</xsl:text>
</xsl:template>
<xsl:template match="om:OMS[@cd='mltt' and @name='funtype']" mode="needed"/>

<xsl:template match="om:OMS[@cd='mltt' and @name='type']" mode="needed"/>

<!-- transformations for the logical symbols -->

<xsl:template match="om:OMS[@cd='logic1' and @name='equivalent']">
  <xsl:text>EQUIV</xsl:text>
</xsl:template>
<xsl:template match="om:OMS[@cd='logic1' and @name='equivalent']" mode="needed"/>

<xsl:template match="om:OMS[@cd='logic1' and @name='not']">
  <xsl:text>IMPLIES</xsl:text>
</xsl:template>
<xsl:template match="om:OMS[@cd='logic1' and @name='not']" mode="needed"/>

<xsl:template match="om:OMS[@cd='logic1' and @name='and']">
  <xsl:text>AND</xsl:text>
</xsl:template>
<xsl:template match="om:OMS[@cd='logic1' and @name='and']" mode="needed"/>

<xsl:template match="om:OMS[@cd='logic1' and @name='or']">
  <xsl:text>OR</xsl:text>
</xsl:template>
<xsl:template match="om:OMS[@cd='logic1' and @name='or']" mode="needed"/>

<xsl:template match="om:OMS[@cd='logic1' and @name='implies']">
  <xsl:text>IMPLIES</xsl:text>
</xsl:template>
<xsl:template match="om:OMS[@cd='logic1' and @name='implies']" mode="needed"/>

<xsl:template match="om:OMS[@cd='logic1' and @name='true']">
  <xsl:text>TRUTH</xsl:text>
</xsl:template>
<xsl:template match="om:OMS[@cd='logic1' and @name='true']" mode="needed"/>

<xsl:template match="om:OMS[@cd='logic1' and @name='false']">
  <xsl:text>FALSEHOOD</xsl:text>
</xsl:template>
<xsl:template match="om:OMS[@cd='logic1' and @name='false']" mode="needed"/>

<xsl:template match="om:OMS[@cd='quant1' and @name='forall']">
  <xsl:text>FORALL</xsl:text>
</xsl:template>
<xsl:template match="om:OMS[@cd='quant1' and @name='forall']" mode="needed"/>

<xsl:template match="om:OMS[@cd='quant1' and @name='exsists']">
  <xsl:text>EXISTS</xsl:text>
</xsl:template>
<xsl:template match="om:OMS[@cd='quant1' and @name='exsists']" mode="needed"/>

<xsl:template match="om:OMS[@cd='fns1' and @name='lambda']">
  <xsl:text>LAMBDA</xsl:text>
</xsl:template>
<xsl:template match="om:OMS[@cd='fns1' and @name='lambda']" mode="needed"/>

</xsl:stylesheet>




