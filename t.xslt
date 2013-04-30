<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes"/>
<xsl:template match="node()|@*">
 <xsl:copy>
    <xsl:apply-templates select="node()|@*"/>
  </xsl:copy>
</xsl:template>

<xsl:template match="entry">
 <xsl:copy>

 <xsl:attribute name="auth_method">grid_proxy</xsl:attribute>
 <xsl:attribute name="trust_domain">grid</xsl:attribute>
 <xsl:apply-templates select="@*|node()"/>

 </xsl:copy>
</xsl:template>
</xsl:transform>
