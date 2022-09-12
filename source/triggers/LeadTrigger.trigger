trigger LeadTrigger on Lead (before insert,before update,after insert,after update,after delete,after undelete) {
    
    if(trigger.isBefore && trigger.isInsert){
        LeadTriggerHandler.leadSourceUpdate(trigger.new);
        LeadTriggerHandler.industryValidation(trigger.new);
    }else if(trigger.isBefore && trigger.isUpdate){
        LeadTriggerHandler.leadSourceUpdate(trigger.new);
        LeadTriggerHandler.leadStatusValidation(trigger.new,trigger.oldMap);
    }else if(trigger.isBefore && trigger.isDelete){
        
    }else if(trigger.isAfter && trigger.isInsert){
        if(LeadTriggerHandler.alreadyExecuted == false){
            LeadTriggerHandler.alreadyExecuted = true;
            LeadTriggerHandler.createTask(trigger.new);
        }
        
    }
}