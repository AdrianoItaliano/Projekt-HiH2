<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    <xsl:strip-space elements="*"/>
    
    <!-- Include CSS for styling -->
    <xsl:template name="css">
        <style>
            body { font-family: Arial, sans-serif; }
            h1, h2, h3 { color: #333; }
            .model { border: 1px solid #ccc; padding: 10px; margin: 10px 0; }
            .akcesorium { border: 1px solid #ccc; padding: 5px; margin: 5px 0; }
        </style>
    </xsl:template>
    
    <!-- Template for the root element -->
    <xsl:template match="/drony">
        <html>
            <head>
                <xsl:call-template name="css"/>
            </head>
            <body>
                <xsl:apply-templates select="modele"/>
                <xsl:apply-templates select="akcesoria"/>
            </body>
        </html>
    </xsl:template>
    
    <!-- Template for modele element -->
    <xsl:template match="modele">
        <h1>Modele Dronów</h1>
        <xsl:apply-templates select="model">
            <xsl:sort select="@id" data-type="number" order="ascending"/>
        </xsl:apply-templates>
    </xsl:template>
    
    <!-- Template for model element -->
    <xsl:template match="model">
        <xsl:variable name="modelName" select="nazwa"/>
        <xsl:variable name="modelPrice" select="number(translate(@cena, ' PLN', ''))"/>
        <div class="model">
            <h2><xsl:value-of select="position()"/>. <xsl:value-of select="$modelName"/></h2>
            <p>Cena: <xsl:value-of select="format-number($modelPrice, '#,###.00')"/> PLN</p>
            <p>Waga: <xsl:value-of select="format-number(number(translate(@waga, 'g', '')), '#,###.00')"/> g</p>
            <p>Kamera: <xsl:value-of select="@kamera"/></p>
            <p>Wymiary: <xsl:value-of select="wymiary"/></p>
            <p>Zastosowanie: <xsl:value-of select="zastosowanie"/></p>
            <p>Kolorystyka: <xsl:value-of select="kolorystyka"/></p>
            <xsl:choose>
                <xsl:when test="@kamera='Tak'">
                    <p>Ten model posiada kamerę.</p>
                </xsl:when>
                <xsl:otherwise>
                    <p>Ten model nie posiada kamery.</p>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates select="opinie"/>
            <xsl:apply-templates select="zdjecia"/>
            <xsl:apply-templates select="linki"/>
        </div>
    </xsl:template>
    
    <!-- Template for opinie element -->
    <xsl:template match="opinie">
        <h3>Opinie</h3>
        <ul>
            <xsl:apply-templates select="opinia"/>
        </ul>
    </xsl:template>
    
    <!-- Template for opinia element -->
    <xsl:template match="opinia">
        <li>
            <p>Ocena: <xsl:value-of select="@ocena"/></p>
            <p>Data: <xsl:value-of select="@data"/></p>
            <p><xsl:value-of select="."/></p>
        </li>
    </xsl:template>
    
    <!-- Template for zdjecia element -->
    <xsl:template match="zdjecia">
        <h3>Zdjęcia</h3>
        <xsl:apply-templates select="zdjecie"/>
    </xsl:template>
    
    <!-- Template for zdjecie element -->
    <xsl:template match="zdjecie">
        <div>
            <img>
                <xsl:attribute name="src">
                    <xsl:value-of select="@link"/>
                </xsl:attribute>
                <xsl:attribute name="alt">
                    <xsl:value-of select="@opis"/>
                </xsl:attribute>
            </img>
        </div>
    </xsl:template>
    
    <!-- Template for linki element -->
    <xsl:template match="linki">
        <h3>Linki</h3>
        <ul>
            <xsl:apply-templates select="link"/>
        </ul>
    </xsl:template>
    
    <!-- Template for link element -->
    <xsl:template match="link">
        <li>
            <a>
                <xsl:attribute name="href">
                    <xsl:value-of select="@link"/>
                </xsl:attribute>
                <xsl:value-of select="@typ"/>
            </a>
        </li>
    </xsl:template>
    
    <!-- Template for akcesoria element -->
    <xsl:template match="akcesoria">
        <h1>Akcesoria</h1>
        <ul>
            <xsl:apply-templates select="akcesorium">
                <xsl:sort select="number(translate(@cena, ' PLN EUR', ''))" data-type="number" order="ascending"/>
            </xsl:apply-templates>
        </ul>
    </xsl:template>
    
    <!-- Template for akcesorium element -->
    <xsl:template match="akcesorium">
        <xsl:variable name="akcesoriumName" select="@nazwa"/>
        <xsl:variable name="akcesoriumPrice" select="number(translate(@cena, ' PLN EUR', ''))"/>
        <li class="akcesorium">
            <p>Nazwa: <xsl:value-of select="$akcesoriumName"/></p>
            <p>Cena: <xsl:value-of select="format-number($akcesoriumPrice, '#,###.00')"/>
                <xsl:choose>
                    <xsl:when test="contains(@cena, 'PLN')">PLN</xsl:when>
                    <xsl:otherwise>EUR</xsl:otherwise>
                </xsl:choose>
            </p>
            <p>Kompatybilność: <xsl:value-of select="@kompatybilnosc"/></p>
        </li>
    </xsl:template>
</xsl:stylesheet>
