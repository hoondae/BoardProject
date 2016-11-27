<%@page import="java.util.regex.Pattern" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@page import="java.sql.*" %>

<script language="javascript"> // 자바 스크립트 시작
function writeCheck() {
    var form = document.writeform;
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
    Class.forName("com.mysql.jdbc.Driver");
    String url = "jdbc:mysql://localhost:3306/BoardTest?useUnicode=true&characterEncoding=utf8";
    String id = "root";
    String pass = "1234";

    String userId = (String) session.getAttribute("userId");
    String userPassword = (String) session.getAttribute("userPassword");

    try {
        Connection conn = DriverManager.getConnection(url, id, pass);
        Statement stmt = conn.createStatement();

        String sql = "SELECT USERID, USERPASSWORD FROM MEMBER WHERE USERID='" + userId + "' AND USERPASSWORD='" + userPassword + "'";
        ResultSet rs = stmt.executeQuery(sql);

        if (rs.next()) {
            userId = rs.getString(1);
            userPassword = rs.getString(2);
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
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>게시판</title>
</head>
<body>
<table>
    <form name=writeform method=post action="write_ok.jsp">
        <tr>
            <td>
                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                    <tr style="background:url('img/table_mid.gif') repeat-x; text-align:center;">
                        <td width="5"><img src="img/table_left.gif" width="5" height="30"/></td>
                        <td>글쓰기</td>
                        <td width="5"><img src="img/table_right.gif" width="5" height="30"/></td>
                    </tr>
                </table>
                <table>
                    <tr>
                        <td>&nbsp;</td>
                        <td align="center">제목</td>
                        <td><input name="title" size="50" maxlength="100"></td>
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
                            <input type=button value="등록" OnClick="javascript:writeCheck();">
                            <input type=button value="취소" OnClick="javascript:history.back(-1)">
                        <td>&nbsp;</td>
                    </tr>
                </table>
            </td>
        </tr>
    </form>
</table>
</body>
</html>