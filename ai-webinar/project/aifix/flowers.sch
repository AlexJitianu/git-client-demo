<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron"
  xmlns:sqf="http://www.schematron-quickfix.com/validator/process" queryBinding="xslt2"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <sch:pattern>
    <!-- Title - styling elements are not allowed in title. -->
    <sch:rule context="title/b">
      <sch:report test="true()" sqf:fix="resolveBold" role="warn" id="boldID"> Bold element is not allowed in
        title, remove it.</sch:report>

      <!-- Quick fix that converts a bold element into text -->
      <sqf:fix id="resolveBold">
        <sqf:description>
          <sqf:title>Change the bold element into text</sqf:title>
          <sqf:p>Removes the bold (b) markup and keeps the text content.</sqf:p>
        </sqf:description>
        <sqf:replace select="node()"/>
      </sqf:fix>
    </sch:rule>
  </sch:pattern>
  
  <sch:pattern>
    <!-- External reference asserts -->
    <sch:rule context="xref[@scope = 'external']">
      <!-- Check the external link protocol -->
      <sch:assert test="matches(@href, '^http(s?)://')" sqf:fix="addHttp addHttps" role="warn" id="externalLinkID">
        An external link should start with http(s).</sch:assert>

      <!-- Quick fixes that adds the http(s) in front of the external link.-->
      <sqf:fix id="addHttp">
        <sqf:description>
          <sqf:title>Add "http://" before the link</sqf:title>
        </sqf:description>
        <sqf:replace match="@href" node-type="attribute" target="href" select="concat('http://', .)"/>
      </sqf:fix>

      <sqf:fix id="addHttps">
        <sqf:description>
          <sqf:title>Add "https://" before the link</sqf:title>
        </sqf:description>
        <sqf:replace match="@href" node-type="attribute" target="href"
          select="concat('https://', .)"/>
      </sqf:fix>

      <!-- Check that the format attribute is set on an external link. -->
      <sch:assert test="@format" sqf:fix="addFormat" role="error" id="xrefFormatID"> Referenced resource
          "<sch:value-of select="@href"/>" needs to have the "format" attribute set to
        it.</sch:assert>

      <!-- Quick fix that adds the format attribute on the current element. -->
      <sqf:fix id="addFormat">
        <sqf:description>
          <sqf:title>Add @format attribute</sqf:title>
        </sqf:description>
        <sqf:add node-type="attribute" target="format"/>
      </sqf:fix>
    </sch:rule>
  </sch:pattern>
  
  <sch:pattern>
    <!-- Table asserts -->
    <sch:rule context="table">
      <sch:let name="minColumsNo" value="min(.//row/count(entry))"/>
      <sch:let name="reqColumsNo" value="max(.//row/count(entry))"/>

      <!-- Check the number of cells on each row -->
      <sch:assert test="$minColumsNo >= $reqColumsNo" sqf:fix="addCells" id="tableCellsID">Cells are missing. (The
        number of cells for each row must be <sch:value-of select="$reqColumsNo"/>)</sch:assert>

      <!-- Quick fix that adds the missing cells from a table. -->
      <sqf:fix id="addCells">
        <sqf:description>
          <sqf:title>Add enough empty cells on each row</sqf:title>
          <sqf:p>Add enough empty cells on each row to match the required number of cells.</sqf:p>
        </sqf:description>
        <sqf:add match="//row" position="last-child">
          <sch:let name="columnNo" value="count(entry)"/>
          <xsl:for-each select="1 to xs:integer($reqColumsNo - $columnNo)">
            <entry/><xsl:text>
						</xsl:text>
          </xsl:for-each>
        </sqf:add>
      </sqf:fix>
    </sch:rule>
  </sch:pattern>
  
  <sch:pattern>
    <!-- Ordered list assert -->
    <sch:rule context="ol">
      <sch:assert test="false()" sqf:fix="convertOLinUL" role="error" id="oLinUlID"> Ordered lists are not
        allowed, use unordered lists instead.</sch:assert>

      <!-- Quick fix that converts an ordered list into an unordered one. -->
      <sqf:fix id="convertOLinUL">
        <sqf:description>
          <sqf:title>Convert ordered list to unordered list</sqf:title>
        </sqf:description>
        <sqf:replace target="ul" node-type="element">
          <xsl:apply-templates mode="copyExceptClass" select="@*|node()"/>
        </sqf:replace>
      </sqf:fix>
    </sch:rule>
    
    <sch:rule context="li">
      <!-- The list item should not end with semicolon -->
      <sch:report test="ends-with((.//text()[normalize-space()!=''])[last()], ';')" sqf:fix="removeSemicolon removeSemicolonList removeAllSemicolons"
        role="info" id="liSemicolonID"> It is not recommended to add a semicolon after a list item.</sch:report>
      
      <sqf:fix id="removeSemicolon">
        <sqf:description>
          <sqf:title>Remove semicolon from this item</sqf:title>
        </sqf:description>
        <sqf:stringReplace match="(.//text()[normalize-space()!=''])[last()]" regex=";$"/>
      </sqf:fix>
      <!-- Quick fix that removes the semicolon from every list item. -->
      <sqf:fix id="removeSemicolonList">
        <sqf:description>
          <sqf:title>Remove semicolon from all items in the current list</sqf:title>
        </sqf:description>
        <sqf:stringReplace match="../li[ends-with((.//text()[normalize-space()!=''])[last()], ';')]/(.//text()[normalize-space()!=''])[last()]" regex=";$"/>
      </sqf:fix>

      <!-- Quick fix that removes the semicolon from every list item in the entire document. -->
      <sqf:fix id="removeAllSemicolons">
        <sqf:description>
          <sqf:title>Remove semicolon from all items in the entire document</sqf:title>
        </sqf:description>
        <sqf:stringReplace match="//li[ends-with((.//text()[normalize-space()!=''])[last()], ';')]/(.//text()[normalize-space()!=''])[last()]" regex=";$"/>
      </sqf:fix>
    </sch:rule>
    

  </sch:pattern>
  
  <!-- Template used to copy the current node -->
  <xsl:template match="node() | @*" mode="copyExceptClass">
    <xsl:copy copy-namespaces="no">
      <xsl:apply-templates select="node() | @*" mode="copyExceptClass"/>
    </xsl:copy>
  </xsl:template>
  <!-- Template used to skip the @class attribute from being copied -->
  <xsl:template match="@class" mode="copyExceptClass"/>
</sch:schema>
