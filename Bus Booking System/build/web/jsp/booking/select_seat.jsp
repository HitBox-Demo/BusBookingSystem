<%-- 
    Document   : select_seat
    Created on : 10 Jun 2025, 18:48:12
    Author     : nine
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Select Your Seat</title>
        <!-- style.css must define .seat-map, .seat, .seat.booked, .seat.selected -->
        <link rel="stylesheet"
              href="${pageContext.request.contextPath}/assets/css/style.css"/>
    </head>
    <body>
        <div class="container">
            <h2>Select Your Seat</h2>

            <form method="post"
                  action="${pageContext.request.contextPath}/book">
                <input type="hidden" name="scheduleId"
                       value="${scheduleId}"/>

                <div class="seat-map">
                    <!-- JSTL loop to render buttons 1..totalSeats -->
                    <c:forEach var="i" begin="1" end="${totalSeats}">
                        <button type="button"
                                class="seat
                                ${bookedSeats.contains(i) ? 'booked' : ''}"
                                data-seat="${i}"
                                ${bookedSeats.contains(i) ? 'disabled' : ''}>
                            ${i}
                        </button>
                    </c:forEach>
                </div>

                <!-- will hold comma-list of selected seats -->
                <input type="hidden" id="selectedSeats"
                       name="selectedSeats" value=""/>

                <button type="submit">Book Selected Seats</button>
            </form>
        </div>

        <!-- Always include this script *after* the seat-map div -->
        <script src="${pageContext.request.contextPath}/assets/js/seat_selection.js"></script>
    </body>
</html>
