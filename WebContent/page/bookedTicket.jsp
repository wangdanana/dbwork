<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="Db.Dbutil" %>
<%@ page import="java.sql.*" %>
<%@ page import="Bean.Ticket" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>已订机票</title>
<meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link rel="stylesheet" href="../layui/css/layui.css"  media="all">
  <style type="text/css">body{margin: 2em 0.5em 0.5em 0em;}</style>
</head>
<body>
<%
int user_ID=Integer.parseInt(session.getAttribute("ID").toString());
Dbutil util=new Dbutil();
String SQL="";
ResultSet rs=null;
%>
<table class="layui-table" lay-size='sm' id="booked_tickets" >
  <thead>
    <tr>
    	<th>订单编号</th>
      	<th>航班号</th>
       	<th>乘客姓名</th>
       	<th>机舱号</th>
        <th>座位号</th>
        <th>机票价格</th>
        <th>出发时间</th>
        <th>出发城市</th>
        <th>出发机场</th>
        <th>到达时间</th>
        <th>到达城市</th>
        <th>到达机场</th>
        <th>退票</th>
    </tr> 
  </thead>
  <tbody>
<%
SQL="";
SQL+=" select ticket_ID,ticket.flight_ID,ticket.passenger_ID,passenger_name,price, ";
SQL+=" start_time,end_time,aa.airport_name as start_airport,bb.airport_name as end_airport,aa.city as start_city,bb.city as end_city,cabin_type,seat_location ";
SQL+=" from ticket,passenger,flight,airport as aa,airport as bb,plane_seat ";
SQL+=" where passenger.user_ID='"+user_ID+"' and ticket_state='normal' and cernum=passenger_ID and ticket.flight_ID=flight.flight_ID "; 
SQL+=" and flight.start_ID=aa.airport_ID and flight.end_ID=bb.airport_ID ";
SQL+=" and flight.plane_ID=plane_seat.plane_ID and ticket.seat_ID=plane_seat.seat_ID ";
rs=util.query(SQL);
while(rs.next()){
	Ticket ticket=new Ticket();
	ticket.ticket_id=rs.getInt("ticket_ID");
	ticket.flight_id=rs.getInt("flight_ID");
	ticket.passenger_name=rs.getString("passenger_name");
	ticket.cabin_type=rs.getString("cabin_type");
	ticket.seat_location=rs.getString("seat_location");
	ticket.price=rs.getDouble("price");
	ticket.start_time=rs.getString("start_time");
	ticket.start_city=rs.getString("start_city");
	ticket.start_airport=rs.getString("start_airport");
	ticket.end_time=rs.getString("end_time");
	ticket.end_city=rs.getString("end_city");
	ticket.end_airport=rs.getString("end_airport");
%>
		<tr>
		   	<td><%=ticket.ticket_id %></td>
    		<td><%=ticket.flight_id %></td>
    		<td><%=ticket.passenger_name %></td>
    		<td><%=ticket.cabin_type %></td>
    		<td><%=ticket.seat_location %></td>
    		<td><%=ticket.price %></td>
    		<td><%=ticket.start_time %></td>
    		<td><%=ticket.start_city %></td>
    		<td><%=ticket.start_airport %></td>
    		<td><%=ticket.end_time %></td>
    		<td><%=ticket.end_city %></td>
    	    <td><%=ticket.end_airport %></td>
    		<td><input type="button" class="layui-btn layui-btn-xs" name="return" value="退订"></td>
    	</tr>

<%
}
util.close();
%>
</tbody>
</table>

</body>
<script src="../layui/layui.js" charset="utf-8"></script>
<script type="text/javascript" src="http://libs.baidu.com/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
	$("#booked_tickets").on("click", ":button", function(event) {
		ticket_ID=$(this).closest("tr").find("td").eq(0).text();
		createXMLHttpRequest();
		var url = "doReturn.jsp?ticket_ID='"+ticket_ID+"'";  
	    XMLHttpReq.open("GET", url, true);  
	    XMLHttpReq.onreadystatechange = processResponse;//指定响应函数  
	    XMLHttpReq.send(null);
	});
});
function createXMLHttpRequest() {  
    if(window.XMLHttpRequest) { //Mozilla 浏览器  
        XMLHttpReq = new XMLHttpRequest();  
    }  
    else if (window.ActiveXObject) { // IE浏览器  
        try {  
            XMLHttpReq = new ActiveXObject("Msxml2.XMLHTTP");  
        } catch (e) {  
            try {  
                XMLHttpReq = new ActiveXObject("Microsoft.XMLHTTP");  
            } catch (e) {}  
        }  
    }  
}
function processResponse() {  
    if (XMLHttpReq.readyState == 4) { // 判断对象状态  
        if (XMLHttpReq.status == 200) { // 信息已经成功返回，开始处理信息  
				location.reload();
        } else { 
            window.alert("您所请求的页面有异常。");  
        }  
    }  
}
</script>

</html>




