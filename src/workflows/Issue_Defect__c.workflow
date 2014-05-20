<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_Notification_to_Defect_assigned_perosn</fullName>
        <description>Email Notification to Defect assigned  perosn</description>
        <protected>false</protected>
        <recipients>
            <field>Assigned_To__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Personal_Email_Templates/Email_Notification_on_Defie</template>
    </alerts>
    <rules>
        <fullName>Email Notification to Defect Assigned Person</fullName>
        <actions>
            <name>Email_Notification_to_Defect_assigned_perosn</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <formula>AND(NOT(ISBLANK(Assigned_To__c)), OR(ISNEW(),ISCHANGED(Assigned_To__c )))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
