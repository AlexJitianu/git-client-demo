<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt3"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:ns uri="http://www.oxygenxml.com/ai/function" prefix="ai"/>
    <sch:pattern>
        <sch:rule context="p">
            <sch:assert test="ai:verify-content('Is spelling and grammar correct?', .)" sqf:fix="rephrase">
                The spelling and grammar must be corrected.</sch:assert>
            <sqf:fix id="rephrase">
                <sqf:description>
                    <sqf:title>Correct spelling and grammar in the text</sqf:title>
                </sqf:description>
                <sqf:replace match="text()" select="ai:transform-content('Correct spelling and grammar in the text', .)"></sqf:replace>
            </sqf:fix>
        </sch:rule>
    </sch:pattern>
</sch:schema>