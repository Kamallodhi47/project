package com.univ.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.security.Principal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.Set;
import java.util.stream.Collectors;

import org.apache.catalina.User;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
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
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.univ.entity.UserDtls;
import com.univ.service.CartService;
import com.univ.service.ComplainService;



import com.univ.service.UserDtlsService;
import com.razorpay.Order;
import com.razorpay.RazorpayClient;
import com.razorpay.Utils;
import com.univ.Repository.ChackoutRepo;
import com.univ.Repository.OfferRepository;
import com.univ.Repository.OfferUsageRepository;
import com.univ.Repository.OrderDtlsRepo;
import com.univ.Repository.ProductRepo;
import com.univ.entity.Cart;
import com.univ.entity.Category;
import com.univ.entity.Chackout;
import com.univ.entity.Complain;
import com.univ.entity.Offer;
import com.univ.entity.OfferType;
import com.univ.entity.OfferUsage;
import com.univ.entity.OrderDtls;
import com.univ.entity.OrderItem;
import com.univ.entity.Product;

import org.springframework.ui.Model;

import jakarta.servlet.http.HttpSession;

@Controller
public class User1controller {
	@Autowired
	public UserDtlsService userDtlsService;
	
	@Autowired
	private RestTemplate restTemplate;
	
	/*
	 * @GetMapping("/") public String index(Model model, HttpSession session) {
	 * List<Category> categories = userDtlsService.getCategoriesFromAdmin().stream()
	 * .sorted((c1, c2) -> c2.getId().compareTo(c1.getId())).limit(6).toList();
	 * 
	 * session.setAttribute("categories", categories);
	 * model.addAttribute("categories", categories);
	 * 
	 * 
	 * List<Product> products = userDtlsService.getProductsFromAdmin().stream()
	 * .sorted((p1, p2) -> p2.getId().compareTo(p1.getId())).limit(8).toList();// ye
	 * method create karna hoga model.addAttribute("products", products);
	 * 
	 * List<Product> allProducts = userDtlsService.getProductsFromAdmin(); // ⭐⭐ 4.
	 * OFFER SECTION — HIGHEST DISCOUNT FIRST ⭐⭐ List<Product> offerProducts =
	 * allProducts.stream() .filter(p -> p.getDiscount() > 0) // only products with
	 * discount .sorted((p1, p2) -> Integer.compare(p2.getDiscount(),
	 * p1.getDiscount())) // highest → lowest .limit(10) // show top 10 offers
	 * .toList();
	 * 
	 * model.addAttribute("offerProducts", offerProducts);
	 * 
	 * ////////////////////////////////////////////////////////////smart offer
	 * //////////////////////// UserDtls user = (UserDtls)
	 * session.getAttribute("user");
	 * 
	 * if (user == null) { return "redirect:/Login"; } try {
	 * 
	 * 
	 * ===================================================== ⭐ Cart Data
	 * =====================================================
	 * 
	 * List<Cart> cartItems = cartService.getCartItems(user.getId());
	 * 
	 * double totalAmount = cartService.getGrandTotal(user.getId());
	 * 
	 * List<Integer> cartProductIds = cartItems.stream() .map(Cart::getProductId)
	 * .toList();
	 * 
	 * 
	 * ===================================================== ⭐ Offer Engine Logic
	 * =====================================================
	 * 
	 * 
	 * List<Offer> activeOffers = offerEngineService.getBestOffersForCart(
	 * user.getId(), totalAmount, cartProductIds, 10 );
	 * 
	 * 
	 * ===================================================== ⭐ Applied Offers
	 * Marking (UI Support) =====================================================
	 * 
	 * 
	 * if (activeOffers != null && !activeOffers.isEmpty()) {
	 * 
	 * Set<Integer> appliedIds = activeOffers.stream() .map(Offer::getId)
	 * .collect(Collectors.toSet());
	 * 
	 * activeOffers.forEach(offer ->
	 * offer.setApplied(appliedIds.contains(offer.getId())) ); } boolean isNewUser =
	 * false; boolean hasCartItems = cartItems != null && !cartItems.isEmpty();
	 * 
	 * long totalOrders = orderRepository.countByUser(user);
	 * 
	 * if (totalOrders == 0) { isNewUser = true; }
	 * 
	 * ===================================================== ⭐ Model Data
	 * =====================================================
	 * 
	 * model.addAttribute("isNewUser", isNewUser);
	 * model.addAttribute("hasCartItems", hasCartItems); model.addAttribute("user",
	 * user); model.addAttribute("cartItems", cartItems);
	 * model.addAttribute("totalAmount", totalAmount);
	 * model.addAttribute("activeOffers", activeOffers);
	 * model.addAttribute("pageTitle", "Special Offers For You");
	 * System.out.println("activeOffers="+activeOffers+"="+cartItems);
	 * 
	 * 
	 * 
	 * return "Index"; // index.jsp }
	 */
	@GetMapping("/")
	public String index(Model model, HttpSession session) {

	    /* =====================================================
	       ⭐ Categories
	    ===================================================== */
		List<Category> categories = userDtlsService.getCategoriesFromAdmin().stream()
				.sorted((c1, c2) -> c2.getId().compareTo(c1.getId())).limit(6).toList();
				  
				  session.setAttribute("categories", categories);
				  model.addAttribute("categories", categories);

	    /* =====================================================
	       ⭐ Latest Products
	    ===================================================== */
	    List<Product> allProducts = userDtlsService.getProductsFromAdmin();

	    List<Product> products = allProducts.stream()
	            .sorted((p1, p2) -> p2.getId().compareTo(p1.getId()))
	            .limit(8)
	            .toList();

	    model.addAttribute("products", products);

	    /* =====================================================
	       ⭐ Discount Products
	    ===================================================== */
	    List<Product> offerProducts = allProducts.stream()
	            .filter(p -> p.getDiscount() > 0)
	            .sorted((p1, p2) -> Integer.compare(p2.getDiscount(), p1.getDiscount()))
	            .limit(10)
	            .toList();

	    model.addAttribute("offerProducts", offerProducts);

	    /* =====================================================
	       ⭐ SMART OFFER ENGINE
	    ===================================================== */
	    UserDtls user = (UserDtls) session.getAttribute("user");

	    if (user != null) {

	          // ✅ COMMON METHOD CALL
	        model.addAttribute("user", user);
	    }

	    model.addAttribute("pageTitle", "Home");

	    return "Index";
	}
	@GetMapping("exam")
	public String ddd() {
		return "exam";
	}

