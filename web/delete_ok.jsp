<%@ page import="java.util.regex.Pattern" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%
    Class.forName("com.mysql.jdbc.Driver");                       // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
    String url = "jdbc:mysql://localhost:3306/BoardTest";        // 사용하려는 데이터베이스명을 포함한 URL 기술
    String id = "root";
    String pass = "1234";

    int idx = Integer.parseInt(request.getParameter("idx"));
    String userPasswordd = (String) session.getAttribute("userPassword");
    String userPassword;

    try {

        Connection conn = DriverManager.getConnection(url, id, pass);
        Statement stmt = conn.createStatement();

        String sql = "SELECT USERPASSWORD FROM BOARD WHERE NUM=" + idx;
        ResultSet rs = stmt.executeQuery(sql);

        if (rs.next()) {
            userPassword = rs.getString(1);
            if (userPassword.equals(userPasswordd)) {
                sql = "DELETE FROM BOARD WHERE NUM=" + idx;
                stmt.executeUpdate(sql);
%>
<script language=javascript>
    self.window.alert("해당 글을 삭제하였습니다.");
    location.href = "list.jsp";
</script>

<%
    rs.close();
    stmt.close();
    conn.close();
} else {
%>
<script language=javascript>
    self.window.alert("비밀번호를 틀렸습니다.");
    location.href = "javascript:history.back()";
</script>
<%
            }
        }
    } catch (SQLException e) {
        out.println(e.toString());
    }
%>