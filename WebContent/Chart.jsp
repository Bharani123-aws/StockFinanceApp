<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.JsonObject"%>
 <%@ page import="java.sql.*" %>
<%
Gson gsonObj = new Gson();
Map<Object,Object> map = null;
List<Map<Object,Object>> list = new ArrayList<Map<Object,Object>>();
String dataPoints = null;
try{
	Class.forName("com.mysql.jdbc.Driver"); 
	Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_project?autoReconnect=true&useSSL=false", "root", "");
	Statement statement = connection.createStatement();
	String exchangeName;
	float percentage;
	int index=0;
	ResultSet resultSet = statement.executeQuery("select Stock_ExchangeName,count(*)*100/t.Total as Percentage from exchangestock" + 
			" cross join (select count(*) as Total from exchangestock ) t where Stock_ExchangeName like'AMEX%'" + 
			" union" + 
			" Select Stock_ExchangeName, count(*)*100/t.Total as Percentage from exchangestock " + 
			" cross join (select count(*) as Total from exchangestock ) t where Stock_ExchangeName like'NYSE%'" + 
			" union" + 
			" select Stock_ExchangeName,count(*)*100/t.Total as Percentage from exchangestock" + 
			" cross join (select count(*) as Total from exchangestock ) t where Stock_ExchangeName like'NASDAQ%'");
	
	while(resultSet.next()){
		index=index+1;
		exchangeName = resultSet.getString("Stock_ExchangeName");
		percentage = resultSet.getFloat("Percentage");
		if(index==1){
			map = new HashMap<Object,Object>(); map.put("label",exchangeName ); map.put("y",percentage ); map.put("exploded", true);list.add(map);
		}
		else{
		map = new HashMap<Object,Object>(); map.put("label",exchangeName ); map.put("y",percentage );list.add(map);
		}
		dataPoints = gsonObj.toJson(list);
	}
	connection.close();
}
catch(Exception ex){
	
	ex.printStackTrace();
	
}
 
%>
 
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
window.onload = function() { 
 
var chart = new CanvasJS.Chart("chartContainer", {
	theme: "light2",
	animationEnabled: true,
	exportFileName: "Companies listing stock exchange",
	exportEnabled: true,
	title:{
		text: "Companies listing stock exchange(%)"
	},
	data: [{
		type: "pie",
		showInLegend: true,
		legendText: "{label}",
		toolTipContent: "{label}: <strong>{y}%</strong>",
		indexLabel: "{label} {y}%",
		dataPoints : <%out.print(dataPoints);%>
	}]
});
 
chart.render();
 
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
