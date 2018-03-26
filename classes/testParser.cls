public class testParser {
    public list<cls> cls;
    public class cls{
        public Integer user;    //51515
        public Integer id;  //3562633
        public String datex; //2018-03-11
        public Integer timex;    //36000
        public boolean isLocked;
        public String comment;
        public cls_task task;
        public List<history> history;
    }
    public class cls_task {
        public List<String> projects;
        public String id;   //as:588657564876573
        public String type; //task
        public String name; //Task 1 - Understand API documentation
        public String url;  //https://app.asana.com/0/587623789378408/588657564876573/f
        public String status;   //open
        public String createdAt;    //2018-03-11 20:53:16
        public String dueAt;    //2018-03-13 00:00:00
        public timex timex;
    }
    public class timex{
        public String total;
    }
    public class history{
        public Integer createdBy;
        public Integer id;
        public Integer timex;
        public String action;
        public String createdAt;
    }
}