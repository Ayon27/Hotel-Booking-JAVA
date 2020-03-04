<%@ page import="java.sql.Connection" %>
<%@ page import="com.DB.DatabaseConnection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: Ayn
  Date: 3/2/2020
  Time: 11:15 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    if (session.getAttribute("name") == null) {
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Home</title>
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
<div style="margin-top: 20px">
    <nav class="navbar navbar-light navbar-expand-md navigation-clean">
        <div class="container">
            <button data-toggle="collapse" class="navbar-toggler" data-target="#navcol-1"><span
                    class="sr-only">Toggle navigation</span><span class="navbar-toggler-icon"></span></button>
            <div class="collapse navbar-collapse" id="navcol-1">
                <ul class="nav navbar-nav ml-auto">
                    <li class="nav-item" role="presentation"><a class="nav-link" href="#">Home</a></li>

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
                                                                  href="#">Profile</a>
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
<div>
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <div class="contact-clean">
                    <form method="get" action="search.jsp?">
                        <h2 class="text-center">Find a place to stay</h2>
                        <div class="form-group"><input required class="form-control" type="text" name="key"
                                                       placeholder="Search For a Place"></div>
                        <div class="form-group"><input required class="form-control" type="text" id="cinDate"
                                                       autocomplete="off"
                                                       name="cinDate" placeholder="Check-in Date"></div>
                        <div class="form-group"><input required class="form-control" type="text" id="coutDate"
                                                       autocomplete="off"
                                                       name="coutDate" placeholder="Check-out Date"></div>
                        <div class="form-group"><input required class="form-control" type="number" name="guestCount"
                                                       placeholder="Number of Guests" min="1"></div>
                        <div class="form-group">
                            <button class="btn btn-primary" type="submit">Search</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="container">
                <h2 class="text-center" style="margin-top: 100px; margin-bottom: 50px"><strong>Featured places</strong>
                </h2>
                <div class="card-deck">
                    <%
                        String s = (String) session.getAttribute("id");

                        try {
                            Connection conn = DatabaseConnection.getConnection();
                            PreparedStatement stmt = conn.prepareStatement("SELECT * from listing ORDER BY RAND() LIMIT 6");
                            ResultSet result = stmt.executeQuery();
                            while (result.next()) {
                                String gym = "No Gym";
                                String pool = "No Pool";
                                String entireHouse = "Shared Place";

                                if (result.getString("entire_house").equals("1")) {
                                    entireHouse = "Entire Place";
                                }
                                if (result.getString("has_gym").equals("1")) {
                                    gym = "Has a Gym";
                                }
                                if (result.getString("has_pool").equals("1")) {
                                    pool = "Has a Pool";
                                }
                    %>
                    <div class="card" style="min-width: 300px; max-width: 350px; margin-top: 15px; margin-bottom: 20px">
                        <img class="card-img-top" src="assets/download.png" alt="Card image cap"
                             style="width: 100px; margin-left: 35%; margin-top: 20px">
                        <div class="card-body">
                            <h5 class="card-title  text-center"><%=result.getString("name")%>
                            </h5>
                            <p class="card-text text-secondary  text-center"><%=entireHouse%>, <%=gym%>, <%=pool%>
                            </p>
                            <p class="card-text text-secondary  text-center">Hosted by: <%= result.getString("hostName") %>
                            </p>
                        </div>
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item  text-center"><%=result.getString("address")%>
                                , <%=result.getString("state")%>
                                , <%=result.getString("country")%>
                            </li>
                            <li class="list-group-item  text-center">Rooms: <%=result.getString("bedrooms")%>
                            </li>
                            <li class="list-group-item  text-center">Washrooms: <%=result.getString("bedrooms")%>
                            </li>
                            <li class="list-group-item text-center">For: <%=result.getString("guests")%> People
                            </li>
                        </ul>
                        <div class="card-body">
                            <a href="confirmBooking.jsp?placeID=<%=result.getString("id")%>"
                               class="card-link">
                                <Button class="btn btn-secondary" style="min-width: 100%"><%=result.getString("price")%> /
                                    Night
                                </Button>
                            </a>
                        </div>
                    </div>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    %>
                </div>
            </div>
        </div>
    </div>
</body>

</html>
<%@include  file="assets/footer.jsp"%>

<script type="text/javascript">
    $("#cinDate").datepicker({
        autoClose: true,
        dateFormat: 'yy-mm-dd',
        minDate: new Date(),
        onSelect: function (dateStr) {
            var min = $(this).datepicker('getDate');
            var minDate = new Date();
            minDate.setDate(min.getDate() + 1);
            $('#coutDate').datepicker('option', 'minDate', minDate || '0');
        }
    });

    $('#coutDate').datepicker({
        minDate: '0',
        dateFormat: 'yy-mm-dd',
        autoClose: true,
    });
</script>

