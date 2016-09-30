<%-- 
    Document   : GenerateCipher
    Created on : 19 Sep, 2016, 10:35:00 PM
    Author     : kush
--%>

<%@page import="databaseConnection.MySqlDatabaseConnector"%>
<%@page import="substitutionCipherScheme.VernamCipher"%>
<%@page import="transpositionCipherScheme.HillCipher"%>
<%@page import="substitutionCipherScheme.CaesarCipher"%>
<%@page import="transpositionCipherScheme.PlayFairCipher"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Project Crypto</title>
        <link href='base.css' rel='stylesheet' type='text/css'>
        <link href='normalize.css' rel='stylesheet' type='text/css'>
        <link href='style.css' rel='stylesheet' type='text/css'>
        <link href='http://fonts.googleapis.com/css?family=Titillium+Web:400,300,600' rel='stylesheet' type='text/css'>
        <script type="text/javascript">
            function show() {
                var p = document.getElementById('plainText');
                p.setAttribute('type', 'text');
            }

            function hide() {
                var p = document.getElementById('plainText');
                p.setAttribute('type', 'password');
            }

            var pwShown = 0;

            function showHide() {
                if (pwShown == 0) {
                    pwShown = 1;
                    show();
                } else {
                    pwShown = 0;
                    hide();
                }
            }
        </script>
    </head>
    <body class="body">
        <div align = "center" class="top" >
            <img src="orange-key-512.png" width="30" height="30" alt="icon"/>&nbsp;&nbsp;&nbsp;&nbsp;<h1 class="heading"><a href="index.html"><b>Project Crypto</b></a></h1>

            <list class="headingList">
            <ul class="horizontal-list" style="padding-left: 0px;">
                <li><a class="link" href="index.html">Home</a></li>&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;
                <li><a class="link" href="CryptoIntro.html">Cryptography</a></li>&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;
                <li><a class="link" href="history.jsp">History</a></li>&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;
                <li><a class="link" href="AboutProject.html">About Project</a></li>
            </ul>
            </list>

        </div>
        <div class="form">

            <p class="headingList">

                <%
                    String result = "", msg = "", t = "", key = null;
                    char type;
                    String button = request.getParameter("act");
                    if (button == null) {
                    } else if (button.equals("encrypt")) {
                        type = request.getParameter("encryption-type").charAt(0);
                        String plainText = request.getParameter("plainText");
                        t = "Cipher Text: ";
                        switch (type) {
                            case 'c':
                                key = request.getParameter("keyText");
                                CaesarCipher caesarCipher = new CaesarCipher();
                                try {
                                    result = caesarCipher.encrypt(plainText.toLowerCase().replace(" ", ""), Integer.parseInt(key)).toUpperCase();
                                } catch (Exception e) {
                                    msg = "Error: " + e.toString();
                                }
                                break;
                            case 'v':
                                key = request.getParameter("keyText");
                                VernamCipher vernamCipher = new VernamCipher();
                                try {
                                    result = vernamCipher.encrypt(plainText.toLowerCase().replace(" ", ""), key.toLowerCase().replace(" ", "")).toUpperCase();
                                } catch (Exception e) {
                                    msg = "Error: " + e.toString();
                                }
                                break;
                            case 'p':
                                key = request.getParameter("keyText");
                                PlayFairCipher playfairCipher = new PlayFairCipher();
                                try {
                                    result = playfairCipher.encrypt(plainText.toLowerCase().replace(" ", ""), key.toLowerCase().replace(" ", "")).toUpperCase();
                                } catch (Exception e) {
                                    msg = "Error: " + e.toString();
                                }
                                break;
                            case 'h':
                                int[][] keyMatrix = new int[3][3];
                                String choice = request.getParameter("autoGenKey");
                                HillCipher hillCipher = new HillCipher();
                                try {
                                    if (choice == null) {
                                        for (int i = 0; i < 3; i++) {
                                            for (int j = 0; j < 3; j++) {
                                                keyMatrix[i][j] = Integer.parseInt(request.getParameter("matrix[" + i + "][" + j + "]"));

                                            }
                                        }
                                        if(!hillCipher.checkMatrixModularInverse(keyMatrix))
                                            msg = "Error: Key Matrix provided has a modular inverse of 0.";
                                    }
                                    if(msg != null)
                                        result = hillCipher.encrypt(plainText.toLowerCase().replace(" ", ""), keyMatrix, (choice == null ? false : true)).toUpperCase();
                                        
                                } catch (Exception e) {
                                    msg = "Error: " + (e.toString().equals("transpositionCipherScheme.MatrixModularInverseIsZeroException: Key Matrix provided has a modular inverse of 0.") ? "Key Matrix provided has a modular inverse of 0." : e.toString());
                                }

                                if (choice != null) {
                                    keyMatrix = hillCipher.getKeyMatrix();
                                }
                                for (int i = 0; i < 3; i++) {
                                    for (int j = 0; j < 3; j++) {
                                        pageContext.setAttribute("keyMatrix" + i + j, keyMatrix[i][j]);
                                    }
                                }
                                break;
                            default:
                                msg = "Error: Invalid Encryption Technique";
                        }
                        pageContext.setAttribute("type", type);
                    } else if (button.equals("decrypt")) {

                        type = request.getParameter("decryption-type").charAt(0);
                        String plainText = request.getParameter("cipherText");
                        t = "Plain Text: ";
                        switch (type) {
                            case 'c':
                                key = request.getParameter("decKeyTextInput");
                                CaesarCipher caesarCipher = new CaesarCipher();
                                try {
                                    result = caesarCipher.decrypt(plainText.toLowerCase().replace(" ", ""), Integer.parseInt(key)).toUpperCase();
                                } catch (Exception e) {
                                    msg = "Error: " + e.toString();
                                }
                                break;
                            case 'v':
                                key = request.getParameter("decKeyTextInput");
                                VernamCipher vernamCipher = new VernamCipher();
                                try {
                                    result = vernamCipher.decrypt(plainText.toLowerCase().replace(" ", ""), key.toLowerCase().replace(" ", "")).toUpperCase();
                                } catch (Exception e) {
                                    msg = "Error: " + e.toString();
                                }
                                break;
                            case 'p':
                                key = request.getParameter("decKeyTextInput");
                                PlayFairCipher playfairCipher = new PlayFairCipher();
                                try {
                                    result = playfairCipher.decrypt(plainText.toLowerCase().replace(" ", ""), key.toLowerCase().replace(" ", "")).toUpperCase();
                                } catch (Exception e) {
                                    msg = "Error: " + e.toString();
                                }
                                break;
                            case 'h':
                                int[][] keyMatrix = new int[3][3];
                                HillCipher hillCipher = new HillCipher();
                                try {
                                    for (int i = 0; i < 3; i++) {
                                        System.out.println();
                                        for (int j = 0; j < 3; j++) {
                                            keyMatrix[i][j] = Integer.parseInt(request.getParameter("matrix[" + i + "][" + j + "]"));
                                        }
                                    }
                                    result = hillCipher.decrypt(plainText.toLowerCase().replace(" ", ""), keyMatrix).toUpperCase();
                                } catch (RuntimeException e) {
                                    msg = "Error: Provided Key Matrix is Singular. Cannot Decrypt!";
                                } catch (Exception e) {
                                    msg = "Error: " + e.toString();
                                }

                                for (int i = 0; i < 3; i++) {
                                    for (int j = 0; j < 3; j++) {
                                        pageContext.setAttribute("keyMatrix" + i + j, keyMatrix[i][j]);
                                    }
                                }
                                break;
                            default:
                                msg = "Error: Invalid Decryption Technique";
                        }
                        pageContext.setAttribute("type", type);
                    } else {
                    }
                %>
                <%=t%>
            <div class="field-wrap">
                <input type="text" disabled="true" style="color: white;" value="<%=result%>"/>
                <%
                    MySqlDatabaseConnector sql;
                    if(msg == "") {
                        sql = new MySqlDatabaseConnector("jdbc:mysql://localhost:3306/", "crypto", "root", "shiv1994kush");
                        try {
                            button = "" + request.getParameter("act").charAt(0);
                            String tech, cp;
                            if(button.equals("e")) {
                                tech = request.getParameter("encryption-type").charAt(0) + "";
                                cp = request.getParameter("plainText");
                            }
                            else {
                                tech = request.getParameter("decryption-type").charAt(0) + "";
                                cp = request.getParameter("cipherText");
                            }
                            sql.insert(request.getParameter("userId"), button, cp, tech, result);
                        } catch(Exception e) {
                            System.err.println(e);
                        }
                    }
                %>
            </div>
            Key used:<br/><br/>

            <div class="top-row">
                <div class="field-wrap" style="width: 87%;">

                    <c:choose>
                        <c:when test="${type != 'h'}">
                            <input type="password" disabled="true" id="plainText" name="plainText"  value="<%=key%>"/>
                        </div>
                        <button type="button" style="background: transparent; border: transparent; float: right;" onclick="showHide()" id="eye">
                            <img src="eye-3-xxl.png" width="30" height="30" alt="eye"/>
                        </button>
                    </c:when>
                    <c:otherwise>
                        <table>
                            <tr>
                                <td><input type="number" disabled="true" name="matrix[0][0]" style="text-align: center" value="<c:out value="${keyMatrix00}"/>" /> </td>
                                <td><input type="number" disabled="true" name="matrix[0][1]" style="text-align: center" value="<c:out value="${keyMatrix01}"/>" /> </td>
                                <td><input type="number" disabled="true" name="matrix[0][2]" style="text-align: center" value="<c:out value="${keyMatrix02}"/>" /> </td>
                            </tr>
                            <tr>
                                <td><input type="number" disabled="true" name="matrix[1][0]" style="text-align: center" value="<c:out value="${keyMatrix10}"/>" /> </td>
                                <td><input type="number" disabled="true" name="matrix[1][1]" style="text-align: center" value="<c:out value="${keyMatrix11}"/>" /> </td>
                                <td><input type="number" disabled="true" name="matrix[1][2]" style="text-align: center" value="<c:out value="${keyMatrix12}"/>" /> </td>
                            </tr>
                            <tr>
                                <td><input type="number" disabled="true" name="matrix[2][0]" style="text-align: center" value="<c:out value="${keyMatrix20}"/>" /> </td>
                                <td><input type="number" disabled="true" name="matrix[2][1]" style="text-align: center" value="<c:out value="${keyMatrix21}"/>" /> </td>
                                <td><input type="number" disabled="true" name="matrix[2][2]" style="text-align: center" value="<c:out value="${keyMatrix22}"/>" /> </td>
                            </tr>
                        </table>
                    </c:otherwise>
                </c:choose>

            </div>


            <div style="width: 100%">
            <font color="red"><%=msg%></font>
            </div>
        </p>
    </div>
</body>
</html>
