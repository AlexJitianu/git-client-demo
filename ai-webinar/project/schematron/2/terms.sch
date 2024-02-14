<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt3"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:ns uri="http://www.oxygenxml.com/ai/function" prefix="ai"/>
    <sch:pattern>
        <sch:rule context="p">
            <!--<sch:report test="ai:verify-content('Are the technical terms explained ambiguous?', .)"-->
            <sch:report test="contains(., 'WIFI')"
                sqf:fix="reformulateUser" role="warn"> The text uses technical terms that are not explained adequately.</sch:report>
            
            <sqf:fix id="reformulateUser">
                <sqf:description>
                    <sqf:title>Specify how to reformulate the phrase</sqf:title>
                </sqf:description>
                <sqf:user-entry name="userInput" default="'Reformulate phrase and replace the ambiguous terms with a more accurate one'">
                    <sqf:description>
                        <sqf:title>How to correct:</sqf:title>
                    </sqf:description>
                </sqf:user-entry>
                <sqf:replace match="text()" select="ai:transform-content($userInput, .)"/>
            </sqf:fix>
        </sch:rule>
    </sch:pattern>
</sch:schema>