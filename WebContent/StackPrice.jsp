<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %> 
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <title>Stack Market</title>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
  <script>
  $( function() {
    $( "#tabs" ).tabs({
      beforeLoad: function( event, ui ) {
        ui.jqXHR.fail(function() {
          ui.panel.html(
            "Couldn't load this tab. We'll try to fix this as soon as possible. " +
            "If this wouldn't be a demo." );
        });
      }
    });
    
    $(function() {
        $("#datepicker1").datepicker({
        	
        	dateFormat: "yy-mm-dd",
        	setDate: new Date(1970, 01, 02),
        	startDate: '2020'
            
        });
        
$("#datepicker2").datepicker({
        	
        	dateFormat: "yy-mm-dd",
        	setDate: new Date(2006, 12, 29),
        	startDate: '2000'
        });
      });
  } );
  
  </script>
  
</head>
<body BGCOLOR= #BABEA7>
<h2 style="color:blue;text-align:left"> UCM Stock Info <i class="fa fa-database" aria-hidden="true"></i></h2>
 <br>
<div id="tabs" style="width:83%; left:100px;height:800px;background-color: #EEEDE8" >
<h4><%= (new java.util.Date()).toLocaleString()%> <i class="fa fa-clock-o" aria-hidden="true"></i></h4>
<br>
  <ul>
    <li><a href="#tabs-1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Stock Summary&nbsp;<i class="fa fa-list"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
    <li><a href="#tabs-2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Statistics&nbsp;<i class="fa fa-bar-chart"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
    <li><a href="#tabs-3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Analysis&nbsp;<i class="fa fa-line-chart"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </a></li>
    <li><a href="#tabs-4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Financial&nbsp;<i class="fa fa-usd"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
  </ul>
  <div id="tabs-1">
  <form action="PriceServlet" method="get" >
  <br><br>
  <fieldset>
  <legend><h4>Stock Information <i class="fa fa-database" aria-hidden="true"></i></h4></legend>
  <input type="checkbox" name="HighPrice" value="HighPrice"> Highest Price <br/><br/>
  
  <input type="checkbox" name="HighVolume" value="HighVolume"> Highest Volume <br/><br/>
  </fieldset> <br><br><br>

<%
try {
	Connection conn= null;
	ResultSet rs = null;
	String connectionURL="jdbc:mysql://localhost:3306/db_project?autoReconnect=true&useSSL=false";
	Class.forName("com.mysql.jdbc.Driver");

	Statement statement = null;
	conn = DriverManager.getConnection(connectionURL, "root", "bh12");
	statement = conn.createStatement();
	String QueryString = "SELECT * from companyname";
	rs = statement.executeQuery(QueryString);
	%>
    
    <p style="color:black" >Symbol: 
 <select name="symbol" size="1" id="symbol">
        <%  while(rs.next()){ %>
            <option><%= rs.getString(1)%></option>
        <% } %>
        </select>



	<%
	// close all the connections.
	rs.close();
	statement.close();
	conn.close();
	} catch (Exception ex) {
	%>
	
	
	<%
	out.println(ex);
	}
	%>
	<input type="submit" name="submit" value="Submit">
	</form>
</div>


<div id="tabs-2">
  <form action="Statistics" method="get" >
  <br><br>
  <p style="color:black">Display:
  <select name="Top">
  <option value="10" selected>Last 10</option>
  <option value="100">Last 100</option>
  <option value="200">Last 200</option>
  
  </select> <br><br>
  
  <fieldset>
  <p style="color:black"></p>
  <legend>
  <h4>Exchange<i class="fa fa-exchange"></i></h4>
  </legend>
  <input type="radio" name="exchange" value="ALL" checked/>ALL
  <input type="radio" name="exchange" value="AMEX%" />AMEX
  <input type="radio" name="exchange" value="NYSE%"/>NYSE
  <input type="radio" name="exchange" value="NASDAQ%" />NASDAQ
  </fieldset>
  <br><br>
  <p style="color:black">Symbol:
  <input type="text" name="symbol" style="height:20px">
  <input type="submit" style="height:25px">
  
  </form>
  </div>

