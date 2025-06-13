<%--
    Document   : my_bookings
    Created on : 10 Jun 2025, 18:49:27
    Author     : nine
--%>


<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.busbooking.model.BookingDAO, com.busbooking.model.Booking" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    // 1) Session check
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect(request.getContextPath() + "/jsp/user/login.jsp");
        return;
    }
    int userId = (Integer) session.getAttribute("userId");

    // 2) Fetch bookings
    BookingDAO dao = new BookingDAO();
    List<Booking> bookings = dao.getBookingsByUser(userId);
    request.setAttribute("bookings", bookings);
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>My Bookings</title>
        <link
            href="${pageContext.request.contextPath}/assets/css/bootstrap.min.css"
            rel="stylesheet"/>
    </head>
    <body>
        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">Bus Booking</a>
                <div class="ms-auto">
                    <a class="btn btn-outline-light me-2"
                       href="${pageContext.request.contextPath}/index.jsp">
                        Home
                    </a>
                    <a class="btn btn-danger"
                       href="${pageContext.request.contextPath}/logout">
                        Logout
                    </a>
                </div>
            </div>
        </nav>

        <div class="container my-4">
            <h2>My Bookings</h2>
            <table class="table table-striped table-bordered mt-3">
                <thead class="table-dark">
                    <tr>
                        <th>Booking ID</th>
                        <th>Schedule ID</th>
                        <th>Seat Number</th>
                        <th>Booking Time</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty bookings}">
                            <c:forEach var="b" items="${bookings}">
                                <tr>
                                    <td>${b.bookingId}</td>
                                    <td>${b.scheduleId}</td>
                                    <td>${b.seatNumber}</td>
                                    <td>${b.bookingTimestamp}</td>
                                    <td>
                                        <form action="${pageContext.request.contextPath}/cancelBooking"
                                              method="post" class="d-inline">
                                            <input type="hidden" name="bookingId" value="${b.bookingId}"/>
                                            <button type="submit" class="btn btn-sm btn-danger">
                                                Cancel
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="5" class="text-center">
                                    You have no active bookings.
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>

        <script
            src="${pageContext.request.contextPath}/assets/js/bootstrap.bundle.min.js">
        </script>
    </body>
</html>