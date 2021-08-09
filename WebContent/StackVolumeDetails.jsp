<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>   
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<title>Insert title here</title>
</head>
<body>
<div align="left">
<h3 style="color: blue;" >Today's date: <%= (new java.util.Date()).toLocaleString()%> <i class="fa fa-clock-o"></i> </h3>
<h4> Stock Information</h4>
        <table border="1" cellpadding="10">
 

  <c:forEach items="${listPriceDetails}" var="stack">
<th style="width:300px;background-color: #B6BEA7;">Description</th>
  <th style="width:300px;background-color: #B6BEA7;">Result</th>
    <tr>
      <td>Symbol</td>
      <td><c:out value="${stack.stock_Symbol}" /></td>
    </tr>
    <tr>
    <td>CompayName</td>
    <td><c:out value="${stack.companyName}" /></td>
    
    </tr>
    <tr>
    <td>Stock Exchange</td>
    <td><c:out value="${stack.exchangeName}" /></td>
    
    </tr>
    <tr>
    <td>Start Trading Date</td>
    <td><c:out value="${stack.startTradingDate}" /></td>
    
    </tr>
    <tr>
    <td>End Trading Date</td>
    <td><c:out value="${stack.endTradingDate}" /></td>
    
    </tr>
     <tr>
    <td>High Volume</td>
    <td><c:out value="${stack.maxVolumne}" /></td>
    
    </tr>
  </c:forEach>
</table>
<TABLE>
<TR>
<TD><form action="StackPrice.jsp">
<button type="submit"><-Back </button> </form></TD>
</TR>

</TABLE>
            
        
    </div>
</body>
</html>