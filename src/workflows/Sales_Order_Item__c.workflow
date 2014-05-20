<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Field_Update_on_the_Quatity</fullName>
        <field>Quantity__c</field>
        <formula>1</formula>
        <name>Field Update on the Quatity</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Flip_Milestone_Status_to_Complete</fullName>
        <field>Status__c</field>
        <literalValue>Completed</literalValue>
        <name>Flip Milestone Status to Complete</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Flip_Milestone_Status_to_Pending</fullName>
        <description>The field update is changing status to Pending if Planned date is assigned but there is no Actual date</description>
        <field>Status__c</field>
        <literalValue>Pending</literalValue>
        <name>Flip Milestone Status to Pending</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Flip_Status_to_Closed_Invoiced</fullName>
        <field>Status__c</field>
        <literalValue>Closed - Invoiced</literalValue>
        <name>Flip Status to Closed-Invoiced</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Flip_Status_to_Partially_Invoiced</fullName>
        <field>Status__c</field>
        <literalValue>Partially Invoiced</literalValue>
        <name>Flip Status to Partially Invoiced</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Change Status to %27Completed%27</fullName>
        <active>true</active>
        <description>Change Sales order item  &apos;status&apos; to completed when actual date and planned date are filled</description>
        <formula>AND(   NOT( ISBLANK( Actual_Date__c))    , NOT( ISBLANK(Planned_Date__c  )),  ISPICKVAL(Sales_Order__r.Billing_Type__c ,&quot;FP&quot; ) ,  NOT( ISPICKVAL( Sales_Order__r.Status__c , &quot;Closed - Invoiced&quot;)  ))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Change Status to Closed-Invoiced</fullName>
        <actions>
            <name>Flip_Status_to_Closed_Invoiced</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND( OR( Actual_Milestone_Revenue__c  &lt;&gt; 0, Actual_Milestone_Revenue__c  &lt;&gt; null) , Actual_Milestone_Revenue__c  &gt;=  Planned_Milestone_Revenue__c ,     NOT( ISPICKVAL(Sales_Order__r.Status__c, &apos;Completed&apos;) )  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Change Status to Completed</fullName>
        <actions>
            <name>Flip_Milestone_Status_to_Complete</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND( Planned_Date__c  &lt;&gt; null, Actual_Date__c   &lt;&gt;  null, NOT( ISPICKVAL(Sales_Order__r.Status__c, &apos;Completed&apos;) ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Change Status to Partially Invoiced</fullName>
        <actions>
            <name>Flip_Status_to_Partially_Invoiced</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND( OR( Actual_Milestone_Revenue__c  &lt;&gt; null, Actual_Milestone_Revenue__c  &lt;&gt; 0) , Actual_Milestone_Revenue__c  &lt;  Planned_Milestone_Revenue__c, NOT( ISPICKVAL(Sales_Order__r.Status__c, &apos;Completed&apos;) ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Field Update on the Quatity</fullName>
        <actions>
            <name>Field_Update_on_the_Quatity</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Quantity should be equal to 1 for the project FP</description>
        <formula>ISPICKVAL( Sales_Order__r.Billing_Type__c, &apos;FP&apos;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Planned Date Populated but No Actual Date</fullName>
        <actions>
            <name>Flip_Milestone_Status_to_Pending</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Sales_Order_Item__c.Planned_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Sales_Order_Item__c.Actual_Date__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
