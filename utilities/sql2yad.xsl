<?xml version="1.0" encoding="utf-8" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text" />

  <xsl:param name="mode" select="'data'" />

  <xsl:variable name="nl" select="'&#xa;'" />
  <xsl:variable name="apos">'</xsl:variable>
  <xsl:variable name="quot"></xsl:variable>

  <!-- <xsl:variable name="fs" select="' '" /> -->
  <!-- <xsl:variable name="fs" select="'|'" /> -->
  <xsl:variable name="fs" select="$nl" />

  <xsl:template match="resultset">
    <xsl:choose>
      <xsl:when test="$mode='defs'">
        <xsl:value-of select="'--list '" />
        <xsl:apply-templates select="row[1]" mode="make_columns" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="*" mode="write_data" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="row" mode="make_columns">
    <xsl:apply-templates select="field" mode="make_column" />
  </xsl:template>

  <xsl:template match="field" mode="make_column">
    <xsl:value-of select="concat(' --column=&quot;',@name,'&quot;')" />
  </xsl:template>

  <xsl:template match="row" mode="write_data">
    <xsl:apply-templates select="field" mode="write_data" />
  </xsl:template>

  <xsl:template match="field" mode="write_data">
    <xsl:value-of select="concat($quot,.,$quot,$fs)" />
    <!-- <xsl:value-of select="concat($fs,.)" /> -->
  </xsl:template>


</xsl:stylesheet>
