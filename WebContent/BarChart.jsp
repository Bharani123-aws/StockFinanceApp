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

if(symbol.equals("")){
	
	out.println("<h3>Please select correct symbol..!!!</h3>");
	
}
else{
try{
	Class.forName("com.mysql.jdbc.Driver"); 
	String query="select year(TradingDate) as TYear, max(High) as highPrice from price where symbol=? group by year(TradingDate)";
	Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_project?autoReconnect=true&useSSL=false", "root", "");
	PreparedStatement st= connection.prepareStatement(query);
	st.setString(1, symbol);
	int xVal ;
	
	float yVal;
	
	ResultSet resultSet = st.executeQuery();
	
	while(resultSet.next()){
		
		
		xVal = resultSet.getInt("TYear");
		yVal = resultSet.getFloat("highPrice");
		map = new HashMap<Object,Object>(); map.put("x", xVal); map.put("y", yVal); list.add(map);
		dataPoints = gsonObj.toJson(list);
		
	}
	connection.close();
}
catch(SQLException e){
	out.println("Data not Available please select other symbol");
	dataPoints = null;
}}
%>
 
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">

window.onload = function() { 
	<% String str=request.getParameter("symbol"); %>
	var sym1="<%=str%>";
<% if(dataPoints != null) { %>
var chart = new CanvasJS.Chart("chartContainer", {
	animationEnabled: true,
	exportEnabled: true,
	title: {
		text: "Highest Price in Year -"+sym1
	},
	axisX: {
		title: "Years"
	},
	axisY: {
		title: "Highest Price",
		includeZero: true
	},
	data: [{
		type: "column", //change type to bar, line, area, pie, etc
		name: sym1,
		showInLegend: true,
		dataPoints: <%out.print(dataPoints);%>
	}]
});
chart.render();
<% } %> 
 
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
