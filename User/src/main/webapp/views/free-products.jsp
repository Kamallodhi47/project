<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Free Product Offer</title>
</head>
<body>

<h2>Select Your Free Product</h2>

<c:if test="${empty products}">
    <p>No free products available</p>
</c:if>

<c:forEach var="p" items="${products}">
    <form action="apply-free-product" method="post">
        <div style="border:1px solid #ccc; padding:10px; margin:10px;">
            <h3>${p.name}</h3>
            <p>Price: ₹0 (Free)</p>

            <input type="hidden" name="productId" value="${p.id}" />
            <button type="submit">Select</button>
        </div>
    </form>
</c:forEach>

</body>
</html>