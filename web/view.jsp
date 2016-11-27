<%@ page import="java.util.regex.Pattern" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="java.sql.*" %>

<%
    Class.forName("com.mysql.jdbc.Driver");                       // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
    String url = "jdbc:mysql://localhost:3306/BoardTest";        // 사용하려는 데이터베이스명을 포함한 URL 기술
    String id = "root";
    String pass = "1234";
    int idx = Integer.parseInt(request.getParameter("idx"));

    try {

        Connection conn = DriverManager.getConnection(url, id, pass);
        Statement stmt = conn.createStatement();

        String sql = "SELECT USERID, TITLE, MEMO, TIME, HIT FROM board WHERE NUM=" + idx;
        ResultSet rs = stmt.executeQuery(sql);
        if (rs.next()) {
            String name = rs.getString(1);
            String title = rs.getString(2);
            String memo = rs.getString(3);
            String time = rs.getString(4);
            int hit = rs.getInt(5);
            hit++;
%>

<html>
<head>
    <title>게시판</title>
</head>
<body>
<table>
    <tr>
        <td>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr style="background:url('img/table_mid.gif') repeat-x; text-align:center;">
                    <td width="5"><img src="img/table_left.gif" width="5" height="30"/></td>
                    <td>내 용</td>
                    <td width="5"><img src="img/table_right.gif" width="5" height="30"/></td>
                </tr>
            </table>
            <table width="413">
                <tr>
                    <td width="0">&nbsp;</td>
                    <td align="center" width="76">글번호</td>
                    <td width="319"><%=idx%>
                    </td>
                    <td width="0">&nbsp;</td>
                </tr>
                <tr height="1" bgcolor="#dddddd">
                    <td colspan="4" width="407"></td>
                </tr>
                <tr>
                    <td width="0">&nbsp;</td>
                    <td align="center" width="76">조회수</td>
                    <td width="319"><%=hit%>
                    </td>
                    <td width="0">&nbsp;</td>
                </tr>
                <tr height="1" bgcolor="#dddddd">
                    <td colspan="4" width="407"></td>
                </tr>
                <tr>
                    <td width="0">&nbsp;</td>
                    <td align="center" width="76">이름</td>
                    <td width="319"><%=name%>
                    </td>
                    <td width="0">&nbsp;</td>
                </tr>
                <tr height="1" bgcolor="#dddddd">
                    <td colspan="4" width="407"></td>
                </tr>
                <tr>
                    <td width="0">&nbsp;</td>
                    <td align="center" width="76">작성일</td>
                    <td width="319"><%=time%>
                    </td>
                    <td width="0">&nbsp;</td>
                </tr>
                <tr height="1" bgcolor="#dddddd">
                    <td colspan="4" width="407"></td>
                </tr>
                <tr>
                    <td width="0">&nbsp;</td>
                    <td align="center" width="76">제목</td>
                    <td width="319"><%=title%>
                    </td>
                    <td width="0">&nbsp;</td>
                </tr>
                <tr height="1" bgcolor="#dddddd">
                    <td colspan="4" width="407"></td>
                </tr>
                <tr>
                    <td width="0"></td>
                    <td width="399" colspan="2" height="200"><%=memo %>
                </tr>
                <%
                            sql = "UPDATE board SET HIT=" + hit + " where NUM=" + idx;
                            stmt.executeUpdate(sql);
                            rs.close();
                            stmt.close();
                            conn.close();
                        }
                    } catch (SQLException e) {
                    }

                %>
                <tr height="1" bgcolor="#dddddd">
                    <td colspan="4" width="407"></td>
                </tr>
                <tr height="1" bgcolor="#82B5DF">
                    <td colspan="4" width="407"></td>
                </tr>
                <tr align="center">
                    <td width="0">&nbsp;</td>
                    <td colspan="2" width="399">
                        <input type=button value="글쓰기" OnClick="window.location='write.jsp'">
                        <input type=button value="답글" OnClick="window.location='reply.jsp?idx=<%=idx%>'">
                        <input type=button value="목록" OnClick="window.location='list.jsp'">
                        <input type=button value="수정" OnClick="window.location='modify.jsp?idx=<%=idx%>'">
                        <input type=button value="삭제" OnClick="window.location='delete.jsp?idx=<%=idx%>'">
                    <td width="0">&nbsp;</td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</body>

</html>