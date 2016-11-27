<%@ page import="java.util.regex.Pattern" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="java.sql.*" %>

<%
    Class.forName("com.mysql.jdbc.Driver");                       // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
    String url = "jdbc:mysql://localhost:3306/BoardTest";        // 사용하려는 데이터베이스명을 포함한 URL 기술
    String id = "root";
    String pass = "1234";

    try {
        String userId = request.getParameter("userId");
        String userPassword = request.getParameter("userPassword");
        String userIdd, userPasswordd;

        Connection conn = DriverManager.getConnection(url, id, pass);
        Statement stmt = conn.createStatement();

        String sql = "SELECT USERID, USERPASSWORD FROM MEMBER WHERE USERID='" + userId + "' AND USERPASSWORD='" + userPassword + "'";
        ResultSet rs = stmt.executeQuery(sql);

        if (rs.next()) {
            userIdd = rs.getString(1);
            userPasswordd = rs.getString(2);
            session.setAttribute("userId", userIdd);                 // 세션에 "id" 이름으로 id 등록
            session.setAttribute("userPassword", userPasswordd);
            response.sendRedirect("list.jsp");               // 로그인 성공 메인페이지 이동
        } else {
%>
<script language=javascript>
    self.window.alert("비밀번호를 틀렸습니다.");
    location.href = "javascript:history.back()";
</script>
<%
        }
    } catch (SQLException e) {
        out.println(e.toString());
    }
%>