<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.JsonObject"%>
 <%@ page import="java.util.*,java.sql.*" %>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>   
<%
Gson gsonObj = new Gson();
Map<Object,Object> map = null;
List<Map<Object,Object>> list = new ArrayList<Map<Object,Object>>();
String dataPoints1 = null;
String dataPoints2 =null;
String query=null;

String symbol=request.getParameter("symbol");
String range=request.getParameter("Range");
int days=Integer.parseInt(request.getParameter("Days"));

if(symbol.equals("")){
	
	out.println("<h1>Please select the correct symbol...!!</h1>");
}
else{

try{
	Class.forName("com.mysql.jdbc.Driver"); 
	Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_project?autoReconnect=true&useSSL=false", "root", "");

	ResultSet resultSet=null;
	if("1".equals(range)){
	 query="SELECT"+ 
		" CONCAT(DATE_FORMAT(TradingDate,'%b'),'-', day(TradingDate)) as tdate,"+
			 " AVG (Price_Open) OVER (ORDER BY TradingDate RANGE INTERVAL ? DAY PRECEDING) as mvgPrice"+
			" FROM price"+
			" WHERE symbol=? and year(TradingDate)=(select max(year(TradingDate)) from price where symbol=?)"+
			" order by TradingDate";
	 PreparedStatement st= connection.prepareStatement(query);
	 st.setInt(1,days);
		st.setString(2, symbol);
		st.setString(3, symbol);
	 resultSet = st.executeQuery();
	}
	else if("2".equals(range)){
		query="SELECT"+ 
				" CONCAT(DATE_FORMAT(TradingDate,'%b'),'-', year(TradingDate)) as tdate,"+
					 " AVG (Price_Open) OVER (ORDER BY TradingDate RANGE INTERVAL ? DAY PRECEDING) as mvgPrice"+
					" FROM price"+
					" WHERE symbol=? and year(TradingDate) between (select year(max(TradingDate))-1 from price where symbol=?) and (select year(max(TradingDate)) from price where symbol=?)"+
					" order by TradingDate";
		PreparedStatement st= connection.prepareStatement(query);
		st.setInt(1,days);
		st.setString(2, symbol);
		st.setString(3, symbol);
		st.setString(4, symbol);
		
		 resultSet = st.executeQuery();
	}
	else if("3".equals(range)){
		
		query="SELECT"+ 
				" CONCAT(DATE_FORMAT(TradingDate,'%b'),'-', year(TradingDate)) as tdate,"+
					 " AVG (Price_Open) OVER (ORDER BY TradingDate RANGE INTERVAL ? DAY PRECEDING) as mvgPrice"+
					" FROM price"+
					" WHERE symbol=? and year(TradingDate) between (select year(max(TradingDate))-4 from price where symbol=?) and (select year(max(TradingDate)) from price where symbol=?)"+
					" order by TradingDate";
		PreparedStatement st= connection.prepareStatement(query);
		st.setInt(1,days);
		st.setString(2, symbol);
		st.setString(3, symbol);
		st.setString(4, symbol);
		
		 resultSet = st.executeQuery();
		
		
		
	}
else {
		
		query="SELECT"+ 
				" CONCAT(DATE_FORMAT(TradingDate,'%b'),'-', year(TradingDate)) as tdate,"+
					 " AVG (Price_Open) OVER (ORDER BY TradingDate RANGE INTERVAL ? DAY PRECEDING) as mvgPrice"+
					" FROM price"+
					" WHERE symbol=? and year(TradingDate) between (select year(min(TradingDate)) from price where symbol=?) and (select year(max(TradingDate)) from price where symbol=?)"+
					" order by TradingDate";
		PreparedStatement st= connection.prepareStatement(query);
		st.setInt(1,days);
		st.setString(2, symbol);
		st.setString(3, symbol);
		st.setString(4, symbol);
		
		 resultSet = st.executeQuery();
		
		
		
	}
	
	
	String xVal ;
	
	float yVal;
	
	
	
	while(resultSet.next()){
		
		
		xVal = resultSet.getString("tdate");
		yVal = resultSet.getFloat("mvgPrice");
		map = new HashMap<Object,Object>(); map.put("label", xVal); map.put("y", yVal); list.add(map);
		dataPoints1 = gsonObj.toJson(list);
	
	}
	connection.close();
}
catch(SQLException e){
	out.println("No data available for this symbol");
	dataPoints1 = null;
}
 
list = new ArrayList<Map<Object,Object>>();
try{
	Class.forName("com.mysql.jdbc.Driver"); 
	Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/db_project?autoReconnect=true&useSSL=false", "root", "");
	ResultSet resultSet=null;
	if("1".equals(range)){
	query="select CONCAT(DATE_FORMAT(TradingDate,'%b'),'-', day(TradingDate)) as tdate,"+
			"Price_Open from price where symbol=? and year(TradingDate)=(select max(year(TradingDate)) "+
			"from price where symbol=?)";
	
	PreparedStatement st= connection.prepareStatement(query);
	st.setString(1, symbol);
	st.setString(2, symbol);
	resultSet = st.executeQuery();
	
	}
	else if("2".equals(range)){
		
		query="select CONCAT(DATE_FORMAT(TradingDate,'%b'),'-', year(TradingDate)) as tdate,"+
				" Price_Open from price where symbol=? and year(TradingDate) between (select year(max(TradingDate))-1 from price where symbol=?) and (select year(max(TradingDate)) from price where symbol=?)";
		
		PreparedStatement st= connection.prepareStatement(query);
		st.setString(1, symbol);
		st.setString(2, symbol);
		st.setString(3, symbol);
		resultSet = st.executeQuery();

		
	}
	else if("3".equals(range)){
		
		query="select CONCAT(DATE_FORMAT(TradingDate,'%b'),'-', year(TradingDate)) as tdate,"+
				"Price_Open from price where symbol=? and year(TradingDate) between (select year(max(TradingDate))-4 from price where symbol=?) and (select year(max(TradingDate)) from price where symbol=?)";
		
		PreparedStatement st= connection.prepareStatement(query);
		st.setString(1, symbol);
		st.setString(2, symbol);
		st.setString(3, symbol);
		resultSet = st.executeQuery();


	}
else {
		
		query="select CONCAT(DATE_FORMAT(TradingDate,'%b'),'-', year(TradingDate)) as tdate,"+
				"Price_Open from price where symbol=? and year(TradingDate) between (select year(min(TradingDate)) from price where symbol=?) and (select year(max(TradingDate)) from price where symbol=?)";
		
		PreparedStatement st= connection.prepareStatement(query);
		st.setString(1, symbol);
		st.setString(2, symbol);
		st.setString(3, symbol);
		resultSet = st.executeQuery();


	}
	String xVal ;
	
	float yVal;
	
 
	
	while(resultSet.next()){
		
		
		xVal = resultSet.getString("tdate");
		yVal = resultSet.getFloat("Price_Open");
		map = new HashMap<Object,Object>(); map.put("label", xVal); map.put("y", yVal);list.add(map);
		dataPoints2 = gsonObj.toJson(list);
		
	}
	connection.close();
}
catch(SQLException e){
	out.println("No data available for this symbol");
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
	<% String str=request.getParameter("symbol"); %>
	var sym1="<%=str%>";
	<% String days1=request.getParameter("Days"); %>
	var day="<%=days1%>";
	
	
	
	
	if(sym1!=''){
		
		document.getElementById('chartContainer').style.display = 'block';
	}
	else{
		
		document.getElementById('chartContainer').style.display = 'none';
		
	}
	
var chart = new CanvasJS.Chart("chartContainer", {
	animationEnabled: true,
	//colorSet: "colorSet2",
	theme: "light1",
	//backgroundColor: "#FFCC99",
	title: {
		text: "Moving Average"
	},
	axisX: {
		title: "Date"
		
	},
	axisY: {
		title: "Price",
		prefix: "$",
		includeZero: true
	},
	toolTip: {
		shared: true
	},
	legend: {
		cursor: "pointer",
		itemclick: toggleDataSeries,
		verticalAlign: "top"
	},
	data: [
	       
{
	type: "line",
	name: sym1,
	showInLegend: true,
	xValueType: "dateTime",
	yValueFormatString: "$#,##0",
	dataPoints: <%out.print(dataPoints2);%>
}
	       ,{
			type: "line",
			name: day+" Days Moving Average",
			showInLegend: true,
			
			yValueFormatString: "$#,##0",
			dataPoints: <%out.print(dataPoints1);%>
		}
		]
});
chart.render();
 
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

<sql:setDataSource
        var="myDS"
        driver="com.mysql.jdbc.Driver"
        url="jdbc:mysql://localhost:3306/db_project?autoReconnect=true&useSSL=false"
        user="root" password="bh12"
    />
     
    <sql:query var="listUsers"   dataSource="${myDS}">
        select * from(
Select min(p.Price_Open) as minOpenPrice,max(p.Price_Open) as maxOpenPrice,
min(p.volume) as minvol, max(p.volume) as maxvol,
min(p.Price_Close) as minclosePrice,max(p.Price_Close) as maxclosePrice,
min(p.Low) as minLow,max(p.Low) as maxLow, min(p.High) as minhigh, max(p.High)as maxhigh,
c.Company_Name as companyName,p.symbol as comSym
from price p
left join companyname c on c.stock_symbol=p.symbol
where p.symbol='<%=request.getParameter("symbol")%>') as a;

    </sql:query>

<div class="float-container">

  <div class="float-child">
    <div id="chartContainer" style="height: 400px; width: 60%;float:left"></div>
  </div>
  
  <div class="float-child" style="position:absolute; right:100px; top:80px;background-color: lightblue;width:400px;">
  <br>
  
 
    <c:forEach var="user" items="${listUsers.rows}">
     			<tr>
                
                   <u> <td> <c:out value="${user.comSym}" /> &nbsp;&nbsp;&nbsp;&nbsp;- &nbsp;&nbsp;&nbsp;&nbsp;<c:out value="${user.companyName}" /> </td></u>
                    
                </tr>
                <br><br>
                <tr>
                
                   <u> <td>Price:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; <c:out value="${user.minOpenPrice}" /> - <c:out value="${user.maxOpenPrice}" /> </td></u>
                    
                </tr>
                <br><br>
                <tr>
                
                  <u>  <td>Open:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; <c:out value="${user.minclosePrice}" /> - <c:out value="${user.maxclosePrice}" /> </td></u>
                    
                </tr>
                <br><br>
                <tr>
                
                   <u> <td>Low: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp;<c:out value="${user.minLow}" /> - <c:out value="${user.maxLow}" /> </td></u>
                    
                </tr>
                <br><br>
                <tr>
                
                   <u> <td>High:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; <c:out value="${user.minhigh}" /> - <c:out value="${user.maxhigh}" /> </td></u>
                    
                </tr>
                <br><br>
                <tr>
                
                   <u> <td>Volume:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp; &nbsp; <c:out value="${user.minvol}" /> - <c:out value="${user.maxvol}" /> </td></u>
                    
                </tr>
            </c:forEach>
            <br><br><br>
  </div>
  
</div>

<div style=" position: absolute;bottom: 150px;">

<form action="StackPrice.jsp">
<button type="submit"><-Back </button> </form>

</div>
<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
</body>
</html> 
