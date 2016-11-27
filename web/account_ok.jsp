<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="java.sql.*" %>

<%
    Class.forName("com.mysql.jdbc.Driver");
    String url = "jdbc:mysql://localhost:3306/BoardTest";
    String id = "root";
    String pass = "1234";
    String userId = request.getParameter("userId");
    String userPassword = request.getParameter("userPassword");

    try {
        Connection conn = DriverManager.getConnection(url, id, pass);
        Statement stmt = conn.createStatement();

        String sql = "INSERT INTO member (USERID,USERPASSWORD) VALUES(?,?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setString(1, userId);
        pstmt.setString(2, userPassword);

        pstmt.execute();
        pstmt.close();
        stmt.close();
        conn.close();
    } catch (SQLException e) {
        out.println(e.toString());
    }
%>

<script language=javascript>
    self.window.alert("회원가입이 완료되었습니다.");
    location.href = "login.jsp";
</script>