<%@ page import="java.util.regex.Pattern" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@ page import="java.sql.*" %>

<script language="javascript">  // 자바 스크립트 시작
function modifyCheck() {
    var form = document.modifyform;
    if (form.userPassword.value == "") {
        alert("비밀번호를 적어주세요");
        form.password.focus();
        return;
    }
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

    String userId = "";
    String userPassword = "";
    String title = "";
    String memo = "";

    int idx = Integer.parseInt(request.getParameter("idx"));

    try {
        Connection conn = DriverManager.getConnection(url, id, pass);
        Statement stmt = conn.createStatement();

        String sql = "SELECT USERID, USERPASSWORD, TITLE, MEMO FROM BOARD WHERE NUM=" + idx;
        ResultSet rs = stmt.executeQuery(sql);

        if (rs.next()) {
            userId = rs.getString(1);
            userPassword = rs.getString(2);
            title = rs.getString(3);
            memo = rs.getString(4);
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
    <form name=modifyform method=post action="modify_ok.jsp?idx=<%=idx%>">
        <tr>
            <td>&nbsp;</td>
            <td align="center">제목</td>
            <td><input type=text name=title size=50 maxlength=50 value="<%=title%>"></td>
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
            <td><input type=password name="userPassword" id="pass" size=50 maxlength=50></td>
            <td>&nbsp;</td>
        </tr>
        <tr height="1" bgcolor="#dddddd">
            <td colspan="4"></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td align="center">내용</td>
            <td><textarea name=memo cols=50 rows=13><%=memo%></textarea></td>
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
                <input type=button value="수정" OnClick="javascript:modifyCheck();">
                <input type=button value="취소" OnClick="javascript:history.back(-1)">
            <td>&nbsp;</td>
        </tr>
    </form>
</table>
</body>
</html>