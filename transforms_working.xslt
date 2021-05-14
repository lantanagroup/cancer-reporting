<xsl:stylesheet xmlns="http://hl7.org/fhir" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fhir="http://hl7.org/fhir" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:lcg="http://www.lantanagroup.com" version="2.0" exclude-result-prefixes="lcg fhir xs xsi">

    <xsl:variable name="cancer-concept-map" select="document('ConceptMap-working.xml')" />

    <xsl:template match="//fhir:Observation/fhir:code">
        <code>
            <xsl:apply-templates />
            <xsl:variable name="codevalue" select="fhir:coding/fhir:code/@value" />

            <xsl:for-each select="$cancer-concept-map//fhir:element[fhir:code/@value = $codevalue]">
                <coding>
                    <system value="http://snomed.info/sct" />
                    <code>
                        <xsl:attribute name="value" select="fhir:target/fhir:code/@value" />
                    </code>
                    <xsl:copy-of select="fhir:target/fhir:display"/>
                </coding>
            </xsl:for-each>
        </code>
    </xsl:template>
  
  <xsl:template match="//fhir:Observation/fhir:valueCodeableConcept">
    <valueCodeableConcept>
      <xsl:apply-templates/>
      <xsl:variable name="valuecc" select="fhir:coding/fhir:code/@value"/>
      <xsl:for-each select="$cancer-concept-map//fhir:element[fhir:code/@value = $valuecc]">
        <coding>
          <system value="http://snomed.info/sct" />
          <code>
            <xsl:attribute name="value" select="fhir:target/fhir:code/@value" />
          </code>
          <xsl:copy-of select="fhir:target/fhir:display"/>
        </coding>
      </xsl:for-each>
    </valueCodeableConcept>
  </xsl:template>

    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()" />
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
