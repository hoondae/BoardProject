<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="java.sql.*,java.text.SimpleDateFormat,java.util.Date" %>

<html>
<head>
    <title>게시판</title>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");
    Class.forName("com.mysql.jdbc.Driver");
    String url = "jdbc:mysql://localhost:3306/BoardTest?useUnicode=true&characterEncoding=utf8";
    String id = "root";
    String pass = "1234";
    int total = 0;

    try {
        Connection conn = DriverManager.getConnection(url, id, pass);
        Statement stmt = conn.createStatement();

        String sqlCount = "SELECT COUNT(*) FROM board";
        ResultSet rs = stmt.executeQuery(sqlCount);

        if (rs.next()) {
            total = rs.getInt(1);
        }
        rs.close();
        out.print("총 게시물 : " + total + "개");
        String sqlList = "SELECT NUM, USERID, TITLE, TIME, HIT, INDENT from board order by REF DESC, TIME ASC";
        rs = stmt.executeQuery(sqlList);
%>

<table width="100%" cellpadding="0" cellspacing="0" border="0">
    <tr height="5">
        <td width="5"></td>
    </tr>
    <tr style="background:url('img/table_mid.gif') repeat-x; text-align:center;">
        <td width="5"><img src="img/table_left.gif" width="5" height="30"/></td>
        <td width="73">번호</td>
        <td width="379">제목</td>
        <td width="73">작성자</td>
        <td width="164">작성일</td>
        <td width="58">조회수</td>
        <td width="7"><img src="img/table_right.gif" width="5" height="30"/></td>
    </tr>
    <%
        if (total == 0) {
    %>

    <tr align="center" bgcolor="#FFFFFF" height="30">
        <td colspan="6">등록된 글이 없습니다.</td>
    </tr>

    <%
    } else {

        while (rs.next()) {
            int idx = rs.getInt(1);
            String name = rs.getString(2);
            String title = rs.getString(3);
            String time = rs.getString(4);
            int hit = rs.getInt(5);
            int indent = rs.getInt(6);

            Date date = new Date();
            SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
            String year = (String) simpleDate.format(date);
            String yea = time.substring(0, 10);
    %>

    <tr height="25" align="center">
        <td>&nbsp;</td>
        <td><%=idx %>
        </td>
        <td align="left">
            <%

                for (int j = 0; j < indent; j++) {
            %>        &nbsp;&nbsp;&nbsp;<%
            }
            if (indent != 0) {
        %> <img src='img/reply_icon.gif'/>
            <%
                }
            %>
            <a href="view.jsp?idx=<%=idx%>"><%=title %>
        <%
            if (year.equals(yea)) {
        %>
        <img src='img/new.jpg'/>
        <%
            }
        %>
        </td>
        <td align="center"><%=name %>
        </td>
        <td align="center"><%=time %>
        </td>
        <td align="center"><%=hit %>
        </td>
        <td>&nbsp;</td>
    </tr>
    <tr height="1" bgcolor="#D2D2D2">
        <td colspan="6"></td>
    </tr>
    <%
                }
            }
            rs.close();
            stmt.close();
            conn.close();
        } catch (SQLException e) {
            out.println(e.toString());
        }
    %>
    <tr height="1" bgcolor="#82B5DF">
        <td colspan="6" width="752"></td>
    </tr>
</table>

<table width="100%" cellpadding="0" cellspacing="0" border="0">
    <tr>
        <td colspan="4" height="5"></td>
    </tr>
    <tr align="center">
        <td>&nbsp;</td>
        <td colspan="2">
            <input type=button value="글쓰기" OnClick="window.location='write.jsp'">
            <input type=button value="로그아웃" OnClick="window.location='logout.jsp'">
        <td>&nbsp;</td>
    </tr>
</table>
</body>
</html>