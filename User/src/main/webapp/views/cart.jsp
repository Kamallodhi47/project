<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html>
<head>
    <title>Your Cart - ShopEasy</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e9ecef 100%);
            font-family: 'Inter', sans-serif;
            min-height: 100vh;
        }

        /* Header Styles */
        .cart-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 20px;
            padding: 30px;
            margin-bottom: 40px;
            color: white;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
        }

        .cart-header h3 {
            font-size: 2rem;
            font-weight: 800;
            margin: 0;
            letter-spacing: -0.5px;
        }

        .cart-header h3 i {
            margin-right: 15px;
            animation: bounce 1s ease infinite;
        }

        @keyframes bounce {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-5px); }
        }

        /* Cart Card Styles */
        .cart-card {
            background: white;
            border-radius: 20px;
            padding: 20px;
            margin-bottom: 20px;
            transition: all 0.3s ease;
            border: 1px solid rgba(0, 0, 0, 0.05);
            position: relative;
            overflow: hidden;
        }

        .cart-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
        }

        .cart-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: linear-gradient(90deg, #667eea, #764ba2);
        }

        .product-image {
            width: 130px;
            height: 130px;
            object-fit: contain;
            border-radius: 15px;
            background: #f8f9fa;
            padding: 10px;
            transition: transform 0.3s ease;
        }

        .cart-card:hover .product-image {
            transform: scale(1.05);
        }

        .product-name {
            font-size: 1.2rem;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 8px;
        }

        .product-price {
            font-size: 1.3rem;
            font-weight: 800;
            color: #667eea;
            margin-bottom: 15px;
        }

        .product-price small {
            font-size: 0.9rem;
            font-weight: 500;
            color: #718096;
        }

        /* Quantity Control */
        .quantity-control {
            display: flex;
            align-items: center;
            gap: 12px;
            margin: 15px 0;
        }

        .qty-btn {
            width: 35px;
            height: 35px;
            border-radius: 12px;
            border: none;
            background: #f7fafc;
            color: #4a5568;
            font-weight: bold;
            transition: all 0.2s ease;
        }

        .qty-btn:hover {
            background: #667eea;
            color: white;
            transform: scale(1.05);
        }

        .qty-input {
            width: 60px;
            text-align: center;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            padding: 8px;
            font-weight: 600;
            background: white;
        }

        /* Remove Button */
        .remove-btn {
            background: linear-gradient(135deg, #f56565 0%, #ed64a6 100%);
            border: none;
            padding: 8px 20px;
            border-radius: 12px;
            color: white;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .remove-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(245, 101, 101, 0.3);
        }

        /* Summary Box */
        .summary-box {
            background: white;
            border-radius: 20px;
            padding: 25px;
            position: sticky;
            top: 20px;
            border: 1px solid rgba(0, 0, 0, 0.05);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
        }

        .summary-title {
            font-size: 1.5rem;
            font-weight: 800;
            color: #2d3748;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 2px solid #e2e8f0;
        }

        .summary-item {
            display: flex;
            justify-content: space-between;
            padding: 12px 0;
            font-size: 1rem;
        }

        .summary-total {
            display: flex;
            justify-content: space-between;
            padding: 15px 0;
            border-top: 2px solid #e2e8f0;
            margin-top: 10px;
            font-size: 1.3rem;
            font-weight: 800;
            color: #667eea;
        }

        .checkout-btn {
            background: linear-gradient(135deg, #48bb78 0%, #38a169 100%);
            border: none;
            padding: 15px;
            border-radius: 15px;
            font-weight: 700;
            font-size: 1.1rem;
            margin-top: 20px;
            transition: all 0.3s ease;
        }

        .checkout-btn:hover:not(.disabled) {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(72, 187, 120, 0.3);
        }

        .checkout-btn.disabled {
            opacity: 0.6;
            cursor: not-allowed;
            background: linear-gradient(135deg, #a0aec0 0%, #718096 100%);
        }

        /* Empty Cart */
        .empty-cart {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 20px;
        }

        .empty-cart i {
            font-size: 5rem;
            color: #cbd5e0;
            margin-bottom: 20px;
        }

        .shop-now-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            padding: 12px 30px;
            border-radius: 12px;
            color: white;
            font-weight: 600;
            margin-top: 20px;
            display: inline-block;
            text-decoration: none;
        }

        /* Notification */
        .notify {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 9999;
            padding: 15px 25px;
            border-radius: 12px;
            color: white;
            font-weight: 600;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.2);
            animation: slideIn 0.3s ease;
        }

        @keyframes slideIn {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        /* Badge */
        .price-badge {
            background: linear-gradient(135deg, #fbbf24 0%, #f59e0b 100%);
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            display: inline-block;
        }

        @media (max-width: 768px) {
            .cart-card {
                flex-direction: column;
                text-align: center;
            }
            
            .product-image {
                margin: 0 auto;
            }
            
            .quantity-control {
                justify-content: center;
            }
        }
    </style>
</head>

<body>
	<%@ include file="header1.jsp"%>
    <div class="container my-4">

        <!-- Header -->
        
        <div id="notify" class="notify"></div>

        <div class="row g-4">

            <!-- CART ITEMS -->
            <div class="col-lg-8">

                <c:set var="grandTotal" value="0" />

                <c:choose>
                    <c:when test="${not empty cartItems}">
                        <c:forEach var="c" items="${cartItems}">
                            <div class="cart-card" id="cart-${c.id}">
                                <div class="row align-items-center">
                                    <div class="col-md-3 text-center">
                                        <img src="${pageContext.request.contextPath}/assets/img/product_img/${c.productImage}"
                                             class="product-image"
                                             onerror="this.src='${pageContext.request.contextPath}/assets/default-product.jpg'"
                                             alt="${c.productName}">
                                    </div>
                                    
                                    <div class="col-md-5">
                                        <h5 class="product-name">${c.productName}</h5>
                                        <div class="product-price">
                                            ₹${c.price}
                                            <small>/ piece</small>
                                        </div>
                                        <span class="price-badge">
                                            <i class="fas fa-tag"></i> Best Price
                                        </span>
                                    </div>
                                    
                                    <div class="col-md-4">
                                        <div class="quantity-control">
                                           <!-- <button class="qty-btn" onclick="updateQuantity(${c.id}, ${c.quantity - 1})">
                                                <i class="fas fa-minus"></i>
                                            </button>-->
                                            <input type="number" 
                                                   id="qty-${c.id}"
                                                   value="${c.quantity}"
                                                   min="1" 
                                                   max="99"
                                                   readonly
                                                   class="qty-input">
<!--                                            <button class="qty-btn" onclick="updateQuantity(${c.id}, ${c.quantity + 1})">
                                                <i class="fas fa-plus"></i>
                                            </button>
-->                                        </div>
                                        
                                        <div class="d-flex gap-2 mt-3">
                                            <button class="btn remove-btn" onclick="removeItem(${c.id})">
                                                <i class="fas fa-trash-alt"></i> Remove
                                            </button>
                                        </div>
                                        
                                        <div class="mt-3">
                                            <strong id="item-total-${c.id}" style="color: #667eea; font-size: 1.2rem;">
                                                Total: ₹${c.totalPrice}
                                            </strong>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <c:set var="grandTotal" value="${grandTotal + c.totalPrice}" />
                        </c:forEach>
                    </c:when>

                    <c:otherwise>
                        <div class="empty-cart">
                            <i class="fas fa-shopping-cart"></i>
                            <h4 class="mt-3">Your cart is empty!</h4>
                            <p class="text-muted">Looks like you haven't added anything to your cart yet.</p>
                            <a href="${pageContext.request.contextPath}/home" class="shop-now-btn">
                                <i class="fas fa-store"></i> Start Shopping
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>

            </div>

            <!-- SUMMARY -->
			<div class="col-lg-4">
			    <div class="summary-box">
			        <div class="summary-title">
			            <i class="fas fa-receipt"></i> Order Summary
			        </div>
			        
			        <div class="summary-item">
			            <span><i class="fas fa-box"></i> Total Items (Quantity)</span>
			            <strong id="totalQuantity">
			                <c:set var="totalQty" value="0" />
			                <c:forEach var="c" items="${cartItems}">
			                    <c:set var="totalQty" value="${totalQty + c.quantity}" />
			                </c:forEach>
			                ${totalQty}
			            </strong>
			        </div>
			        
			        <div class="summary-item">
			            <span><i class="fas fa-list"></i> Different Products</span>
			            <strong>${not empty cartItems ? fn:length(cartItems) : 0}</strong>
			        </div>
			        
			        <div class="summary-item">
			            <span><i class="fas fa-truck"></i> Shipping</span>
			            <strong class="text-success">Free</strong>
			        </div>
			        
			        <div class="summary-total">
			            <span><i class="fas fa-rupee-sign"></i> Grand Total</span>
			            <strong>₹<span id="grandTotal">${grandTotal}</span></strong>
			        </div>
			        
			        <div class="mt-3 text-center text-muted small">
			            <i class="fas fa-shield-alt"></i> Secure Checkout
			        </div>
			        
			        <a href="${pageContext.request.contextPath}/checkout"
			           class="btn checkout-btn w-100 ${empty cartItems ? 'disabled' : ''}">
			            <i class="fas fa-lock"></i> Proceed to Checkout
			        </a>
			        
			        <a href="${pageContext.request.contextPath}/home" 
			           class="btn btn-link w-100 mt-2 text-decoration-none">
			            <i class="fas fa-arrow-left"></i> Continue Shopping
			        </a>
			    </div>
			</div>
    <script>
        const ctx = '${pageContext.request.contextPath}';

        function notify(msg, ok = true) {
            const box = document.getElementById('notify');
            box.style.display = 'block';
            box.style.background = ok ? 'linear-gradient(135deg, #48bb78, #38a169)' : 'linear-gradient(135deg, #f56565, #ed64a6)';
            box.innerHTML = '<i class="fas fa-' + (ok ? 'check-circle' : 'exclamation-circle') + '"></i> ' + msg;
            setTimeout(() => box.style.display = 'none', 3000);
        }

        function updateQuantity(id, newQty) {
            if (newQty < 1) {
                if (confirm('Remove item from cart?')) {
                    removeItem(id);
                }
                return;
            }
            if (newQty > 99) {
                notify('Maximum quantity is 99', false);
                return;
            }

            fetch(ctx + '/update', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    cartId: id,
                    quantity: newQty
                })
            })
            .then(r => r.ok ? r.json() : Promise.reject())
            .then(d => {
                if (d.success) {
                    document.getElementById('qty-' + id).value = newQty;
                    document.getElementById('item-total-' + id).innerHTML = 'Total: ₹' + d.itemTotal;
                    document.getElementById('grandTotal').innerText = d.grandTotal;
                    notify('Quantity updated');
                } else {
                    notify(d.message || 'Update failed', false);
                }
            })
            .catch(() => notify('Server error', false));
        }

        function removeItem(id) {
            if (!confirm('Remove this item from cart?')) return;

            fetch(ctx + '/remove', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    cartId: id
                })
            })
            .then(r => r.ok ? r.json() : Promise.reject())
            .then(d => {
                if (d.success) {
                    const element = document.getElementById('cart-' + id);
                    element.style.animation = 'slideOut 0.3s ease';
                    setTimeout(() => {
                        element.remove();
                        document.getElementById('grandTotal').innerText = d.grandTotal;
                        document.getElementById('itemCount').innerText = d.cartCount;
                        
						document.getElementById('totalQty').innerText = d.totalQuantity;

                        if (d.cartCount === 0) {
                            location.reload();
                        }
                    }, 300);
                    notify('Item removed successfully');
                } else {
                    notify(d.message || 'Failed to remove', false);
                }
            })
            .catch(() => notify('Server error', false));
        }
    </script>

    <style>
        @keyframes slideOut {
            from {
                transform: translateX(0);
                opacity: 1;
            }
            to {
                transform: translateX(100%);
                opacity: 0;
            }
        }
    </style>

</body>
</html>