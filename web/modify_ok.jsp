<%@ page import="java.util.regex.Pattern" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8" session="true" %>
<%@ page import="java.sql.*" %>

<%
        request.setCharacterEncoding("utf-8");
        Class.forName("com.mysql.jdbc.Driver");                       // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
        String url = "jdbc:mysql://localhost:3306/BoardTest";        // 사용하려는 데이터베이스명을 포함한 URL 기술
        String id = "root";
        String pass = "1234";

        try{
            int idx = Integer.parseInt(request.getParameter("idx"));
            String title = request.getParameter("title");
            String memo = request.getParameter("memo");
            String userIdd = (String) session.getAttribute("userId");
            String userPasswordd = request.getParameter("userPassword");
            String userId, userPassword;

            Connection conn = DriverManager.getConnection(url,id,pass);
            Statement stmt = conn.createStatement();

            String sql = "SELECT USERID, USERPASSWORD FROM BOARD WHERE NUM=" + idx;
            ResultSet rs = stmt.executeQuery(sql);

            if(rs.next()){
                userId = rs.getString(1);
                userPassword = rs.getString(2);
                if(userId.equals(userIdd)){
                    if(userPassword.equals(userPasswordd)) {
                        sql = "UPDATE BOARD SET TITLE='" + title+ "' ,MEMO='"+ memo +"' WHERE NUM=" + idx;
                        stmt.executeUpdate(sql);
%>

<script language=javascript>
    self.window.alert("글이 수정되었습니다.");
    location.href="view.jsp?idx=<%=idx%>";
</script>

<%
            rs.close();
            stmt.close();
            conn.close();
                } else {
%>
<script language=javascript>
    self.window.alert("비밀번호를 틀렸습니다.");
    location.href="javascript:history.back()";
</script>
<%
                }
            }else {
                    %>
<script language=javascript>
    self.window.alert("해당 게시글의 작성자가 아닙니다.");
    location.href="javascript:history.back()";
</script>
<%
                }
        }
    } catch(SQLException e) {
        out.println( e.toString() );
    }
%>