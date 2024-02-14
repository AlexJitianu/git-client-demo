<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt3"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <sch:ns uri="http://www.oxygenxml.com/ai/function" prefix="ai"/>
    <sch:pattern>
        <sch:rule context="p">
            <sch:report test="contains(., '- ')" sqf:fix="replace" role="info">
                The text should be a list.</sch:report>
            <sqf:fix id="replace">
                <sqf:description>
                    <sqf:title>Create a list from the phrases from the paragraph</sqf:title>
                </sqf:description>
                <sqf:replace match="text()">
                    <xsl:value-of
                        select="ai:transform-content('Create a Dita unorderd list with an item from each of the following phrases', .)"
                        disable-output-escaping="yes"/>
                </sqf:replace>
            </sqf:fix>
        </sch:rule>
    </sch:pattern>
</sch:schema>
