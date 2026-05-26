package com.univ.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.ZoneId;
import java.time.format.DateTimeParseException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import com.univ.entity.Product;
import com.univ.entity.UserDtls;
import com.univ.entity.UserType;
import com.univ.entity.Category;
import com.univ.entity.Complain;
import com.univ.entity.Offer;
import com.univ.entity.OfferType;
import com.univ.entity.OrderDtls;
import com.univ.entity.OrderItem;
import com.univ.service.Categoryservice;
import com.univ.service.ComplainService;
import com.univ.service.OrderDtlsService;
import com.univ.service.OrderItemService;
import com.univ.service.Productservice;
import com.univ.service.UserDtlsService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ObjectUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.service.annotation.GetExchange;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.ui.Model;
import jakarta.servlet.http.HttpSession;

@Controller
public class IndexController {

	@Autowired
	private Categoryservice categoryservice;
	@Autowired
	private Productservice productservice;

	// Home
	@GetMapping("/")
	public String index(Model model, HttpSession session) {

	    UserDtls user = (UserDtls) session.getAttribute("user");

	    // agar login nahi hai
	    if (user == null) {
	        return "redirect:/login";
	    }

	    // agar login hai tabhi index open
	    return "index";
	}
	
	@GetMapping("Ragistration")
	public String Ragistration()
	{
		return"Ragistration";
	}
	
	@PostMapping("/register")
	public String registerUser(@ModelAttribute UserDtls userDtls,
	                           @RequestParam("img") MultipartFile file) {

	    String fileName = file.getOriginalFilename();
      System.out.println("fileName"+ fileName);
	    // null check (optional but good)
	    if (fileName != null && !fileName.isEmpty()) {
	        userDtls.setProfileImage(fileName);
	    }

	    userService.registerUser(userDtls);

	    return "Login";
	}
	
	
	@GetMapping("/login")
	public String showLoginPage(HttpSession session) {
		UserDtls user = (UserDtls) session.getAttribute("user");

		// agar user already login hai
		if (user != null) {
			return "Login";
		}

		// session से कोई message दिखाना हो तो model में डाल सकते हो
		Object msg = session.getAttribute("msg");
		if (msg != null) {
			session.removeAttribute("msg"); // एक बार दिखा दो
		}

		return "Login"; // login.jsp
	}
	@PostMapping("/login")
	public String loginUser(@RequestParam String email, @RequestParam String password, HttpSession session) {
		System.out.println("Email: " + email);
		UserDtls user = userService.findByEmail(email);
		System.out.println(user);

		if (email == null) {
			session.setAttribute("msg", "Invalid email!");
			return "redirect:/Login";
		}

		if (!user.getPassword().equals(password)) {
	        session.setAttribute("msg", "Wrong password!");
	        return "redirect:/Login";
	    }

		if (!user.getIsEnable()) {
			session.setAttribute("msg", "Account not active. Wait for admin approval.");
			return "redirect:/";
		}
		//session.setAttribute("user", user);
		session.setAttribute("user", user);
		session.setAttribute("userId", user.getId());
		System.out.println("final" + user);

		return "redirect:/";

	}

	
	@GetMapping("/admin")
	   public String adminOrder()
	   {
		   return"admin-order-details";
	   }
	 
	 @Autowired
	 private OrderItemService orderItemService;
	 @Autowired
	 private OrderDtlsService orderService;
	 @Autowired
	 private UserDtlsService  userService;
	 
