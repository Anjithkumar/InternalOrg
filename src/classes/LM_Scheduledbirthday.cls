global class LM_Scheduledbirthday implements Schedulable
{
global void execute(SchedulableContext sc)
{
LM_birthdayremainder b = new LM_birthdayremainder();
database.executebatch(b);
}
}