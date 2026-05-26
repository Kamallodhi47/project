package com.univ.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.univ.entity.OrderDtls;
import com.univ.entity.UserDtls;

@Repository
public interface OrderDtlsRepo extends JpaRepository<OrderDtls, Integer> {

    List<OrderDtls> findByUserOrderByOrderDateDesc(UserDtls user);

    OrderDtls findByOrderIdAndUser(String orderId, UserDtls user);

    List<OrderDtls> findByUser(UserDtls user);

    List<OrderDtls> findByUserAndStatusOrderByOrderDateDesc(UserDtls user, String status);

    // ✅ Correct Count Method
    long countByUser(UserDtls user);

    // ✅ Alternative Clean Version (Recommended)
    long countByUser_Id(Integer userId);
}