	@GetMapping("/service")
	public String service(HttpSession session, Model model) {
		UserDtls user = (UserDtls) session.getAttribute("user");
		if (user == null) {
			return "redirect:/Login";
		}

		LocalDate today = LocalDate.now();
		List<OrderDtls> orders = orderRepository.findByUserOrderByOrderDateDesc(user);
		List<OrderDtls> todayOrders = new ArrayList<>();

		for (OrderDtls order : orders) {
			if (order.getOrderDate() != null && order.getOrderDate().toLocalDate().isEqual(today)) {
				todayOrders.add(order);
			}
		}

		model.addAttribute("todayOrders", todayOrders);
		return "service"; // This should match your JSP file name (service.jsp)
	}

	@RequestMapping("sel")
	public String Sel() {
		return "Seller";
	}

	@RequestMapping("register")
	public String Ragistretion() {
		return "register";
	}
	/*
	 * @RequestMapping("sel") public String Sellar() { return"Sellar"; }
	 */

	@GetMapping("/Login")
	public String showLoginPage(HttpSession session) {
		UserDtls user = (UserDtls) session.getAttribute("user");

		// agar user already login hai
		if (user != null) {
			return "redirect:/";
		}

		// session से कोई message दिखाना हो तो model में डाल सकते हो
		Object msg = session.getAttribute("msg");
		if (msg != null) {
			session.removeAttribute("msg"); // एक बार दिखा दो
		}

		return "Login"; // login.jsp
	}

	
	@GetMapping("/logout")
	public String logout(HttpSession session) {

	    session.invalidate(); // पूरा session खत्म

	    return "redirect:/Login"; // login page पर भेज दो
	}
	@RequestMapping("Das")
	public String Dasbord() {
		return "Dasbord";
	}

	@GetMapping("/products")
	public String allProducts(@RequestParam(required = false) String category,
			@RequestParam(required = false) Integer id, @RequestParam(value = "search", required = false) String search,
			Model model) {
		System.out.println("Search keyword = " + search);
		// 1. Load categories
		List<Category> categories = userDtlsService.getCategoriesFromAdmin();
		model.addAttribute("categories", categories);
		///

		// 2. Load all products
		List<Product> allProducts = userDtlsService.getProductsFromAdmin();

		// 3. CATEGORY FILTER (your requirement)
		if (category != null && !category.isEmpty()) {

			List<Product> categoryProducts = allProducts.stream()
					.filter(p -> p.getCategory() != null && p.getCategory().equalsIgnoreCase(category)).toList();

			List<Product> otherProducts = allProducts.stream()
					.filter(p -> p.getCategory() == null || !p.getCategory().equalsIgnoreCase(category)).toList();

			allProducts = new ArrayList<>();
			allProducts.addAll(categoryProducts); // Selected category first
			allProducts.addAll(otherProducts); // Other products next
			// OTHER PRODUCTS BELOW

			model.addAttribute("selectedCategory", category);
		}
		if (search != null && !search.trim().isEmpty()) {

			String keyword = search.toLowerCase();

			allProducts = allProducts.stream()
					.filter(p -> (p.getTitle() != null && p.getTitle().toLowerCase().contains(keyword))
							|| (p.getCategory() != null && p.getCategory().toLowerCase().contains(keyword))
							|| (p.getDescription() != null && p.getDescription().toLowerCase().contains(keyword)))
					.toList();

			model.addAttribute("search", search);
		}

		// 4. Selected product details
		if (id != null) {
			Product product = userDtlsService.getProductById(id);
			model.addAttribute("selectedProduct", product);
		}

		// Offer products (Top 10 discounted)
		List<Product> offerProducts = userDtlsService.getProductsFromAdmin().stream().filter(p -> p.getDiscount() > 0)
				.sorted((p1, p2) -> Integer.compare(p2.getDiscount(), p1.getDiscount())).limit(10).toList();

		model.addAttribute("offerProducts", offerProducts);

		// 5. Final product list (after category sorting)
		model.addAttribute("products", allProducts);

		return "product"; // product.jsp
	}

	///////////////////////////////////////////////////////////////////////////////////

	////////////////////////////////////////////

	@PostMapping("/saveUser")
	public String registerUser(@ModelAttribute UserDtls user, HttpSession session) {

		try {

			boolean emailExists = userDtlsService.existsEmail(user.getEmail());
			if (emailExists) {
				session.setAttribute("msg", "Email already registered!");
				return "redirect:/register";
			}

			user.setRole("USER");

			user.setIsEnable(true);

			user.setProfileImage("default-avatar.png");

			userDtlsService.save(user);

			session.setAttribute("msg", "User registered successfully! Please login.");
			return "redirect:/Login";

		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("msg", "Error occurred during registration.");
			return "redirect:/register";
		}
	}

	@PostMapping("/loginUser")
	public String loginUser(@RequestParam String email, @RequestParam String password, HttpSession session) {

		UserDtls user = userDtlsService.findByEmail(email);
		System.out.println(user);

		if (user == null) {
			session.setAttribute("msg", "Invalid email!");
			return "redirect:/Login";
		}

		if (!user.getPassword().equals(password)) {
			session.setAttribute("msg", "Wrong password!");
			return "redirect:/Login";
		}

		if (!user.getIsEnable()) {
			session.setAttribute("msg", "Account not active. Wait for admin approval.");
			return "redirect:/Login";
		}
		//session.setAttribute("user", user);
		session.setAttribute("user", user);
		session.setAttribute("userId", user.getId());
		System.out.println("final" + user);

		return "redirect:/";

	}

/////////offer//////////////                       

	
	@GetMapping("/offers")
	public String Discount(Model model, HttpSession session) {

	    // Get logged-in user from session
	    UserDtls user = (UserDtls) session.getAttribute("user");

	    // If user not logged in → redirect
	    if (user == null) {
	        return "redirect:/Login";
	    }

	    try {

	        // ✅ Call common reusable method
	       

	        // Fetch all products from admin
	        List<Product> allProducts = userDtlsService.getProductsFromAdmin();

	        // Filter discounted products and sort by highest discount
	        List<Product> offerProducts = allProducts.stream()
	                .filter(p -> p.getDiscount() > 0)
	                .sorted((p1, p2) -> Integer.compare(p2.getDiscount(), p1.getDiscount()))
	                .toList();

	        // Add discounted products separately
	        model.addAttribute("offerProducts", offerProducts);
	        model.addAttribute("pageTitle", "Top Discounted Products");

	        return "offers";

	    } catch (Exception e) {
	        e.printStackTrace();
	        model.addAttribute("error", "Error loading offers: " + e.getMessage());
	        return "error";
	    }
	}

