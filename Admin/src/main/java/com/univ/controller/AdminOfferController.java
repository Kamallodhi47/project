package com.univ.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.univ.entity.Offer;
import com.univ.entity.OfferType;
import com.univ.entity.Product;
import com.univ.service.AdminOfferService;
import com.univ.service.Productservice;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class AdminOfferController {

    private final AdminOfferService adminOfferService;
    private final Productservice productservice;

    public AdminOfferController(AdminOfferService adminOfferService,
                                Productservice productservice) {
        this.adminOfferService = adminOfferService;
        this.productservice = productservice;
    }
    
    @GetMapping("/offers")
    public String showOfferDashboard(Model model) {
        // Get all offers sorted by priority
        List<Offer> offers = adminOfferService.getAllOffers();
        List<Product> products = productservice.findAll();
        
        model.addAttribute("offers", offers);
        model.addAttribute("products", products);
        model.addAttribute("offerTypes", OfferType.values());
        model.addAttribute("activeCount", offers.stream().filter(Offer::getActive).count());
       // System.out.println("offers");
        
        return "/offer-dashboard";
    }

    @GetMapping("/new")
    public String showCreateForm(Model model) {
        model.addAttribute("offer", new Offer());
        model.addAttribute("products",productservice.findAll());
        model.addAttribute("offerTypes", OfferType.values());
        model.addAttribute("isEdit", false);
        
        return "/create-offer";
    }
    /*
    ==========================================
    ✅ Save Offer + Upload Banner
    ==========================================
    */
    @PostMapping("/save")
    public String saveOffer(
            Offer offer,
            @RequestParam(required = false) List<Integer> eligibleProductIds,
            @RequestParam(required = false) List<Integer> freeProductIds,
            @RequestParam("bannerFile") MultipartFile bannerFile,
            HttpSession session) {

        try {

            // ✅ Product Mapping
            if (eligibleProductIds != null && !eligibleProductIds.isEmpty()) {
                offer.setEligibleProducts(
                        productservice.findAllById(eligibleProductIds));
            }

            if (freeProductIds != null && !freeProductIds.isEmpty()) {
                offer.setFreeProducts(
                		
                        productservice.findAllById(freeProductIds));
                System.out.println(eligibleProductIds);
            }

            // ⭐ Banner File Name Generate
            String imageName = null;

            if (bannerFile != null && !bannerFile.isEmpty()) {
                imageName = System.currentTimeMillis() + "_" + bannerFile.getOriginalFilename();
                offer.setBannerImage(imageName);
            }

            // ✅ Save Offer First (Important ⭐)
           

            // ⭐ Upload Banner File After DB Save
            if (bannerFile != null && !bannerFile.isEmpty()) {

                String adminDir =
                        "C:\\freshpickmart\\Admin\\src\\main\\webapp\\uploads\\banner";

                String userDir =
                        "C:\\freshpickmart\\User\\src\\main\\webapp\\uploads\\banner";

                Files.createDirectories(Paths.get(adminDir));
                Files.createDirectories(Paths.get(userDir));

                Path adminPath = Paths.get(adminDir, imageName);
                Path userPath = Paths.get(userDir, imageName);

                Files.copy(bannerFile.getInputStream(),
                        adminPath,
                        StandardCopyOption.REPLACE_EXISTING);

                Files.copy(bannerFile.getInputStream(),
                        userPath,
                        StandardCopyOption.REPLACE_EXISTING);
            }

            session.setAttribute("success", "Offer saved successfully");

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Error : " + e.getMessage());
        }

        return "redirect:/admin/offers";
    }
    /*
    ==========================================
    ✅ Get All Offers
    ==========================================
    */
    @GetMapping("/all")
    @ResponseBody
    public Object getAllOffers() {
        return adminOfferService.getAllOffers();
    }

    /*
    ==========================================
    ✅ Get Active Offers
    ==========================================
    */
    @GetMapping("/active")
    @ResponseBody
    public Object getActiveOffers() {
        return adminOfferService.getActiveOffers();
    }

    
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable Integer id, Model model) {
        Optional<Offer> offer = adminOfferService.getOfferById(id);
        model.addAttribute("offer", offer);
        model.addAttribute("products", productservice.findAll());
        model.addAttribute("offerTypes", OfferType.values());
        model.addAttribute("isEdit", true);
        
        return "admin/offer-form";
    }
    /*
    ==========================================
    ✅ Toggle Offer Status
    ==========================================
    */
    @PostMapping("/toggle/{id}")
    public String toggleOffer(@PathVariable Integer id, RedirectAttributes redirectAttributes) {
        try {
            adminOfferService.toggleOffer(id);
            redirectAttributes.addFlashAttribute("success", "Offer status updated!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/offers";
    }
    /*
    ==========================================
    ✅ Delete Offer
    ==========================================
    */
    @PostMapping("/delete/{id}")
    public String deleteOffer(@PathVariable Integer id, RedirectAttributes redirectAttributes) {
        try {
            adminOfferService.deleteOffer(id);
            redirectAttributes.addFlashAttribute("success", "Offer deleted successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
        }
        return "redirect:/admin/offers";
    }
    @GetMapping("/analytics")
    public String showAnalytics(Model model) {
        List<Offer> offers = adminOfferService.getAllOffers();
        
        long totalOffers = offers.size();
        long activeOffers = offers.stream().filter(Offer::getActive).count();
        long expiredOffers = offers.stream()
                .filter(o -> o.getEndDate() != null && o.getEndDate().isBefore(java.time.LocalDateTime.now()))
                .count();
        
        model.addAttribute("totalOffers", totalOffers);
        model.addAttribute("activeOffers", activeOffers);
        model.addAttribute("expiredOffers", expiredOffers);
        model.addAttribute("offers", offers);
        
        return "admin/offer-analytics";
    }
}