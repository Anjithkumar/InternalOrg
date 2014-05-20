<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_Notification_on_License_Expiry</fullName>
        <description>Email Notification on License Expiry</description>
        <protected>false</protected>
        <recipients>
            <field>Relationship_ManagerEmail__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <field>Sales_Manger_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Personal_Email_Templates/Notification_on_License_Expiring_date</template>
    </alerts>
    <fieldUpdates>
        <fullName>Copying_Relationship_manager_email</fullName>
        <field>Relationship_ManagerEmail__c</field>
        <formula>Deal__r.Customer__r.Relationship_Manager__r.Email</formula>
        <name>Copying Relationship manager email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Copying_Sales_manager_email</fullName>
        <field>Sales_Manger_Email__c</field>
        <formula>Deal__r.Customer__r.Sales_Manager__r.Email</formula>
        <name>Copying Sales manager email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Email Notification to Deal Owner</fullName>
        <actions>
            <name>Copying_Relationship_manager_email</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Copying_Sales_manager_email</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Deal_Item__c.End_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Deal_Item__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Licenses</value>
        </criteriaItems>
        <criteriaItems>
            <field>Deal_Item__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Email Notification to Deal Owner prior to the expiring of the license</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Email_Notification_on_License_Expiry</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Deal_Item__c.End_Date__c</offsetFromField>
            <timeLength>-1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
