<%@ page import="java.util.regex.Pattern" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="java.sql.*" %>

<%
    session.invalidate();
%>

<script>
    alert('로그아웃 되었습니다.');
    location.href = "login.jsp";
</script>