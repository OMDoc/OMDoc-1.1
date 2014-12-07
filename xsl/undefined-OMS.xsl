<?xml version="1.0" encoding="utf-8"?>

<!-- An XSL style sheet for warning about OMS which are not defined, i.e. 
     either the theory/CD cannot be found, or it is missing a symbol 
     declaration of this name.

     Copyright (c) 2002 Michael Kohlhase, 
     This style sheet is released under the Gnu Public License
     Initial version 2001-5-15 by Michael Kohlhase, 
     send bug-reports, patches, suggestions to omdoc@mathweb.org
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:saxon="http://icl.com/saxon" 
  xmlns:omdoc="http://www.mathweb.org/omdoc" 
  xmlns:exsl="http://exslt.org/common" 
  xmlns:set="http://exslt.org/sets" 
  xmlns:om="http://www.openmath.org/OpenMath"
  exclude-result-prefixes="om omdoc"
  extension-element-prefixes="saxon exsl set"
  version="1.0">
 <xsl:include href="exincl.xsl"/>
 <xsl:param name="terminate" select="'yes'"/>
 <xsl:output method="text"/>


<xsl:template match="/" priority="1">
 <xsl:variable name="filename" select="saxon:systemId()"/>
 <xsl:for-each select="$cdus/@cd">
  <xsl:variable name="cd" select="."/>
  <!-- the URI given for the omdoc in the catalogue -->
  <xsl:variable name="omdocURI" select="$href-cat/catalogue/loc[@theory=$cd]/@omdoc"/>
  <!-- and find the respective theoy either there or locally -->
  <xsl:variable name="theory">
   <xsl:choose>
    <xsl:when test="not($omdocURI)">
     <xsl:choose>
      <xsl:when test="exsl:node-set($all)/descendant::omdoc:theory[@id=$cd]">
       <xsl:copy-of select="$all/descendant::omdoc:theory[@id=$cd]"/>
      </xsl:when>
      <xsl:otherwise>
       <xsl:choose>
        <xsl:when test="$terminate='yes'">
         <xsl:message terminate="yes">Could not find theory <xsl:value-of select="$cd"/>!</xsl:message>
        </xsl:when>
        <xsl:otherwise>
         <xsl:text>theory</xsl:text>
         <xsl:value-of select="$cd"/>
         <xsl:text>could not be found;&#xA;  in </xsl:text>
         <xsl:value-of select="$filename"/>
         <xsl:text>!&#xA;</xsl:text>
        </xsl:otherwise>
       </xsl:choose>
      </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
     <xsl:copy-of select="document($omdocURI,$here)//omdoc:theory[@id=$cd]"/>
    </xsl:otherwise>
   </xsl:choose>
  </xsl:variable>
  <!-- now, we determine the symbol names we want to find there -->
  <xsl:variable name="names" 
   select="set:distinct(exsl:node-set($all)/descendant::om:OMS[@cd=$cd]/@name)"/>
  <!-- and actually operate on them -->
  <xsl:for-each select="$names">
   <xsl:variable name="name" select="."/>
   <xsl:if test="not(exsl:node-set($theory)/descendant::omdoc:symbol[@id=$name])">
    <xsl:choose>
     <xsl:when test="$terminate='yes'">
      <xsl:message terminate="yes">symbol <OMS cd="{$cd}" name="{$name}"/> undefined!</xsl:message>
     </xsl:when>
     <xsl:otherwise>
      <xsl:message>symbol <OMS cd="{$cd}" name="{$name}"/> undefined!</xsl:message>
      <xsl:text>undefined symbol &lt;OMS cd="</xsl:text>
      <xsl:value-of select="$cd"/>
      <xsl:text>" name="</xsl:text>
      <xsl:value-of select="$name"/>
      <xsl:text>"&gt;&#xA;  in </xsl:text>
      <xsl:value-of select="$filename"/>
      <xsl:text>!&#xA;</xsl:text>
     </xsl:otherwise>
    </xsl:choose>
   </xsl:if>
  </xsl:for-each>
 </xsl:for-each>
</xsl:template>

</xsl:stylesheet>
