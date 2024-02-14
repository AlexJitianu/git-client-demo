<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt3"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:ns uri="http://www.oxygenxml.com/ai/function" prefix="ai"/>
    <sch:pattern>
        <sch:rule context="p">
            <sch:let name="isConsistent" value="ai:verify-content('Is the text easy to read and understand?', .)"/>
            <sch:assert test="$isConsistent" sqf:fix="rephrase" role="warn">
                The text in not easy to read and understand</sch:assert>
            <sqf:fix id="rephrase">
                <sqf:description>
                    <sqf:title>Correct the consistency of the text</sqf:title>
                </sqf:description>
                <sqf:replace match="text()" select="ai:transform-content('Correct the text to be easy to read and understand', .)"></sqf:replace>
            </sqf:fix>
        </sch:rule>
    </sch:pattern>
</sch:schema>