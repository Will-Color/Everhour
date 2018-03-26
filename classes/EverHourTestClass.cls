@isTest
public class EverHourTestClass {
    public static testmethod void test0(){
        Ever_Hour__c eh1 = new Ever_Hour__c(name='endpoint', key__c ='https://api.everhour.com');
        Ever_Hour__c eh2 = new Ever_Hour__c(name='everhourkey', key__c ='test');
        insert eh1;
        insert eh2;
        test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
       // EverHourCallouts.getProjectRecords();
       // EverHourCallouts.getDateRecords();
        String sch = '0 0 23 * * ?';
        //system.schedule('Test check', sch, new GetDataRecordSchedular());
        system.schedule('Test check1', sch, new getProjectRecordsSchedular());
        test.stopTest();
    }
    
    public static testmethod void test1(){
        Ever_Hour__c eh1 = new Ever_Hour__c(name='endpoint', key__c ='https://api.everhour.com');
        Ever_Hour__c eh2 = new Ever_Hour__c(name='everhourkey', key__c ='test');
        insert eh1;
        insert eh2;
        String s = '[{"canSyncTasks":true,"users":[51515],"id":"as:587623789378408","name":"Test Project","createdAt":"2018-03-09","workspaceId":"as:587623752703430","workspaceName":"Personal","foreign":false,"favorite":false,"hasWebhook":false,"status":"open"}]';
        List<EverHourProjectParser> resp = EverHourProjectParser.parse(s);
        List<Projects__c> prlst = new List<Projects__c>();
        for(EverHourProjectParser ep : resp){
            Projects__c p = new Projects__c(Name = ep.name,Project_Id__c = ep.id,Workspace_Id__c=ep.workspaceId,Workspace_Name__c=ep.workspaceName);
            prlst.add(p);
        }
        insert prlst;
        test.startTest();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        //EverHourCallouts.getDateRecords();
        String sch = '0 0 23 * * ?';
        system.schedule('Test check', sch, new GetDataRecordSchedular());
        test.stopTest();
        
        /*String sch = '0 0 23 * * ?';
        system.schedule('Test check', sch, new GetDataRecordSchedular());
        system.schedule('Test check1', sch, new getProjectRecordsSchedular());*/
    }
}