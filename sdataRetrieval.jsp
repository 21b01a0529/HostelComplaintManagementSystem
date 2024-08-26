<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>

<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Complaints Data Retrieval</title>
</head>
<body>
    <form method="get" action="sdataRetrieval.jsp">
        Registration Number: <input type="text" name="regNo"><br>
        <input type="submit" value="Submit">
    </form>

    <%
    String driver = "com.mysql.jdbc.Driver";
    String url = "jdbc:mysql://localhost:3306/complaintsdb?useSSL=false";
    String username = "root";
    String password = "1234";

    try {
        Class.forName(driver);
        Connection con = DriverManager.getConnection(url, username, password);

        String regNo = request.getParameter("regNo"); // Get the registration number from the user

        String query = "SELECT * FROM complaints WHERE regno = ?";
        PreparedStatement statement = con.prepareStatement(query);
        statement.setString(1, regNo);
        ResultSet resultSet = statement.executeQuery();

        out.println("<style>");
        out.println("table {");
        out.println("    width: 80%;");
        out.println("    margin: 0 auto;"); // Align the table at the center
        out.println("    border-collapse: collapse;");
        out.println("}");
        out.println("th, td {");
        out.println("    border: 1px solid black;");
        out.println("    padding: 8px;");
        out.println("}");
        out.println("</style>");

        out.println("<table>");
        out.println("<tr><th>Name</th><th>Registration Number</th><th>Block</th><th>Room no</th><th>Date</th><th>Complaint</th><th>Status</th></tr>");
        while (resultSet.next()) {
            out.println("<tr>");
            out.println("<td>" + resultSet.getString(1) + "</td>");
            out.println("<td>" + resultSet.getString(2) + "</td>");
            out.println("<td>" + resultSet.getString(3) + "</td>");
            out.println("<td>" + resultSet.getString(4) + "</td>");
            out.println("<td>" + resultSet.getString(5) + "</td>");
            out.println("<td>" + resultSet.getString(6) + "</td>");
            out.println("<td>" + resultSet.getString(7) + "</td>");
            out.println("</tr>");
        }
        out.println("</table>");

        resultSet.close();
        statement.close();
        con.close();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
    %>
</body>
</html>
