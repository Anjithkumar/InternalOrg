<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Acknowledgement_Email_to_Customer</fullName>
        <description>Acknowledgement Email to Customer</description>
        <protected>false</protected>
        <recipients>
            <field>Supplied_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Tickets_Email_Template/Email_to_Customer_on_Ticket_Creation</template>
    </alerts>
    <alerts>
        <fullName>EmailToSuppliedEmailOnTicketStatusClosed</fullName>
        <ccEmails>chincholisachin@gmail.com</ccEmails>
        <description>EmailToSuppliedEmailOnTicketStatusClosed</description>
        <protected>false</protected>
        <recipients>
            <field>Supplied_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Tickets_Email_Template/EmailToSuppliedEmailOnTicketStatusClosed</template>
    </alerts>
    <alerts>
        <fullName>EmailToUserOnTicketAssignment</fullName>
        <ccEmails>chincholisachin@gmail.com</ccEmails>
        <description>EmailToUserOnTicketAssignment</description>
        <protected>false</protected>
        <recipients>
            <field>Assigned_User__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Tickets_Email_Template/EmailToUserOnTicketAssignment</template>
    </alerts>
    <alerts>
        <fullName>Email_To_Assigned_User_One_Day_Before_Due_Date</fullName>
        <description>Email To Assigned User One Day Before Due Date</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <field>Assigned_User__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Tickets_Email_Template/Email_To_Queue_One_Day_Before_Due_Date</template>
    </alerts>
    <alerts>
        <fullName>Email_To_Queue_One_Day_Before_Due_Date</fullName>
        <ccEmails>chincholisachin@extentor.com</ccEmails>
        <description>Email To Queue One Day Before Due Date</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Tickets_Email_Template/Email_To_Queue_One_Day_Before_Due_Date</template>
    </alerts>
    <alerts>
        <fullName>Email_notification_to_queue_regarding_the_user_assignment</fullName>
        <description>Email notification  to queue regarding the user assignment</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Tickets_Email_Template/Ticket_has_not_assigned_to_any_one</template>
    </alerts>
    <alerts>
        <fullName>Email_to_Customer_On_Ticket_Creation</fullName>
        <description>Email to Customer On Ticket Creation</description>
        <protected>false</protected>
        <recipients>
            <field>Supplied_Email__c</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Tickets_Email_Template/Email_to_Customer_on_Ticket_Creation</template>
    </alerts>
    <alerts>
        <fullName>Email_to_Queue_on_Ticket_Creation</fullName>
        <description>Email to Queue on Ticket Creation</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Tickets_Email_Template/Email_to_Queue_on_Ticket_Creation</template>
    </alerts>
    <alerts>
        <fullName>EscalationEmailNotification</fullName>
        <description>Escalation Email Notification</description>
        <protected>false</protected>
        <recipients>
            <field>Assigned_User__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Tickets_Email_Template/Escalation_mail</template>
    </alerts>
    <alerts>
        <fullName>Escalation_Email_Notification</fullName>
        <description>Escalation Email Notification</description>
        <protected>false</protected>
        <recipients>
            <field>Assigned_User__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>Tickets_Email_Template/Escalation_mail</template>
    </alerts>
    <fieldUpdates>
        <fullName>Due_Date_Update_on_Priority</fullName>
        <field>Due_Date__c</field>
        <formula>IF(ISPICKVAL(Priority__c , &apos;Critical&apos;),CreatedDate +1,IF(ISPICKVAL(Priority__c ,&apos;Serious&apos;) , CreatedDate +2,IF(ISPICKVAL(Priority__c , &apos;Important&apos;), CreatedDate+3,IF(ISPICKVAL(Priority__c , &apos;Low&apos;),CreatedDate+4,CreatedDate+5))))</formula>
        <name>Due Date Update on Priority</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Due_Date_Updation_on_Priority</fullName>
        <description>Due Date Updation on Priority</description>
        <field>Due_Date__c</field>
        <formula>IF(ISPICKVAL(Priority__c , &apos;Critical&apos;),CreatedDate +1,IF(ISPICKVAL(Priority__c ,&apos;Serious&apos;) , CreatedDate +2,IF(ISPICKVAL(Priority__c , &apos;Important&apos;), CreatedDate+3,IF(ISPICKVAL(Priority__c , &apos;Low&apos;),CreatedDate+4,CreatedDate+5))))</formula>
        <name>Due Date Updation on Priority</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Field_Update_status</fullName>
        <field>Status__c</field>
        <literalValue>Assigned</literalValue>
        <name>Field Update status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_Changed_To_escalated</fullName>
        <field>Status__c</field>
        <literalValue>Escalated</literalValue>
        <name>Status Changed To escalated</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_Changed_to_Escalate</fullName>
        <field>Status__c</field>
        <literalValue>Escalated</literalValue>
        <name>Status Changed to &quot;Escalate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Status_To_Assigned</fullName>
        <field>Status__c</field>
        <literalValue>Assigned</literalValue>
        <name>Status To Assigned</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Change Record Type To Child Ticket</fullName>
        <active>true</active>
        <description>Changes Record type to Child Ticket,Once Parent ticket is assigned</description>
        <formula>if( Parent_Ticket__c!=null,true,false)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Email To Queue One Day Before Due Date</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Ticket__c.Status__c</field>
            <operation>notEqual</operation>
            <value>Closed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Ticket__c.Assigned_User__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Email To Queue One Day Before Due Date</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Email_To_Assigned_User_One_Day_Before_Due_Date</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Ticket__c.Due_Date__c</offsetFromField>
            <timeLength>-1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Email To Supplied Email On Ticket Status Closed</fullName>
        <actions>
            <name>EmailToSuppliedEmailOnTicketStatusClosed</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Ticket__c.Status__c</field>
            <operation>equals</operation>
            <value>Closed</value>
        </criteriaItems>
        <description>Email To Supplied Email On Ticket Status Closed</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Email To User On Ticket Assignment</fullName>
        <actions>
            <name>EmailToUserOnTicketAssignment</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Ticket__c.Assigned_User__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Email To User On Ticket Assignment and Status Update to Assigned.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Queue Assignment%2FEmail to Customer%2FDue Date Updation</fullName>
        <actions>
            <name>Acknowledgement_Email_to_Customer</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Email_to_Queue_on_Ticket_Creation</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Due_Date_Updation_on_Priority</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Ticket__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Queue Assignment/Email to Customer/Due Date Updation</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Ticket escalation</fullName>
        <active>true</active>
        <booleanFilter>1 AND (2 OR 3 OR 4)</booleanFilter>
        <criteriaItems>
            <field>Ticket__c.Due_Date__c</field>
            <operation>lessThan</operation>
            <value>TODAY</value>
        </criteriaItems>
        <criteriaItems>
            <field>Ticket__c.Status__c</field>
            <operation>notEqual</operation>
            <value>Resolved</value>
        </criteriaItems>
        <criteriaItems>
            <field>Ticket__c.Status__c</field>
            <operation>notEqual</operation>
            <value>Complete</value>
        </criteriaItems>
        <criteriaItems>
            <field>Ticket__c.Status__c</field>
            <operation>notEqual</operation>
            <value>Closed</value>
        </criteriaItems>
        <description>When due date exceeds , ticket will escalate</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Escalation_Email_Notification</name>
                <type>Alert</type>
            </actions>
            <actions>
                <name>Status_Changed_To_escalated</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Ticket__c.Due_Date__c</offsetFromField>
            <timeLength>1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Ticket has not Assigned to user</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Ticket__c.Status__c</field>
            <operation>notEqual</operation>
            <value>Assigned</value>
        </criteriaItems>
        <description>Ticket has not Assigned to user</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Email_notification_to_queue_regarding_the_user_assignment</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Ticket__c.CreatedDate</offsetFromField>
            <timeLength>2</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
