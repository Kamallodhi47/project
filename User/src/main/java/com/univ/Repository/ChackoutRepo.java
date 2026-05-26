package com.univ.Repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.univ.entity.Chackout;
import com.univ.entity.UserDtls;
@Repository
public interface ChackoutRepo extends JpaRepository<Chackout, Integer> {
	 List<Chackout> findByUser(UserDtls user);

	 Chackout findFirstByUser(UserDtls user);
}