	 @GetMapping("/admindashbord")
	 public String AdminDasbord(Model model ,  HttpSession session)
	 {
		 
		 long totalUsers = userService.countAllUsers();
		    long totalOrders = orderService.countAllOrders();

		    long pendingOrders = orderService.countByStatus("PENDING");
		    long confirmedOrders = orderService.countByStatus("CONFIRMED");
		    long deliveredOrders = orderService.countByStatus("DELIVERED");

		   
		    double averageOrderValue = orderService.getAverageOrderValue();
               
		    model.addAttribute("totalUsers", totalUsers);
		    model.addAttribute("totalOrders", totalOrders);
		    model.addAttribute("pendingOrders", pendingOrders);
		    model.addAttribute("confirmedOrders", confirmedOrders);
		    model.addAttribute("deliveredOrders", deliveredOrders);
		    
		    model.addAttribute("averageOrderValue", averageOrderValue);
		 return"admin-dashboard";
	 }
	 @GetMapping("/adminorders")
	 public String adminOrders(
	         @RequestParam(defaultValue = "0") Integer pageNo,
	         @RequestParam(defaultValue = "10") Integer pageSize,
	         @RequestParam(required = false) String search,
	         @RequestParam(required = false) String status,
	         @RequestParam(required = false) String dateRange,
	         Model model,
	         HttpSession session) {

	     // Check admin authentication (if needed)
			/*
			 * UserDtls admin = (UserDtls) session.getAttribute("userobj"); if (admin ==
			 * null || !"ROLE_ADMIN".equals(admin.getRole())) { return "redirect:"; }
			 */
	     // 1️⃣ Fetch paginated and filtered orders
	     Page<OrderDtls> orderPage = orderService.getFilteredOrders(pageNo, pageSize, search, status, dateRange);
	     List<OrderDtls> orders = orderPage.getContent();

	     // 2️⃣ For each order, calculate grand total from items and set customer details
	     for (OrderDtls order : orders) {
	         // Get order items (already fetched due to LAZY loading with OpenSessionInViewFilter)
	         List<OrderItem> items = order.getItems();
	         
	         // Calculate grand total from items
	         if (items != null && !items.isEmpty()) {
	             double grandTotal = items.stream()
	                     .mapToDouble(item -> {
	                         // Ensure total is calculated correctly
	                         if (item.getTotal() == null) {
	                             return item.getPrice() * item.getQuantity();
	                         }
	                         return item.getTotal();
	                     })
	                     .sum();
	             order.setGrandTotal(grandTotal);
	         } else {
	             // If no items, use order amount
	             order.setGrandTotal(order.getAmount() != null ? order.getAmount() : 0.0);
	         }

	         // Ensure user object is accessible in JSP
	         UserDtls user = order.getUser();
	         if (user != null && order.getUserName() == null) {
	             order.setUserName(user.getName());
	         }
	     }

	     // 3️⃣ Add data to model
	     model.addAttribute("orders", orders);
	     
	    	     model.addAttribute("orders", orderPage.getContent());
	     model.addAttribute("totalElements", orderPage.getTotalElements());
	     model.addAttribute("pageNo", orderPage.getNumber());
	     model.addAttribute("totalPages", orderPage.getTotalPages());
	     model.addAttribute("pageSize", pageSize);
	     model.addAttribute("searchParam", search);
	     model.addAttribute("statusParam", status);
	     model.addAttribute("dateRange", dateRange);
	     
	     // Stats for quick view
	     model.addAttribute("pendingCount", orderService.countByStatus("PENDING"));
	     model.addAttribute("confirmedCount", orderService.countByStatus("CONFIRMED"));
	     model.addAttribute("shippedCount", orderService.countByStatus("SHIPPED"));
	     model.addAttribute("deliveredCount", orderService.countByStatus("DELIVERED"));
	     model.addAttribute("cancelledCount", orderService.countByStatus("CANCELLED"));

	     return "admin-orders";
	 }
	 @PostMapping("/update")
	 public ResponseEntity<String> updateOrderStatus(
	         @RequestParam Integer orderId,
	         @RequestParam String status,
	         @RequestParam(required = false) String cancellationReason) {

	     System.out.println("=== UPDATE ORDER STATUS API HIT ===");
	     System.out.println("Order ID: " + orderId);
	     System.out.println("Status: " + status);
	     System.out.println("Cancel Reason: " + cancellationReason);

	     try {
	         orderService.updateOrderStatus(orderId, status, cancellationReason);
	         System.out.println("Status updated successfully");
	         return ResponseEntity.ok("success");

	     } catch (Exception e) {
	         e.printStackTrace();
	         return ResponseEntity.badRequest().body("error: " + e.getMessage());
	     }
	 }
	@GetMapping("/category")
	public String categoryPage(Model model, @RequestParam(name = "pageNo", defaultValue = "0") Integer pageNo,
			@RequestParam(name = "pageSize", defaultValue = "10") Integer pageSize) {

		Page<Category> page = categoryservice.getAllCategorPagination(pageNo, pageSize);
		List<Category> categories = page.getContent();

		model.addAttribute("categories", categories);
		model.addAttribute("pageNo", page.getNumber());
		model.addAttribute("totalPages", page.getTotalPages());
		model.addAttribute("totalElements", page.getTotalElements());

		return "category";
	}

