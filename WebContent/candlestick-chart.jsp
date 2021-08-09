<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.sql.*" %>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.JsonObject"%>
 
<%
Gson gsonObj = new Gson();
Map<Object,Object> map = null;
List<Map<Object,Object>> list = new ArrayList<Map<Object,Object>>();
String dataPoints = null;
String symbol=request.getParameter("symbol");


try{
	Class.forName("com.mysql.jdbc.Driver"); 
	String query="SELECT  CONCAT(DATE_FORMAT(TradingDate,'%b'),'-', day(TradingDate)) as tdate ,"
			+ " TRUNCATE((Price_Open),2) as price_Close, TRUNCATE((price_Close),2) as Price_Open,TRUNCATE((Low),2) as Low,TRUNCATE((High),2) as High"+
		    " FROM"+
		     " ("
		      +" SELECT TradingDate, QUARTER(TradingDate) as _quarter," 
		      +" Price_Open,price_Close,Low,High"
		     + " FROM Price where symbol=? and year(TradingDate)="
		      + " (Select max(year(TradingDate)) from price  where symbol=?) and QUARTER(TradingDate)=4"
		  +" ) AS sub_query"
		 +" GROUP BY  TradingDate";
	Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_project?autoReconnect=true&useSSL=false", "root", "bh12");
	PreparedStatement st= connection.prepareStatement(query);
	st.setString(1, symbol);
	st.setString(2, symbol);
	
	
	String date;
	double openPrice;
	
	double high;
	double volume;
	double closePrice;
	double low;
	
	
	ResultSet resultSet = st.executeQuery();
	
	while(resultSet.next()){
		
		
		date=resultSet.getString("tdate");
		openPrice = resultSet.getFloat("Price_Open");
		high = resultSet.getFloat("High");
		closePrice = resultSet.getFloat("price_Close");
		low = resultSet.getFloat("Low");
		
		
		
		map = new HashMap<Object,Object>(); map.put("label", date); map.put("y",new Double[] {openPrice,high,low,closePrice}); list.add(map);
		dataPoints = gsonObj.toJson(list);
		
	}
	connection.close();
}
catch(SQLException e){
	out.println("Data unavailable...Please select other symbol. ");
	
	dataPoints = null;
}
%>
 
<!DOCTYPE HTML>
<html>
<head>
<script type="text/javascript">
window.onload = function () {
	<% String str=request.getParameter("symbol"); %>
	var sym1="<%=str%>";
	var chart = new CanvasJS.Chart("chartContainer",
	{
		title:{
			text: "Quarterly Analysis - "+sym1,
			fontFamily: "times new roman"
		},
		zoomEnabled: true,
		exportEnabled: true,
		axisY: {
			includeZero:false,
			title: "Price",
			prefix: "$ "
		},
		axisX: {
			title: "Date"
		},
		data: [
		{
			type: "candlestick",
			risingColor: "green",
			color: "red",
			yValueFormatString: "$#,##0",
			dataPoints: <%out.print(dataPoints);%>
		}
		]
	});
	chart.render();
}
</script>
<script type="text/javascript" src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
</head>
<body>
<div id="chartContainer" style="height: 450px; width: 60%;">
</div>
<div style=" position: absolute;bottom: 150px;">

<form action="StackPrice.jsp">
<button type="submit"><-Back </button> </form>

</div>
</body>
</html>      