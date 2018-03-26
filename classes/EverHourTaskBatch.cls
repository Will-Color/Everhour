global class EverHourTaskBatch implements Database.Batchable<sObject>,Database.AllowsCallouts,schedulable{

   global final String Query;

   global EverHourTaskBatch(){
        query = 'select id,Project_Id__c from Projects__c limit 1';
   }

   global Database.QueryLocator start(Database.BatchableContext BC){
      return Database.getQueryLocator(query);
   }

   global void execute(Database.BatchableContext BC, List<Projects__c> scope){
       for(Projects__c p : scope){
         EverHourCallouts.getProjectTaskRecords(p.Project_Id__c,p.id);
       }
   }

   global void finish(Database.BatchableContext BC){
   }
   
   global void execute(SchedulableContext sc){
       Database.executeBatch(new EverHourTaskBatch(),1);
   }
}