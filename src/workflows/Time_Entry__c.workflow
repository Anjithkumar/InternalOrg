<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_Alert_to_user</fullName>
        <description>Email Alert to user</description>
        <protected>false</protected>
        <recipients>
            <field>Project_Lead_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Personal_Email_Templates/Time_Entry_Submitted</template>
    </alerts>
    <fieldUpdates>
        <fullName>Field_Update_on_Lead_email_field</fullName>
        <field>Project_Lead_Email__c</field>
        <formula>Project__r.Project_Lead__r.Email</formula>
        <name>Field Update on Lead email field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Flip_Record_Type_to_R_O</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Read_Only</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Flip Record Type to R/O</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Flip_Record_Type_to_R_W</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Read_Write</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Flip Record Type to R/W</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Change Record Type to R%2FO</fullName>
        <actions>
            <name>Flip_Record_Type_to_R_O</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Time_Entry__c.Status__c</field>
            <operation>equals</operation>
            <value>Submitted</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Change Record Type to R%2FW</fullName>
        <actions>
            <name>Flip_Record_Type_to_R_W</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Time_Entry__c.RecordTypeId</field>
            <operation>notEqual</operation>
            <value>Read/Write</value>
        </criteriaItems>
        <criteriaItems>
            <field>Time_Entry__c.Status__c</field>
            <operation>equals</operation>
            <value>Rejected</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Copy email address of project lead</fullName>
        <actions>
            <name>Field_Update_on_Lead_email_field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Project__c.Project_Lead__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Time Trigger on Time Enteries</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Time_Entry__c.Status__c</field>
            <operation>equals</operation>
            <value>Submitted</value>
        </criteriaItems>
        <description>Email notification will send to related user</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Email_Alert_to_user</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Time_Entry__c.Submission_Date__c</offsetFromField>
            <timeLength>7</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
