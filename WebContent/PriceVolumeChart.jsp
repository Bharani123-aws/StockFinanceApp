<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.sql.*" %>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.JsonObject"%>
 
<%
Gson gsonObj = new Gson();
Map<Object,Object> map = null;
List<Map<Object,Object>> list = new ArrayList<Map<Object,Object>>();
String dataPoints = null;
String dataPoints2=null;
String symbol=request.getParameter("symbol");
String startDate=request.getParameter("startDate");
String endDate=request.getParameter("endDate");




try{
	Class.forName("com.mysql.jdbc.Driver"); 
	String query="select "+ 
			" CONCAT(year(TradingDate),'-',DATE_FORMAT(TradingDate,'%b'),'-', day(TradingDate)) as tdate,"+
			" TRUNCATE((Price_Open),2) as price_Close, "+
"TRUNCATE((price_Close),2) as Price_Open,"+
"TRUNCATE((Low),2) as Low,"+
"TRUNCATE((High),2) as High"
			+" from price where symbol=?  and (tradingdate) between ? and ? ";
	Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_project?autoReconnect=true&useSSL=false", "root", "bh12");
	PreparedStatement st= connection.prepareStatement(query);
	st.setString(1, symbol);
	st.setString(2,startDate);
	st.setString(3,endDate);
	
	
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
	
		
		map = new HashMap<Object,Object>(); map.put("label", date); map.put("y", new Double[] {openPrice,high,low,closePrice}); list.add(map);
		dataPoints = gsonObj.toJson(list);
		
	}
	connection.close();
}
catch(SQLException e){
	out.println(e);
	
	dataPoints = null;
}

list = new ArrayList<Map<Object,Object>>();
try{
	Class.forName("com.mysql.jdbc.Driver"); 
	Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_project?autoReconnect=true&useSSL=false", "root", "bh12");
	ResultSet resultSet=null;
	
	String query=" select CONCAT(year(TradingDate),'-',DATE_FORMAT(TradingDate,'%b'),'-', day(TradingDate)) as tdate,"
			 +" volume"
			  +" from price where symbol=?  and (tradingdate) between ? and ? ";
	
	PreparedStatement st= connection.prepareStatement(query);
	st.setString(1, symbol);
	st.setString(2,startDate);
	st.setString(3,endDate);
	
	resultSet = st.executeQuery();
	
	String xVal ;
	
	float yVal;
	
 
	
	while(resultSet.next()){
		
		
		xVal = resultSet.getString("tdate");
		yVal = resultSet.getInt("Volume");
		map = new HashMap<Object,Object>(); map.put("label", xVal); map.put("y", yVal);list.add(map);
		
		dataPoints2 = gsonObj.toJson(list);
		
	}
	connection.close();
}
catch(SQLException e){
	out.println(e);
	dataPoints2 = null;
}


%>
<!DOCTYPE HTML>
<html>
<head>
<script>
window.onload = function () {
	<% String str=request.getParameter("symbol"); %>
	var sym1="<%=str%>";
	var chart = new CanvasJS.Chart("chartContainer",
	{
		title:{
			text: "Price Volume - "+sym1,
			fontFamily: "times new roman",
			fontSize:25
		},
		zoomEnabled: true,
		exportEnabled: true,
		axisY: {
			includeZero:true,
			title: "Price",
			fontSize:25,
			prefix: "$ "
		},
		axisY2: {
			title: "Volume",
			labelFormatter: addSymbols,
			fontSize:25
		},
		
		toolTip: {
			shared: true
		},
		legend: {
			cursor: "pointer",
			itemclick: toggleDataSeries
		},
		data: [
		{
			type: "candlestick",
			risingColor: "green",
			color: "red",
			name: "Stock Price",
			showInLegend: true,
			yValueFormatString: "$#,##0",
			dataPoints: <%out.print(dataPoints);%>
		},
		{
			type: "line",
			axisYType: "secondary",
			markerSize: 6,
			color: "LimeGreen",
			name: "Volume",
			showInLegend: true,
			dataPoints: <%out.print(dataPoints2);%>
		}
		]
	});
	chart.render();
	function addSymbols(e){
		var suffixes = ["", "K", "M", "B"];
		var order = Math.max(Math.floor(Math.log(e.value) / Math.log(1000)), 0);

		if(order > suffixes.length - 1)                	
			order = suffixes.length - 1;

		var suffix = suffixes[order];      
		return CanvasJS.formatNumber(e.value / Math.pow(1000, order)) + suffix;
	}

	function toggleDataSeries(e) {
		if (typeof (e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
			e.dataSeries.visible = false;
		} else {
			e.dataSeries.visible = true;
		}
		e.chart.render();
	}
}
</script>
</head>
<body>
<div id="chartContainer" style="height: 400px; width: 60%;"></div>

<div style=" position: absolute;bottom: 100px;">

<form action="StackPrice.jsp">
<button type="submit"><-Back </button> </form>

</div>
<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
</body>
</html>


