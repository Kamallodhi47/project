package com.univ.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.univ.Repository.CartRepository;
import com.univ.Repository.ProductRepo;
import com.univ.entity.Cart;
import com.univ.entity.Product;

@Service
public class CartService {

    @Autowired
    private CartRepository cartRepo;

    @Autowired
    private ProductRepo productrepo;

    // ⭐ ADD PRODUCT TO CART (with full details)
    public void addProductToCart(Integer userId, Integer productId, Integer qty) {

        // ✅ Product मिलने वाला है
        Product product = productrepo.findById(productId).orElse(null);

        if (product == null) {
            return;
        }

        // ✅ पहले से cart में है या नहीं
        Cart existing = cartRepo.findByUserIdAndProductId(userId, productId);

        if (existing != null) {
            existing.setQuantity(existing.getQuantity() + qty);
            cartRepo.save(existing);
            return;
        }

        // ✅ नया cart item create
        Cart cart = new Cart();

        cart.setUserId(userId);
        cart.setProductId(productId);

        // ✅ Details Save
        cart.setProductName(product.getTitle());
        cart.setPrice(product.getDiscountPrice());
        cart.setProductImage(product.getImage());
        cart.setQuantity(qty);

        cartRepo.save(cart);
    }

    // ⭐ Cart Count
    public int getCartCount(int userId) {
        Integer count = cartRepo.getCartCount(userId);
        return (count == null) ? 0 : count;
    }

    // ⭐ Cart Items
    public List<Cart> getCartItems(Integer userId) {
        return cartRepo.findByUserId(userId);
    }
    
    public boolean removeFromCart(Integer cartId) {
        try {
            // Check if cart item exists
            Optional<Cart> cartOptional = cartRepo.findById(cartId);
            
            if (cartOptional.isPresent()) {
                // Delete the cart item
                cartRepo.deleteById(cartId);
                System.out.println("Cart item deleted: " + cartId);
                return true;
            } else {
                System.out.println("Cart item not found: " + cartId);
                return false;
            }
        } catch (Exception e) {
            System.err.println("Error deleting cart item: " + cartId);
            e.printStackTrace();
            return false;
        }
    }

    public Double getGrandTotal(Integer userId) {
        // TODO: Calculate grand total for user's cart
        
        try {
            // Get all cart items for the user
            List<Cart> cartItems = cartRepo.findByUserId(userId);
            
            if (cartItems == null || cartItems.isEmpty()) {
                System.out.println("Cart is empty for user: " + userId);
                return 0.0;
            }
            
            // Calculate total sum of all items
            double total = 0.0;
            
            for (Cart item : cartItems) {
                if (item.getTotalPrice() != null) {
                    total += item.getTotalPrice();
                }
            }
            
            System.out.println("Grand total for user " + userId + ": ₹" + total);
            return total;
            
        } catch (Exception e) {
            System.err.println("Error calculating grand total for user " + userId + ": " + e.getMessage());
            e.printStackTrace();
            return 0.0;
        }
    }
	/*
	 * public boolean removeFromCart(Integer cartId) { // TODO Auto-generated method
	 * stub return false; }
	 */
	/*
	 * public void updateQuantity(String type, Integer id) {
	 * 
	 * // Fetch cart item Cart cart = cartRepo.findById(id).orElse(null);
	 * 
	 * if (cart == null) { return; }
	 * 
	 * int qty = cart.getQuantity();
	 * 
	 * // increase if (type.equals("increase")) { qty++; }
	 * 
	 * // decrease if (type.equals("decrease")) { qty--; }
	 * 
	 * // Bound check if (qty < 1) qty = 1; if (qty > 99) qty = 99;
	 * 
	 * cart.setQuantity(qty);
	 * 
	 * cartRepo.save(cart); }
	 */

    public void clearCart(Integer userId) {
        try {
            List<Cart> items = cartRepo.findByUserId(userId);
            if (items != null && !items.isEmpty()) {
                cartRepo.deleteAll(items);
                System.out.println("Cleared " + items.size() + " items from cart for user: " + userId);
            }
        } catch (Exception e) {
            System.err.println("Error clearing cart: " + e.getMessage());
        }
    }

    public Cart updateQuantity(Integer cartId, Integer quantity) {
        try {
            Optional<Cart> optionalCart = cartRepo.findById(cartId);
            
            if (optionalCart.isEmpty()) {
                System.out.println("Cart item not found: " + cartId);
                return null;
            }
            
            Cart cart = optionalCart.get();
            
            if (quantity <= 0) {
                // Remove item if quantity is 0
                cartRepo.delete(cart);
                System.out.println("Removed cart item (quantity 0): " + cartId);
                return cart;
            }
            
            // Update quantity and total
            cart.setQuantity(quantity);
            cart.setPrice(quantity * cart.getPrice());
            
            Cart updatedCart = cartRepo.save(cart);
            System.out.println("Updated cart item " + cartId + " to quantity: " + quantity);
            
            return updatedCart;
            
        } catch (Exception e) {
            System.err.println("Error updating quantity: " + e.getMessage());
            return null;
        }
    }    

	
}
