<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>A_week_more_for_project_to_end</fullName>
        <description>A week more for project to end</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>lokendra.chouhan@extentor.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Personal_Email_Templates/Project_End_Date</template>
    </alerts>
    <alerts>
        <fullName>Notification_on_Actual_Effort</fullName>
        <ccEmails>chandan.miskin@extentor.com</ccEmails>
        <ccEmails>praveen.louis@extentor.com</ccEmails>
        <ccEmails>sreekanth@extentor.com</ccEmails>
        <description>Notification on Actual Effort</description>
        <protected>false</protected>
        <recipients>
            <field>Project_Lead__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Personal_Email_Templates/Notification_for_Actual_Effort</template>
    </alerts>
    <alerts>
        <fullName>Project_completed_closed</fullName>
        <description>Project completed or closed</description>
        <protected>false</protected>
        <recipients>
            <recipient>lokendra.chouhan@extentor.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Personal_Email_Templates/Project_Completion_Reminder</template>
    </alerts>
    <fieldUpdates>
        <fullName>Flip_Project_Status_to_Closed</fullName>
        <field>Status__c</field>
        <literalValue>Closed</literalValue>
        <name>Flip Project Status to Closed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Flip_Project_Status_to_Completed</fullName>
        <field>Status__c</field>
        <literalValue>Completed</literalValue>
        <name>Flip Project Status to Completed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Flip_Project_Status_to_In_Progress</fullName>
        <field>Status__c</field>
        <literalValue>In-Progress</literalValue>
        <name>Flip Project Status to In-Progress</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Flip_Project_Status_to_Open</fullName>
        <field>Status__c</field>
        <literalValue>Open</literalValue>
        <name>Flip Project Status to Open</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_record_type_to_Read_Only</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Read_Only</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Update record type to Read-Only</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Change Project Status to Completed</fullName>
        <actions>
            <name>Flip_Project_Status_to_Completed</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND ( NOT( ISBLANK(Actual_End_Date__c  ) ) ,NOT( ISBLANK(Actual_Start_Date__c  ) ) , TODAY()  &gt; Actual_End_Date__c  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Change Project Status to In-Progress</fullName>
        <actions>
            <name>Flip_Project_Status_to_In_Progress</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND (  NOT(ISBLANK( Actual_Start_Date__c ) )  , ISBLANK( Actual_End_Date__c ) , TODAY()  &gt;  Actual_Start_Date__c , Project_Allocation_Count__c &gt;0)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Change Project Status to Open</fullName>
        <actions>
            <name>Flip_Project_Status_to_Open</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISBLANK( Actual_Start_Date__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Email Notification  to Project Lead</fullName>
        <actions>
            <name>Notification_on_Actual_Effort</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Email Notification  to Project lead regarding the actual effort</description>
        <formula>ActualEffort__c   &gt;= 0.8 *  Planned_Effort__c</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Project Completion</fullName>
        <actions>
            <name>Project_completed_closed</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>Project__c.Status__c</field>
            <operation>equals</operation>
            <value>Completed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Project__c.Status__c</field>
            <operation>equals</operation>
            <value>Closed</value>
        </criteriaItems>
        <description>Project completion</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Project End Date a week</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Project__c.Planned_End_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>A_week_more_for_project_to_end</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Project__c.Planned_End_Date__c</offsetFromField>
            <timeLength>-7</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Update Project once project is created</fullName>
        <actions>
            <name>Update_record_type_to_Read_Only</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Project__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Once project is created,
* Project Type
* Project Category
* Billing Type
* Billing Cycle
fields should be read only .</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Updating the project category</fullName>
        <active>true</active>
        <description>Updating the project category in salesorder</description>
        <formula>Sales_Order__c  &lt;&gt; null</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
