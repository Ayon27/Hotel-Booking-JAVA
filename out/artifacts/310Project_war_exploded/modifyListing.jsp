<%@ page import="com.DB.DatabaseConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%--
  Created by IntelliJ IDEA.
  User: Ayn
  Date: 3/4/2020
  Time: 8:57 AM
  To change this template use File | Settings | File Templates.
--%>
<% response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

    if ((session.getAttribute("name") == null) || (session.getAttribute("id") == null)) {
        response.sendRedirect("login.jsp");
    }
%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% if (request.getParameter("id") == null || request.getParameter("id").equals("")
        || request.getParameter("name") == null || request.getParameter("name").equals("")) {
    response.sendRedirect("mylisting.jsp");
} else {
    String place_id = request.getParameter("id");
    int id = Integer.parseInt(place_id);
    String place_name = request.getParameter("name");
    Connection conn = null;
%>

<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Modify My Listings</title>
    <script src="assets/js/jquery.min.js"></script>
    <script src="assets/bootstrap/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/Contact-Form-Clean.css">
    <link rel="stylesheet" href="assets/css/Highlight-Clean.css">
    <link rel="stylesheet" href="assets/css/Navigation-Clean.css">
    <link rel="stylesheet" href="assets/css/Navigation-with-Button.css">
    <link rel="stylesheet" href="assets/css/styles.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"
            integrity="sha256-T0Vest3yCU7pafRw9r+settMBX6JkKN06dqBnpQ8d30=" crossorigin="anonymous"></script>
    <link rel="stylesheet"
          href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/themes/smoothness/jquery-ui.min.css"/>
</head>
<body>
<%@include file="assets/header.jsp" %>

<div>
    <div class="container">
        <h2 class="text-center" style="margin-top: 30px; margin-bottom: 20px">Update Information of
            <strong><%=place_name%>
            </strong>
        </h2>
        <div class="row">
            <div class="col-md-4"></div>
            <div class="col-md-4">
                <%
                    try {
                        conn = DatabaseConnection.getConnection();
                        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM listing WHERE id = ?");
                        stmt.setInt(1, id);
                        ResultSet result = stmt.executeQuery();
                        if (result.next()) {
                %>
                <p class="text-center text-danger" name="error">${updateError}</p>
                <form method="POST" action="UpdateListing">
                    <div class="form-group">
                        <label style="margin-top: 20px;">
                            <input type="hidden" name="id" value="<%=place_id%>">
                            Change Name:
                        </label><input required name="name" class="form-control" placeholder="" type="text"
                                       pattern="[A-Za-z\s]+" value="<%=result.getString("name")%>">
                    </div>

                    <div class="form-group">
                        <label style="margin-top: 20px;">
                            Number of Bedrooms:
                        </label><input required name="bedroom" class="form-control" placeholder="" type="number"
                                       min="1" value="<%=result.getString("bedrooms")%>">
                    </div>

                    <div class="form-group">
                        <label style="margin-top: 20px;">
                            Number of washrooms:
                        </label>
                        <input required name="washroom" class="form-control" placeholder="" type="number" min="1"
                               value="<%=result.getString("washrooms")%>">
                    </div>

                    <div class="form-group">
                        <label style="margin-top: 20px;">
                            How many guests can stay?
                        </label>
                        <input required name="guests" class="form-control" type="number" min="1"
                               value="<%=result.getString("guests")%>">
                    </div>

                    <div class="form-group">
                        <label style="margin-top: 20px;">
                            Is the entire place for guests?
                        </label>
                        <select name="entirePlace" required class="form-control">
                            <option value="1">Yes</option>
                            <option value="0">No, just a part of it</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label style="margin-top: 20px;">
                            Street Address:
                        </label>
                        <input required name="address" class="form-control" type="text"
                               value="<%=result.getString("address")%>">
                    </div>

                    <div class="form-group">
                        <label style="margin-top: 20px;">
                            Price for one night stay:
                        </label>
                        <input required name="price" class="form-control" type="number" step="0.01" min="0"
                               value="<%=result.getString("price")%>">
                    </div>
                        <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                    }
                %>

            </div>
        </div>
        <div class="form-group">
            <div class="btn-group" role="group"></div>
            <button class="btn btn-primary" type="submit"
                    style="margin-top: 20px; min-width: 120px;min-height: 40px; margin-left: 45%; margin-top: 30px; margin-bottom: 50px;">
                Save
            </button>
        </div>
        </form>
    </div>

    <div class="col-md-4">
    </div>
</div>
<%@include file="assets/footer.jsp" %>
</body>
</html>
