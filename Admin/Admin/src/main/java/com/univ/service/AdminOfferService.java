package com.univ.service;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.univ.Repository.OfferRepository;
import com.univ.Repository.OfferUsageRepository;
import com.univ.Repository.Productrepo;
import com.univ.entity.Offer;

import jakarta.servlet.http.HttpSession;

@Service
public class AdminOfferService {

	private final OfferRepository offerRepository;
	private final OfferUsageRepository offerUsageRepository;

	private final Productrepo productrepo;

	public AdminOfferService(OfferRepository offerRepository, OfferUsageRepository offerUsageRepository,
			Productrepo productrepo) {

		this.offerRepository = offerRepository;
		this.offerUsageRepository = offerUsageRepository;
		this.productrepo = productrepo;
	}

	/*
	 * ========================================== ✅ Create / Update Offer
	 * ==========================================
	 */
	public Offer saveOffer(Offer offer) {

		if (offer.getStartDate() == null || offer.getEndDate() == null) {
			throw new RuntimeException("Offer Date Required");
		}

		if (offer.getStartDate().isAfter(offer.getEndDate())) {
			throw new RuntimeException("Invalid Date Range");
		}

		return offerRepository.save(offer);
	}

	/*
	 * ========================================== ✅ Get Active Offers
	 * ==========================================
	 */
	public List<Offer> getActiveOffers() {

		LocalDateTime now = LocalDateTime.now();

		return offerRepository.findActiveOffers(now);
	}

	/*
	 * ========================================== ✅ Toggle Offer Status
	 * ==========================================
	 */
	public void toggleOffer(Integer offerId) {

		Offer offer = offerRepository.findById(offerId).orElseThrow(() -> new RuntimeException("Offer Not Found"));

		offer.setActive(!offer.getActive());

		offerRepository.save(offer);
	}

	public void uploadBannerImage(Integer offerId, MultipartFile bannerFile) {

		try {

			// 🔴 Validation
			if (bannerFile == null || bannerFile.isEmpty()) {
				throw new RuntimeException("Please upload banner image");
			}

			// ✅ Unique Image Name
			String imageName = System.currentTimeMillis() + "_" + bannerFile.getOriginalFilename();

			// ✅ Check Offer Exists
			Offer offer = offerRepository.findById(offerId).orElseThrow(() -> new RuntimeException("Offer not found"));

			// ✅ Save DB First
			offer.setBannerImage(imageName);
			offerRepository.save(offer);

			// ✅ Directory Paths (Change According To Your Project)
			String adminDir = "C:\\freshpickmart\\Admin\\src\\main\\webapp\\uploads\\banner";
			String userDir = "C:\\freshpickmart\\User\\src\\main\\webapp\\uploads\\banner";

			Files.createDirectories(Paths.get(adminDir));
			Files.createDirectories(Paths.get(userDir));

			Path adminPath = Paths.get(adminDir, imageName);
			Path userPath = Paths.get(userDir, imageName);

			Files.copy(bannerFile.getInputStream(), adminPath, StandardCopyOption.REPLACE_EXISTING);

			Files.copy(bannerFile.getInputStream(), userPath, StandardCopyOption.REPLACE_EXISTING);

		} catch (Exception e) {
			throw new RuntimeException("Banner upload failed : " + e.getMessage());
		}
	}

	public void deleteOffer(Integer offerId) {
		offerRepository.deleteById(offerId);
	}

	/*
	 * @PostMapping("/updateBanner") public String updateBanner(@RequestParam
	 * Integer offerId,
	 * 
	 * @RequestParam("bannerFile") MultipartFile file, HttpSession session) {
	 * 
	 * try {
	 * 
	 * if (file == null || file.isEmpty()) { session.setAttribute("errorMsg",
	 * "Please upload banner image"); return "redirect:/admin/offers"; }
	 * 
	 * // ✅ Unique File Name String imageName = System.currentTimeMillis() + "_" +
	 * file.getOriginalFilename();
	 * 
	 * // ✅ Save DB First Offer offer = offerRepository.findById(offerId)
	 * .orElseThrow(() -> new RuntimeException("Offer not found"));
	 * 
	 * offer.setBannerImage(imageName); offerRepository.save(offer);
	 * 
	 * // ✅ Directory Paths (Change According to Your Project)
	 * 
	 * String adminDir =
	 * "C:\\freshpickmart\\Admin\\src\\main\\webapp\\uploads\\banner"; String
	 * userDir = "C:\\freshpickmart\\User\\src\\main\\webapp\\uploads\\banner";
	 * 
	 * 
	 * Files.createDirectories(Paths.get(adminDir));
	 * Files.createDirectories(Paths.get(userDir));
	 * 
	 * Path adminPath = Paths.get(adminDir, imageName); Path userPath =
	 * Paths.get(userDir, imageName);
	 * 
	 * Files.copy(file.getInputStream(), adminPath,
	 * StandardCopyOption.REPLACE_EXISTING); Files.copy(file.getInputStream(),
	 * userPath, StandardCopyOption.REPLACE_EXISTING);
	 * 
	 * session.setAttribute("succMsg", "Banner updated successfully");
	 * 
	 * } catch (Exception e) { e.printStackTrace(); session.setAttribute("errorMsg",
	 * "Banner upload failed"); }
	 * 
	 * return "redirect:/admin/offers"; }
	 */
	public List<Offer> getAllOffers() {

		return offerRepository.findAll().stream().sorted((o1, o2) -> o2.getPriority().compareTo(o1.getPriority()))
				.toList();
	}

	public Optional<Offer> getOfferById(Integer id) {
		return offerRepository.findById(id);
	}

}