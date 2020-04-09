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
        <xsl:for-each select=".">
            <xsl:variable name="i" select="3"/>
            <xsl:choose>
                <xsl:when test=".[@lemma = $geofile[$i]]">
                    <xsl:element name="placeName">
                        <xsl:attribute name="id">
                            <xsl:value-of select="$geofile[$i]/@id"/>
                        </xsl:attribute>
                        <xsl:attribute name="ref">file:fr_Cussac_coord_entites.xml</xsl:attribute>
                        <xsl:element name="name">
                            <xsl:element name="w">
                                <xsl:attribute name="lemma">
                                    <xsl:value-of select="$geofile[$i]"/>
                                </xsl:attribute>
                                <xsl:attribute name="type">NPr</xsl:attribute>
                                <xsl:value-of select="$geofile[$i]"/>
                            </xsl:element>
                        </xsl:element>
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:element name="w">
                        <xsl:attribute name="lemma">
                            <xsl:value-of
                                select="
                                    translate(.
                                    , 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
                                    , 'abcdefghijklmnopqrstuvwxyz')"
                            />
                        </xsl:attribute>
                        <xsl:attribute name="type">NAM</xsl:attribute>
                        <xsl:value-of select="."/>
                    </xsl:element>
                </xsl:otherwise>
            </xsl:choose>

        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
