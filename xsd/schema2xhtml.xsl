<?xml version="1.0" encoding="utf-8"?>
<!--
Author: Romeo Anghelache romeo@psyx.org
released under GNU license, 2001
version="2.0"
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
<xsl:output method="html" encoding="utf-8"/>
	<xsl:template match="/xsd:schema">
		<xhtml>
			<head>
				<title>
					<xsl:value-of select="@id"/> Schema version <xsl:value-of select="@version"/>
				</title>
			</head>
			<body style="font:sans-serif;">
			

			<h2><xsl:value-of select="@id"/> Schema version <xsl:value-of select="@version"/></h2>
			<h3>Notation and color conventions of this schema representation:</h3>
			<div>a choice: [x y z] ; a sequence: (x y z) ; (* x,y) is the same as the dtd-like notation (x,y)*</div>
<div>Colours used: <span style="font-weight:bold; color:darkblue">{type declarations}</span>;  <span style="font-weight:normal; color:darkred">element names</span>; <span style="font-weight:normal; color:darkgreen">attribute names</span>; <span style="font-weight:normal; color:blue">restriction/extension facets</span>; <a style="font-weight:bold" href="#">{links to type definitions}</a>; <span style="font-weight:normal; color:black">comments</span>; </div>
<div>an extension of a type is {&lt;&lt;type&gt;&gt;} ; and a restriction to it, is : {&gt;&gt;type&lt;&lt;}
</div>
			<xsl:for-each select="xsd:annotation/xsd:documentation">
			<p><xsl:value-of select="text()"/></p>
			</xsl:for-each>
			<xsl:if test="xsd:import">
				<h3>Imported schemata:</h3>
					<xsl:for-each select="xsd:import">
						<div>
							<a href="{@schemaLocation}">
								<xsl:value-of select="@schemaLocation"/>
							</a>
							from namespace 
							<span style="font-weight:bold;">
								<xsl:value-of select="@namespace"/>
							</span>
						</div>
					</xsl:for-each>
			</xsl:if>
			<xsl:if test="xsd:include">
				<h3>Included schemata:</h3>
					<xsl:for-each select="xsd:import">
						<div>
							<a href="{@schemaLocation}">
								<xsl:value-of select="@schemaLocation"/>
							</a>
							from namespace 
							<span style="font-weight:bold;"> 
								<xsl:value-of select="@namespace"/>
							</span>
						</div>
					</xsl:for-each>
			</xsl:if>

				<h3>Global Elements:</h3>
				<xsl:apply-templates select="xsd:element"/>
				<h3>Global Types:</h3>
				<xsl:apply-templates select="xsd:complexType">
				<xsl:sort select="@name"/>
				</xsl:apply-templates>
				<xsl:apply-templates select="xsd:simpleType">
				<xsl:sort select="@name"/>
				</xsl:apply-templates>
				<xsl:if test="xsd:group|xsd:attributeGroup">
				<h3>Useful groups:</h3>
				<xsl:apply-templates select="xsd:group|xsd:attributeGroup">
				<xsl:sort select="@name"/>
				</xsl:apply-templates>
				</xsl:if>
			</body>
		</xhtml>
	</xsl:template>

