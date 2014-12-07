<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl [<!ENTITY it ""><!ENTITY PlusMinus "">]>

<!-- this is a style sheet that converts presentation MathML into OMDoc. 
     Of course this cannot be done in general, but this style sheet does all it
     can based on a few assumptions about 'good presentation-MathML' such as using
     invisible times, etc.

     Copyright (c) 2001 Michael Kohlhase, 
     This style sheet is released under the Gnu Public License
     Initial version 20010320 by Michael Kohlhase, 
     send bug-reports, patches, suggestions to kohlhase@mathweb.org
     -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

  <xsl:output method="xml"/>
  <xsl:strip-space elements="math mo mi mn msub msup"/>

  <xsl:template match="/">
  <xsl:comment>
    In this document, all presentation MathML expressions have been converted 
    to OpenMath by by the XSLT style sheet pmml2om.xsl. 
  </xsl:comment>
  <xsl:text>&#xA;&#xA;</xsl:text>
  <xsl:apply-templates/>
  </xsl:template>

<!-- everything is copied, unless it is in a 'math' element -->
<xsl:template match="*">
  <xsl:copy>
    <xsl:copy-of select="@*"/>
    <xsl:apply-templates/>
  </xsl:copy>
</xsl:template>

<xsl:template match="math">
  <OMOBJ>
    <xsl:apply-templates/>
  </OMOBJ>
</xsl:template>

<xsl:template match="semantics">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="annotation"/>

<xsl:template match="mi">
  <xsl:variable name="name" select="."/>
  <OMV name="{$name}"/>
</xsl:template>

<xsl:template match="mn">
  <OMI><xsl:apply-templates/></OMI>
</xsl:template>

<xsl:template match="msup">
  <OMA>
   <OMS cd="arith1" name="power"/>
   <xsl:apply-templates/>
 </OMA>
</xsl:template>

<xsl:template match="mfrac">
  <OMA>
   <OMS cd="arith1" name="divide"/>
   <xsl:apply-templates/>
 </OMA>
</xsl:template>

<xsl:template match="mo[node()='+']">
  <OMS cd="arith1" name="plus"/>
</xsl:template>

<xsl:template match="mo[node()='=']">
  <OMS cd="relation1" name="eq"/>
</xsl:template>

<xsl:template match="mrow[mo[node()='+']]">
  <OMA>
    <OMS cd="arith1" name="plus"/>
    <xsl:for-each select="*">
      <xsl:variable name="cont" select="."/>
      <xsl:if test="$cont!='+'">
        <xsl:apply-templates select="."/>
      </xsl:if>
    </xsl:for-each>
  </OMA>
</xsl:template>

<xsl:template match="mrow[mo[node()='-']]">
  <OMA>
    <OMS cd="arith1" name="minus"/>
    <xsl:for-each select="*">
      <xsl:variable name="cont" select="."/>
      <xsl:if test="$cont!='-'">
        <xsl:apply-templates select="."/>
      </xsl:if>
    </xsl:for-each>
  </OMA>
</xsl:template>


<xsl:template match="mrow[mo[node()='&it;']]">
  <OMA>
    <OMS cd="arith1" name="times"/>
    <xsl:for-each select="*">
      <xsl:variable name="cont" select="."/>
      <xsl:if test="$cont!='&it;'">
        <xsl:apply-templates select="."/>
      </xsl:if>
    </xsl:for-each>
  </OMA>
</xsl:template>

<xsl:template match="mrow[mo[node()='&PlusMinus;']]">
  <OMA>
    <OMS cd="arith1" name="plusminus"/>
    <xsl:for-each select="*">
      <xsl:variable name="cont" select="."/>
      <xsl:if test="$cont!='&PlusMinus;'">
        <xsl:apply-templates select="."/>
      </xsl:if>
    </xsl:for-each>
  </OMA>
</xsl:template>

<xsl:template match="mrow[mo[node()='=']]">
  <OMA>
    <OMS cd="relation1" name="eq"/>
    <xsl:for-each select="*">
      <xsl:variable name="cont" select="."/>
      <xsl:if test="$cont!='='">
        <xsl:apply-templates select="."/>
      </xsl:if>
    </xsl:for-each>
  </OMA>
</xsl:template>


</xsl:stylesheet>
