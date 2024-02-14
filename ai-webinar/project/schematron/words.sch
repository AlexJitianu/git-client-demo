<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt3"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <sch:ns uri="http://www.oxygenxml.com/ai/function" prefix="ai"/>

    <sch:pattern>
        <sch:rule context="shortdesc">
            <sch:report test="count(tokenize(.,'\s+')) > 50" sqf:fix="rephrase" role="warn">
                The description must contain less than 50 words.</sch:report>
            <sqf:fix id="rephrase">
                <sqf:description>
                    <sqf:title>Reformulate phrase to contain less than 50 words</sqf:title>
                </sqf:description>
                <sqf:replace match="text()" select="ai:transform-content('Reformulate phrase to contain less than 50 words', .)"/>
            </sqf:fix>
        </sch:rule>
    </sch:pattern>
</sch:schema>