	@GetMapping("/view")
	public String view(@RequestParam int id, Model model) {

		Product products = userDtlsService.getProductById(id);
		model.addAttribute("product", products);

		return "view";
	}

	@GetMapping("/todayOrder")
	public String todayOrder(HttpSession session, Model model) {

		UserDtls user = (UserDtls) session.getAttribute("user");

		// login check
		if (user == null) {
			return "redirect:/Login";
		}

		// aaj ki date (without time)
		LocalDate today = LocalDate.now();

		// user ke saare orders
		List<OrderDtls> orders = orderRepository.findByUserOrderByOrderDateDesc(user);

		// sirf aaj ke orders
		List<OrderDtls> todayOrders = new ArrayList<>();

		for (OrderDtls order : orders) {
			if (order.getOrderDate() != null && order.getOrderDate().toLocalDate().isEqual(today)) {

				todayOrders.add(order);
			}
		}

		// status wise lists
		List<OrderDtls> pendingOrders = new ArrayList<>();
		List<OrderDtls> deliveredOrders = new ArrayList<>();

		for (OrderDtls order : todayOrders) {
			if ("PENDING".equals(order.getStatus())) {
				pendingOrders.add(order);
			} else if ("DELIVERED".equals(order.getStatus())) {
				deliveredOrders.add(order);
			}
		}

		// model attributes
		model.addAttribute("todayOrders", todayOrders);
		model.addAttribute("totalTodayOrders", todayOrders.size());
		model.addAttribute("pendingCount", pendingOrders.size());
		model.addAttribute("deliveredCount", deliveredOrders.size());

		return "todayOrder"; // todayOrder.jsp
	}

	@GetMapping("/help")
	public String helpCenter() {
		return "help_center";
	}

	@GetMapping("/contact")
	public String contactUs() {
		return "contact_us";
	}

	@GetMapping("/about")
	public String aboutUs() {
		return "about_us";
	}

	@GetMapping("/terms")
	public String terms() {
		return "terms_conditions";
	}

	/////////////////////////////////////////////////// add to
	/////////////////////////////////////////////////// Cart////////////////////////

	@Autowired
	private CartService cartService;

	@GetMapping("/cart")
	public String viewCart(HttpSession session, Model model) {

		UserDtls user = (UserDtls) session.getAttribute("user");
		System.out.println("Logged User: " + user);

		if (user == null) {
			return "redirect:/Login";
		}

		List<Cart> items = cartService.getCartItems(user.getId());

		model.addAttribute("cartItems", items);

		return "cart";
	}

	@PostMapping("/cart/add")
	@ResponseBody
	public Map<String, Object> addToCart(@RequestBody Map<String, Object> data, HttpSession session) {

	    Map<String, Object> res = new HashMap<>();

	    UserDtls user = (UserDtls) session.getAttribute("user");

	    if (user == null) {
	        res.put("success", false);
	        res.put("msg", "Please login first!");
	        return res;
	    }

	    try {

	        Object pidObj = data.get("productId");
	        Object qtyObj = data.get("quantity");

	        if (pidObj == null || qtyObj == null) {
	            res.put("success", false);
	            res.put("msg", "ProductId or Quantity missing");
	            return res;
	        }

	        Integer pid = Integer.parseInt(pidObj.toString());
	        Integer qty = Integer.parseInt(qtyObj.toString());

	        // ✅ 1️⃣ Add product to cart
	        cartService.addProductToCart(user.getId(), pid, qty);

	        // =====================================================
	        // ✅ 2️⃣ CHECK FOR AUTO OFFERS
	        // =====================================================

	        double totalAmount = cartService.getGrandTotal(user.getId());

	        List<Cart> cartItems = cartService.getCartItems(user.getId());

	        List<Integer> cartProductIds = cartItems.stream()
	                .map(Cart::getProductId)
	                .toList();

	       
	        // 👉 check if any ADD_TO_CART_FREE_CHOICE offer available
	        
	       
	        // =====================================================
	        // ✅ 3️⃣ CART COUNT
	        // =====================================================
	        int cartCount = cartService.getCartCount(user.getId());

	        res.put("success", true);
	        res.put("cartCount", cartCount);

	    } catch (Exception e) {
	        e.printStackTrace();
	        res.put("success", false);
	        res.put("msg", "Error adding to cart");
	    }

	    return res;
	}
    @Autowired
	 private OfferRepository offerRepository;
	  //  private final OfferUsageRepository offerUsageRepository;
	
    @PostMapping("/offer/apply")
    @ResponseBody
    public Map<String, Object> applyOfferToCart(
            @RequestBody Map<String, Object> data,
            HttpSession session) {

        Map<String, Object> res = new HashMap<>();

        // ✅ FIX: Get user from session
        UserDtls user = (UserDtls) session.getAttribute("user");
        
        if (user == null) {
            res.put("success", false);
            res.put("msg", "Please login first");
            return res;
        }

        try {
            Integer offerId = Integer.parseInt(data.get("offerId").toString());

            Offer offer = offerRepository.findById(offerId).orElse(null);
            if (offer == null) {
                res.put("success", false);
                res.put("msg", "Offer not found");
                return res;
            }

            // Add eligible products
            if (offer.getEligibleProducts() != null) {
                offer.getEligibleProducts().forEach(product -> 
                    cartService.addProductToCart(user.getId(), product.getId(), 1)  // ✅ user.getId()
                );
            }

            // Add free products
            if (offer.getFreeProducts() != null) {
                offer.getFreeProducts().forEach(product -> 
                    cartService.addProductToCart(user.getId(), product.getId(), 1)  // ✅ user.getId()
                );
            }

            // Mark offer used and applied
           

            int cartCount = cartService.getCartCount(user.getId());  // ✅ user.getId()
            res.put("success", true);
            res.put("cartCount", cartCount);

        } catch (Exception e) {
            e.printStackTrace();
            res.put("success", false);
            res.put("msg", "Error applying offer");
        }

        return res;
    }
   
   
    @PostMapping("/update-qty")
	@ResponseBody
	public Map<String, Object> updateCartQty(@RequestBody Map<String, Object> data, HttpSession session) {

		Map<String, Object> res = new HashMap<>();

		UserDtls user = (UserDtls) session.getAttribute("user");

		if (user == null) {
			res.put("success", false);
			res.put("message", "Please login first");
			return res;
		}

		try {
			Integer cartId = Integer.parseInt(data.get("cartId").toString());
			Integer quantity = Integer.parseInt(data.get("quantity").toString());

			System.out.println("Updating cart: ID=" + cartId + ", Qty=" + quantity);

			// Update quantity
			Cart updatedCart = cartService.updateQuantity(cartId, quantity);

			if (updatedCart == null) {
				res.put("success", false);
				res.put("message", "Item not found in cart");
				return res;
			}

			// Get updated totals
			Double grandTotal = cartService.getGrandTotal(user.getId());

			res.put("success", true);
			res.put("itemTotal", updatedCart.getTotalPrice());
			res.put("grandTotal", grandTotal);

			System.out.println("Updated successfully. Item Total: " + updatedCart.getTotalPrice() + ", Grand Total: "
					+ grandTotal);

		} catch (NumberFormatException e) {
			res.put("success", false);
			res.put("message", "Invalid data format");
			e.printStackTrace();
		} catch (Exception e) {
			res.put("success", false);
			res.put("message", "Error updating cart");
			e.printStackTrace();
		}

		return res;
	}