<xsl:key name="type" match="xsd:complexType|xsd:simpleType|xsd:group|xsd:attributeGroup" use="@name"/>

	<xsl:template match="xsd:element">
		<ul>
			<li>&lt;<span style="font-weight:normal; color:darkred;"><xsl:value-of select="@name | @ref"/></span>&gt;
			<xsl:call-template name="howmany"/>
				<span style="font-weight:bold; color:darkblue">
				<xsl:choose>
					<xsl:when test="@type">
					<xsl:choose>
						<xsl:when test="contains(@type,':')">{<xsl:value-of select="@type"/>}</xsl:when>
						<xsl:otherwise><xsl:text> </xsl:text><a href="#{generate-id(key('type',@type))}">{<xsl:value-of select="@type"/>}</a></xsl:otherwise>
					</xsl:choose>
					</xsl:when>
				</xsl:choose>
				</span>
				<xsl:if test="xsd:annotation"><span style="font-weight:normal; color:black;"><xsl:apply-templates  select="xsd:annotation"/></span></xsl:if>
				<xsl:if test="xsd:attribute"><ul><xsl:apply-templates  select="xsd:attribute"/></ul></xsl:if>
				<xsl:apply-templates select="xsd:complexType|xsd:simpleType|xsd:group|xsd:attributeGroup"/>
				</li>
	</ul>
	</xsl:template>

	<xsl:template match="xsd:group|xsd:attributeGroup">
		<xsl:choose>
			<xsl:when test="@ref">
			<ul><li>
			<xsl:choose>
				<xsl:when test="contains(@type,':')">{<xsl:value-of select="@type"/>}</xsl:when>
				<xsl:otherwise><xsl:text> </xsl:text><a href="#{generate-id(key('type',@ref))}">{<xsl:value-of select="@ref"/>}</a></xsl:otherwise>
			</xsl:choose>
			</li></ul>
			</xsl:when>
			<xsl:otherwise>
			<p style="font-weight:bold; color:darkblue;">
				<a name="{generate-id()}"><xsl:value-of select="@name"/></a> :
			</p>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="xsd:attributeGroup">
		<xsl:choose>
			<xsl:when test="@ref">
			<ul><li>
			<xsl:choose>
				<xsl:when test="contains(@type,':')">{<xsl:value-of select="@type"/>}</xsl:when>
				<xsl:otherwise><xsl:text> </xsl:text><a href="#{generate-id(key('type',@ref))}">{<xsl:value-of select="@ref"/>}</a></xsl:otherwise>
			</xsl:choose>
			</li></ul>
			</xsl:when>
			<xsl:otherwise>
			<p style="font-weight:normal; color:darkgreen;">
				<a name="{generate-id()}"><xsl:value-of select="@name"/></a> :
			</p>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:apply-templates/>
	</xsl:template>
 
 
 
	<xsl:template match="xsd:complexType">
			<xsl:if test="@name">
				<p style="font-weight:bold; color:darkblue;">
					<a name="{generate-id()}"><xsl:value-of select="@name"/></a> :
				<xsl:if test="@mixed='true'">
					<span> {free text}</span>
				</xsl:if>
				<xsl:if test="xsd:annotation"><span style="font-weight:normal; color:black;"><xsl:apply-templates  select="xsd:annotation"/></span></xsl:if>
				</p>
			</xsl:if>
			<xsl:apply-templates select="xsd:complexContent|xsd:simpleContent|xsd:sequence|xsd:choice|xsd:group|xsd:attributeGroup"/>
			<ul><xsl:apply-templates select="xsd:attribute"/></ul>
	</xsl:template>
	
	<xsl:template match="xsd:any">
	<span style="font-weight:bold;">any</span>
	</xsl:template>

	<xsl:template match="xsd:sequence">
				<ul>
					<li><div style="font-weight:bold; color:darkblue">(<xsl:call-template name="howmany"/></div>
						<xsl:apply-templates/>
						<div style="font-weight:bold; color:darkblue">)</div>
					</li>
						
				</ul>
	</xsl:template>

	<xsl:template match="xsd:choice">
				
				<ul style="font-weight:bold; color:darkblue">
					<li><div style="font-weight:bold; color:darkblue">[<xsl:call-template name="howmany"/></div>
						<xsl:apply-templates/>
						<div style="font-weight:bold; color:darkblue">]</div>
					</li>
				</ul>
				
	</xsl:template>


	<xsl:template match="xsd:attribute">
		<li>
			<xsl:if test="@name">
				<span style="font-weight:normal; color:darkgreen;">
				<xsl:value-of select="@name"/> : 
				</span>
			</xsl:if>
			<span style="font-weight:bold; color:darkblue">
				<span style="font-weight:bold; color:darkblue">
				<xsl:choose>
					<xsl:when test="@type">
					<xsl:choose>
						<xsl:when test="contains(@type,':')">{<xsl:value-of select="@type"/>}</xsl:when>
						<xsl:otherwise><xsl:text> </xsl:text><a href="#{generate-id(key('type',@type))}">{<xsl:value-of select="@type"/>}</a></xsl:otherwise>
					</xsl:choose>
					</xsl:when>
				</xsl:choose>
				</span>
			</span>
			<xsl:apply-templates select="xsd:annotation"/>
			<xsl:apply-templates select="xsd:simpleType"/>
		</li>
	</xsl:template>
	

	<xsl:template match="xsd:simpleType">
			<xsl:if test="@name">
				<p>
					<span style="font-weight:bold; color:darkblue;">
					<a name="{generate-id()}"><xsl:value-of select="@name"/></a></span> :
					<xsl:if test="xsd:annotation"><xsl:apply-templates select="xsd:annotation"/></xsl:if>
				</p>
			</xsl:if>
			<ul><li><xsl:apply-templates select="xsd:extension|xsd:restriction|xsd:list|xsd:union"/></li></ul>
	</xsl:template>

	<xsl:template match="xsd:extension">
		<span style="font-weight:bold; color:darkblue">&lt;&lt;{
		<xsl:choose>
			<xsl:when test="contains(@base,':')"><xsl:value-of select="@base"/></xsl:when>
			<xsl:otherwise>
			<a href="#{generate-id(key('type',@base))}"><xsl:value-of select="@base"/></a>
			</xsl:otherwise>
		</xsl:choose>
		}&gt;&gt;</span>
		<xsl:apply-templates>
			<xsl:sort  select="@value" order="ascending"/>
		</xsl:apply-templates>
	</xsl:template>

	<xsl:template match="xsd:restriction">
		<span style="font-weight:bold; color:darkblue">&gt;&gt;{
		<xsl:choose>
			<xsl:when test="contains(@base,':')"><xsl:value-of select="@base"/></xsl:when>
			<xsl:otherwise>
			<a href="#{generate-id(key('type',@base))}"><xsl:value-of select="@base"/></a>
			</xsl:otherwise>
		</xsl:choose>
		}&lt;&lt;</span>
		<xsl:apply-templates>
			<xsl:sort  select="@value" order="ascending"/>
		</xsl:apply-templates>
	</xsl:template>
	

	<xsl:template match="xsd:pattern">
