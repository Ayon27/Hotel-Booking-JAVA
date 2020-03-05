<%@ page import="java.sql.Connection" %>
<%@ page import="com.DB.DatabaseConnection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: Ayn
  Date: 3/5/2020
  Time: 9:19 PM
  To change this template use File | Settings | File Templates.
--%>
<%
    if (session.getAttribute("name") == null) {
        response.sendRedirect("login.jsp");
    }
    Connection conn = null;
%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Profile</title>

    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
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
<body style="background-color: #EEF4F7;">
<div>
    <nav class="navbar navbar-light navbar-expand-md navigation-clean">
        <div class="container">
            <button data-toggle="collapse" class="navbar-toggler" data-target="#navcol-1"><span
                    class="sr-only">Toggle navigation</span><span class="navbar-toggler-icon"></span></button>
            <div class="collapse navbar-collapse" id="navcol-1">
                <ul class="nav navbar-nav ml-auto">
                    <li class="nav-item" role="presentation"><a class="nav-link" href="index.jsp">Home</a></li>

                    <li class="dropdown nav-item"><a class="dropdown-toggle nav-link" data-toggle="dropdown"
                                                     aria-expanded="false" href="#">Become a Host</a>
                        <div class="dropdown-menu" role="menu"><a class="dropdown-item" role="presentation"
                                                                  href="host.jsp">Host a place</a>
                            <a class="dropdown-item" role="presentation"
                               href="mylisting.jsp">My Listings</a>
                    </li>

                    <li class="nav-item" role="presentation"></li>
                    <li class="dropdown nav-item"><a class="dropdown-toggle nav-link" data-toggle="dropdown"
                                                     aria-expanded="false"
                                                     href="#"><% out.print(session.getAttribute("name")); %></a>
                        <div class="dropdown-menu" role="menu"><a class="dropdown-item" role="presentation"
                                                                  href="profile.jsp">Profile</a>
                            <a class="dropdown-item"
                               role="presentation"
                               href="logout.jsp">Log
                                out</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</div>

<div class="team-boxed" style="background-color: #EEF4F7; ">
    <%
        String s = (String) session.getAttribute("id");

        try {
            int currentUser = 0;
            try {
                currentUser = Integer.parseInt(s);
                conn = DatabaseConnection.getConnection();
            } catch (NumberFormatException n) {
                response.getWriter().print("yy");
            }
            PreparedStatement stmt = conn.prepareStatement("SELECT * from user where id = ?");
            stmt.setInt(1, currentUser);
            ResultSet result = stmt.executeQuery();
            if (result.next()) {
    %>
    <div class="container">
        <div class="row">
            <div class="col-md-6 col-lg-4 item"
                 style="background-color: white; margin-top: 70px; border: 1px solid white; border-radius: 5px; box-shadow: 0 0 2px #9f9f9f; max-height: 430px">
                <div class="box" style="margin-top: 15px"><img class="rounded-circle" src="assets/cnh.png"
                                                               style="width: 200px; margin-left: 20%; margin-top: 10px; margin-bottom: 15px">
                    <h3 class="name" style="text-align: center"><%=result.getString("name")%>
                    </h3>
                    <p class="title" style="text-align: center"><%=result.getString("email")%>
                    </p>
                    <div>
                        <p class="title" style=" text-align: center"><i style="margin-right: 10px; font-size: 20px;"
                                                                        class="material-icons">local_phone</i><%=result.getString("phone")%>
                        </p>
                    </div>
                    <p class="description" style="text-align: center"><i class="material-icons">location_on</i>
                        <%=result.getString("address") + ", " + result.getString("state") + ", " + result.getString("country")%>
                    </p>
                    <%
                        }
                    %>
                </div>
            </div>

            <div class="col-md-6 col-lg-4 item"></div>
            <div class="col-md-6 col-lg-4 item" style="margin-top: 60px; max-height:100vh; overflow-y: auto;">
                <h4 class="text-secondary text-center">Your Booking History Will Appear Here</h4>
                <%
                    PreparedStatement stmtForHistory = conn.prepareStatement("SELECT booking.listing_id, booking.booking_id, booking.check_in, " +
                            "booking.check_out, listing.name," +
                            " listing.hostName, listing.address, listing.state, listing.country " +
                            "from listing " +
                            "INNER JOIN booking on booking.listing_id = listing.id " +
                            "WHERE booking.user_id = ?;");
                    stmtForHistory.setInt(1, currentUser);
                    ResultSet historyResult = stmtForHistory.executeQuery();
                    while (historyResult.next()) {
                %>
                <a href="confirmBooking.jsp?placeID=<%=historyResult.getString("listing_id")%>"
                   style="text-decoration: none; color: black;">
                    <div class="card" style="margin-bottom: 30px; margin-top: 15px; max-height: 300px;">
                        <div class="card-body">
                            <h4 class="card-title text-center"><%=historyResult.getString("name")%>
                            </h4>
                            <h6 class="text-muted card-subtitle mb-2 text-center"><%=historyResult.getString("address") + ", " + historyResult.getString("state") + ", "
                                    + historyResult.getString("country")%>
                            </h6>

                            <p class="card-text text-center" style="margin-top: 30px">
                                Check-in: <%=historyResult.getString("check_in")%>
                            </p>
                            <p class="card-text text-center"> Check-out: <%=historyResult.getString("check_out")%>
                            </p>
                        </div>
                    </div>
                </a>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {

                        if (conn != null) {
                            try {
                                conn.close();
                            } catch (SQLException e) {
                                e.printStackTrace();
                            }
                        }
                    }
                %>
            </div>
        </div>
    </div>
</div>

</div>
</body>
</html>