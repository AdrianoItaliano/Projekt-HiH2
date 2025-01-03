<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <xsl:template match="/drony">
        <nowyKorzen>
            <xsl:apply-templates select="modele"/>
            <xsl:apply-templates select="akcesoria"/>
        </nowyKorzen>
    </xsl:template>

    <xsl:template match="modele">
        <drony>
            <xsl:apply-templates select="model"/>
        </drony>
    </xsl:template>

    <xsl:template match="model">
        <dron>
            <xsl:variable name="sanitizedName" select="translate(translate(nazwa, ' +,', '__'), ',', '')"/>
            <xsl:element name="{$sanitizedName}">
                <xsl:attribute name="cena">
                    <xsl:value-of select="@cena"/>
                </xsl:attribute>
                <xsl:attribute name="waga">
                    <xsl:value-of select="@waga"/>
                </xsl:attribute>
                <xsl:attribute name="kamera">
                    <xsl:value-of select="@kamera"/>
                </xsl:attribute>
                <xsl:attribute name="nazwa">
                    <xsl:value-of select="nazwa"/>
                </xsl:attribute>
                <wymiary>
                    <xsl:value-of select="wymiary"/>
                </wymiary>
                <zastosowanie>
                    <xsl:value-of select="zastosowanie"/>
                </zastosowanie>
                <kolory>
                    <xsl:value-of select="kolorystyka"/>
                </kolory>
                <xsl:apply-templates select="opinie"/>
                <xsl:apply-templates select="zdjecia"/>
                <xsl:apply-templates select="linki"/>
            </xsl:element>
        </dron>
    </xsl:template>

    <xsl:template match="opinie">
        <opinie>
            <xsl:apply-templates select="opinia"/>
        </opinie>
    </xsl:template>

    <xsl:template match="opinia">
        <opinia>
            <xsl:attribute name="ocena">
                <xsl:value-of select="@ocena"/>
            </xsl:attribute>
            <xsl:attribute name="data">
                <xsl:value-of select="@data"/>
            </xsl:attribute>
            <xsl:value-of select="."/>
        </opinia>
    </xsl:template>

    <xsl:template match="zdjecia">
        <zdjecia>
            <xsl:apply-templates select="zdjecie"/>
        </zdjecia>
    </xsl:template>

    <xsl:template match="zdjecie">
        <zdjecie>
            <xsl:attribute name="src">
                <xsl:value-of select="@link"/>
            </xsl:attribute>
            <xsl:attribute name="opis">
                <xsl:value-of select="@opis"/>
            </xsl:attribute>
        </zdjecie>
    </xsl:template>

    <xsl:template match="linki">
        <linki>
            <xsl:apply-templates select="link"/>
        </linki>
    </xsl:template>

    <xsl:template match="link">
        <link>
            <xsl:attribute name="url">
                <xsl:value-of select="@link"/>
            </xsl:attribute>
            <xsl:attribute name="typ">
                <xsl:value-of select="@typ"/>
            </xsl:attribute>
        </link>
    </xsl:template>

    <xsl:template match="akcesoria">
        <akcesoria>
            <xsl:apply-templates select="akcesorium"/>
        </akcesoria>
    </xsl:template>

    <xsl:template match="akcesorium">
        <akcesorium>
            <xsl:attribute name="nazwa">
                <xsl:value-of select="@nazwa"/>
            </xsl:attribute>
            <xsl:attribute name="koszt">
                <xsl:value-of select="@cena"/>
            </xsl:attribute>
            <xsl:attribute name="kompatybilnosc">
                <xsl:value-of select="@kompatybilnosc"/>
            </xsl:attribute>
        </akcesorium>
    </xsl:template>
</xsl:stylesheet>