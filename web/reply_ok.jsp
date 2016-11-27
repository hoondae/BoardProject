<%@ page import="java.util.regex.Pattern" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="java.sql.*" %>

<%
    request.setCharacterEncoding("utf-8");
    Class.forName("com.mysql.jdbc.Driver");                       // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
    String url = "jdbc:mysql://localhost:3306/BoardTest";        // 사용하려는 데이터베이스명을 포함한 URL 기술
    String id = "root";
    String pass = "1234";

    String userId = (String) session.getAttribute("userId");
    String userPassword = (String) session.getAttribute("userPassword");
    String title = request.getParameter("title");
    String memo = request.getParameter("memo");
    int idx = Integer.parseInt(request.getParameter("idx"));

    try {
        int ref = 0;
        int indent = 0;
        int step = 0;

        Connection conn = DriverManager.getConnection(url, id, pass);
        Statement stmt = conn.createStatement();

        String sql = "SELECT REF, INDENT, STEP FROM BOARD WHERE NUM=" + idx;
        ResultSet rs = stmt.executeQuery(sql);

        if (rs.next()) {
            ref = rs.getInt(1);
            indent = rs.getInt(2);
            step = rs.getInt(3);
        }

        sql = "UPDATE BOARD SET STEP=STEP+1 where REF=" + ref + " and STEP>" + step;
        stmt.executeUpdate(sql);

        sql = "INSERT INTO BOARD(USERID, USERPASSWORD, TITLE, MEMO, REF, INDENT, STEP) " +
                "values(?,?,?,?,?,?,?)";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, userId);
        pstmt.setString(2, userPassword);
        pstmt.setString(3, title);
        pstmt.setString(4, memo);
        pstmt.setInt(5, ref);
        pstmt.setInt(6, indent + 1);
        pstmt.setInt(7, step + 1);

        pstmt.execute();
        rs.close();
        stmt.close();
        pstmt.close();
        conn.close();

    } catch (Exception e) {

    }
%>
<script language=javascript>
    self.window.alert("입력한 글을 저장하였습니다.");
    location.href = "list.jsp";
</script>