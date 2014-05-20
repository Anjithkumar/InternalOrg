<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Deal_has_been_closed</fullName>
        <description>Deal has been closed</description>
        <protected>false</protected>
        <recipients>
            <recipient>lokendra.chouhan@extentor.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>praveen.louis@extentor.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>sreekanth@extentor.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Personal_Email_Templates/Deal_is_closed_won</template>
    </alerts>
    <alerts>
        <fullName>Email_Notification</fullName>
        <description>Email Notification</description>
        <protected>false</protected>
        <recipients>
            <field>CSM_Email__c</field>
            <type>email</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Personal_Email_Templates/Email_Notification_to_Deal_Owner</template>
    </alerts>
    <fieldUpdates>
        <fullName>FieldUpdate</fullName>
        <field>CSM_Email__c</field>
        <formula>Customer__r.Relationship_Manager__r.Email</formula>
        <name>FieldUpdate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Client_Renewable</fullName>
        <field>Client_Renewal__c</field>
        <literalValue>1</literalValue>
        <name>Update Client Renewable</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Deal is closed won</fullName>
        <actions>
            <name>Deal_has_been_closed</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Deal__c.Stage__c</field>
            <operation>equals</operation>
            <value>Closed Won</value>
        </criteriaItems>
        <description>When a deal is closed a notification is been sent</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Email Notification to Deal Owner and CSM</fullName>
        <actions>
            <name>Email_Notification</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Deal__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Deal__c.Client_Renewal__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Deal__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Licenses</value>
        </criteriaItems>
        <criteriaItems>
            <field>Deal__c.Email_Notification__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>FieldUpdatepdate on Client Renewable</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Deal__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Deal__c.RecordTypeId</field>
            <operation>equals</operation>
            <value>Licenses</value>
        </criteriaItems>
        <criteriaItems>
            <field>Deal__c.Client_Renewal__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Update_Client_Renewable</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Deal__c.Deal_End_Date__c</offsetFromField>
            <timeLength>-120</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>To get CSM Mail</fullName>
        <actions>
            <name>FieldUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Deal__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>