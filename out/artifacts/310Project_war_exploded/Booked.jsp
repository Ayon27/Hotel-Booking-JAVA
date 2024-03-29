<%@ page import="java.sql.Connection" %>
<%@ page import="com.DB.DatabaseConnection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="javax.xml.transform.Result" %><%--
  Created by IntelliJ IDEA.
  User: Ayn
  Date: 3/5/2020
  Time: 6:37 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--
  Created by IntelliJ IDEA.
  User: Ayn
  Date: 3/4/2020
  Time: 4:08 AM
  To change this template use File | Settings | File Templates.
--%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

    if ((session.getAttribute("name") == null) || (session.getAttribute("id") == null)) {
        response.sendRedirect("login.jsp");
    }
    int bookingID = Integer.parseInt(request.getParameter("bookingID"));
%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Booked</title>
    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/Highlight-Clean.css">
    <link rel="stylesheet" href="assets/css/Navigation-with-Button.css">
    <link rel="stylesheet" href="assets/css/styles.css">
</head>

<body style="min-height: 100%">
<div class="container" style="min-height: 100%">
    <%@include  file="assets/header.jsp"%>
<div class="highlight-clean">
    <div class="container" style="margin-top: 100px">
        <div class="intro">

            <%
                int placeID = 0;
                try {
                    Connection conn = DatabaseConnection.getConnection();
                    PreparedStatement stmt = conn.prepareStatement("SELECT * from booking WHERE booking_id =?");
                    stmt.setInt(1, bookingID);
                    ResultSet result = stmt.executeQuery();

                    if (result.next()) {
                        placeID = result.getInt("listing_id");
                        result.beforeFirst();
                    }
                    PreparedStatement stmt1 = conn.prepareStatement("SELECT * from listing WHERE id =?");
                    stmt1.setInt(1, placeID);
                    ResultSet resultFromListing = stmt1.executeQuery();
                    if (resultFromListing.next()) {
            %>
            <h2 class="text-center">Congratulations!</h2>
            <p class="text-center">Your Booking has Been confirmed.</p>
            <p class="text-center">Booking #<%=bookingID%></p>

            <h5 style="margin-top: 70px " class="text-center"><%=resultFromListing.getString("name")%></h5>
            <p class="text-center">Host: <%=resultFromListing.getString("hostName")%></p>

            <p class="text-center"><%=resultFromListing.getString("address")%>
                , <%=resultFromListing.getString("state")%>
                , <%=resultFromListing.getString("country")%></p>
        </div>
    </div>
</div>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
</div>
<script src="assets/js/jquery.min.js"></script>
<script src="assets/bootstrap/js/bootstrap.min.js"></script>
</body>

</html>