	@PostMapping("/remove")
	@ResponseBody
	public Map<String, Object> removeFromCart(@RequestBody Map<String, Object> data, HttpSession session) {

		Map<String, Object> res = new HashMap<>();

		UserDtls user = (UserDtls) session.getAttribute("user");

		if (user == null) {
			res.put("success", false);
			res.put("message", "Please login first");
			return res;
		}

		try {
			Integer cartId = Integer.parseInt(data.get("cartId").toString());

			// Remove item from cart
			boolean removed = cartService.removeFromCart(cartId);

			if (removed) {
				// Get updated totals
				Double grandTotal = cartService.getGrandTotal(user.getId());
				int cartCount = cartService.getCartCount(user.getId());

				res.put("success", true);
				res.put("grandTotal", grandTotal);
				res.put("cartCount", cartCount);
			} else {
				res.put("success", false);
				res.put("message", "Item not found");
			}

		} catch (Exception e) {
			res.put("success", false);
			res.put("message", "Error removing item");
			e.printStackTrace();
		}

		return res;
	}

	@GetMapping("/count")
	@ResponseBody
	public Map<String, Object> getCartCount(HttpSession session) {

		Map<String, Object> res = new HashMap<>();

		UserDtls user = (UserDtls) session.getAttribute("user");

		if (user == null) {
			res.put("count", 0);
			return res;
		}

		int cartCount = cartService.getCartCount(user.getId());
		res.put("count", cartCount);

		return res;
	}

	@PostMapping("/clear")
	@ResponseBody
	public Map<String, Object> clearCart(HttpSession session) {

		Map<String, Object> res = new HashMap<>();

		UserDtls user = (UserDtls) session.getAttribute("user");

		if (user == null) {
			res.put("success", false);
			res.put("message", "Please login first");
			return res;
		}

		try {
			cartService.clearCart(user.getId());
			res.put("success", true);
			res.put("message", "Cart cleared successfully");
		} catch (Exception e) {
			res.put("success", false);
			res.put("message", "Error clearing cart");
			e.printStackTrace();
		}

		return res;
	}

	//////////////////////////////////////////////////////////////////////////////
	///
	@GetMapping("/checkout")
	public String checkout(HttpSession session, Model model) {

		UserDtls user = (UserDtls) session.getAttribute("user");

		if (user == null) {
			return "redirect:/Login";
		}
		List<Cart> items = cartService.getCartItems(user.getId());

		Double totalAmount = cartService.getGrandTotal(user.getId());

		model.addAttribute("cartItems", items);
		model.addAttribute("totalAmount", totalAmount);
		/* System.out.println("User Name: " + user); */
		model.addAttribute("user", user);
		return "chackout"; // JSP name
	}

	@GetMapping("/order")
	public String order() {
		return "Order";
	}

	/*
	 * @GetMapping("/todayOrder") public String order1() { return"todayOrder"; }
	 */

	@GetMapping("/profile")
	public String profile() {
		return "profile";
	}

	@Autowired
	private ComplainService complainService;

	@GetMapping("/complain")
	public String complain(@RequestParam(value = "orderId", required = false) Integer orderId, HttpSession session,
			Model model, RedirectAttributes redirectAttributes) {

		UserDtls user = (UserDtls) session.getAttribute("user");

		// 1️⃣ Login check
		if (user == null) {
			redirectAttributes.addFlashAttribute("errorMsg", "Please login first!");
			return "redirect:/Login";
		}

		// If no orderId provided, redirect to general complain page or orders
		if (orderId == null) {
			return "Complain"; // This would be a general complaint form without order
		}

		// 2️⃣ Order fetch
		OrderDtls order = orderRepository.findById(orderId).orElse(null);

		if (order == null) {
			redirectAttributes.addFlashAttribute("errorMsg", "Order not found!");
			return "redirect:/Order";
		}

		// 3️⃣ Order belongs to logged-in user
		if (!order.getUser().getId().equals(user.getId())) {
			redirectAttributes.addFlashAttribute("errorMsg", "Invalid order access!");
			return "redirect:/Order";
		}

		// 4️⃣ Only today's order allowed
		if (!order.getOrderDate().toLocalDate().equals(LocalDate.now())) {
			redirectAttributes.addFlashAttribute("errorMsg", "You can complain only for today's order!");
			return "redirect:/Order";
		}

		// 5️⃣ Only one complaint per order
		boolean alreadyComplained = complainService.existsByOrderId(orderId);
		if (alreadyComplained) {
			redirectAttributes.addFlashAttribute("errorMsg", "Complaint already submitted for this order!");
			return "redirect:/complain";
		}

		model.addAttribute("orderId", orderId);
		return "Complain"; // This should match your JSP file name (Complain.jsp)
	}

