<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@page import="Db.Dbutil" %>
<%@page import="Bean.Plane" %>
<%@page import="Bean.Airport" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="renderer" content="webkit">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link rel="stylesheet" href="../../layui/css/layui.css"  media="all">
</head>
<%
String SQL="";
ResultSet rs=null;
Dbutil util=new Dbutil();
%>
<body>
<br>
<form class="layui-form" action="doAddFlight.jsp" method="post">
  <div class="layui-form-item">
    <label class="layui-form-label">航班号</label>
    <div class="layui-input-inline">
      <input name="flight_ID" class="layui-input" type="text" placeholder="请输入航班号" required="required">
    </div>
  </div>
  <div class="layui-form-item">
	 <label class="layui-form-label">飞机编号</label>
     <div class="layui-input-inline">
      <select name="plane_ID">
        <%
        SQL="select plane.plane_ID,plane_type,company_name from plane,company where plane.company_ID=company.company_ID and state='正常' ";
        rs=util.query(SQL);
        Plane plane=new Plane();
        while(rs.next()){
        	plane.plane_ID=rs.getInt("plane_ID");
        	plane.plane_type=rs.getString("plane_type");
        	plane.company_name=rs.getString("company_name");
        %>
        <option value="<%=plane.plane_ID %>">飞机编号：<%=plane.plane_ID %>&nbsp航空公司：<%=plane.company_name %>&nbsp飞机型号：<%=plane.plane_type %></option>
        <%} %>
      </select>
    </div>
  </div>
    <div class="layui-form-item">
	 <label class="layui-form-label">出发地</label>
     <div class="layui-input-inline">
      <select name="start">
        <%
        SQL="select * from airport ";
        rs=util.query(SQL);
        Airport ap=new Airport();
        while(rs.next()){
        	ap.airport_ID=rs.getInt("airport_ID");
        	ap.airport_name=rs.getString("airport_name");
        	ap.city=rs.getString("city");
        %>
        <option value="<%=ap.airport_ID %>">机场编号：<%=ap.airport_ID %>&nbsp&nbsp机场名称：<%=ap.airport_name %>&nbsp&nbsp城市：<%=ap.city %></option>
        <%} %>
      </select>
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">出发时间</label>
    <div class="layui-input-inline">
      <input id="st" name="starttime" class="layui-input" type="text" required="required">
    </div>
  </div>
  <div class="layui-form-item">
	 <label class="layui-form-label">经停地</label>
     <div class="layui-input-inline">
      <select name="stop">
      	<option value="null" ></option>
        <%
        SQL="select * from airport ";
        rs=util.query(SQL);
        Airport app=new Airport();
        while(rs.next()){
        	app.airport_ID=rs.getInt("airport_ID");
        	app.airport_name=rs.getString("airport_name");
        	app.city=rs.getString("city");
        %>
        <option value="<%=app.airport_ID %>">机场编号：<%=app.airport_ID %>&nbsp&nbsp机场名称：<%=app.airport_name %>&nbsp&nbsp城市：<%=app.city %></option>
        <%} %>
      </select>
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">到站时间</label>
    <div class="layui-input-inline">
      <input id="arrivetime" name="arrivetime" class="layui-input" type="text" >
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">经停时间</label>
    <div class="layui-input-inline">
      <input id="stoptime" name="stoptime" class="layui-input" type="text" placeholder="分钟">
    </div>
  </div>
    <div class="layui-form-item">
    <label class="layui-form-label">前段价格</label>
    <div class="layui-input-inline">
      <input id="A1_price" name="A1_price" class="layui-input" type="text" placeholder="头等舱">
      <input id="B1_price" name="B1_price" class="layui-input" type="text" placeholder="商务舱">
      <input id="C1_price" name="C1_price" class="layui-input" type="text" placeholder="经济舱">
    </div>
  </div>
    <div class="layui-form-item">
    <label class="layui-form-label">后段价格</label>
    <div class="layui-input-inline">
      <input id="A2_price" name="A2_price" class="layui-input" type="text" placeholder="头等舱">
      <input id="B2_price" name="B2_price" class="layui-input" type="text" placeholder="商务舱">
      <input id="C2_price" name="C2_price" class="layui-input" type="text" placeholder="经济舱">
    </div>
  </div>
  <div class="layui-form-item">
	 <label class="layui-form-label">到达地</label>
     <div class="layui-input-inline">
      <select name="end">
        <%
        SQL="select * from airport ";
        rs=util.query(SQL);
        Airport ap1=new Airport();
        while(rs.next()){
        	ap1.airport_ID=rs.getInt("airport_ID");
        	ap1.airport_name=rs.getString("airport_name");
        	ap1.city=rs.getString("city");
        %>
        <option value="<%=ap1.airport_ID %>">机场编号：<%=ap1.airport_ID %>&nbsp&nbsp机场名称：<%=ap1.airport_name %>&nbsp&nbsp城市：<%=ap1.city %></option>
        <%} %>
      </select> 
    </div>
  </div>
  <div class="layui-form-item">
    <label class="layui-form-label">到达时间</label>
    <div class="layui-input-inline">
      <input id="et" name="endtime" class="layui-input" type="text" required="required">
    </div>
  </div>
	<div class="layui-form-item">
    <label class="layui-form-label">头等舱价格</label>
    <div class="layui-input-inline">
      <input id="A_price" name="A_price" class="layui-input" type="number" required="required">
    </div>
  	</div>
  	<div class="layui-form-item">
    <label class="layui-form-label">商务舱价格</label>
    <div class="layui-input-inline">
      <input id="B_price" name="B_price" class="layui-input" type="number" required="required">
    </div>
  	</div>
  	<div class="layui-form-item">
    <label class="layui-form-label">普通舱价格</label>
    <div class="layui-input-inline">
      <input id="C_price" name="C_price" class="layui-input" type="number" required="required">
    </div>
  	</div>
  	<div class="layui-form-item">
	    <div class="layui-input-block">
	      <button class="layui-btn" type="submit">提交</button>
	      <button class="layui-btn layui-btn-primary" type="reset">重置</button>
	    </div>
	  </div>
</form>
<script src="../../layui/layui.js" charset="UTF-8"></script>
<script>
layui.use(['form', 'layedit', 'laydate'], function(){
  var form = layui.form
  ,layer = layui.layer
  ,layedit = layui.layedit
  ,laydate = layui.laydate;
  laydate.render({
	    elem: '#st' //指定元素
	    ,type:'datetime'
	  });
  laydate.render({
	    elem: '#et' //指定元素
	    ,type:'datetime'
	  });
  laydate.render({
	    elem: '#arrivetime' //指定元素
	    ,type:'datetime'
	  });
});
</script>
</body>
</html>