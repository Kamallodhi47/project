package com.univ.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.univ.entity.OrderItem;
@Repository
public interface OrderItemrepo extends JpaRepository<OrderItem, Integer>{
	List<OrderItem> findByOrder_Id(Integer orderId);
}
