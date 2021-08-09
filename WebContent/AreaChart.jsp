<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.sql.*" %>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.JsonObject"%>
 
<%
Gson gsonObj = new Gson();
Map<Object,Object> map = null;
List<Map<Object,Object>> list = new ArrayList<Map<Object,Object>>();
String dataPoints1 = null;
String dataPoints2 = null;
String symbol1=request.getParameter("symbol1");
String symbol2=request.getParameter("symbol2");

if((symbol1==null)||(symbol2)==null ){
	
	out.println("Please enter correct symbol");
}

else{
try{
	Class.forName("com.mysql.jdbc.Driver"); 
	String query="Select year(TradingDate)  as tDate,Price_Open from price where   symbol=? group by year(TradingDate)";
	Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_project?autoReconnect=true&useSSL=false", "root", "bh12");
	PreparedStatement st= connection.prepareStatement(query);
	st.setString(1, symbol1);
	int xVal ;
	
	float yVal;
	
	ResultSet resultSet = st.executeQuery();
	
	while(resultSet.next()){
		
		
		xVal = resultSet.getInt("tDate");
		yVal = resultSet.getFloat("Price_Open");
		map = new HashMap<Object,Object>(); map.put("x", xVal); map.put("y", yVal);list.add(map);
		dataPoints1 = gsonObj.toJson(list);
		
	}
	connection.close();
}
catch(SQLException e){
	out.println("Data not Available please select other symbol");
	dataPoints1 = null;
}

list = new ArrayList<Map<Object,Object>>();
try{
	Class.forName("com.mysql.jdbc.Driver"); 
	String query="Select year(TradingDate)  as tDate,Price_Open from price where   symbol=? group by year(TradingDate)";
	Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_project?autoReconnect=true&useSSL=false", "root", "bh12");
	PreparedStatement st= connection.prepareStatement(query);
	st.setString(1, symbol2);
	int xVal ;
	
	float yVal;
	
	ResultSet resultSet = st.executeQuery();
	
	while(resultSet.next()){
		
		
		xVal = resultSet.getInt("tDate");
		yVal = resultSet.getFloat("Price_Open");
		map = new HashMap<Object,Object>(); map.put("x", xVal); map.put("y", yVal);list.add(map);
		dataPoints2 = gsonObj.toJson(list);
		
	}
	connection.close();
}
catch(SQLException e){
	out.println("Data not Available please select other symbol");
	dataPoints2 = null;
}


}
%>

<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
window.onload = function() { 
	<% String str=request.getParameter("symbol1"); %>
	var sym1="<%=str%>";
	<% String str2=request.getParameter("symbol2"); %>
	var sym2="<%=str2%>";
 
var chart = new CanvasJS.Chart("chartContainer", {  
	theme: "light1", // "light1", "dark1", "dark2"
	//backgroundColor: "#8FBC8F",
	title: {
		text: "Stock comparison "+sym1 +" Vs " +sym2
	},
	axisX: {
		title: "Year"
	},
	axisY: {
		prefix: "$",
		title: "Price",
		
		includeZero: true
	},
	
	toolTip: {
		shared: true
	},
	legend:{
		cursor: "pointer",
		itemclick: toggleDataSeries
	},
	data: [{
		type: "area",
		name: sym1,
		showInLegend: true,
		dataPoints: <%out.print(dataPoints1);%>
	},
	{
		type: "area",
		name: sym2,
		showInLegend: true,
		dataPoints:<%out.print(dataPoints2);%>
	}]
});
 
chart.render();
 
function toggleDataSeries(e){
	if (typeof(e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
		e.dataSeries.visible = false;
	}
	else{
		e.dataSeries.visible = true;
	}
	chart.render();
}
 
}
</script>
</head>
<body>
<div id="chartContainer" style="height: 370px; width: 60%;"></div>
<div style=" position: absolute;bottom: 150px;">

<form action="StackPrice.jsp">
<button type="submit"><-Back </button> </form>

</div>
<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
</body>
</html>                      