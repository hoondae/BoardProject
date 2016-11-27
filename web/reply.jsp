<%@ page import="java.util.regex.Pattern" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="java.sql.*" %>

<script language="javascript">  // 자바 스크립트 시작
function replyCheck() {
    var form = document.replyform;
    if (form.title.value == "") {
        alert("제목을 적어주세요");
        form.title.focus();
        return;
    }
    if (form.memo.value == "") {
        alert("내용을 적어주세요");
        form.memo.focus();
        return;
    }
    form.submit();
}
</script>

<%
    Class.forName("com.mysql.jdbc.Driver");                       // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
    String url = "jdbc:mysql://localhost:3306/BoardTest";        // 사용하려는 데이터베이스명을 포함한 URL 기술
    String id = "root";
    String pass = "1234";
    String title = "";

    String userId = (String) session.getAttribute("userId");
    String userPassword = (String) session.getAttribute("userPassword");
    int idx = Integer.parseInt(request.getParameter("idx"));

    try {
        Connection conn = DriverManager.getConnection(url, id, pass);
        Statement stmt = conn.createStatement();

        String sql = "SELECT TITLE FROM board WHERE NUM=" + idx;
        ResultSet rs = stmt.executeQuery(sql);

        if (rs.next()) {
            title = rs.getString(1);
        }

        rs.close();
        stmt.close();
        conn.close();

    } catch (SQLException e) {
        out.println(e.toString());
    }
%>

<html>
<head>
    <title>게시판</title>
</head>
<body>
<table>
    <form name=replyform method=post action="reply_ok.jsp?idx=<%=idx%>">
        <tr>
            <td>
                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                    <tr style="background:url('img/table_mid.gif') repeat-x; text-align:center;">
                        <td width="5"><img src="img/table_left.gif" width="5" height="30"/></td>
                        <td>답글</td>
                        <td width="5"><img src="img/table_right.gif" width="5" height="30"/></td>
                    </tr>
                </table>
                <table>
                    <tr>
                        <td>&nbsp;</td>
                        <td align="center">제목</td>
                        <td><input name="title" size="50" maxlength="100" value="<%=title%>"></td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr height="1" bgcolor="#dddddd">
                        <td colspan="4"></td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td align="center">이름</td>
                        <td><%=userId%><input type=hidden name=userId size=50 maxlength=50 value="<%=userId%>"></td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr height="1" bgcolor="#dddddd">
                        <td colspan="4"></td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td align="center">비밀번호</td>
                        <td><%=userPassword%><input type=hidden type="password" name="userPassword" size="50"
                                                    maxlength="50" value="<%=userPassword%>"></td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr height="1" bgcolor="#dddddd">
                        <td colspan="4"></td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td align="center">내용</td>
                        <td><textarea name="memo" cols="50" rows="13"></textarea></td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr height="1" bgcolor="#dddddd">
                        <td colspan="4"></td>
                    </tr>
                    <tr height="1" bgcolor="#82B5DF">
                        <td colspan="4"></td>
                    </tr>
                    <tr align="center">
                        <td>&nbsp;</td>
                        <td colspan="2">
                            <input type=button value="등록" OnClick="javascript:replyCheck();">
                            <input type=button value="취소" OnClick="javascript:history.back(-1)">
                        <td>&nbsp;</td>
                    </tr>
                </table>
            </td>
        </tr>
</table>
</body>