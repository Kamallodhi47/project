package com.univ.Repository;

import com.univ.entity.Cart;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CartRepository extends JpaRepository<Cart, Integer> {

    // User के लिए cart items fetch करना
   
    
    Cart findByUserIdAndProductId(int userId, int productId);
    // Delete a cart item by id and userId (optional)
    void deleteByIdAndUserId(Integer id, Integer userId);

    @Query("SELECT SUM(c.quantity) FROM Cart c WHERE c.userId = :userId")
    Integer getCartCount(int userId);
    List<Cart> findByUserId(Integer userId);

    Cart findByUserIdAndProductId(Integer userId, Integer productId);
}