	@PostMapping("/saveComplaint")
	public String saveComplaint(@RequestParam(value = "orderId", required = false) Integer orderId,
			@RequestParam("subject") String subject, @RequestParam("message") String message,
			@RequestParam(value = "file", required = false) MultipartFile file, HttpSession session,
			RedirectAttributes redirectAttributes) {

		try {
			// 1️⃣ Check if user is logged in
			UserDtls user = (UserDtls) session.getAttribute("user");
			if (user == null) {
				redirectAttributes.addFlashAttribute("errorMsg", "Please login first!");
				return "redirect:/Login";
			}

			OrderDtls order = null;

			// 2️⃣ Validate order if orderId is provided
			if (orderId != null) {
				Optional<OrderDtls> optionalOrder = orderRepository.findById(orderId);

				if (optionalOrder.isEmpty()) {
					redirectAttributes.addFlashAttribute("errorMsg", "Order not found!");
					return "redirect:/Order";
				}

				order = optionalOrder.get();

				// Verify the order belongs to logged-in user
				if (!order.getUser().getId().equals(user.getId())) {
					redirectAttributes.addFlashAttribute("errorMsg", "Invalid order!");
					return "redirect:/Order";
				}

				// Ensure order date is today
				if (order.getOrderDate() == null || !order.getOrderDate().toLocalDate().equals(LocalDate.now())) {
					redirectAttributes.addFlashAttribute("errorMsg", "Complaint allowed only for today's orders!");
					return "redirect:/Order";
				}
			}

			// 3️⃣ Validate subject & message
			if (subject == null || subject.trim().isEmpty() || message == null || message.trim().isEmpty()) {
				redirectAttributes.addFlashAttribute("errorMsg", "All fields are required!");
				return orderId != null ? "redirect:/complain?orderId=" + orderId : "redirect:/complain";
			}

			// 4️⃣ Create and populate complaint
			Complain complain = new Complain();
			complain.setUser(user);
			if (orderId != null) {
				complain.setOrderId(orderId);
			}
			complain.setSubject(subject.trim());
			complain.setMessage(message.trim());
			complain.setStatus("PENDING");
			complain.setComplaintDate(LocalDateTime.now());
			complain.setCreatedAt(LocalDateTime.now());

			// 5️⃣ Handle file upload
			if (file != null && !file.isEmpty()) {
				complain.setAttachment(file.getBytes());
				complain.setAttachmentName(file.getOriginalFilename());
				complain.setAttachmentType(file.getContentType());
			}

			// 6️⃣ Save complaint
			complainService.saveComplaint(complain);

			redirectAttributes.addFlashAttribute("successMsg", "Complaint submitted successfully!");
			return "redirect:/todayOrder";

		} catch (Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("errorMsg", "Error while submitting complaint!");
			return "redirect:/complain";
		}
	}

	@PostMapping("/resolveComplaint")
	public String resolveComplaint(@RequestParam(value = "orderId", required = false) Integer orderId,
			HttpSession session, RedirectAttributes redirectAttributes) {

		try {
			// 1️⃣ Get logged-in user
			UserDtls user = (UserDtls) session.getAttribute("user");
			if (user == null) {
				redirectAttributes.addFlashAttribute("errorMsg", "Please login first!");
				return "redirect:/Login";
			}

			// 2️⃣ Determine complaint to resolve
			Optional<Complain> optionalComplain;

			// Only consider orderId if it's > 0 (to handle blank/0 from JSP)
			if (orderId != null && orderId > 0) {
				optionalComplain = complainService.getComplaintByOrderIdAndUserId(orderId, user.getId());
			} else {
				// If no valid orderId → get latest complaint of this user
				optionalComplain = complainService.getLatestComplaintByUserId(user.getId());
			}

			// 3️⃣ Check if complaint exists
			if (optionalComplain.isEmpty()) {
				redirectAttributes.addFlashAttribute("errorMsg", "Complaint not found!");
				return "redirect:/complain";
			}

			Complain complain = optionalComplain.get();
			System.out.println("=== Debug Complaint ===");
			System.out.println("Complaint ID: " + complain.getId());
			System.out.println("Order ID: " + complain.getOrderId());
			System.out.println("User ID: " + complain.getUser().getId());
			System.out.println("Status: " + complain.getStatus());
			System.out.println("Complaint Date: " + complain.getComplaintDate());
			System.out.println("======================");

			// 4️⃣ Already resolved?
			if ("RESOLVED".equalsIgnoreCase(complain.getStatus())) {
				redirectAttributes.addFlashAttribute("errorMsg", "Complaint is already resolved!");
				return "redirect:/complain";
			}

			// 5️⃣ Update complaint status
			complain.setStatus("RESOLVED");
			complain.setResolvedDate(java.time.LocalDateTime.now());

			// 6️⃣ Save & flush immediately
			complainService.saveComplaint(complain);

			redirectAttributes.addFlashAttribute("successMsg", "Complaint resolved successfully!");
			return "redirect:/complain";

		} catch (Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("errorMsg", "Error while resolving complaint!");
			return "redirect:/complain";
		}
	}

	// ------------------------------------------------
	// ================= RAZORPAY PAYMENT =================
	@Autowired
	private OrderDtlsRepo orderRepository;
	@Autowired
	private ChackoutRepo chackoutRepository;

	private static final String RAZORPAY_KEY = "rzp_test_SkryTQrYqgFMvD";
	private static final String RAZORPAY_SECRET = "HQKG4I6cfkQh5CgZphHx99H2";

	@PostMapping("/payment/create-order")
	@ResponseBody
	public Map<String, Object> createOrder(HttpSession session) {
		Map<String, Object> res = new HashMap<>();

		try {
			UserDtls user = (UserDtls) session.getAttribute("user");
			if (user == null) {
				res.put("error", "Please login first");
				return res;
			}

			Double total = cartService.getGrandTotal(user.getId());
			int amount = (int) (total * 100); // rupees -> paise

			RazorpayClient client = new RazorpayClient(RAZORPAY_KEY, RAZORPAY_SECRET);

			JSONObject options = new JSONObject();
			options.put("amount", amount);
			options.put("currency", "INR");
			options.put("receipt", "rcpt_" + System.currentTimeMillis());

			Order order = client.orders.create(options);

			res.put("orderId", order.get("id"));
			res.put("amount", amount);
			res.put("key", RAZORPAY_KEY);

		} catch (Exception e) {
			e.printStackTrace();
			res.put("error", "Order create failed");
		}

		return res;
	}

