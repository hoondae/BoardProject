<%@page import="java.util.regex.Pattern" %>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<%@page import="java.sql.*" %>

<script language="javascript"> // 자바 스크립트 시작
function loginCheck() {
    var form = document.loginform;

    if (form.userId.value == '') {
        alert("아이디을 적어주세요");
        form.userId.focus();
        return;
    }
    if (form.userPassword.value == "") {
        alert("비밀번호를 적어주세요");
        form.userPassword.focus();
        return;
    }
    form.submit();
}

function checkEnter(e) {
    if (e.which == 13) {
        loginCheck();
    }
}

</script>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>로그인하기</title>
</head>

<body>
<table>
    <form name=loginform method=post action="login_ok.jsp">
        <tr>
            <td>
                <table width="100%" cellpadding="0" cellspacing="0" border="0">
                    <tr style="background:url('img/table_mid.gif') repeat-x; text-align:center;">
                        <td width="5"><img src="img/table_left.gif" width="5" height="30"/></td>
                        <td width="411">로그인하기</td>
                        <td width="5"><img src="img/table_right.gif" width="5" height="30"/></td>
                    </tr>
                </table>
                <table>
                    <tr height="1" bgcolor="#dddddd">
                        <td colspan="4"></td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td align="center">아이디</td>
                        <td><input name="userId" size="50" maxlength="50"></td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr height="1" bgcolor="#dddddd">
                        <td colspan="4"></td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td align="center">비밀번호</td>
                        <td><input type="password" name="userPassword" size="50" maxlength="50"
                                   onkeypress="javascript:checkEnter(event);"></td>
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
                            <input type=button value="로그인" OnClick="javascript:loginCheck();">
                            <input type=button value="회원가입" OnClick="window.location='account.jsp'">
                        <td>&nbsp;</td>
                    </tr>
                </table>
            </td>
        </tr>
    </form>
</table>
</body>
</html>
