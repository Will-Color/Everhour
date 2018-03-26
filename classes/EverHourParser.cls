/** * Class Name : EverHourParser 
* Description : This class contains the parser class details related to EverHour timerecord
* * @author : Prasun Banerjee
* Modification Log =============================================================== 
Ver Date Author Modification --- ---- ------ -------------
* */ 

public class EverHourParser{
    public List<cls> clslst;
    public class cls{
        public Integer user;    //51515
        public Integer id;  //3562633
        public String datex; //2018-03-11
        public Integer timex;    //36000
        public cls_task task;   
        public boolean isLocked;
        public String timecomment;
    }
    
    class cls_task {
        public List<String> projects;
        public cls_estimate estimate;
        public String id;   //as:588657564876573
        public String type; //task
        public String name; //Task 1 - Understand API documentation
        public String url;  //https://app.asana.com/0/587623789378408/588657564876573/f
        public String status;   //open
        public cls_labels[] labels;
        public String createdAt;    //2018-03-11 20:53:16
        public String dueAt;    //2018-03-13 00:00:00
    }
    
    class cls_estimate {
        public String type; //overall
        public Integer total;   //36000
    }
    class cls_labels {
    }
}