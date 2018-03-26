public class EverHourProjectParser {

    public Boolean canSyncTasks;
    public List<Integer> users;
    public String id;
    public String name;
    public String createdAt;
    public String workspaceId;
    public String workspaceName;
    public Boolean foreign;
    public Boolean favorite;
    public Boolean hasWebhook;
    public String status;
    public Boolean changeProtected;

    
    public static List<EverHourProjectParser> parse(String json) {
        return (List<EverHourProjectParser>) System.JSON.deserialize(json, List<EverHourProjectParser>.class);
    }
}