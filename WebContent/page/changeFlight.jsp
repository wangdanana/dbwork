<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="Db.Dbutil" %>
<%@ page import="Bean.Flight" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link rel="stylesheet" href="../layui/css/layui.css"  media="all">
</head>
<body>
<div id="div1">
<table class="layui-table" lay-size='sm' id="booked_tickets" >
  <thead>
    <tr>
      	<th>航班号</th>
      	<th>飞行时间</th>
        <th>出发时间</th>
        <th>到达时间</th>
        <th>A类票价</th>
        <th>B类票价</th>
        <th>C类票价</th>
        <th>订票</th>
    </tr> 
  </thead>
  <tbody>
<%
response.setContentType("text/html;charset=utf-8");  
request.setCharacterEncoding("utf-8");
String ticket_ID=request.getParameter("ticket_ID");
Dbutil util=new Dbutil();
String SQL="select passenger_ID,flight_ID,seat_ID from ticket where ticket_ID='"+ticket_ID+"' ";
ResultSet rs=null,rs1=null;
rs=util.query(SQL);
int flight_ID=-1,seat_ID=-1;
String passenger_ID=null;
if(rs.next()){
	flight_ID=rs.getInt("flight_ID");
	passenger_ID=rs.getString("passenger_ID");
	seat_ID=rs.getInt("seat_ID");
	}
	SQL="select b.* from flight as a,flight as b where a.flight_ID='"+flight_ID+"' and a.start_ID=b.start_ID and a.end_ID=b.end_ID and b.flight_state='正常' ";
	rs1=util.query(SQL);
	while(rs1.next()){
		%>
		<tr>
    		<td><%=rs1.getInt("flight_ID") %></td>
    		<td><%=new Flight().getTime(rs1.getString("start_time"),rs1.getString("end_time")) %>
    		<td><%=rs1.getString("start_time") %></td>
    		<td><%=rs1.getString("end_time") %></td>
    		<td><%=rs1.getDouble("A_price") %></td>
    		<td><%=rs1.getDouble("B_price") %></td>
    		<td><%=rs1.getDouble("C_price") %></td>
    		<td><input type="button" class="layui-btn layui-btn-xs" name="book" value="预定"></td>
    	</tr>
		<% 
	}
util.close();
%>
</tbody>
</table>
</div>
</body>
<script src="../layui/layui.js" charset="utf-8"></script>
</html>