	// Save category
	/*
	 * @PostMapping("/saveCategory") public String saveCategory(@ModelAttribute
	 * Category category, @RequestParam("file") MultipartFile file, HttpSession
	 * session) throws IOException {
	 * 
	 * 
	 * 
	 * 
	 * String imageName = file != null && !file.isEmpty() ?
	 * file.getOriginalFilename() : "default.jpg"; category.setImageName(imageName);
	 * 
	 * Boolean existCategory = categoryservice.existCategory(category.getName());
	 * 
	 * if (existCategory) { session.setAttribute("errorMsg",
	 * "Category Name already exists"); return "redirect:/category"; }
	 * 
	 * Category saveCategory = categoryservice.saveCategory(category);
	 * 
	 * if (ObjectUtils.isEmpty(saveCategory)) { session.setAttribute("errorMsg",
	 * "Not saved ! internal server error"); return "redirect:/category"; }
	 * 
	 * if (file != null && !file.isEmpty()) { String adminDir =
	 * "C:\\maltiWenderWeb\\Admin (5)\\Admin\\src\\main\\webapp\\assets\\img\\category_img"
	 * ; String userDir =
	 * "C:\\maltiWenderWeb\\User\\User\\src\\main\\webapp\\assets\\img\\category_img";
	 * 
	 * Files.createDirectories(Paths.get(adminDir));
	 * Files.createDirectories(Paths.get(userDir));
	 * 
	 * Path adminPath = Paths.get(adminDir, file.getOriginalFilename());
	 * Files.copy(file.getInputStream(), adminPath,
	 * StandardCopyOption.REPLACE_EXISTING);
	 * 
	 * byte[] bytes = file.getBytes(); Path userPath = Paths.get(userDir,
	 * file.getOriginalFilename()); Files.write(userPath, bytes); // FIXED }
	 * 
	 * session.setAttribute("succMsg", "Saved successfully"); return
	 * "redirect:/category"; }
	 */
	@PostMapping("/saveCategory")
	public String saveCategory(@ModelAttribute Category category, @RequestParam("file") MultipartFile file,
			HttpSession session) {

		try {

			// 🔴 Image mandatory (frontend se)
			if (file == null || file.isEmpty()) {
				session.setAttribute("errorMsg", "Please upload category image");
				return "redirect:/category";
			}

			// ✅ Unique image name (time-based)
			String imageName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
			category.setImageName(imageName);

			// ✅ Check category exists
			Boolean existCategory = categoryservice.existCategory(category.getName());
			if (existCategory) {
				session.setAttribute("errorMsg", "Category Name already exists");
				return "redirect:/category";
			}

			// ✅ Save category
			Category savedCategory = categoryservice.saveCategory(category);
			if (ObjectUtils.isEmpty(savedCategory)) {
				session.setAttribute("errorMsg", "Not saved! Internal server error");
				return "redirect:/category";
			}

			// ✅ Save image in both projects

			String adminDir = "C:\\Users\\dell\\Desktop\\kamal\\Admin (5)\\Admin (5)\\Admin (5)\\Admin\\src\\main\\webapp\\assets\\img\\category_img";
			System.out.println("adminDir"+adminDir);
			String userDir = "C:\\Users\\dell\\Desktop\\kamal\\User\\User\\User\\User\\User\\src\\main\\webapp\\assets\\img\\category_img";

			Files.createDirectories(Paths.get(adminDir));
			Files.createDirectories(Paths.get(userDir));

			Path adminPath = Paths.get(adminDir, imageName);
			Path userPath = Paths.get(userDir, imageName);

			Files.copy(file.getInputStream(), adminPath, StandardCopyOption.REPLACE_EXISTING);
			Files.copy(file.getInputStream(), userPath, StandardCopyOption.REPLACE_EXISTING);

			session.setAttribute("succMsg", "Category saved successfully");

		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("errorMsg", "Image upload failed");
		}

		return "redirect:/category";
	}

