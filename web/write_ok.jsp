<%@page import="java.util.regex.Pattern" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@page import="java.sql.*" %>
<%
    request.setCharacterEncoding("utf-8");
    Class.forName("com.mysql.jdbc.Driver");                       // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
    String url = "jdbc:mysql://localhost:3306/BoardTest?useUnicode=true&characterEncoding=utf8";        // 사용하려는 데이터베이스명을 포함한 URL 기술
    String id = "root";
    String pass = "1234";

    String userId = (String) session.getAttribute("userId");
    String userPassword = (String) session.getAttribute("userPassword");
    String title = request.getParameter("title");
    String memo = request.getParameter("memo");

    int max = 0;

    try {
        Connection conn = DriverManager.getConnection(url, id, pass);
        Statement stmt = conn.createStatement();

        String sql = "SELECT MAX(NUM) FROM board";
        ResultSet rs = stmt.executeQuery(sql);

        if (rs.next()) {
            max = rs.getInt(1);
        }

        sql = "INSERT INTO board(USERID,USERPASSWORD,TITLE,MEMO,REF) VALUES(?,?,?,?,?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setString(1, userId);
        pstmt.setString(2, userPassword);
        pstmt.setString(3, title);
        pstmt.setString(4, memo);
        pstmt.setInt(5, max + 1);

        pstmt.execute();
        pstmt.close();
        stmt.close();
        conn.close();
    } catch (SQLException e) {
        out.println(e.toString());
    }
%>
<script language=javascript>
    self.window.alert("입력한 글을 저장하였습니다.");
    location.href = "list.jsp";
</script>