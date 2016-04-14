<%@ page import="java.sql.*" %>
<%@ page import="com.mongodb.*" %>
<%@ page import="databas.DBConnection" %>
<title>Navetti Sandbox</title>
<html>

<head>

</head>

<body>
<img src="navetti_logo.png" alt="Mountain View" style="width:200px;height:50px;">

<br>
 <style>
  #Table {
    font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
    border-collapse: collapse;
    width: 100%;
  }

  #Table td, #customers th {
    border: 1px solid #ddd;
    text-align: left;
    padding: 8px;
  }

  #Table tr:nth-child(even){background-color: #f2f2f2}

  #Table tr:hover {background-color: #ddd;}

  #Table th {
    padding-top: 5px;
    padding-bottom: 5px;
    background-color: #FF8C00;
    color: white;
  }
  #Table {overflow:hidden; white-space:nowrap}
</style>



<table id="Table">

  <%
    DBConnection test = new DBConnection();
    test.clearMongo();
    ResultSet rs = test.getResultSet();
    test.SQLtoMongo();
    DBCursor cursor = test.getCursor();
  %>

  <tr>
    <%
      for (int i = 1; i <=rs.getMetaData().getColumnCount(); i++)
      {%>
    <th><%=rs.getMetaData().getColumnName(i)%></th>
    <%
      }
    %>

  </tr>
    <tr>


    <%
      while(cursor.hasNext()){
        DBObject doc = cursor.next();
    %>
    <%
      for(int i = 1; i<=rs.getMetaData().getColumnCount();i++)
      { %>
    <td>
      <%= doc.get(rs.getMetaData().getColumnName(i))%>
    </td>
    <%
      }
    %>
  </tr>
  <%
  }
  %>
  <%
    cursor.close();
  %>
</table>
<br/>
<iframe src="https://embed.spotify.com/?uri=spotify%3Auser%3Aqlmhuge%3Aplaylist%3A6Df19VKaShrdWrAnHinwVO" width="300" height="380" frameborder="0" allowtransparency="true"></iframe>

</body>
</html>
