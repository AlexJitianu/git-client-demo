<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt3"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:ns uri="http://www.oxygenxml.com/ai/function" prefix="ai"/>
    <sch:pattern>
        <sch:rule context="p">
            <sch:assert test="ai:verify-content('Is the text clear and concise, with simple language used where possible?', .)"
                sqf:fix="rephrase" role="warn"> The text is not clear and concise.</sch:assert>
            <sqf:fix id="rephrase">
                <sqf:description>
                    <sqf:title>Reformulate the text to be clear and concise.</sqf:title>
                </sqf:description>
                <sqf:replace match="text()" select="ai:transform-content('Reformulate the text to be clear and concise, with simple language used where possible', .)"></sqf:replace>
            </sqf:fix>
        </sch:rule>
    </sch:pattern>
</sch:schema>