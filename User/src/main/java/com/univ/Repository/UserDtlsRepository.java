package com.univ.Repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.univ.entity.UserDtls;
@Repository
public interface UserDtlsRepository extends JpaRepository<UserDtls, Integer>{

	//public UserDtls findByEmail(String email);
	
	public Boolean existsByEmail(String email);
	 // Correct method name - 'Password' के साथ
	 // Email से user ढूँढने के लिए method
   // Optional<UserDtls> findByEmail(String email);	
    
    UserDtls findByEmail(String email);
    UserDtls findByEmailAndPassword(String email, String password);
}