	@PostMapping("/payment/verify")
	public String verifyPayment(@RequestParam("razorpay_order_id") String orderId,
			@RequestParam("razorpay_payment_id") String paymentId, @RequestParam("razorpay_signature") String signature,
			HttpSession session, Model model) {

		try {
			JSONObject payload = new JSONObject();
			payload.put("razorpay_order_id", orderId);
			payload.put("razorpay_payment_id", paymentId);
			payload.put("razorpay_signature", signature);

			boolean valid = Utils.verifyPaymentSignature(payload, RAZORPAY_SECRET);

			if (valid) {
				UserDtls user = (UserDtls) session.getAttribute("user");
				if (user == null) {
					return "redirect:/login";
				}

				List<Cart> cartItems = cartService.getCartItems(user.getId());
				double grandTotal = 0;

				// 1️⃣ Create Order
				OrderDtls order = new OrderDtls();
				order.setOrderId(orderId);
				order.setPaymentId(paymentId);
				order.setUser(user);
				order.setUserName(user.getName());
				order.setStatus("PENDING");

				// Pehle save (taaki order persistent ho jaye)
				orderRepository.save(order);

				// 2️⃣ Add items & calculate total
				for (Cart c : cartItems) {
					double itemTotal = c.getTotalPrice();
					grandTotal += itemTotal;

					OrderItem orderItem = new OrderItem();
					orderItem.setUserId(user.getId());
					orderItem.setProductId(c.getProductId());
					orderItem.setProductName(c.getProductName());
					orderItem.setQuantity(c.getQuantity());
					orderItem.setPrice(c.getPrice());
					orderItem.setTotal(itemTotal);
					orderItem.setProductImage(c.getProductImage());

					order.addItem(orderItem);
				}

				// 3️⃣ Set final amount
				order.setAmount(grandTotal);
				order.setGrandTotal(grandTotal); // agar field hai

				// ⭐ Yahan dobara save zaroor karo
				orderRepository.save(order);

				// 4️⃣ Save Checkout Location
				Chackout loc = (Chackout) session.getAttribute("checkoutLocation");
				if (loc != null) {
					loc.setUser(user);
					chackoutRepository.save(loc);
					session.removeAttribute("checkoutLocation");
				}

				// 5️⃣ Clear Cart
				cartService.clearCart(user.getId());

				// 6️⃣ Send to JSP
				model.addAttribute("order", order);
				model.addAttribute("location", loc);

				return "order-success";

			} else {
				model.addAttribute("error", "Payment Failed");
				return "payment-failed";
			}

		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error", "Error verifying payment");
			return "payment-failed";
		}
	}

	@PostMapping("/address/save")
	public ResponseEntity<?> saveAddress(@RequestBody Map<String, Object> data, HttpSession session) {
		try {

			UserDtls user = (UserDtls) session.getAttribute("user");
			if (user == null) {
				return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
						.body(Map.of("success", false, "message", "User not logged in"));
			}

			Chackout address = new Chackout();
			address.setHouse((String) data.get("house"));
			address.setArea((String) data.get("area"));
			address.setLandmark((String) data.get("landmark"));
			address.setCity((String) data.get("city"));
			address.setState((String) data.get("state"));
			address.setPincode((String) data.get("pincode"));
			address.setMobile((String) data.get("mobile"));
			if (data.get("latitude") != null)
				address.setLatitude(Double.valueOf(data.get("latitude").toString()));
			if (data.get("longitude") != null)
				address.setLongitude(Double.valueOf(data.get("longitude").toString()));

			address.setUser(user);

			// Save
			chackoutRepository.save(address);

			return ResponseEntity.ok(Map.of("success", true, "message", "Address saved successfully"));
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body(Map.of("success", false, "message", e.getMessage()));
		}
	}

	@GetMapping("/list")
	public List<Chackout> listAddresses(HttpSession session) {
		UserDtls user = (UserDtls) session.getAttribute("user");
		if (user == null) {
			return List.of(); // Empty list if user not logged in
		}
		return chackoutRepository.findByUser(user);
	}

	@GetMapping("/Order")
	public String getUserOrders(HttpSession session, Model model) {

		UserDtls user = (UserDtls) session.getAttribute("user");

		// Agar user login nahi hai
		if (user == null) {
			return "redirect:/Login";
		}

		try {
			// Checkout location agar session me ho to save kar do
			Chackout loc = (Chackout) session.getAttribute("checkoutLocation");
			if (loc != null) {
				loc.setUser(user);
				chackoutRepository.save(loc);
				session.removeAttribute("checkoutLocation");
			}

			// User ke saare orders nikaal lo
			List<OrderDtls> orders = orderRepository.findByUserOrderByOrderDateDesc(user);

			// Alag-alag lists
			List<OrderDtls> pendingOrders = new ArrayList<>();
			List<OrderDtls> confirmedOrders = new ArrayList<>();
			List<OrderDtls> processingOrders = new ArrayList<>();
			List<OrderDtls> deliveredOrders = new ArrayList<>();
			List<OrderDtls> cancelledOrders = new ArrayList<>();

			for (OrderDtls order : orders) {
				String status = order.getStatus();

				if (status == null) {
					continue;
				}

				switch (status) {
				case "PENDING":
					pendingOrders.add(order);
					break;

				case "CONFIRMED":
					confirmedOrders.add(order);
					break;

				case "PROCESSING":
					processingOrders.add(order);
					break;

				case "DELIVERED":
					deliveredOrders.add(order);
					break;

				case "CANCELLED":
					cancelledOrders.add(order);
					break;

				default:
					break;
				}
			}

			// Map me daal do (agar JSP me chahiye ho)
			Map<String, List<OrderDtls>> categorizedOrders = new HashMap<>();
			categorizedOrders.put("pending", pendingOrders);
			categorizedOrders.put("confirmed", confirmedOrders);
			categorizedOrders.put("processing", processingOrders);
			categorizedOrders.put("delivered", deliveredOrders);
			categorizedOrders.put("cancelled", cancelledOrders);

			// Model me bhejo
			model.addAttribute("location", loc);
			model.addAttribute("allOrders", orders);
			model.addAttribute("categorizedOrders", categorizedOrders);
			model.addAttribute("totalOrders", orders.size());
			model.addAttribute("pendingCount", pendingOrders.size());
			model.addAttribute("deliveredCount", deliveredOrders.size());

			return "Order"; // Order.jsp

		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error", "Error loading orders");
			return "Order";
		}
	}

	@GetMapping("/Order/details/{orderId}")
	public String getOrderDetails(@PathVariable String orderId, HttpSession session, Model model) {

		// Get logged-in user from session
		UserDtls user = (UserDtls) session.getAttribute("user");
		if (user == null) {
			return "redirect:/Login";
		}

		// Fetch order by orderId and user
		OrderDtls order = orderRepository.findByOrderIdAndUser(orderId, user);

		if (order == null) {
			model.addAttribute("error", "Order not found");
			return "redirect:/orders";
		}

		// Fetch delivery address
		Chackout address = chackoutRepository.findFirstByUser(user);

		// Add data to model for JSP
		model.addAttribute("order", order);
		// model.addAttribute("location", loc);
		model.addAttribute("order", order);
		model.addAttribute("address", address);
		model.addAttribute("user", user);

		// Render JSP
		return "order-details";
	}

