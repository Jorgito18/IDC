<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.tei-c.org/ns/1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    exclude-result-prefixes="#all" version="2.0">
    
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:variable name="geofile"
        select="document('fr_Cussac-coord-entites.xml')/geolocalisation/entite_nom"/>
    
    <xsl:template match="node() | @*">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="//*[@type = 'NAM']">
        <xsl:variable name="curVal" select="."/>
        <xsl:variable name="length" select="6"/>
        <xsl:variable name="i" select="0"/>
            <xsl:choose>
                <xsl:when test=" $curVal/text() = $geofile/text() ">
                    <xsl:for-each select="for $i in 0 to $length return $geofile[$i]">
                        <xsl:if test="$curVal/text() = ./text()">
                            <xsl:element name="placeName">
                                <xsl:attribute name="id">
                                    <xsl:value-of select="./@id"/>
                                </xsl:attribute>
                                <xsl:attribute name="ref">file:fr_Cussac_coord_entites.xml</xsl:attribute>
                                <xsl:element name="name">
                                    <xsl:element name="w">
                                        <xsl:attribute name="lemma">
                                            <xsl:value-of select="."/>
                                        </xsl:attribute>
                                        <xsl:attribute name="type">NAM</xsl:attribute>
                                        <xsl:value-of select="."/>
                                    </xsl:element>
                                </xsl:element>
                            </xsl:element>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:element name="w">
                        <xsl:attribute name="lemma">
                            <xsl:value-of select="translate($curVal, 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')" />
                        </xsl:attribute>
                        <xsl:attribute name="type">NAM</xsl:attribute>
                        <xsl:value-of select="$curVal"/>
                    </xsl:element>
                </xsl:otherwise>
            </xsl:choose>
    </xsl:template>
</xsl:stylesheet>