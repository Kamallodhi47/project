package com.univ.Repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.univ.entity.UserDtls;

public interface userRepo extends JpaRepository<UserDtls, Integer> {

	long count();

	UserDtls findByEmail(String email);

}
