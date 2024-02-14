<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt3"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:ns uri="http://www.oxygenxml.com/ai/function" prefix="ai"/>
    <sch:pattern>
        <sch:rule context="p[@id='openai']">
            <sch:assert test="ai:verify-content('Does the text answers exactly to the following question: What is OpenAI?', .)" sqf:fix="rephrase" role="warn">
                The test does not answer to the question "What is OpenAPI?" </sch:assert>
            <sqf:fix id="rephrase">
                <sqf:description>
                    <sqf:title>Correct the text to answer to the question: What is OpenAI?</sqf:title>
                </sqf:description>
                <sqf:replace match="text()" select="ai:transform-content('Reformulate the text to answer to the question: What is OpenAI?', .)"/>
            </sqf:fix>
        </sch:rule>
    </sch:pattern>
</sch:schema>