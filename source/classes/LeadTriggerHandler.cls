public class LeadTriggerHandler {
    public static boolean alreadyExecuted = false;
    public static void leadSourceUpdate(List<Lead> leadList){
        for(Lead l : leadList){
            if(string.isBlank(l.LeadSource)){
                l.LeadSource = 'Other';
            }
        }
    }
    public static void industryValidation(List<Lead> leadList){
        for(Lead l : leadList){
            if(string.isBlank(l.Industry)){
                l.Industry.addError('The inductry field can\'t be blank');
            }
        }
    }
    public static void leadStatusValidation(List<Lead> leadList,Map<Id,Lead> oldLeadMap){
        for(Lead l : leadList){
            if((l.Status == 'Closed - Converted' || l.Status == 'Closed - Not Converted') && oldLeadMap.get(l.Id).Status == 'Open - Not Contacted'){
                l.Status.addError('You can\'t close an open lead record');
            }
        }
    }
    public static void createTask(List<Lead> leadList){
        List<Task> neaTaskList = new List<Task>();
        for(Lead l : leadList){
            Task tsk = new Task();
            tsk.Subject = 'Follow up on lead status';
            tsk.WhoId = l.Id;
            neaTaskList.add(tsk);
        }
        insert neaTaskList; 
        
        lead anotherLead = new Lead(LastName = 'Test',Status = 'Open - Not Contacted',Company = 'Test',Industry = 'Banking');
        insert anotherLead;
        
    }
    
}