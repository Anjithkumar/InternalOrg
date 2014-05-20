<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Record_Type_Update</fullName>
        <field>RecordTypeId</field>
        <lookupValue>License</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Record Type Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_recordtype_field</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Services_T_M</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Update recordtype  field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_recordtype_id_if_Billing_type_FP</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Service_Type</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Update recordtype  id if Billing type=FP</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Changing Record Type</fullName>
        <actions>
            <name>Record_Type_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Sales_Order__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Sales_Order__c.Deal_Type__c</field>
            <operation>equals</operation>
            <value>Licenses</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update recordtype  id if Billing type%3DFP</fullName>
        <actions>
            <name>Update_recordtype_id_if_Billing_type_FP</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1</booleanFilter>
        <criteriaItems>
            <field>Sales_Order__c.Billing_Type__c</field>
            <operation>equals</operation>
            <value>FP</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update recordtype  id if Billing type%3DT%26M</fullName>
        <actions>
            <name>Update_recordtype_field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR  2</booleanFilter>
        <criteriaItems>
            <field>Sales_Order__c.Billing_Type__c</field>
            <operation>equals</operation>
            <value>T&amp;M</value>
        </criteriaItems>
        <criteriaItems>
            <field>Sales_Order__c.Billing_Type__c</field>
            <operation>equals</operation>
            <value>CTM</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
