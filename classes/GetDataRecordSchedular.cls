public class GetDataRecordSchedular implements Schedulable {
    public void execute(SchedulableContext sc){
        EverHourCallouts.getDateRecords();
    }

}