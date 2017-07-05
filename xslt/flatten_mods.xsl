<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:mods="http://www.loc.gov/mods/v3"
    xmlns:saxon="http://saxon.sf.net/" exclude-result-prefixes="xs" version="2.0">
    <xsl:output encoding="UTF-8" method="text"/>
    <xsl:strip-space elements="*"/>
    <xsl:template match="/"> {"record": {<xsl:apply-templates/>}} </xsl:template>

    <xsl:template match="*[normalize-space(child::text())]">
        <!--        <xsl:value-of select="replace(replace(saxon:path(), '/', '-'), 'mods:', '')"/> -->
        <xsl:text>"</xsl:text>
        <xsl:for-each select="ancestor-or-self::*[not(self::mods:mods)]">
            <xsl:value-of select="local-name()"/>
            <xsl:for-each select="@*">
                <xsl:text>@</xsl:text>
                <xsl:value-of select="name()"/>
                <xsl:text>=</xsl:text>
                <xsl:value-of select="string(.)"/>
                <xsl:text>-</xsl:text>
            </xsl:for-each>
            <xsl:if test="position() != last()">
                <xsl:text>-</xsl:text>
            </xsl:if>
        </xsl:for-each>
        <xsl:text>" : "</xsl:text>
        <xsl:value-of select="child::text()"/>
        <xsl:text>"</xsl:text>
        <xsl:text>,&#10;</xsl:text>
    </xsl:template>
</xsl:stylesheet>
