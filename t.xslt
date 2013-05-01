<xsl:transform version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" indent="yes"/>
<!-- Generic template: copy everything -->
<xsl:template match="node()|@*">
 <xsl:copy>
    <xsl:apply-templates select="node()|@*"/>
  </xsl:copy>
</xsl:template>

<!-- Specific templates -->
<!-- Add auth_method and trust_domain attribute to entry nodes -->
<xsl:template match="entry">
 <xsl:copy>
  <xsl:attribute name="auth_method">grid_proxy</xsl:attribute>
  <xsl:attribute name="trust_domain">grid</xsl:attribute>
 <xsl:apply-templates select="@*|node()"/>
 </xsl:copy>
</xsl:template>

<!-- Remove downtimes node -->
<xsl:template match="downtimes"/>

<!-- <xsl:text xml:space="preserve">&#10;</xsl:text> -->
<!-- Add process_logs to log_retention node -->
<xsl:template match="log_retention">
 <xsl:copy>
  <xsl:apply-templates select="@*|node()"/>
<xsl:text>   </xsl:text> <process_logs>
<xsl:text>&#10;       </xsl:text> <process_log extension="info" max_days="7.0" max_mbytes="100.0" min_days="3.0" msg_types="INFO"/>
<xsl:text>&#10;       </xsl:text> <process_log extension="err" max_days="7.0" max_mbytes="100.0" min_days="3.0" msg_types="DEBUG,ERR,WARN"/>
<xsl:text>&#10;      </xsl:text> </process_logs>
<xsl:text>&#10;   </xsl:text>
 </xsl:copy>
</xsl:template>

<!-- Convert max_jobs attributes to per_entry element and attributes -->
<xsl:template match="max_jobs">
 <max_jobs><xsl:text>&#10;               </xsl:text>
  <per_entry>
   <xsl:attribute name="held"><xsl:value-of select="@held"/></xsl:attribute>
   <xsl:attribute name="idle"><xsl:value-of select="@idle"/></xsl:attribute>
   <xsl:attribute name="running"><xsl:value-of select="@running"/></xsl:attribute>
  </per_entry>
 <xsl:apply-templates/> 
 </max_jobs>
</xsl:template>

<!-- Rename default_max_jobs_frontend to defaults_per_frontend -->
<xsl:template match="default_max_jobs_frontend">
<default_per_frontend>
    <xsl:apply-templates select="@*|node()"/>
</default_per_frontend>
</xsl:template>

<!-- Rename max_job_frontends to per_frontends -->
<xsl:template match="max_job_frontends">
  <per_frontends>
    <xsl:apply-templates select="@*|node()"/>
  </per_frontends>
</xsl:template>


</xsl:transform>
