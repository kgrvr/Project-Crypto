<%-- 
    Document   : history
    Created on : 29 Sep, 2016, 8:45:25 PM
    Author     : kush
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="databaseConnection.MySqlDatabaseConnector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Project Crypto</title>
        <link href='font-style.css' rel='stylesheet' type='text/css'>
        <link href='base.css' rel='stylesheet' type='text/css'>
        <link href='normalize.css' rel='stylesheet' type='text/css'>
        <link href='style.css' rel='stylesheet' type='text/css'>
        <script lang="text/javascript">
            function getParameterByName(name, url) {
                if (!url)
                    url = window.location.href;
                name = name.replace(/[\[\]]/g, "\\$&");
                var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
                        results = regex.exec(url);
                if (!results)
                    return null;
                if (!results[2])
                    return '';
                return decodeURIComponent(results[2].replace(/\+/g, " "));
            }
            function onload() {
                var userId = document.getElementById("userId");
                var id = getParameterByName('userId');
                if(id != null)  userId.setAttribute("value", id);
            }
        </script>
    </head>
    <body onload="onload()">

        <div align = "center" class="top" >
            <img src="orange-key-512.png" width="30" height="30" alt="icon"/>&nbsp;&nbsp;&nbsp;&nbsp;<h1 class="heading"><a href="index.html"><b>Project Crypto</b></a></h1>

            <list class="headingList">
            <ul class="horizontal-list" style="padding-left: 0px; color: #fff">
                <li><a class="link" href="/Crypto">Home</a></li>&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;
                <li><a class="link" href="history.jsp">History</a></li>&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;
                <li><a class="link" href="CryptoIntro.html">Cryptography</a></li>&nbsp;&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;
                <li><a class="link" href="AboutProject.html">About Project</a></li>
            </ul>
            </list>

        </div>
        <div class="form" >

            <h1 id="header">History</h1>

            <form action="history.jsp" method="get">
                <div class="field-wrap">
                    <label>
                        ID<span class="req">*</span>
                    </label>
                    <input type="email" id="userId" name="userId" required autocomplete="off"/>
                </div>
                <center><button type="submit"  name="act" value="check" class="checkButton">Check</button></center>
            </form>

            <br/><br/>
            
                <%
                        MySqlDatabaseConnector sql = new MySqlDatabaseConnector("jdbc:mysql://localhost:3306/", "crypto", "root", "shiv1994kush");
                        String userId = request.getParameter("userId");
                        int eCount = sql.getTupleCount(userId, "e");
                        request.setAttribute("eCount", eCount);
                        int dCount = sql.getTupleCount(userId, "d");
                        request.setAttribute("dCount", dCount);
                %>
                
                <c:if test="${eCount ne 0}">
                
            <table width="100%" class="htable" >
                <caption style="font-size: 20px"><b>Encryption</b></caption>
                <th class="hth">Text</th>
                <th class="hth">Technique</th>
                <th class="hth">Converted Text</th>
                    <%
                        try {
                            ResultSet r = sql.getAllEncryptionTuples(userId);
                            while (r.next()) {
                    %>
                <tr class="htr">
                    <td class="htd">
                        <%=r.getString(3)%>
                    </td>
                    <td class="htd">
                        <%=(r.getString(4)).equals("c") ? "Caesar Cipher" : ((r.getString(4)).equals("v") ? "Vernam Cipher" : (r.getString(4)).equals("h") ? "Hill Cipher" : (r.getString(4)).equals("p") ? "PlayFair Cipher" : "")%>
                    </td>
                    <td class="htd">
                        <%=r.getString(5)%>
                    </td>
                </tr>
                <%
                            System.out.println(r.getString(1) + " " + r.getString(2) + " " + r.getString(3) + " " + r.getString(4) + " " + r.getString(5));
                        }
                    } catch (Exception e) {
                        System.err.println(e);
                    }
                %>

            </table>
                </c:if>
            <br/>
            
            <c:if test="${dCount ne 0}">
            <table width="100%" class="htable">
                <caption style="font-size: 20px"><b>Decryption</b></caption>
                <th class="hth">Text</th>
                <th class="hth">Technique</th>
                <th class="hth">Converted Text</th>
                    <%
                        try {
                            ResultSet r = sql.getAllDecryptionTuples(userId);
                            while (r.next()) {
                    %>
                <tr class="htr">
                    <td class="htd">
                        <%=r.getString(3)%>
                    </td>
                    <td class="htd">
                        <%=(r.getString(4)).equals("c") ? "Caesar Cipher" : ((r.getString(4)).equals("v") ? "Vernam Cipher" : (r.getString(4)).equals("h") ? "Hill Cipher" : (r.getString(4)).equals("p") ? "PlayFair Cipher" : "")%>
                    </td>
                    <td class="htd">
                        <%=r.getString(5)%>
                    </td>
                </tr>
                <%
                            System.out.println(r.getString(1) + " " + r.getString(2) + " " + r.getString(3) + " " + r.getString(4) + " " + r.getString(5));
                        }
                    } catch (Exception e) {
                        System.err.println(e);
                    }
                %>

            </table>
                </c:if>
        </div> <!-- /form -->
        <script src='jquery.min.js'></script>
        <script src='index.js'></script>
    </body>
</html>