	/**
	 * Refresh order status (AJAX endpoint)
	 */
	@GetMapping("/Order/refresh")
	@ResponseBody
	public Map<String, Object> refreshOrderStatus(@RequestParam String orderId, HttpSession session) {
		Map<String, Object> response = new HashMap<>();

		UserDtls user = (UserDtls) session.getAttribute("user");

		if (user == null) {
			response.put("success", false);
			response.put("message", "User not logged in");
			return response;
		}

		try {
			OrderDtls order = orderRepository.findByOrderIdAndUser(orderId, user);

			if (order == null) {
				response.put("success", false);
				response.put("message", "Order not found");
				return response;
			}

			// Check if admin has confirmed the order
			boolean isConfirmed = checkAdminConfirmation(orderId);

			if (isConfirmed && "PENDING".equals(order.getStatus())) {
				// Update order status
				order.setStatus("CONFIRMED");
				order.setConfirmedDate(LocalDateTime.now());
				orderRepository.save(order);

				response.put("success", true);
				response.put("newStatus", "CONFIRMED");
				response.put("message", "Order confirmed by admin");
				response.put("order", order);
			} else {
				response.put("success", true);
				response.put("newStatus", order.getStatus());
				response.put("message", "No status change");
				response.put("order", order);
			}

		} catch (Exception e) {
			response.put("success", false);
			response.put("message", "Error refreshing order status");
			e.printStackTrace();
		}

		return response;
	}

	/**
	 * Cancel order (AJAX endpoint)
	 */
	@PostMapping("/Order/cancel")
	@ResponseBody
	public Map<String, Object> cancelOrder(@RequestBody Map<String, Object> data, HttpSession session) {
		Map<String, Object> response = new HashMap<>();

		UserDtls user = (UserDtls) session.getAttribute("user");

		if (user == null) {
			response.put("success", false);
			response.put("message", "User not logged in");
			return response;
		}

		try {
			String orderId = (String) data.get("orderId");
			String reason = (String) data.get("reason");

			OrderDtls order = orderRepository.findByOrderIdAndUser(orderId, user);

			if (order == null) {
				response.put("success", false);
				response.put("message", "Order not found");
				return response;
			}

			// Only allow cancellation if order is pending
			if (!"PENDING".equals(order.getStatus())) {
				response.put("success", false);
				response.put("message", "Order cannot be cancelled at this stage");
				return response;
			}

			// Update order status
			order.setStatus("CANCELLED");
			order.setCancelledDate(LocalDateTime.now());
			order.setCancellationReason(reason);
			orderRepository.save(order);

			// Process refund if payment was made
			if ("PAID".equals(order.getPaymentId())) {
				processRefund(order);
			}

			response.put("success", true);
			response.put("message", "Order cancelled successfully");
			response.put("order", order);

		} catch (Exception e) {
			response.put("success", false);
			response.put("message", "Error cancelling order");
			e.printStackTrace();
		}

		return response;
	}

	/**
	 * Reorder items from previous order
	 */
	@PostMapping("/Order/reorder")
	@ResponseBody
	public Map<String, Object> reorderItems(@RequestBody Map<String, Object> data, HttpSession session) {
		Map<String, Object> response = new HashMap<>();

		UserDtls user = (UserDtls) session.getAttribute("user");

		if (user == null) {
			response.put("success", false);
			response.put("message", "User not logged in");
			return response;
		}

		try {
			String orderId = (String) data.get("orderId");

			OrderDtls order = orderRepository.findByOrderIdAndUser(orderId, user);

			if (order == null) {
				response.put("success", false);
				response.put("message", "Order not found");
				return response;
			}

			// Add all items from order to cart
			int itemsAdded = 0;
			// Note: You need to implement this method in cartService
			// itemsAdded = cartService.addOrderItemsToCart(user.getId(), order);

			// For now, simulate adding items

			// itemsAdded = order.getItems() != null ? order.getItems().size() : 0;

			response.put("success", true);
			response.put("message", itemsAdded + " items added to cart");
			response.put("itemsAdded", itemsAdded);

		} catch (Exception e) {
			response.put("success", false);
			response.put("message", "Error reordering items");
			e.printStackTrace();
		}

		return response;
	}

	/**
	 * Rate order after delivery
	 */
	@PostMapping("/Order/rate")
	@ResponseBody
	public Map<String, Object> rateOrder(@RequestBody Map<String, Object> data, HttpSession session) {
		Map<String, Object> response = new HashMap<>();

		UserDtls user = (UserDtls) session.getAttribute("user");

		if (user == null) {
			response.put("success", false);
			response.put("message", "User not logged in");
			return response;
		}

		try {
			String orderId = (String) data.get("orderId");
			Integer rating = (Integer) data.get("rating");
			String review = (String) data.get("review");

			OrderDtls order = orderRepository.findByOrderIdAndUser(orderId, user);

			if (order == null) {
				response.put("success", false);
				response.put("message", "Order not found");
				return response;
			}

			// Only allow rating for delivered orders
			if (!"DELIVERED".equals(order.getStatus())) {
				response.put("success", false);
				response.put("message", "You can only rate delivered orders");
				return response;
			}

			// Update order with rating and review
			order.setRating(rating);
			order.setReview(review);
			order.setCancelledDate(LocalDateTime.now());
			orderRepository.save(order);

			response.put("success", true);
			response.put("message", "Thank you for your feedback!");
			response.put("order", order);

		} catch (Exception e) {
			response.put("success", false);
			response.put("message", "Error submitting rating");
			e.printStackTrace();
		}

		return response;
	}

	/**
	 * Get order statistics for user
	 */
	@GetMapping("/Order/stats")
	@ResponseBody
	public Map<String, Object> getOrderStats(HttpSession session) {
		Map<String, Object> response = new HashMap<>();

		UserDtls user = (UserDtls) session.getAttribute("user");

		if (user == null) {
			response.put("success", false);
			response.put("message", "User not logged in");
			return response;
		}

		try {
			List<OrderDtls> orders = orderRepository.findByUser(user);

			int totalOrders = orders.size();
			int pendingOrders = 0;
			int confirmedOrders = 0;
			int processingOrders = 0;
			int deliveredOrders = 0;
			int cancelledOrders = 0;
			double totalSpent = 0;

			for (OrderDtls order : orders) {
				switch (order.getStatus()) {
				case "PENDING":
					pendingOrders++;
					break;
				case "CONFIRMED":
					confirmedOrders++;
					break;
				case "PROCESSING":
					processingOrders++;
					break;
				case "DELIVERED":
					deliveredOrders++;

					totalSpent += order.getGrandTotal() != null ? order.getGrandTotal() : 0.0;
					break;
				case "CANCELLED":
					cancelledOrders++;
					break;
				}
			}

			response.put("success", true);
			response.put("totalOrders", totalOrders);
			response.put("pendingOrders", pendingOrders);
			response.put("confirmedOrders", confirmedOrders);
			response.put("processingOrders", processingOrders);
			response.put("deliveredOrders", deliveredOrders);
			response.put("cancelledOrders", cancelledOrders);
			response.put("totalSpent", totalSpent);
			response.put("averageOrderValue", totalOrders > 0 ? totalSpent / deliveredOrders : 0);

		} catch (Exception e) {
			response.put("success", false);
			response.put("message", "Error getting order statistics");
			e.printStackTrace();
		}

		return response;
	}