	// Add product page
	/*
	 * @GetMapping("addpro") public String product1() {
	 * 
	 * return"add_product";
	 * 
	 * }
	 */

	/*
	 * List<Category> list = categoryservice.findAll();
	 * model.addAttribute("categories", list);
	 */
	@GetMapping("addpro")
	public String product1(Model model) {

		List<Category> list = categoryservice.getAllCategory();
		model.addAttribute("categories", list);

		return "add_product";
	}

	// Save product
	@PostMapping("/saveProduct")
	public String addProduct(@ModelAttribute Product product, @RequestParam("file") MultipartFile file,
			HttpSession session) throws IOException {

		/*
		 * String imageName = file != null && !file.isEmpty() ?
		 * file.getOriginalFilename() : "default.jpg"; product.setImage(imageName);
		 * product.setDiscount(product.getDiscount() == 0 ? 0 : product.getDiscount());
		 * product.setDiscountPrice(product.getPrice());
		 * 
		 * Product saveProduct = productservice.saveProduct(product);
		 */
		String imageName = (file != null && !file.isEmpty()) ? file.getOriginalFilename() : "default.jpg";
		product.setImage(imageName);
		product.setDiscount(product.getDiscount() == 0 ? 0 : product.getDiscount());
		product.setDiscountPrice(product.getPrice());

		Product saveProduct = productservice.saveProduct(product);

		System.out.println("save" + saveProduct);
		if (!ObjectUtils.isEmpty(saveProduct)) {
			if (file != null && !file.isEmpty()) {
				String adminDir = "C:\\Users\\dell\\Desktop\\kamal\\Admin (5)\\Admin (5)\\Admin (5)\\Admin\\src\\main\\webapp\\assets\\img\\product_img";
				String userDir = "C:\\Users\\dell\\Desktop\\kamal\\User\\User\\User\\User\\User\\src\\main\\webapp\\assets\\img\\product_img";
				System.out.println("userDir=" + userDir);
				Files.createDirectories(Paths.get(adminDir));
				Files.createDirectories(Paths.get(userDir));

				Path adminPath = Paths.get(adminDir, file.getOriginalFilename());
				Files.copy(file.getInputStream(), adminPath, StandardCopyOption.REPLACE_EXISTING);

				byte[] bytes = file.getBytes();
				Path userPath = Paths.get(userDir, file.getOriginalFilename());
				Files.write(userPath, bytes); // FIXED
				System.out.printf("product" + userPath, bytes);
			}

			session.setAttribute("succMsg", "Product Saved Successfully");
		} else {
			session.setAttribute("errorMsg", "Something went wrong on server");
		}

		return "redirect:/productview";
	}

	// Delete category
	@GetMapping("/deleteCategory/{id}")
	public String deleteCategory(@PathVariable int id, HttpSession session) {
		Boolean deleteCategory = categoryservice.deleteCategory(id);

		if (deleteCategory) {
			session.setAttribute("succMsg", "category delete success");
		} else {
			session.setAttribute("errorMsg", "something wrong on server");
		}

		return "redirect:/category";
	}

	// Load edit category
	@GetMapping("/loadEditCategory/{id}")
	public String loadEditCategory(@PathVariable int id, Model m) {
		m.addAttribute("category", categoryservice.getCategoryById(id));
		return "edit_category";
	}