<div id="tabs-3">
  <form action="Chart.jsp" method="get" >
  <br><br>
  <fieldset>
  <p style="color:black"></p>
  <legend>
  <b>Stock Exchange <i class="fa fa-pie-chart"></i></b>
  </legend>
  <p style="color:black">Percentage of companies listed on stock exchange:
  <button type="submit" style="height:30px">Get <i class="fa fa-pie-chart"></i> </button>
  </fieldset>
  
  
  </form>
  <form action="BarChart.jsp">
  <br>
  <fieldset>
  <p style="color:black"></p>
  <legend>
  <b>Highest Price <i class="fa fa-bar-chart" aria-hidden="true"></i></b>
  </legend>
  <p style="color:black">Symbol:
  <input type="text" name="symbol" style="height:20px">
  <input type="submit" style="height:25px">
  </fieldset>
  </form>
  
    <form action="candlestick-chart.jsp">
  <br>
  <fieldset>
  <p style="color:black"></p>
  <legend>
 <b> Quarterly Analysis <i class="fa fa-line-chart"></i></b>
  </legend>
  <%
try {
	Connection conn= null;
	ResultSet rs = null;
	String connectionURL="jdbc:mysql://localhost:3306/db_project?autoReconnect=true&useSSL=false";
	Class.forName("com.mysql.jdbc.Driver");

	Statement statement = null;
	conn = DriverManager.getConnection(connectionURL, "root", "bh12");
	statement = conn.createStatement();
	String QueryString = " select distinct Company_Symbol from timeframe";
	rs = statement.executeQuery(QueryString);
	%>
    
    <p style="color:black" >Symbol: 
 <select name="symbol" size="1" id="symbol">
        <%  while(rs.next()){ %>
            <option><%= rs.getString(1)%></option>
        <% } %>
        </select>



	<%
	// close all the connections.
	rs.close();
	statement.close();
	conn.close();
	} catch (Exception ex) {
	%>
	
	
	<%
	out.println(ex);
	}
	%>
	
	
	<input type="submit" name="submit" value="Submit">
  </fieldset>
  </form>
  
  
  <form action="AreaChart.jsp" method="get" >
  <br><br>
  <fieldset>
  <p style="color:black"></p>
  <legend>
  <b>Stock Comparison <i class="fa fa-area-chart" aria-hidden="true"></i></b>
  </legend>
  <p style="color:black">Symbol:
  <input type="text" name="symbol1" style="height:20px"> <br>
  
  <p style="color:black">Symbol:
  <input type="text" name="symbol2" style="height:20px"> <br><br>
  <button type="submit" value="Submit" style="position: relative;left: 70px;">Submit </button>
  </fieldset>
  
  
  </form>
  
  </div>
  
  
  
  <div id="tabs-4">
  <form action="FinanceChart.jsp" method="get" >
  <br><br>
  <p style="color:black">Range:
  <select name="Range">
  <option value="1" selected>1 year</option>
  <option value="2"> 2 years</option>
  <option value="3">5 years</option>  
   <option value="ALL">ALL</option> 
  </select> <br><br>
  
  <fieldset>
  <p style="color:black"></p>
  <legend>
  <h4>Financial trend <i class="fa fa-usd"></i></h4>
  </legend>
  
  <p style="color:black">Average:
  <select name="Days">
  <option value="1" selected>1 Day</option>
  <option value="5"> 5 Day</option>
  <option value="50">50 Day</option>
  <option value="200">200 Day</option>
  
  </select> <br><br>
 <p style="color:black">Symbol:
  <input type="text" name="symbol" style="height:20px">
  <input type="submit" style="height:25px">
  
  </fieldset>
  
  </form>
  
  <form action="PriceVolumeChart.jsp" method="get">
  <fieldset>
  <p style="color:black"></p>
  <legend>
  <h4>Price & Volume<i class="fa fa-usd"></i></h4>
  </legend>
  
 From: <input type="text" id="datepicker1" name='startDate' value='2006-01-01'>  To: <input type="text" id="datepicker2" name='endDate' value='2006-03-29'>
   <br><br>
 <p style="color:black">Symbol:
  <input type="text" name="symbol" style="height:20px">
  <input type="submit" style="height:25px">
  
  </fieldset> 
  
  </form>
  </div>
  
  
  
  


  </div>
  
 
 
</body>

</html>