/** * Class Name : EverHourCallouts 
* Description : This class contains all the methods for callouts related to EverHour API
* * @author : Prasun Banerjee
* Modification Log =============================================================== 
Ver Date Author Modification --- ---- ------ -------------
* */ 




public class EverHourCallouts {
    
    /**Method Name : getDateRecords 
    * Description : This methods pulls all time record from Everhour
    * * @author : Prasun Banerjee
    * */   
    @future(callout=true)
    public static void getDateRecords() {
        String frm = String.valueof(date.today().addDays(-7).year()) + date.today().addDays(-7).month() + date.today().addDays(-7).day();
        String to = String.valueof(date.today().year()) + date.today().month() + date.today().day();
        String url = Ever_Hour__c.getInstance('endpoint').key__c;
        String key = Ever_Hour__c.getInstance('everhourkey').key__c;
        url = url+'/team/time?from=2018-01-01&to=2018-03-19';
        String res = EverHourAPIHelper.httpRequestGET(url,key);
        res = res.replaceAll('"date"','"datex"');
        res = res.replaceAll('"time"','"timex"');
        system.debug(res);
        List<testParser.cls> ep = (List<testParser.cls>) json.deserialize(res, List<testParser.cls>.class);
        system.debug(ep);
        Map<String,id> projectMap = new Map<String,id>();
        for(Projects__c p :[select id,project_id__c from Projects__c]){
            projectMap.put(p.Project_Id__c, p.Id);
        }
        Map<String,List<Time_Log__c>> tllst = new Map<String,List<Time_Log__c>>();
        Map<String,Project_Task__c> ptlst = new Map<String,Project_Task__c>(); 
        system.debug(ep.size());
        for(testParser.cls c : ep){
            Time_Log__c tl = new Time_Log__c();
            //tl.name = c.task.projects[0];
            tl.External_Project_ID__c = c.task.id;
            tl.Task_URL__c = c.task.url;
            tl.External_ID_Time_Log__c = String.Valueof(c.id);
            tl.Time_decimal__c  = c.timex/3600;
            
            system.debug(' Time : ' + c.timex/3600);
            
            tl.External_Task_Label__c  = c.task.name;
            tl.Time_Log_Comments__c = c.comment;
            
            system.debug('DueDate String : ' + c.datex.substring(0,10));
            List<String> dd = c.datex.substring(0,10).split('-');
            system.debug(c.task.Id);
            
            Date LogDate = date.newinstance(Integer.valueOf(dd[0]),Integer.valueOf(dd[1]),Integer.valueOf(dd[2]));
            system.debug('LogDate : ' + LogDate);
            tl.Time_Log_Date__c = LogDate;
            if(tllst.containskey(c.task.Id)){
                tllst.get(c.task.Id).add(tl);
            } else {
                List<Time_Log__c> tll = new List<Time_Log__c>();
                tll.add(tl);
                tllst.put(c.task.Id,tll);
            }
           // tllst.put(c.task.Id,tl);
            
            Project_Task__c pt = new Project_Task__c(Project__c=projectMap.get(c.task.projects[0]),Task_Title__c =c.task.name, Task_Id__c =c.task.Id);
            ptlst.put(c.task.Id,pt);
        }
        system.debug(ptlst.size());
        system.debug(tllst.size());
        upsert ptlst.values() Task_Id__c;
        List<Time_Log__c> tlls = new List<Time_Log__c>();
        for(String s : ptlst.keySet()){
            for(Time_Log__c t : tllst.get(s)){
            	t.Project_Task__c = ptlst.get(s).id;
        	}
            tlls.addAll(tllst.get(s));
            //tllst.get(s).Project_Task__c = ptlst.get(s).id;
        }
        
        upsert tlls External_ID_Time_Log__c;
        system.debug(tlls.size());
    }
    
    
    /**Method Name : getDateRecords 
    * Description : This methods pulls all project record from Everhour	
    * * @author : Prasun Banerjee
    * */   
    @future(callout=true)
    public static void getProjectRecords(){
        String url = Ever_Hour__c.getInstance('endpoint').key__c;
        String key = Ever_Hour__c.getInstance('everhourkey').key__c;
        url = url+'/projects?limit=100';
        String res = EverHourAPIHelper.httpRequestGET(url,key);
        system.debug(res);
        List<EverHourProjectParser> resp = EverHourProjectParser.parse(res);
        List<Projects__c> prlst = new List<Projects__c>();
        for(EverHourProjectParser ep : resp){
            Projects__c p = new Projects__c(Name = ep.name,Project_Id__c = ep.id,Workspace_Id__c=ep.workspaceId,Workspace_Name__c=ep.workspaceName);
            prlst.add(p);
        }
        insert prlst;
    }
    
    /**Method Name : getProjectTaskRecords 
    * Description : This methods pulls all project task record from Everhour
    * * @author : Prasun Banerjee
    * */   
   /* public static void getProjectTaskRecords(String project_id, String SFProjectId){
        String url = Ever_Hour__c.getInstance('endpoint').key__c;
        String key = Ever_Hour__c.getInstance('everhourkey').key__c;
        url = url+'/projects/'+project_id+'/tasks';
        String res = EverHourAPIHelper.httpRequestGET(url,key);
        system.debug(res);
        List<ProjectTaskParser> ptplst = (List<ProjectTaskParser>)json.deserialize(res, List<ProjectTaskParser>.class);
        system.debug(ptplst);
        if(SFProjectId != null){
            List<Project_Task__c> ptlst = new List<Project_Task__c>(); 
            for(ProjectTaskParser p : ptplst){
                Project_Task__c pt = new Project_Task__c(Project__c=SFProjectId,Task_Title__c =p.name, Task_Id__c =p.Id);
                ptlst.add(pt);
            }
            upsert ptlst Task_Id__c;
        }
    }*/
}