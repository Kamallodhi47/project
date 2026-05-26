package com.univ.configretion.copy;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class CorsConfig {

    @Bean
    public WebMvcConfigurer corsConfigurer() {
        return new WebMvcConfigurer() {

            // ✅ CORS config
            @Override
            public void addCorsMappings(CorsRegistry registry) {
                registry.addMapping("/api/**")
                        .allowedOrigins("http://localhost:8083"); // User project ka origin
            }

            // ✅ Static resource mapping
            @Override
            public void addResourceHandlers(ResourceHandlerRegistry registry) {
            	 // Admin Category images
                registry.addResourceHandler("/admin_images/category/**")
                        .addResourceLocations("C:\\maltiWenderWeb\\Admin (5)\\Admin\\src\\main\\webapp\\assets\\img\\category_img");

                // Admin Product images
                registry.addResourceHandler("/admin_images/product/**")
                        .addResourceLocations("C:\\maltiWenderWeb\\Admin (5)\\Admin\\src\\main\\webapp\\assets\\img\\product_img");

                // User Category images
                registry.addResourceHandler("/user_images/category/**")
                        .addResourceLocations("C:\\maltiWenderWeb\\User\\User\\src\\main\\webapp\\assets\\img\\category_img");

                // User Product images
                registry.addResourceHandler("/user_images/product/**")
                        .addResourceLocations("C:\\maltiWenderWeb\\User\\User\\src\\main\\webapp\\assets\\img\\product_img");
                           }
        };
    }
}
