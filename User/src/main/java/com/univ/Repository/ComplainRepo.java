package com.univ.Repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import com.univ.entity.Complain;

public interface ComplainRepo extends JpaRepository<Complain, Integer> {
	 boolean existsByOrderId(Integer orderId);
	
		
	  Optional<Complain> findByOrderIdAndUserId(Integer orderId, Integer userId);

	   	    Optional<Complain> findFirstByUserIdOrderByComplaintDateDesc(Integer userId);
}
