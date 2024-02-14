<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt3"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:ns uri="http://www.oxygenxml.com/ai/function" prefix="ai"/>
    <sch:pattern>
        <sch:rule context="shortdesc">
            <sch:assert test="ai:verify-content('Is active voice used?', .)" sqf:fix="rephrase" role="warn">
                In the description we should use active voice.</sch:assert>
            <sqf:fix id="rephrase">
                <sqf:description>
                    <sqf:title>Reformulate the text to use active voice</sqf:title>
                </sqf:description>
                <sqf:replace match="text()" select="ai:transform-content('Reformulate to use active voice', .)"></sqf:replace>
            </sqf:fix>
        </sch:rule>
    </sch:pattern>
</sch:schema>