	/**
	 * Download order invoice
	 */
	@GetMapping("/Order/invoice/{orderId}")
	public String downloadInvoice(@PathVariable String orderId, HttpSession session, Model model) {
		UserDtls user = (UserDtls) session.getAttribute("user");

		if (user == null) {
			return "redirect:/Login";
		}

		try {
			OrderDtls order = orderRepository.findByOrderIdAndUser(orderId, user);

			if (order == null) {
				model.addAttribute("error", "Order not found");
				return "redirect:/orders";
			}

			// Get delivery address
			Chackout address = chackoutRepository.findFirstByUser(user);

			model.addAttribute("order", order);
			model.addAttribute("address", address);
			model.addAttribute("user", user);

			return "invoice"; // invoice.jsp or PDF generation

		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error", "Error generating invoice");
			return "redirect:/orders";
		}
	}

	/**
	 * Update payment status
	 */
	@PostMapping("/Order/payment/update")
	@ResponseBody
	public Map<String, Object> updatePaymentStatus(@RequestBody Map<String, Object> data, HttpSession session) {
		Map<String, Object> response = new HashMap<>();

		UserDtls user = (UserDtls) session.getAttribute("user");

		if (user == null) {
			response.put("success", false);
			response.put("message", "User not logged in");
			return response;
		}

		try {
			String orderId = (String) data.get("orderId");
			String paymentStatus = (String) data.get("paymentStatus");

			OrderDtls order = orderRepository.findByOrderIdAndUser(orderId, user);

			if (order == null) {
				response.put("success", false);
				response.put("message", "Order not found");
				return response;
			}

			order.setPaymentId(paymentStatus);
			orderRepository.save(order);

			response.put("success", true);
			response.put("message", "Payment status updated");
			response.put("order", order);

		} catch (Exception e) {
			response.put("success", false);
			response.put("message", "Error updating payment status");
			e.printStackTrace();
		}

		return response;
	}

	/**
	 * Get pending orders (for user)
	 */
	@GetMapping("/Order/pending")
	public String getPendingOrders(HttpSession session, Model model) {
		UserDtls user = (UserDtls) session.getAttribute("user");

		if (user == null) {
			return "redirect:/Login";
		}

		try {
			List<OrderDtls> pendingOrders = orderRepository.findByUserAndStatusOrderByOrderDateDesc(user, "PENDING");

			model.addAttribute("orders", pendingOrders);
			model.addAttribute("orderType", "Pending Orders");
			model.addAttribute("orderCount", pendingOrders.size());

			return "orders-list"; // Reuse orders-list.jsp

		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error", "Error loading pending orders");
			return "orders";
		}
	}

	/**
	 * Get delivered orders (for user)
	 */
	@GetMapping("/Order/delivered")
	public String getDeliveredOrders(HttpSession session, Model model) {
		UserDtls user = (UserDtls) session.getAttribute("user");

		if (user == null) {
			return "redirect:/Login";
		}

		try {
			List<OrderDtls> deliveredOrders = orderRepository.findByUserAndStatusOrderByOrderDateDesc(user,
					"DELIVERED");

			model.addAttribute("orders", deliveredOrders);
			model.addAttribute("orderType", "Delivered Orders");
			model.addAttribute("orderCount", deliveredOrders.size());

			return "orders-list"; // Reuse orders-list.jsp

		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error", "Error loading delivered orders");
			return "orders";
		}
	}

	/**
	 * Get cancelled orders (for user)
	 */
	@GetMapping("/Order/cancelled")
	public String getCancelledOrders(HttpSession session, Model model) {
		UserDtls user = (UserDtls) session.getAttribute("user");

		if (user == null) {
			return "redirect:/Login";
		}

		try {
			List<OrderDtls> cancelledOrders = orderRepository.findByUserAndStatusOrderByOrderDateDesc(user,
					"CANCELLED");

			model.addAttribute("orders", cancelledOrders);
			model.addAttribute("orderType", "Cancelled Orders");
			model.addAttribute("orderCount", cancelledOrders.size());

			return "orders-list"; // Reuse orders-list.jsp

		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error", "Error loading cancelled orders");
			return "orders";
		}
	}

	// ================= HELPER METHODS =================

	/**
	 * Check if admin has confirmed the order
	 */
	private boolean checkAdminConfirmation(String orderId) {
		// In real application, this would check from admin database or call admin API
		// For simulation, we'll use 80% chance of confirmation

		// Uncomment for real implementation:
		// return orderService.isOrderConfirmedByAdmin(orderId);

		// Simulation:
		return Math.random() > 0.2;
	}

	/**
	 * Process refund for cancelled order
	 */
	private void processRefund(OrderDtls order) {
		// Implement refund logic here
		// This would integrate with payment gateway API

		System.out.println("Processing refund for order: " + order.getOrderId());

		// Example Razorpay refund:
		try {
			RazorpayClient client = new RazorpayClient(RAZORPAY_KEY, RAZORPAY_SECRET);

			JSONObject refundRequest = new JSONObject();
			refundRequest.put("amount", (int) (order.getAmount() * 100)); // Convert to paise
			refundRequest.put("speed", "normal");
			refundRequest.put("notes", Map.of("reason", "Order cancellation", "order_id", order.getOrderId()));

			// Uncomment to actually process refund
			// com.razorpay.Refund refund = client.payments.refund(order.getPaymentId(),
			// refundRequest);

			System.out.println("Refund processed for payment: " + order.getPaymentId());

		} catch (Exception e) {
			System.err.println("Error processing refund: " + e.getMessage());
		}
	}

	
 
 
  

	    

	               

	                
	    
  

  
	

	   
	}
