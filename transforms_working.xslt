<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fhir="http://hl7.org/fhir">

  <xsl:param name="cancer-concept-map-file">ConceptMap-working.xml</xsl:param>

  <xsl:variable name="cancer-concept-map" select="document($cancer-concept-map-file)/ConceptMap" />

  <xsl:template match="//fhir:Observation/fhir:code">
    <code>
     
    <xsl:apply-templates />
      <xsl:variable name="codevalue" select="fhir:coding/fhir:code/@value" />

      <xsl:for-each select="$cancer-concept-map//fhir:code[@value = $codevalue]">
        <coding>
          <system value="http://snomed.info/sct" />
          <code value="test" />
        </coding>
      </xsl:for-each>
    </code>
  </xsl:template>





  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@* | node()" />
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
