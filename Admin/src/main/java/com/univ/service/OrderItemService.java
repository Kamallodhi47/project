package com.univ.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.univ.Repository.OrderItemrepo;
import com.univ.entity.OrderItem;

@Service
public class OrderItemService {
	@Autowired
	private OrderItemrepo  orderItemRepository ;

	 public List<OrderItem> getItemsByOrderId(Integer id) {
	        return orderItemRepository.findByOrder_Id(id);
	    }

	
}
