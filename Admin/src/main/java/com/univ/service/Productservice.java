package com.univ.service;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.util.ObjectUtils;
import org.springframework.web.multipart.MultipartFile;

import com.univ.Repository.Productrepo;
import com.univ.entity.Offer;
import com.univ.entity.Product;

@Service
public class Productservice {

    @Autowired
    private Productrepo productrepo;

    // ✅ SAVE PRODUCT (ADD NEW PRODUCT)
    public Product saveProduct(Product product) {

        Double price = product.getPrice();
        int discount = product.getDiscount();

        // 🔥 Calculate discount price
        Double discountPrice = price - (price * discount / 100.0);

        product.setDiscountPrice(discountPrice);
        product.setIsActive(true);

        return productrepo.save(product);
    }

    public List<Product> getAllProducts() {
        return productrepo.findAll();
    }

    public List<Product> getActiveProducts() {
        return productrepo.findByIsActiveTrue();
    }

    public Product getProductById(Integer id) {
        return productrepo.findById(id).orElse(null);
    }

    // ✅ UPDATE PRODUCT
    public Product updateProduct(Product product, MultipartFile image) {

        Product dbProduct = getProductById(product.getId());

        if (dbProduct == null) {
            return null;
        }

        String imageName = image.isEmpty() ? dbProduct.getImage() : image.getOriginalFilename();

        dbProduct.setTitle(product.getTitle());
        dbProduct.setDescription(product.getDescription());
        dbProduct.setCategory(product.getCategory());
        dbProduct.setPrice(product.getPrice());
        dbProduct.setStockQty(product.getStockQty());
        dbProduct.setStockUnit(product.getStockUnit());

        dbProduct.setImage(imageName);
        dbProduct.setIsActive(product.getIsActive());
        dbProduct.setDiscount(product.getDiscount());

        // 🔥 Calculate discount price again
        Double discountPrice =
                product.getPrice() - (product.getPrice() * product.getDiscount() / 100.0);
        dbProduct.setDiscountPrice(discountPrice);

        Product updatedProduct = productrepo.save(dbProduct);

        // ✅ Save image if uploaded
        if (!ObjectUtils.isEmpty(updatedProduct) && !image.isEmpty()) {
            try {
                // Admin path
                String adminUploadDir =
                        "C:\\maltiWenderWeb\\Admin (5)\\Admin\\src\\main\\webapp\\assets\\img\\Product_img";
                Path adminPath = Paths.get(adminUploadDir, image.getOriginalFilename());
                Files.copy(image.getInputStream(), adminPath, StandardCopyOption.REPLACE_EXISTING);

                // User path
                String userUploadDir =
                        "C:\\maltiWenderWeb\\User\\User\\src\\main\\webapp\\assets\\img\\product_img";
                Path userPath = Paths.get(userUploadDir, image.getOriginalFilename());
                Files.copy(image.getInputStream(), userPath, StandardCopyOption.REPLACE_EXISTING);

            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return updatedProduct;
    }

    public List<Product> searchProduct(String ch) {
        return productrepo.findByTitleContainingIgnoreCaseOrCategoryContainingIgnoreCase(ch, ch);
    }

    public Page<Product> searchProductPagination(Integer pageNo, Integer pageSize, String ch) {
        Pageable pageable = PageRequest.of(pageNo, pageSize);
        return productrepo.findByTitleContainingIgnoreCaseOrCategoryContainingIgnoreCase(ch, ch, pageable);
    }

    public Page<Product> getAllActiveProductPagination(Integer pageNo, Integer pageSize, String category) {

        Pageable pageable = PageRequest.of(pageNo, pageSize);

        if (ObjectUtils.isEmpty(category)) {
            return productrepo.findByIsActiveTrue(pageable);
        } else {
            return productrepo.findByCategory(pageable, category);
        }
    }

    public Page<Product> searchActiveProductPagination(Integer pageNo, Integer pageSize, String ch) {

        Pageable pageable = PageRequest.of(pageNo, pageSize);
        return productrepo.findByisActiveTrueAndTitleContainingIgnoreCaseOrCategoryContainingIgnoreCase(
                ch, ch, pageable);
    }

    public Page<Product> getAllProductsPagination(Integer pageNo, Integer pageSize) {
        Pageable pageable = PageRequest.of(pageNo, pageSize);
        return productrepo.findAll(pageable);
    }

    public Boolean deleteProduct(Integer id) {

        Product product = productrepo.findById(id).orElse(null);

        if (!ObjectUtils.isEmpty(product)) {
            productrepo.delete(product);
            return true;
        }
        return false;
    }

    public List<Product> findAll() {
        return productrepo.findAll();
    }

    public List<Product> findAllById(List<Integer> productIds) {
        if (productIds == null || productIds.isEmpty()) {
            return List.of(); // empty list return karega
        }
        return productrepo.findAllById(productIds);
    }
	
}

