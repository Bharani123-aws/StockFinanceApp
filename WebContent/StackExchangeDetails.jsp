<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Stock Exchange details</title>
</head>
<body>
<div align="left">

<c:choose>
    <c:when test="${empty listExchange}">
        <h1>No data available</h1>
    </c:when>
    <c:otherwise>
        <table border="1" cellpadding="5" >
            <h2>Stack exchange details</h2>
            <tr bgcolor="#B6BEA7">
                <th>Index</th>
                <th>CompanyName</th>
                <th> ExchangeName</th>
                <th>Trading Date</th>
                <th>Open</th>
                <th>Close</th>
                <th>Low</th>
                <th>High</th>
                <th>Volume</th>
            </tr>
            <c:forEach var="exchange" items="${listExchange}">
                <tr>
                    <td><c:out value="${exchange.index}" /></td>
                     <td><c:out value="${exchange.companyName}" /></td>
                    <td><c:out value="${exchange.exchangeName}" /></td>
                    <td><c:out value="${exchange.tradingDate}" /></td>
                    <td><c:out value="${exchange.open}" /></td>
                    <td><c:out value="${exchange.close}" /></td>
                       <td><c:out value="${exchange.low}" /></td>
                    <td><c:out value="${exchange.high}" /></td>
                    <td><c:out value="${exchange.maxVolumne}" /></td>
                </tr>
            </c:forEach>
        </table>
    </c:otherwise> 
</c:choose>
       
    </div>
   <div style="bottom:90px">
    <TABLE> 
<TR>
<TD><form action="StackPrice.jsp">
<button type="submit" >Back </button> </form></TD>
</TR>

</TABLE>
</div> 
</body>
</html>