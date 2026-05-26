package com.univ.service;





import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.univ.Repository.ProductRepo;
import com.univ.Repository.UserDtlsRepository;
import com.univ.entity.Category;
import com.univ.entity.Product;
import com.univ.entity.UserDtls;

@Service
public class UserDtlsService {
	@Autowired
	public UserDtlsRepository userDtlsRepository;
	
	public UserDtls saveUserDtls(UserDtls User)
	{
		UserDtls sv=userDtlsRepository.save(User);
				return sv;
	}

	/*
	 * public UserDtls getUserByEmail(String email) { return
	 * userDtlsRepository.findByEmail(email); }
	 */
	public Boolean existsEmail(String email) {
		return userDtlsRepository.existsByEmail(email);
	}
	public UserDtls getUserDtls(String email, String password) {
        return userDtlsRepository.findByEmailAndPassword(email, password);
       // System.out.println(email+"");
    }
	
	@Autowired
	  private  RestTemplate restTemplate;

	    private String adminUrl = "http://localhost:8082/api/categories/active";

	    public List<Category> getCategoriesFromAdmin() {
	        ResponseEntity<Category[]> response = restTemplate.getForEntity(adminUrl, Category[].class);
	        return Arrays.asList(response.getBody());
	    }
	    private String adminproductUrl = "http://localhost:8082/api/products/active";
	    public List<Product> getProductsFromAdmin() {
	        ResponseEntity<Product[]> response = restTemplate.getForEntity(adminproductUrl, Product[].class);
	        return Arrays.asList(response.getBody());
	    }

	    public void save(UserDtls user) {
	        userDtlsRepository.save(user); // This actually saves the user to DB
	    }

		
		 public UserDtls findByEmail(String email) { return
		 userDtlsRepository.findByEmail(email); }
		 
		  public void sendSeller(UserDtls savedSeller) {
		        String adminUrl1 = "http://localhost:8080/admin/receiveSeller";  
		        RestTemplate restTemplate1 = new RestTemplate();

		        // POST request
		        restTemplate1.postForObject(adminUrl1, savedSeller, String.class);
		    }
	 @Autowired
     private  ProductRepo productrepo;
	 
		public Product getProductById(int id) {
			// TODO Auto-generated method stub
			 return productrepo.findById(id).orElse(null);
		}

		
				
		
}
