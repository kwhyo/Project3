﻿<%@ page language="java" import="java.util.*,java.io.*" import="java.sql.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ page import="com.oreilly.servlet.MultipartRequest,com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<% request.setCharacterEncoding("utf-8"); %>
<%@ include file = "/includes/dbinfo.jsp" %>
<%
	String realFolder = "";
	String saveFolder = "./review_images/";
	String encType = "utf-8";

	int sizeLimit = 10 * 1024 * 1024;
	realFolder = application.getRealPath(saveFolder);
	MultipartRequest multi	= new MultipartRequest(request,realFolder,sizeLimit,encType);

	ResultSet  rs = null;
	Statement stmt = con.createStatement();

	String qna_id		= multi.getParameter("qna_id");
	String product_id		= multi.getParameter("product_id");

	try{

		String strSQL = "SELECT * FROM qna where qna_id ='" + qna_id + "'";
		rs = stmt.executeQuery(strSQL);
		rs.next();

		strSQL = "DELETE FROM qna where qna_id ='" + qna_id + "'";
		stmt.executeUpdate(strSQL);

	} //try end

	catch(SQLException e1){
		e1.printStackTrace();
	} // catch SQLException end

	catch(Exception e2){
		e2.printStackTrace();
	} // catch Exception end

	finally{
		if (stmt  != null) stmt.close();
		if (rs    != null) rs.close();
		if (con   != null) con.close();
		response.sendRedirect("./qna_list.jsp?product_id=" + product_id);
	}
%>