pattern:<span style="font-weight:normal; color:blue">&#9;
			<xsl:value-of select="@value"/>
		</span>
	</xsl:template>

	<xsl:template match="xsd:simpleContent | xsd:complexContent">
	<xsl:if test="xsd:restriction | xsd:extension"><xsl:value-of select="base"/></xsl:if>
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="xsd:enumeration">
	<ul>
		<li style="font-weight:normal; color:blue">
			<xsl:value-of select="@value"/>
			<xsl:apply-templates/>
		</li>
	</ul>
	</xsl:template>

	<xsl:template match="xsd:documentation">
		<span style="font-weight:normal; color:black">
			<xsl:text>&#9;</xsl:text><xsl:value-of select="text()"/>
		</span>
	</xsl:template>


	<xsl:template name="howmany">
		<xsl:choose>
			<xsl:when test="@minOccurs='0' and @maxOccurs='unbounded'">*</xsl:when>
			<xsl:when test="@minOccurs='0' and (not(@maxOccurs) or @maxOccurs='1')">?</xsl:when>
			<xsl:when test="(not(@minOccurs) or @minOccurs='1') and @maxOccurs='unbounded'">+	</xsl:when>
			<xsl:otherwise>
				<xsl:if test="@minOccurs and @maxOccurs!='1'">
					<xsl:value-of select="@minOccurs"/>
					<xsl:if test="@maxOccurs='unbounded'">+</xsl:if>
					<xsl:if test="@maxOccurs!='unbounded'">-<xsl:value-of select="@maxOccurs"/>
					</xsl:if>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="xsd:minExclusive">
		&gt;<xsl:value-of select="@value"/>
	</xsl:template>

	<xsl:template match="xsd:maxExclusive">
		&lt;<xsl:value-of select="@value"/>
	</xsl:template>

	<xsl:template match="xsd:minInclusive">
		&gt;=<xsl:value-of select="@value"/>
	</xsl:template>

	<xsl:template match="xsd:maxInclusive">
		&lt;=<xsl:value-of select="@value"/>
	</xsl:template>


</xsl:stylesheet>
