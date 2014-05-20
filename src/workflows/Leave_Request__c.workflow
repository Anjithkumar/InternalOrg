<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Email_Notification_Approval</fullName>
        <description>Email Notification : Approval</description>
        <protected>false</protected>
        <recipients>
            <field>Employee__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Project_Lead__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Personal_Email_Templates/Leave_Approval_Request</template>
    </alerts>
    <alerts>
        <fullName>Email_Notification_Approved</fullName>
        <description>Email Notification : Approved</description>
        <protected>false</protected>
        <recipients>
            <field>Employee__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Personal_Email_Templates/Leave_Approval_Request</template>
    </alerts>
    <alerts>
        <fullName>Email_Notification_Leave_cancelled</fullName>
        <description>Email Notification :Leave cancelled</description>
        <protected>false</protected>
        <recipients>
            <field>Employee__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Project_Lead__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Personal_Email_Templates/Leave_Cancelled_Request</template>
    </alerts>
    <alerts>
        <fullName>Email_Notification_Rejected</fullName>
        <description>Email Notification : Rejected</description>
        <protected>false</protected>
        <recipients>
            <field>Employee__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Project_Lead__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Personal_Email_Templates/Leave_Cancelled_Request</template>
    </alerts>
    <alerts>
        <fullName>Email_Notification_applied</fullName>
        <description>Email Notification applied</description>
        <protected>false</protected>
        <recipients>
            <field>Employee__c</field>
            <type>userLookup</type>
        </recipients>
        <recipients>
            <field>Project_Lead__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Personal_Email_Templates/Leave_Applied_Request</template>
    </alerts>
    <alerts>
        <fullName>Initial_submission_Email_template</fullName>
        <description>Initial submission--Email template</description>
        <protected>false</protected>
        <recipients>
            <field>Employee__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Personal_Email_Templates/Leave_Applied_Request</template>
    </alerts>
    <fieldUpdates>
        <fullName>Field_Update_On_Approving_Leave</fullName>
        <description>Leave status changes from &apos;Applied&apos; to &apos;Approved&apos;</description>
        <field>Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Field Update : On Approving Leave</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Field_to_Update_in_Approval</fullName>
        <field>Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Field to Update in Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Field_to_Update_in_Final_Approval</fullName>
        <field>Status__c</field>
        <literalValue>Approved</literalValue>
        <name>Field to Update in Final Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Field_to_Update_in_Final_Rejection</fullName>
        <field>Status__c</field>
        <literalValue>Cancelled</literalValue>
        <name>Field to Update in Final Rejection</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Field_to_Update_in_Rejection</fullName>
        <field>Status__c</field>
        <literalValue>Cancelled</literalValue>
        <name>Field to Update in Rejection</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Field_to_Update_in_Submission</fullName>
        <description>submitted for approval</description>
        <field>Status__c</field>
        <literalValue>Applied</literalValue>
        <name>Field to Update in Submission</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Field_to_update_in_Recall</fullName>
        <field>Status__c</field>
        <literalValue>Cancelled</literalValue>
        <name>Field to update in Recall</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Field_update_Total_leaves_from_user</fullName>
        <field>User_Total_Leaves__c</field>
        <formula>$User.Total_Leave__c</formula>
        <name>Field update:Total leaves from user</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Override_validation_field</fullName>
        <field>Override_Validation__c</field>
        <literalValue>0</literalValue>
        <name>Update Override validation field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>After updating leave record</fullName>
        <active>false</active>
        <formula>AND(AND(ISPICKVAL( Status__c , &apos;Applied&apos;),OR( PRIORVALUE( Start_Date__c) &lt;&gt;Start_Date__c  ,  PRIORVALUE(  End_Date__c) &lt;&gt;End_Date__c )  ), Optional_Holiday__c =TRUE)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Email Notification %3ALeaves Cancelled</fullName>
        <actions>
            <name>Email_Notification_Leave_cancelled</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Leave_Request__c.Status__c</field>
            <operation>equals</operation>
            <value>Cancelled</value>
        </criteriaItems>
        <criteriaItems>
            <field>Leave_Request__c.Override_Validation__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>Leaves credited when leave status is Cancelled</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Email Notification%3A Leave Applied</fullName>
        <actions>
            <name>Email_Notification_applied</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <description>Email Notification to the employee when leave approved.</description>
        <formula>AND(AND(ISPICKVAL( Status__c , &apos;Applied&apos;),true )) &amp;&amp;  (Override_Validation__c  = False)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Email Notification%3A Leaves Approval</fullName>
        <actions>
            <name>Email_Notification_Approval</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Leave_Request__c.Status__c</field>
            <operation>equals</operation>
            <value>Approved</value>
        </criteriaItems>
        <criteriaItems>
            <field>Leave_Request__c.Override_Validation__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>Email Notification to the employee when leave approved.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>IF Override validation field %3D%3DTrue</fullName>
        <actions>
            <name>Update_Override_validation_field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Leave_Request__c.Override_Validation__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