	// Update category
	@PostMapping("/updateCategory")
	public String updateCategory(@ModelAttribute Category category, @RequestParam("file") MultipartFile file,
			HttpSession session) throws IOException {

		Category oldCategory = categoryservice.getCategoryById(category.getId());
		String imageName = file != null && !file.isEmpty() ? file.getOriginalFilename() : oldCategory.getImageName();

		oldCategory.setName(category.getName());
		oldCategory.setIsActive(category.getIsActive());
		oldCategory.setImageName(imageName);

		Category updateCategory = categoryservice.saveCategory(oldCategory);

		if (!ObjectUtils.isEmpty(updateCategory)) {
			if (file != null && !file.isEmpty()) {
				String adminDir = "C:\\maltiWenderWeb\\Admin (5)\\Admin\\src\\main\\webapp\\assets\\img\\category_img";
				String userDir = "C:\\maltiWenderWeb\\User\\User\\src\\main\\webapp\\assets\\img\\category_img";

				Files.createDirectories(Paths.get(adminDir));
				Files.createDirectories(Paths.get(userDir));

				Path adminPath = Paths.get(adminDir, file.getOriginalFilename());
				Files.copy(file.getInputStream(), adminPath, StandardCopyOption.REPLACE_EXISTING);

				byte[] bytes = file.getBytes();
				Path userPath = Paths.get(userDir, file.getOriginalFilename());
				Files.write(userPath, bytes); // FIXED
			}

			session.setAttribute("succMsg", "Category update success");
		} else {
			session.setAttribute("errorMsg", "something wrong on server");
		}

		return "redirect:/category/" + category.getId();
	}

	// Edit product page
	@GetMapping("/editProduct/{id}")
	public String editProduct(@PathVariable int id, Model m) {
		m.addAttribute("product", productservice.getProductById(id));
		m.addAttribute("categories", categoryservice.getAllCategory());
		return "edit_product";
	}

