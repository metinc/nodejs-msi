<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:wix="http://schemas.microsoft.com/wix/2006/wi" 
  xmlns="http://schemas.microsoft.com/wix/2006/wi" version="1.0" exclude-result-prefixes="xsl wix">

  <xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />

  <xsl:strip-space elements="*" />

  <!-- find .gitignore file -->
  <xsl:key name="gitignoreRemove" match="wix:Component[ contains(wix:File/@Source, '.gitignore') ]" use="@Id" />

  <!-- find installer directory -->
  <xsl:key name="installerDir" match="wix:Directory[@Name = 'installer_resources']" use="@Id" />
  <xsl:key name="installerRef" match="wix:Component[ancestor::wix:Directory[@Name = 'installer_resources']]" use="@Id" />

  <!-- By default, copy all elements and nodes into the output... -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
  </xsl:template>

  <!-- ...but if the element has a matching key then don't render anything (i.e. removing it from the output) -->
  <xsl:template match="*[ self::wix:Component or self::wix:ComponentRef ][ key( 'gitignoreRemove', @Id ) ]" />

  <xsl:template match="*[ self::wix:Directory ][ key( 'installerDir', @Id ) ]" />
  <xsl:template match="wix:ComponentRef[key('installerRef', @Id)]" />

</xsl:stylesheet>