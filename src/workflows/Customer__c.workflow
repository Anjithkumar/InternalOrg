<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Copy_Billing_City_to_Shipping_City</fullName>
        <field>Shipping_City__c</field>
        <formula>Billing_City__c</formula>
        <name>Copy Billing City to Shipping City</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Billing_Country_to_Shipping_Country</fullName>
        <field>Shipping_Country__c</field>
        <formula>Billing_Country__c</formula>
        <name>Copy Billing Country to Shipping Country</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Billing_Street_to_Shipping_Street</fullName>
        <field>Shipping_Street__c</field>
        <formula>Billing_Street__c</formula>
        <name>Copy Billing Street to Shipping Street</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Billing_Zip_to_Shipping_Zip</fullName>
        <field>Shipping_Zip_Postal_Code__c</field>
        <formula>Billing_Zip_Postal_Code__c</formula>
        <name>Copy Billing zip to Shipping Zip</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copy_Billing_state_to_Shipping_State</fullName>
        <field>Shipping_State_Province__c</field>
        <formula>Billing_State_Province__c</formula>
        <name>Copy Billing state to Shipping State</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Copy Billing Details To Shipping Details</fullName>
        <actions>
            <name>Copy_Billing_City_to_Shipping_City</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_Billing_Country_to_Shipping_Country</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_Billing_Street_to_Shipping_Street</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_Billing_Zip_to_Shipping_Zip</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copy_Billing_state_to_Shipping_State</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Customer__c.Billing_Address_To_Shipping_Address__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
