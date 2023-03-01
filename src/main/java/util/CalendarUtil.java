package util;

public class CalendarUtil {

	// 년과 달과 날자를 두자리로 만들어서 한문장으로 만들어주는 합수 yyyymmdd
	public static String yyyymmdd(int year, int month, int day) {
				
		String syear  =Integer.toString(year);
		String smonth  =Integer.toString(month);
		String sday  =Integer.toString(day);
		
		
		String yyyymmdd = "";
		if(smonth.length() == 1){
			smonth = "0"+smonth;
		}
		if(sday.length() == 1){
			sday = "0"+sday;
		}
		yyyymmdd = syear+smonth+sday;
		return yyyymmdd;
	}
	
	
	//2023-01-01 형식으로 만들어준는 함수
	public static String hyphenDate(String year, String month, String day) {
			
		String rdate = "";
		
		if(month.length() == 1){
			month = "0"+month;
		}
		if(day.length() == 1){
			day = "0"+day;
		}
		
		rdate = year+"-"+month+"-"+day;
		return rdate;

	}
	
	// 202301010101 형식으로 만들어주는 함수
	//date: 2023-03-05(입력 String)
	//time: 20:05(입력 String)
 public static String DateTime(String date, String time) {


String datesplit[] = date.split("-"); //["2023","03","05"]
String year = datesplit[0];
String month = datesplit[1];
String day = datesplit[2];

String timesplit[] = time.split(":");
String hour = timesplit[0];
String min = timesplit[1];

String rdate = year + month + day + hour + min;
return rdate;
}

}