	// Update product
	@PostMapping("/updateProduct")
	public String updateProduct(@ModelAttribute Product product, @RequestParam("file") MultipartFile image,
			HttpSession session, Model m) {

		try {
			if (product.getDiscount() < 0 || product.getDiscount() > 100) {
				session.setAttribute("errorMsg", "Invalid Discount");
			} else {
				Product updated = productservice.updateProduct(product, image);

				if (!ObjectUtils.isEmpty(updated)) {

					if (image != null && !image.isEmpty()) {
						String fileName = image.getOriginalFilename();

						String adminPath = "C:\\maltiWenderWeb\\Admin (5)\\Admin\\src\\main\\webapp\\assets\\img\\product_img";
						Files.createDirectories(Paths.get(adminPath));
						Path adminFilePath = Paths.get(adminPath, fileName);
						Files.copy(image.getInputStream(), adminFilePath, StandardCopyOption.REPLACE_EXISTING);

						String userPath = "C:\\maltiWenderWeb\\User\\User\\src\\main\\webapp\\assets\\img\\product_img";
						Files.createDirectories(Paths.get(userPath));
						System.out.println("userPath");

						byte[] bytes = image.getBytes();
						Path userFilePath = Paths.get(userPath, fileName);
						Files.write(userFilePath, bytes); // FIXED
					}

					session.setAttribute("succMsg", "Product updated successfully");
				} else {
					session.setAttribute("errorMsg", "Something went wrong on server");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("errorMsg", "Error: " + e.getMessage());
		}

		return "redirect:/editProduct/" + product.getId();
	}

	// Admin products listing
	@GetMapping("/productview")
	public String loadViewProduct(Model m, @RequestParam(defaultValue = "") String ch,
			@RequestParam(name = "pageNo", defaultValue = "0") Integer pageNo,
			@RequestParam(name = "pageSize", defaultValue = "10") Integer pageSize) {

		Page<Product> page = ch.length() > 0 ? productservice.searchProductPagination(pageNo, pageSize, ch)
				: productservice.getAllProductsPagination(pageNo, pageSize);

		m.addAttribute("products", page.getContent());
		m.addAttribute("pageNo", page.getNumber());
		m.addAttribute("pageSize", pageSize);
		m.addAttribute("totalElements", page.getTotalElements());
		m.addAttribute("totalPages", page.getTotalPages());
		m.addAttribute("isFirst", page.isFirst());
		m.addAttribute("isLast", page.isLast());
		m.addAttribute("ch", ch);
		System.out.println("Size = " + page.getContent().size());

		return "/products";
	}

	// Delete product
	@GetMapping("/deleteProduct/{id}")
	public String deleteProduct(@PathVariable int id, HttpSession session) {
		Boolean deleteProduct = productservice.deleteProduct(id);
		if (deleteProduct) {
			session.setAttribute("succMsg", "Product delete success");
		} else {
			session.setAttribute("errorMsg", "Something wrong on server");
		}
		return "redirect:/productview";
	}
	@Autowired
    private ComplainService complainService;

	/*
	 * @Autowired private ComplainRepository complainRepository;
	 */

	@GetMapping("/complain")
	public String viewComplaints(
	        @RequestParam(defaultValue = "0") int page,
	        @RequestParam(defaultValue = "10") int size,
	        @RequestParam(required = false) String status,
	        @RequestParam(required = false) String search,
	        @RequestParam(required = false) String fromDate,
	        @RequestParam(required = false) String toDate,
	        Model model) {

	    Pageable pageable = PageRequest.of(page, size, Sort.by("createdAt").descending());
	    LocalDateTime from = null, to = null;

	    try {
	        if (fromDate != null && toDate != null && !fromDate.isEmpty() && !toDate.isEmpty()) {
	            from = LocalDate.parse(fromDate).atStartOfDay();
	            to = LocalDate.parse(toDate).atTime(LocalTime.MAX);
	        }
	    } catch (Exception e) {
	        model.addAttribute("dateError", "Invalid date format");
	    }

	    Page<Complain> complaintsPage = complainService.getComplaints(status, search, from, to, pageable);

	    // LocalDateTime → java.util.Date conversion
	    List<Map<String, Object>> complaintsForView = complaintsPage.getContent().stream().map(c -> {
	        Map<String, Object> map = new HashMap<>();
	        map.put("id", c.getId());
	        map.put("user", c.getUser());
	        map.put("orderId", c.getOrderId());
	        map.put("subject", c.getSubject());
	        map.put("message", c.getMessage());
	        map.put("status", c.getStatus());
	        map.put("createdAt", c.getCreatedAt());
	        map.put("resolvedDate", c.getResolvedDate());
	        map.put("complaintDate", Date.from(c.getComplaintDate().atZone(ZoneId.systemDefault()).toInstant())); // ✅ convert
	        map.put("attachmentName", c.getAttachmentName());
	        map.put("attachmentType", c.getAttachmentType());
	        return map;
	    }).toList();

	    model.addAttribute("complaints", complaintsForView);
	    model.addAttribute("currentPage", page + 1);
	    model.addAttribute("totalPages", complaintsPage.getTotalPages());
	    model.addAttribute("totalComplaints", complainService.count());
	    model.addAttribute("pendingCount", complainService.countByStatus("PENDING"));
	    model.addAttribute("inProgressCount", complainService.countByStatus("IN_PROGRESS"));
	    model.addAttribute("resolvedCount", complainService.countByStatus("RESOLVED"));

	    return "/Complaint";
	}
     
	
	@GetMapping("/complaint/download/{id}")
	public ResponseEntity<byte[]> downloadAttachment(@PathVariable Integer id) {

	    Complain complain = complainService.getById(id);

	    if (complain == null || complain.getAttachment() == null) {
	        return ResponseEntity.notFound().build();
	    }

	    return ResponseEntity.ok()
	            .header(HttpHeaders.CONTENT_DISPOSITION,
	                    "attachment; filename=\"" + complain.getAttachmentName() + "\"")
	            .contentType(MediaType.parseMediaType(complain.getAttachmentType()))
	            .body(complain.getAttachment());
	}

    //----------------------------------------------------------------
	
	 
	}
	  	   
