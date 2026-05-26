<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>FreshpickKart - Premium Shopping Experience</title>

<!-- Bootstrap -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<!-- Google Fonts: Fraunces (luxury display) + Plus Jakarta Sans (clean body) -->
<link
	href="https://fonts.googleapis.com/css2?family=Fraunces:ital,opsz,wght@0,9..144,300;0,9..144,600;0,9..144,700;0,9..144,800;1,9..144,600&family=Plus+Jakarta+Sans:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">

<style>
/* ============================================================
   DESIGN TOKENS — FreshpickKart Premium
   Palette: Deep Teal · Saffron Gold · Ivory · Leaf Green
   ============================================================ */
:root {
  /* Brand Colors */
  --teal:        #0d4f5c;
  --teal-2:      #1a6b7a;
  --teal-3:      #2a8fa0;
  --teal-light:  #e0f4f7;
  --saffron:     #e07b24;
  --saffron-2:   #f59332;
  --saffron-light: #fef0e0;
  --ivory:       #faf8f3;
  --ivory-2:     #f2ede3;
  --ivory-3:     #e8e1d4;
  --leaf:        #2d6a4f;
  --leaf-2:      #40916c;
  --leaf-light:  #d8f3dc;
  --crimson:     #b5281c;
  --crimson-light: #fdecea;

  /* Neutrals */
  --ink:         #1a1a1a;
  --ink-2:       #2e2e2e;
  --muted:       #6b6b6b;
  --muted-2:     #999999;
  --white:       #ffffff;
  --surface:     #f5f2ec;

  /* Shadows */
  --shadow-xs:   0 1px 3px rgba(13,79,92,0.08);
  --shadow-sm:   0 2px 10px rgba(13,79,92,0.10), 0 6px 24px rgba(13,79,92,0.06);
  --shadow-md:   0 6px 24px rgba(13,79,92,0.12), 0 16px 48px rgba(13,79,92,0.07);
  --shadow-lg:   0 12px 48px rgba(13,79,92,0.16), 0 32px 80px rgba(13,79,92,0.08);

  /* Radii */
  --r-sm:  8px;
  --r-md:  14px;
  --r-lg:  20px;
  --r-xl:  28px;
  --r-2xl: 36px;

  /* Legacy compat (keeps JS color refs working) */
  --primary:   #0d4f5c;
  --secondary: #1a6b7a;
  --accent:    #e07b24;
  --success:   #2d6a4f;
  --warning:   #f59332;
  --dark:      #1a1a1a;
  --light:     #faf8f3;
  --text:      #6b6b6b;
}

/* ============================================================
   RESET & BASE
   ============================================================ */
*, *::before, *::after {
  margin: 0; padding: 0;
  box-sizing: border-box;
  -webkit-tap-highlight-color: transparent;
}
html { font-size: 16px; scroll-behavior: smooth; }

body {
  background-color: var(--surface);
  background-image:
    radial-gradient(ellipse 80% 50% at 15% -10%, rgba(13,79,92,0.07) 0%, transparent 60%),
    radial-gradient(ellipse 60% 40% at 90% 110%, rgba(224,123,36,0.06) 0%, transparent 55%);
  font-family: 'Plus Jakarta Sans', system-ui, sans-serif;
  color: var(--ink);
  min-height: 100vh;
  padding-top: 70px;
  overflow-x: hidden;
  touch-action: pan-y;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

h1, h2, h3, h4, h5, h6 {
  font-family: 'Fraunces', serif;
  font-weight: 700;
  color: var(--teal);
}

/* Text utility overrides */
.text-dark    { color: var(--ink-2)    !important; }
.text-danger  { color: var(--crimson)  !important; }
.text-success { color: var(--leaf)     !important; }
.text-muted   { color: var(--muted)    !important; }

/* ============================================================
   HERO SECTION
   ============================================================ */
.hero-section {
  background:
    linear-gradient(135deg, var(--ivory) 0%, var(--ivory-2) 60%, #ecdfc8 100%);
  padding: 72px 0 80px;
  margin-bottom: 0;
  position: relative;
  overflow: hidden;
}

/* Geometric accent — large circle top-right */
.hero-section::before {
  content: '';
  position: absolute;
  top: -160px; right: -160px;
  width: 560px; height: 560px;
  border-radius: 50%;
  background: radial-gradient(circle, rgba(13,79,92,0.07) 0%, transparent 65%);
  pointer-events: none;
}

/* Floating dot pattern */
.hero-section::after {
  content: '';
  position: absolute;
  bottom: 20px; left: 0; right: 0;
  height: 3px;
  background: linear-gradient(90deg,
    transparent 0%,
    var(--teal-3) 25%,
    var(--saffron) 55%,
    var(--leaf-2) 80%,
    transparent 100%);
  opacity: 0.5;
}

/* Animated floating pattern from original — kept, refined */
@keyframes floatPattern {
  0%   { background-position: 0 0; }
  100% { background-position: 300px 300px; }
}

/* ---- Hero Title ---- */
.hero-title {
  font-family: 'Fraunces', serif;
  font-size: clamp(2.2rem, 5.5vw, 3.8rem);
  font-weight: 800;
  line-height: 1.12;
  letter-spacing: -0.025em;
  margin-bottom: 1.4rem;
  color: var(--teal);
  /* override gradient clip from original */
  background: none;
  -webkit-background-clip: unset;
  -webkit-text-fill-color: unset;
  background-clip: unset;
}

.hero-title span {
  font-style: italic;
  color: var(--saffron);
  /* override gradient clip from original */
  background: none;
  -webkit-background-clip: unset;
  -webkit-text-fill-color: unset;
  background-clip: unset;
}

/* ---- Hero Description ---- */
.hero-description {
  font-size: 1.08rem;
  color: var(--muted);
  margin-bottom: 1.8rem;
  line-height: 1.78;
  max-width: 88%;
  font-weight: 300;
}

/* ---- Feature Pills ---- */
.hero-features {
  display: flex;
  flex-wrap: wrap;
  gap: 12px;
  margin-bottom: 2.2rem;
}

.feature {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  padding: 9px 18px;
  background: rgba(255,255,255,0.82);
  border: 1px solid var(--ivory-3);
  border-radius: 50px;
  font-size: 0.83rem;
  font-weight: 600;
  color: var(--teal);
  letter-spacing: 0.01em;
  backdrop-filter: blur(10px);
  transition: all 0.26s cubic-bezier(0.34,1.4,0.64,1);
  box-shadow: var(--shadow-xs);
}
.feature:hover {
  background: var(--white);
  border-color: var(--saffron);
  transform: translateY(-3px);
  box-shadow: var(--shadow-sm);
}

.feature-icon {
  font-size: 0.88rem;
  color: var(--saffron) !important;
  /* Override gradient from original */
  background: none !important;
  -webkit-background-clip: unset !important;
  -webkit-text-fill-color: unset !important;
  background-clip: unset !important;
}

/* ---- CTA Buttons ---- */
.cta-buttons {
  display: flex;
  gap: 14px;
  flex-wrap: wrap;
}

.cta-primary {
  padding: 14px 32px;
  font-family: 'Plus Jakarta Sans', sans-serif;
  font-size: 0.97rem;
  font-weight: 700;
  border-radius: var(--r-md);
  border: none;
  background: var(--teal);
  color: var(--ivory) !important;
  letter-spacing: 0.02em;
  box-shadow: 0 6px 24px rgba(13,79,92,0.32);
  transition: all 0.28s cubic-bezier(0.34,1.4,0.64,1);
  display: inline-flex; align-items: center; justify-content: center; gap: 9px;
  cursor: pointer;
}
.cta-primary:hover {
  background: var(--teal-2);
  transform: translateY(-3px);
  box-shadow: 0 10px 36px rgba(13,79,92,0.4);
  color: var(--ivory) !important;
}

.cta-secondary {
  padding: 13px 30px;
  font-family: 'Plus Jakarta Sans', sans-serif;
  font-size: 0.97rem;
  font-weight: 700;
  border-radius: var(--r-md);
  background: transparent;
  border: 2px solid var(--teal);
  color: var(--teal) !important;
  letter-spacing: 0.02em;
  transition: all 0.26s ease;
  display: inline-flex; align-items: center; justify-content: center; gap: 9px;
  cursor: pointer;
}
.cta-secondary:hover {
  background: var(--teal);
  color: var(--ivory) !important;
  transform: translateY(-2px);
  box-shadow: 0 8px 28px rgba(13,79,92,0.28);
}

/* ---- Hero Slider ---- */
.hero-slider-container {
  position: relative;
  border-radius: var(--r-xl);
  overflow: hidden;
  box-shadow: var(--shadow-lg);
  height: 450px;
  border: 1px solid var(--ivory-3);
}

.hero-slider {
  display: flex;
  width: 100%; height: 100%;
  transition: transform 0.68s cubic-bezier(0.77,0,0.18,1);
}
.hero-slide { min-width: 100%; height: 100%; flex-shrink: 0; }
.slider-content { position: relative; height: 100%; width: 100%; }

.hero-slider-img {
  width: 100%; height: 100%;
  object-fit: cover;
  transition: transform 9s ease;
}
.hero-slide.active .hero-slider-img { transform: scale(1.06); }

.offer-badge {
  position: absolute;
  top: 20px; right: 20px;
  background: var(--saffron);
  color: var(--white);
  padding: 10px 22px;
  border-radius: 50px;
  font-family: 'Plus Jakarta Sans', sans-serif;
  font-weight: 800;
  font-size: 1rem;
  z-index: 2;
  letter-spacing: 0.02em;
  box-shadow: 0 6px 22px rgba(224,123,36,0.42);
  animation: pulseBadge 2.4s ease-in-out infinite;
}
@keyframes pulseBadge {
  0%,100% { transform: scale(1); }
  50%      { transform: scale(1.05); }
}

.slider-caption {
  position: absolute;
  bottom: 0; left: 0; right: 0;
  background: linear-gradient(to top, rgba(13,30,35,0.88) 0%, transparent 100%);
  color: white;
  padding: 30px;
  padding-top: 70px;
}
.slider-caption h3 {
  font-family: 'Fraunces', serif;
  font-size: 1.75rem;
  font-weight: 700;
  color: var(--white);
  margin-bottom: 5px;
}
.slider-caption p {
  font-size: 1rem;
  opacity: 0.88;
  color: #f5d9b0;
  font-weight: 300;
}

/* Slider Controls */
.slider-controls {
  position: absolute;
  bottom: 20px; left: 0; right: 0;
  display: flex; align-items: center; justify-content: center; gap: 18px;
  z-index: 3;
}
.slider-btn {
  width: 48px; height: 48px;
  border-radius: 50%;
  background: rgba(250,248,243,0.92);
  border: 1px solid rgba(255,255,255,0.3);
  display: flex; align-items: center; justify-content: center;
  font-size: 1.1rem;
  color: var(--teal);
  cursor: pointer;
  transition: all 0.22s ease;
  backdrop-filter: blur(8px);
  box-shadow: var(--shadow-sm);
}
.slider-btn:hover { background: var(--white); transform: scale(1.12); }

.slider-dots { display: flex; gap: 8px; }
.dot {
  width: 8px; height: 8px;
  border-radius: 50%;
  background: rgba(255,255,255,0.45);
  cursor: pointer;
  transition: all 0.3s ease;
}
.dot.active {
  background: var(--saffron);
  transform: scale(1.5);
}

/* Hero Responsive */
@media (max-width: 991px) {
  .hero-section { padding: 44px 0; }
  .hero-title   { font-size: 2.4rem; }
  .hero-slider-container { height: 350px; margin-top: 32px; }
}
@media (max-width: 768px) {
  .hero-section { padding: 32px 0; }
  .hero-title   { font-size: 2rem; }
  .hero-description { font-size: 0.98rem; max-width: 100%; }
  .hero-features { gap: 10px; }
  .feature { padding: 8px 14px; font-size: 0.8rem; }
  .cta-buttons { gap: 12px; }
  .cta-primary, .cta-secondary { padding: 13px 24px; font-size: 0.95rem; width: 100%; }
  .hero-slider-container { height: 300px; }
  .slider-caption { padding: 20px; padding-top: 55px; }
  .slider-caption h3 { font-size: 1.35rem; }
  .slider-btn { width: 40px; height: 40px; }
}

/* ============================================================
   MAIN CONTAINER
   ============================================================ */
.main-container {
  width: 94%;
  margin: 36px auto 24px;
  padding: 28px 24px;
  background: var(--white);
  border-radius: var(--r-xl);
  box-shadow: var(--shadow-md);
  border: 1px solid var(--ivory-3);
  position: relative;
  overflow: hidden;
}

/* Top accent bar */
.main-container::before {
  content: '';
  position: absolute;
  top: 0; left: 0; right: 0;
  height: 4px;
  background: linear-gradient(90deg,
    var(--teal-3) 0%,
    var(--saffron) 40%,
    var(--leaf-2) 80%,
    var(--teal-3) 100%);
  border-radius: var(--r-xl) var(--r-xl) 0 0;
}

/* ============================================================
   SECTION TITLES
   ============================================================ */
.bg-section {
  margin-bottom: 32px;
  padding: 0 4px;
}

.section-title {
  font-family: 'Fraunces', serif;
  text-align: center;
  font-weight: 700;
  font-size: 1.45rem;
  color: var(--teal);
  margin-bottom: 22px;
  position: relative;
  padding-bottom: 14px;
  display: inline-block;
  width: 100%;
  letter-spacing: -0.01em;
}
.section-title::after {
  content: '';
  position: absolute;
  bottom: 0; left: 50%;
  transform: translateX(-50%);
  width: 40px; height: 3px;
  background: linear-gradient(90deg, var(--teal-3) 0%, var(--saffron) 100%);
  border-radius: 3px;
}

/* ============================================================
   HORIZONTAL SCROLL ROW
   ============================================================ */
.offer-row {
  display: flex;
  gap: 14px;
  overflow-x: auto;
  padding: 10px 5px 16px;
  scroll-behavior: smooth;
  -webkit-overflow-scrolling: touch;
  scrollbar-width: none;
  margin: 0 -5px;
  width: calc(100% + 10px);
}
.offer-row::-webkit-scrollbar { display: none; }

/* ============================================================
   CARD BASE — offer-card, category-card, product-card
   ============================================================ */
.offer-card, .category-card, .product-card {
  background: var(--ivory);
  border-radius: var(--r-lg);
  padding: 14px 12px !important;
  text-align: center;
  box-shadow: var(--shadow-sm);
  transition: all 0.3s cubic-bezier(0.34,1.2,0.64,1);
  position: relative;
  min-width: 162px !important;
  flex-shrink: 0;
  border: 1px solid var(--ivory-3);
  overflow: hidden;
  scroll-snap-align: start;
}

/* Teal top accent stripe */
.offer-card::before, .category-card::before, .product-card::before {
  content: '';
  position: absolute;
  top: 0; left: 0;
  width: 100%; height: 4px;
  background: linear-gradient(90deg, var(--teal-2) 0%, var(--saffron) 100%);
}

/* ============================================================
   IMAGES
   ============================================================ */
.offer-img {
  height: 90px !important;
  width: 100%;
  object-fit: contain;
  margin-bottom: 8px !important;
  transition: transform 0.4s ease;
  padding: 5px;
  filter: drop-shadow(0 4px 8px rgba(13,79,92,0.10));
}
.category-img {
  height: 80px !important;
  width: 100%;
  object-fit: contain;
  margin-bottom: 8px !important;
  transition: transform 0.4s ease;
  padding: 5px;
  filter: drop-shadow(0 3px 7px rgba(13,79,92,0.09));
}
.product-img {
  height: 100px !important;
  width: 100%;
  object-fit: contain;
  margin-bottom: 8px !important;
  transition: transform 0.4s ease;
  padding: 5px;
  filter: drop-shadow(0 4px 10px rgba(13,79,92,0.10));
}

/* ============================================================
   DISCOUNT BADGE
   ============================================================ */
.discount-badge {
  position: absolute;
  top: 8px !important; right: 8px !important;
  background: var(--teal);
  color: var(--ivory-light, #faf8f3);
  font-family: 'Plus Jakarta Sans', sans-serif;
  font-size: 9px !important;
  font-weight: 800;
  letter-spacing: 0.05em;
  padding: 4px 8px !important;
  border-radius: 6px;
  z-index: 2;
  box-shadow: 0 2px 8px rgba(13,79,92,0.22);
}

/* ============================================================
   CARD TEXT
   ============================================================ */
.offer-card p.mt-2.fw-bold,
.category-card p.mt-2.fw-bold,
.product-card p.mt-2.fw-bold {
  font-family: 'Plus Jakarta Sans', sans-serif;
  font-size: 0.8rem !important;
  font-weight: 700;
  color: var(--ink-2) !important;
  margin: 7px 0 !important;
  min-height: 32px !important;
  display: flex; align-items: center; justify-content: center;
  line-height: 1.25;
  padding: 0 3px !important;
}

/* ============================================================
   PRICE INFO
   ============================================================ */
.offer-card div, .product-card div.mb-2 {
  margin: 5px 0 !important;
  display: flex !important;
  align-items: center !important;
  justify-content: center !important;
  flex-wrap: nowrap !important;
  gap: 5px !important;
  font-size: 0.9rem !important;
}

.text-danger.fw-bold {
  font-family: 'Plus Jakarta Sans', sans-serif;
  font-size: 0.92rem !important;
  font-weight: 800;
  color: var(--crimson) !important;
}
.text-decoration-line-through.text-muted.ms-1 {
  font-size: 0.7rem !important;
  color: var(--muted-2) !important;
  opacity: 0.8;
  margin-left: 0 !important;
}
.text-success.ms-1.fw-bold {
  font-family: 'Plus Jakarta Sans', sans-serif;
  font-size: 0.65rem !important;
  font-weight: 700;
  color: var(--leaf) !important;
  background: var(--leaf-light);
  padding: 2px 6px !important;
  border-radius: 6px;
  margin-left: 0 !important;
}

/* ============================================================
   STOCK LABEL
   ============================================================ */
.product-stock {
  font-family: 'Plus Jakarta Sans', sans-serif;
  font-size: 0.7rem !important;
  color: var(--muted-2);
  margin-bottom: -0.5px !important;
  display: block;
  letter-spacing: 0.02em;
}

/* ============================================================
   ADD TO CART BUTTON
   ============================================================ */
.btn-addcart {
  padding: 9px 12px !important;
  border-radius: var(--r-sm);
  background: var(--teal);
  border: none;
  color: var(--ivory) !important;
  font-family: 'Plus Jakarta Sans', sans-serif;
  font-weight: 700;
  font-size: 0.75rem !important;
  letter-spacing: 0.02em;
  transition: all 0.26s cubic-bezier(0.34,1.4,0.64,1);
  box-shadow: 0 4px 14px rgba(13,79,92,0.24);
  display: inline-flex; align-items: center; justify-content: center;
  gap: 6px !important;
  margin-top: 10px !important;
  width: 100%;
  cursor: pointer;
  min-height: 36px !important;
}
.btn-addcart:hover {
  background: var(--teal-2);
  transform: translateY(-2px);
  box-shadow: 0 8px 24px rgba(13,79,92,0.32);
  color: var(--ivory) !important;
}

/* ============================================================
   QUANTITY SELECTOR
   ============================================================ */
.qty-selector {
  display: flex; justify-content: center; align-items: center;
  gap: 8px !important;
  margin: 8px 0 !important;
  padding: 0 5px;
}
.qty-selector button {
  width: 28px !important; height: 28px !important;
  display: flex; align-items: center; justify-content: center;
  font-weight: 700;
  font-size: 0.95rem !important;
  border-radius: 50%;
  border: 2px solid var(--ivory-3);
  background: var(--white);
  color: var(--teal);
  cursor: pointer;
  transition: all 0.22s ease;
  box-shadow: var(--shadow-xs);
  min-height: 32px !important; min-width: 32px !important;
}
.qty-selector button:hover {
  background: var(--teal);
  color: var(--ivory);
  border-color: var(--teal);
  transform: scale(1.08);
}
.qty-selector input {
  width: 40px !important;
  text-align: center;
  border: 2px solid var(--ivory-3);
  border-radius: var(--r-sm);
  padding: 6px 4px !important;
  font-family: 'Plus Jakarta Sans', sans-serif;
  font-weight: 700;
  font-size: 0.82rem !important;
  color: var(--ink);
  background: var(--white);
  transition: all 0.22s ease;
}
.qty-selector input:focus {
  border-color: var(--teal);
  box-shadow: 0 0 0 3px rgba(13,79,92,0.12);
  outline: none;
}

/* ============================================================
   PRODUCT GRID
   ============================================================ */
.product-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 14px !important;
  padding: 10px 0;
}

.product-card-grid {
  background: var(--ivory);
  border-radius: var(--r-lg);
  padding: 14px 11px !important;
  text-align: center;
  box-shadow: var(--shadow-sm);
  transition: all 0.3s cubic-bezier(0.34,1.2,0.64,1);
  position: relative;
  border: 1px solid var(--ivory-3);
  overflow: hidden;
  display: flex; flex-direction: column;
  height: 100%;
}
.product-card-grid::before {
  content: '';
  position: absolute;
  top: 0; left: 0;
  width: 100%; height: 4px;
  background: linear-gradient(90deg, var(--teal-2) 0%, var(--saffron) 100%);
}
.product-card-grid .product-img {
  height: 130px !important;
  width: 100% !important;
  object-fit: contain;
  margin-bottom: 8px !important;
  transition: transform 0.4s ease;
  padding: 8px;
  filter: drop-shadow(0 4px 10px rgba(13,79,92,0.10));
}
.product-card-grid p.mt-2.fw-bold {
  font-family: 'Plus Jakarta Sans', sans-serif;
  font-size: 0.75rem !important;
  font-weight: 700;
  color: var(--ink-2) !important;
  margin: 5px 0 !important;
  min-height: 30px !important;
  display: flex; align-items: center; justify-content: center;
  line-height: 1.2;
  padding: 0 3px !important;
}
.product-card-grid .qty-selector { margin: -2px 0 !important; padding: 0; }
.product-card-grid .qty-selector input { width: 35px !important; }
.product-card-grid .btn-addcart {
  margin-top: auto;
  padding: 8px 10px !important;
  font-size: 0.7rem !important;
  min-height: 32px !important;
}

/* ============================================================
   CATEGORIES GRID
   ============================================================ */
.row.g-4 { margin: 0 -6px; width: calc(100% + 12px); }
.col-6.col-md-4.col-lg-2 { padding: 5px !important; }

.category-card {
  height: 100%;
  min-height: 120px !important;
  display: flex; flex-direction: column;
  justify-content: center; align-items: center;
  cursor: pointer;
}
.category-card a.text-dark.text-decoration-none {
  font-family: 'Plus Jakarta Sans', sans-serif;
  color: var(--ink-2) !important;
  font-size: 0.8rem !important;
  font-weight: 700;
  text-decoration: none !important;
  text-align: center;
  transition: color 0.22s;
  letter-spacing: 0.01em;
}
.category-card a.text-dark.text-decoration-none:hover { color: var(--teal) !important; }

/* ============================================================
   PRODUCT LINKS
   ============================================================ */
.product-card a.text-dark.text-decoration-none,
.product-card-grid a.text-dark.text-decoration-none {
  font-family: 'Plus Jakarta Sans', sans-serif;
  color: var(--ink-2) !important;
  text-decoration: none !important;
  transition: color 0.22s;
  display: block;
  margin-bottom: 4px !important;
  font-size: 1rem !important;
  font-weight: 500;
}
.product-card a.text-dark.text-decoration-none:hover,
.product-card-grid a.text-dark.text-decoration-none:hover { color: var(--teal) !important; }

/* ============================================================
   SCROLL HINT
   ============================================================ */
.scroll-hint {
  text-align: center;
  color: var(--muted-2);
  font-family: 'Plus Jakarta Sans', sans-serif;
  font-size: 0.72rem;
  letter-spacing: 0.04em;
  margin-top: 10px;
  display: flex; align-items: center; justify-content: center; gap: 8px;
  opacity: 0.85;
  padding: 0 10px;
}
.scroll-hint i {
  color: var(--saffron);
  animation: bounce 2s infinite;
}
@keyframes bounce {
  0%,20%,50%,80%,100% { transform: translateX(0); }
  40% { transform: translateX(-6px); }
  60% { transform: translateX(-3px); }
}

/* ============================================================
   MOBILE FLOATING CART
   ============================================================ */
.mobile-cart-float {
  position: fixed;
  bottom: 22px; right: 22px;
  width: 60px; height: 60px;
  background: var(--teal);
  border-radius: 50%;
  display: none;
  align-items: center; justify-content: center;
  color: var(--ivory);
  font-size: 1.45rem;
  box-shadow: 0 10px 32px rgba(13,79,92,0.42);
  z-index: 999;
  cursor: pointer;
  border: 3px solid var(--white);
  animation: float 3s ease-in-out infinite;
}
.mobile-cart-count {
  position: absolute;
  top: -5px; right: -5px;
  background: var(--saffron);
  color: var(--white);
  font-family: 'Plus Jakarta Sans', sans-serif;
  font-size: 0.78rem;
  font-weight: 800;
  width: 24px; height: 24px;
  border-radius: 50%;
  display: flex; align-items: center; justify-content: center;
  border: 2px solid var(--white);
}
@keyframes float {
  0%,100% { transform: translateY(0); }
  50%      { transform: translateY(-8px); }
}

/* ============================================================
   MOBILE NOTIFICATION TOAST
   ============================================================ */
.mobile-notification {
  position: fixed;
  bottom: 80px; left: 50%;
  transform: translateX(-50%);
  background: rgba(13,30,35,0.92);
  color: var(--white);
  padding: 13px 20px;
  border-radius: var(--r-md);
  z-index: 10000;
  display: flex; align-items: center; gap: 12px;
  max-width: 90%;
  font-family: 'Plus Jakarta Sans', sans-serif;
  font-size: 0.88rem;
  font-weight: 500;
  backdrop-filter: blur(12px);
  -webkit-backdrop-filter: blur(12px);
  border: 1px solid rgba(255,255,255,0.1);
  animation: slideUp 0.3s ease;
}
.mobile-notification i { color: var(--saffron-2); font-size: 1.2rem; }

@keyframes slideUp {
  from { bottom: 60px; opacity: 0; }
  to   { bottom: 80px; opacity: 1; }
}

/* ============================================================
   TABLET  768px+
   ============================================================ */
@media (min-width: 768px) {
  html { font-size: 17px; }
  .main-container { width: 92%; padding: 24px; margin: 0 auto 30px; border-radius: var(--r-xl); }
  .section-title { font-size: 1.65rem; margin-bottom: 26px; }
  .offer-row { gap: 16px; padding: 14px 10px; }
  .offer-card { min-width: 182px !important; padding: 16px 14px !important; }
  .offer-img  { height: 110px !important; }
  .category-img { height: 100px !important; }
  .product-img  { height: 120px !important; }
  .btn-addcart  { padding: 10px 15px !important; font-size: 0.8rem !important; }
  .col-6.col-md-4.col-lg-2 { padding: 8px !important; }
  .category-card { min-height: 140px !important; }
  .product-grid  { grid-template-columns: repeat(3, 1fr); gap: 16px !important; }
  .product-card-grid .product-img { height: 190px !important; }
  .product-card-grid p.mt-2.fw-bold { font-size: 0.8rem !important; }
  .mobile-cart-float { display: none !important; }
}

/* ============================================================
   DESKTOP  992px+
   ============================================================ */
@media (min-width: 992px) {
  html { font-size: 18px; }
  .main-container { max-width: 1400px; padding: 36px; margin: 0 auto 44px; border-radius: var(--r-2xl); }
  .section-title { font-size: 2rem; margin-bottom: 32px; }
  .offer-row  { gap: 20px; padding: 20px 15px; }
  .offer-card { min-width: 202px !important; padding: 20px 16px !important; }
  .offer-img  { height: 130px !important; }
  .category-img { height: 110px !important; }
  .product-img  { height: 140px !important; }
  .btn-addcart  { padding: 12px 20px !important; font-size: 0.88rem !important; }
  .category-card { min-height: 150px !important; }
  .product-grid  { grid-template-columns: repeat(4, 1fr); gap: 20px !important; }
  .product-card-grid .product-img { height: 220px !important; }
  .product-card-grid p.mt-2.fw-bold { font-size: 0.85rem !important; }

  /* Hover lift */
  .offer-card:hover, .category-card:hover, .product-card:hover, .product-card-grid:hover {
    transform: translateY(-8px);
    box-shadow: var(--shadow-md);
    border-color: var(--teal-3);
  }
  .offer-card:hover .offer-img,
  .category-card:hover .category-img,
  .product-card:hover .product-img,
  .product-card-grid:hover .product-img {
    transform: scale(1.06);
  }
}

/* ============================================================
   LARGE DESKTOP  1200px+
   ============================================================ */
@media (min-width: 1200px) {
  .main-container { max-width: 1600px; padding: 44px; }
  .offer-card { min-width: 222px !important; }
  .product-grid { grid-template-columns: repeat(5, 1fr); gap: 22px !important; }
  .product-card-grid .product-img { height: 240px !important; }
}

/* ============================================================
   TOUCH DEVICES
   ============================================================ */
@media (hover: none) and (pointer: coarse) {
  .btn-addcart:hover, .qty-selector button:hover { transform: none !important; }
  .btn-addcart:active, .qty-selector button:active { transform: scale(0.94) !important; opacity: 0.88; }
}

/* ============================================================
   UTILITY OVERRIDES
   ============================================================ */
.container-fluid { padding-left: 15px; padding-right: 15px; }
.row { margin-left: -8px; margin-right: -8px; }
@media (min-width: 768px) { .row { margin-left: -12px; margin-right: -12px; } }
@media (min-width: 992px) { .row { margin-left: -15px; margin-right: -15px; } }

@media (max-width: 768px) { body { padding-top: 60px; } }

/* ============================================================
   DARK MODE
   ============================================================ */
@media (prefers-color-scheme: dark) {
  :root {
    --surface:  #111a1c;
    --white:    #1c2a2d;
    --ivory:    #1e2a2d;
    --ivory-2:  #243133;
    --ivory-3:  #2d3f42;
    --ink:      #e8e4dc;
    --ink-2:    #d8d4cc;
    --muted:    #8a9a9d;
    --muted-2:  #6b7a7d;
  }
  body {
    background-color: var(--surface);
    background-image: radial-gradient(ellipse 80% 50% at 15% -10%, rgba(13,79,92,0.18) 0%, transparent 60%);
  }
  .main-container { background: var(--white); border-color: var(--ivory-3); }
  .offer-card, .category-card, .product-card, .product-card-grid {
    background: var(--ivory); border-color: var(--ivory-3);
  }
  .text-dark  { color: var(--ink-2) !important; }
  .text-muted { color: var(--muted) !important; }
  .qty-selector input, .qty-selector button {
    background: var(--ivory-2); border-color: var(--ivory-3); color: var(--ink);
  }
  .hero-section {
    background: linear-gradient(135deg, #141f21 0%, #1a2830 60%, #1e2d20 100%);
  }
  .feature { background: rgba(30,42,45,0.9); color: #a8d4dc; border-color: var(--ivory-3); }
}
</style>
<%@ include file="header1.jsp"%>
</head>

<body>
	

	<!-- Mobile Floating Cart Button -->
	<div class="mobile-cart-float" id="mobileCartButton"
		onclick="openMobileCart()">
		<i class="fas fa-shopping-cart"></i> <span class="mobile-cart-count"
			id="mobileCartCount">0</span>
	</div>

	<!-- HERO SECTION START -->
	<section class="hero-section">
	    <div class="container">
	        <div class="row align-items-center">
	            <!-- Hero Content -->
	            <div class="col-lg-6 col-md-12">
	                <div class="hero-content">
	                    <h1 class="hero-title mb-4">
	                        Fresh <span class="text-primary">Groceries</span> Delivered to Your Doorstep
	                    </h1>
	                    <p class="hero-description text-muted mb-4">
	                        Experience premium quality fruits, vegetables, and daily essentials with our express delivery service. Fresh from farm to table in under 30 minutes.
	                    </p>
	                    
	                    <!-- Hero Features -->
	                    <div class="hero-features mb-4">
	                        <div class="feature">
	                            <i class="fas fa-bolt feature-icon text-success"></i>
	                            <span>30-Min Delivery</span>
	                        </div>
	                        <div class="feature">
	                            <i class="fas fa-leaf feature-icon text-success"></i>
	                            <span>100% Fresh & Organic</span>
	                        </div>
	                        <div class="feature">
	                            <i class="fas fa-shield-alt feature-icon text-success"></i>
	                            <span>Quality Guaranteed</span>
	                        </div>
	                    </div>
	                    
	                    <!-- CTA Buttons -->
						<button class="btn btn-primary btn-lg cta-primary" onclick="startShopping()">
						    <i class="fas fa-shopping-cart me-2"></i>Shop Now
						</button>
	                        <button class="btn btn-outline-primary btn-lg cta-secondary" onclick="downloadApp()">
	                            <i class="fas fa-mobile-alt me-2"></i>Get App
	                        </button>
	                    </div>
	                </div>
	            </div>
	            
	            <!-- Hero Image Slider -->
				

	</section>
<!-- HERO SECTION END -->


	<div class="main-container">
		<!-- ========== NEW USER FREE PRODUCT SECTION ========== -->
	
		
		
		
		<!-- ========== OFFERS ========== -->
		<div class="bg-section">
			<h2 class="section-title">Top Offers</h2>
			<div class="offer-row">
				<c:forEach var="o" items="${offerProducts}">
					<div class="offer-card mobile-card" data-product-id="${o.id}">
						<c:set var="discountPercent"
							value="${((o.price - o.discountPrice) / o.price) * 100}" />
						<c:set var="discountInt"
							value="${fn:substringBefore(discountPercent, '.')}" />
						<span class="discount-badge">${discountInt}% OFF</span> <img
							src="${pageContext.request.contextPath}/assets/img/product_img/${o.image}"
							class="offer-img" alt="${o.title}">
						<p class="mt-2 fw-bold">${o.title}</p>
						 <p class="product-stock">${o.stockQty} ${o.stockUnit}</p>
						<div class="price-info-compact">
							<span class="text-danger fw-bold">₹${o.discountPrice}</span> <span
								class="text-decoration-line-through text-muted">₹${o.price}</span>
						</div>

						<button class="btn-addcart mt-2"
							onclick="mobileAddToCart(${o.id}, 1)">
							<i class="fas fa-cart-plus"></i> Add to Cart
						</button>
					</div>
				</c:forEach>
			</div>
			<div class="scroll-hint">
				<i class="fas fa-arrow-left"></i> Scroll horizontally for more
				offers <i class="fas fa-arrow-right"></i>
			</div>
		</div>
 
		<c:if test="${not empty freeProduct}">
		    <div style="border:2px solid green; padding:15px; margin-bottom:20px;">
		        <h3>🎁 Special New User Offer!</h3>
		        <p>Get this product FREE:</p>
		        <h4>${freeProduct.productName}</h4>
		        <img src="${freeProduct.image}" width="150"/>
		    </div>
		</c:if>
		
		<!--                     ------------------------------->
		<!-- ========== FESTIVAL OFFER SECTION ========== -->
               
				<!-- ========== CATEGORIES ========== -->
		<div class="bg-section">
			<h2 class="section-title">Shop by Category</h2>
			<div class="row g-4">
				<c:forEach var="c" items="${categories}">
					<div class="col-6 col-md-4 col-lg-2">
						<div class="category-card mobile-card">
							<img
								src="${pageContext.request.contextPath}/assets/img/category_img/${c.imageName}"
								class="category-img" alt="${c.name}">
							<p class="mt-2 fw-bold">
								<a href="products?categories=${c.name}"
									class="text-dark text-decoration-none">${c.name}</a>
							</p>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>

		<!-- ========== LATEST PRODUCTS ========== -->
		<div class="bg-section">
			<h2 class="section-title">Latest Products</h2>
			<div class="product-grid">
				<c:forEach var="p" items="${products}">
					<div class="product-card-grid mobile-card"
						data-product-id="${p.id}">
						<span class="discount-badge">${p.discount}% OFF</span> <img
							src="${pageContext.request.contextPath}/assets/img/product_img/${p.image}"
							class="product-img" alt="${p.title}">
						<p class="mt-2 fw-bold">
							<a href="${pageContext.request.contextPath}/products?id=${p.id}"
								class="text-dark text-decoration-none">${p.title}</a>
						</p>
						<p class="product-stock">${p.stockQty} ${p.stockUnit}</p>
						<div class="price-info-compact mb-2">
							<span class="text-danger fw-bold">₹${p.discountPrice}</span> <span
								class="text-decoration-line-through text-muted">₹${p.price}</span>
						</div>
						<!-- Mobile Optimized Quantity selector -->
						<div class="qty-selector">
							<button type="button"
								onclick="mobileChangeQty('mobile-qty-${p.id}', -1)">-</button>
							<input type="text" value="1" id="mobile-qty-${p.id}"
								class="mobile-qty-input">
							<button type="button"
								onclick="mobileChangeQty('mobile-qty-${p.id}', 1)">+</button>
						</div>
						<button class="btn-addcart mt-2"
							onclick="mobileAddToCart(${p.id}, document.getElementById('mobile-qty-${p.id}').value)">
							<i class="fas fa-cart-plus"></i> Add to Cart
						</button>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>

	<%@ include file="Footar.jsp"%>

	<script>
	// ========== PROFESSIONAL HERO SLIDER ==========
let currentSlide = 0;
const totalSlides = 3;
let slideInterval;

function initializeSlider() {
    const slider = document.getElementById('heroSlider');
    const dots = document.querySelectorAll('.dot');
    
    // Set initial state
    updateSlider();
    
    // Start auto slide
    startAutoSlide();
    
    // Add keyboard navigation
    document.addEventListener('keydown', (e) => {
        if (e.key === 'ArrowLeft') prevSlide();
        if (e.key === 'ArrowRight') nextSlide();
    });
    
    // Add touch/swipe support for mobile
    if (isMobileDevice()) {
        let startX = 0;
        slider.addEventListener('touchstart', (e) => {
            startX = e.touches[0].clientX;
        });
        
        slider.addEventListener('touchend', (e) => {
            const endX = e.changedTouches[0].clientX;
            const diff = startX - endX;
            
            if (Math.abs(diff) > 50) {
                if (diff > 0) {
                    nextSlide();
                } else {
                    prevSlide();
                }
            }
        });
    }
}

function updateSlider() {
    const slider = document.getElementById('heroSlider');
    const dots = document.querySelectorAll('.dot');
    
    // Update slider position
	slider.style.transform = `translateX(-${currentSlide * 100}%)`;

    
    // Update dots
    dots.forEach((dot, index) => {
        dot.classList.toggle('active', index === currentSlide);
    });
    
    // Add active class to current slide
    document.querySelectorAll('.hero-slide').forEach((slide, index) => {
        slide.classList.toggle('active', index === currentSlide);
    });
    
    // Reset auto slide timer
    resetAutoSlide();
}

function nextSlide() {
    currentSlide = (currentSlide + 1) % totalSlides;
    updateSlider();
}

function prevSlide() {
    currentSlide = (currentSlide - 1 + totalSlides) % totalSlides;
    updateSlider();
}

function goToSlide(index) {
    currentSlide = index;
    updateSlider();
}

function startAutoSlide() {
    clearInterval(slideInterval);
    slideInterval = setInterval(nextSlide, 5000);
}

function resetAutoSlide() {
    clearInterval(slideInterval);
    startAutoSlide();
}

function startShopping() {
    const productSection = document.querySelector('.main-container');
    
    if(productSection) {
        productSection.scrollIntoView({ 
            behavior: 'smooth' 
        });

        // Optional: notification
        if(typeof showMobileNotification === "function") {
            showMobileNotification('Start exploring our fresh products!', 'success');
        }
    } else {
        console.error('Products section not found!');
    }
}


function downloadApp() {
    showMobileNotification('Redirecting to app store...', 'info');
    
    // Simulate redirect after delay
    setTimeout(() => {
        if (isMobileDevice()) {
            // Redirect to app store based on device
            if (/iPhone|iPad|iPod/i.test(navigator.userAgent)) {
                window.location.href = 'https://apps.apple.com';
            } else if (/Android/i.test(navigator.userAgent)) {
                window.location.href = 'https://play.google.com';
            }
        } else {
            alert('Scan the QR code on your mobile to download our app!');
        }
    }, 1000);
}

// ========== REST OF YOUR EXISTING JAVASCRIPT ==========
const isMobileDevice = () => {
    return window.innerWidth <= 768 || 
           /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);
};

// ========== INITIALIZE MOBILE ELEMENTS ==========
document.addEventListener('DOMContentLoaded', function() {
    const IS_MOBILE = isMobileDevice();
    
    // Initialize hero slider
    initializeSlider();
    
    // Show/hide mobile floating cart
    const mobileCartButton = document.getElementById('mobileCartButton');
    if (IS_MOBILE && mobileCartButton) {
        mobileCartButton.style.display = 'flex';
        document.body.style.paddingBottom = '80px';
    }
    
    // Initialize touch events for mobile
    if (IS_MOBILE) {
        initMobileTouchEvents();
        loadCartCount();
    }
    
    // Mobile scrolling improvements
    initMobileScrolling();
    
    // Mobile card touch events
    const cards = document.querySelectorAll('.mobile-card');
    cards.forEach(card => {
        card.addEventListener('touchstart', function() {
            this.style.transform = 'scale(0.98)';
        });
        
        card.addEventListener('touchend', function() {
            this.style.transform = '';
        });
    });
    
    // Pause auto slide on hover (desktop only)
    if (!isMobileDevice()) {
        const sliderContainer = document.querySelector('.hero-slider-container');
        sliderContainer.addEventListener('mouseenter', () => {
            clearInterval(slideInterval);
        });
        sliderContainer.addEventListener('mouseleave', startAutoSlide);
    }
});

// ========== MOBILE TOUCH EVENTS ==========
function initMobileTouchEvents() {
    // Add touch feedback to all buttons
	const touchElements = document.querySelectorAll(
	  '.btn-addcart, .slider-btn, .qty-selector button'
	);
    touchElements.forEach(el => {
        el.addEventListener('touchstart', function() {
            this.style.opacity = '0.8';
            this.style.transform = 'scale(0.95)';
        });
        
        el.addEventListener('touchend', function() {
            this.style.opacity = '';
            this.style.transform = '';
        });
    });
    
    // Prevent zoom on double tap
    let lastTouchEnd = 0;
    document.addEventListener('touchend', function(event) {
        const now = Date.now();
        if (now - lastTouchEnd <= 300) {
            event.preventDefault();
        }
        lastTouchEnd = now;
    }, { passive: false });
}

// ========== MOBILE SCROLLING ==========
function initMobileScrolling() {
    const offerRows = document.querySelectorAll('.offer-row');
    offerRows.forEach(row => {
        let startX;
        let scrollLeft;
        
        // Touch events for mobile
        row.addEventListener('touchstart', (e) => {
            startX = e.touches[0].pageX - row.offsetLeft;
            scrollLeft = row.scrollLeft;
        });
        
        row.addEventListener('touchmove', (e) => {
            if (e.touches.length === 1) {
                const x = e.touches[0].pageX - row.offsetLeft;
                const walk = (x - startX) * 2;
                row.scrollLeft = scrollLeft - walk;
                e.preventDefault();
            }
        });
    });
}

// ========== MOBILE CART FUNCTIONS ==========
function mobileAddToCart(productId, quantity) {
    const IS_MOBILE = isMobileDevice();
    
    if (!quantity || quantity < 1) quantity = 1;
    if (quantity > 99) quantity = 99;
    
    // Show loading state
    const button = event?.target?.closest('button') || event.target;
    if (button) {
        const originalHTML = button.innerHTML;
        button.innerHTML = '<i class="fas fa-spinner fa-spin"></i>';
        button.disabled = true;
        
        // Mobile vibration feedback
        if (IS_MOBILE && navigator.vibrate) {
            navigator.vibrate(50);
        }
        
        // Mobile ripple effect
        if (IS_MOBILE) {
            const ripple = document.createElement('span');
            ripple.style.cssText = `
                position: absolute;
                border-radius: 50%;
                background: rgba(255,255,255,0.6);
                transform: scale(0);
                animation: ripple 0.6s linear;
                pointer-events: none;
            `;
            
            const rect = button.getBoundingClientRect();
            const size = Math.max(rect.width, rect.height);
            const x = event.clientX - rect.left - size/2;
            const y = event.clientY - rect.top - size/2;
            
            ripple.style.width = ripple.style.height = size + 'px';
            ripple.style.left = x + 'px';
            ripple.style.top = y + 'px';
            
            button.style.position = 'relative';
            button.style.overflow = 'hidden';
            button.appendChild(ripple);
            
            setTimeout(() => ripple.remove(), 600);
        }
    }
    
    // API call
    fetch('${pageContext.request.contextPath}/cart/add', {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
            "Accept": "application/json"
        },
        body: JSON.stringify({
            productId: productId,
            quantity: quantity
        })
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            // Success feedback
            if (button) {
                button.innerHTML = '<i class="fas fa-check"></i> Added!';
                button.style.background = 'linear-gradient(135deg, #28a745 0%, #20c997 100%)';
                
                // Reset button after delay
                setTimeout(() => {
                    if (button) {
                        button.innerHTML = '<i class="fas fa-cart-plus"></i> Add to Cart';
                        button.style.background = '';
                        button.disabled = false;
                    }
                }, 1500);
            }
            
            // Show mobile notification
            showMobileNotification('Product added to cart!', 'success');
            
            // Update cart counts
            updateCartCount(data.cartCount || 0);
            updateMobileCartCount(data.cartCount || 0);
            
        } else {
            showMobileNotification('Failed to add item', 'error');
            if (button) {
                button.innerHTML = '<i class="fas fa-cart-plus"></i> Add to Cart';
                button.disabled = false;
            }
        }
    })
    .catch(error => {
        console.error("Error:", error);
        showMobileNotification('Network error', 'error');
        if (button) {
            button.innerHTML = '<i class="fas fa-cart-plus"></i> Add to Cart';
            button.disabled = false;
        }
    });
}

// ========== MOBILE QUANTITY CHANGE ==========
function mobileChangeQty(inputId, delta) {
    const input = document.getElementById(inputId);
    if (!input) return;
    
    let val = parseInt(input.value) || 0;
    val += delta;
    if (val < 0) val = 0;
    if (val > 99) val = 99;
    input.value = val;
    
    // Mobile vibration
    if (isMobileDevice() && navigator.vibrate) {
        navigator.vibrate(10);
    }
    
    // Visual feedback for mobile
    input.style.transform = 'scale(1.1)';
    input.style.borderColor = 'var(--primary)';
    setTimeout(() => {
        input.style.transform = '';
        input.style.borderColor = '';
    }, 300);
}

// ========== MOBILE NOTIFICATION ==========
function showMobileNotification(message, type = 'success') {
    const IS_MOBILE = isMobileDevice();
    
    // Remove existing notification
    const existing = document.querySelector('.mobile-notification');
    if (existing) existing.remove();
    
    const notification = document.createElement('div');
    notification.className = 'mobile-notification';
    
    const icon = type === 'success' ? 'fas fa-check-circle' : 'fas fa-exclamation-circle';
    const bgColor = type === 'success' ? 'rgba(40, 167, 69, 0.9)' : 'rgba(220, 53, 69, 0.9)';
    
    notification.innerHTML = `
        <i class="${icon}"></i>
        <span>${message}</span>
    `;
    
    notification.style.background = bgColor;
    
    document.body.appendChild(notification);
    
    // Remove after 2 seconds
    setTimeout(() => {
        notification.style.opacity = '0';
        notification.style.transform = 'translateX(-50%) translateY(20px)';
        setTimeout(() => {
            if (notification.parentNode) {
                notification.remove();
            }
        }, 300);
    }, 2000);
}

// ========== CART COUNT UPDATES ==========
function updateCartCount(count) {
    const cartCountEl = document.querySelector('.cart-count');
    if (cartCountEl) {
        cartCountEl.textContent = count;
        // Animation
        cartCountEl.style.transform = 'scale(1.3)';
        setTimeout(() => {
            cartCountEl.style.transform = 'scale(1)';
        }, 300);
    }
}

function updateMobileCartCount(count) {
    const mobileCartCount = document.getElementById('mobileCartCount');
    if (mobileCartCount) {
        mobileCartCount.textContent = count;
        
        // Pulse animation
        mobileCartCount.style.transform = 'scale(1.5)';
        setTimeout(() => {
            mobileCartCount.style.transform = 'scale(1)';
        }, 300);
    }
}

// Load initial cart count
function loadCartCount() {
    fetch('${pageContext.request.contextPath}/cart/count')
        .then(response => response.json())
        .then(data => {
            if (data.count !== undefined) {
                updateCartCount(data.count);
                updateMobileCartCount(data.count);
            }
        })
        .catch(console.error);
}

// ========== OPEN MOBILE CART ==========
function openMobileCart() {
    window.location.href = '${pageContext.request.contextPath}/cart';
    
    // Add button animation
    const cartBtn = document.getElementById('mobileCartButton');
    if (cartBtn) {
        cartBtn.style.transform = 'scale(0.9)';
        setTimeout(() => {
            cartBtn.style.transform = '';
        }, 200);
    }
}

// ========== WINDOW RESIZE HANDLER ==========
window.addEventListener('resize', function() {
    const IS_MOBILE = isMobileDevice();
    const mobileCartButton = document.getElementById('mobileCartButton');
    
    // Show/hide mobile cart button
    if (IS_MOBILE && mobileCartButton) {
        mobileCartButton.style.display = 'flex';
        document.body.style.paddingBottom = '80px';
    } else if (mobileCartButton) {
        mobileCartButton.style.display = 'none';
        document.body.style.paddingBottom = '';
    }
});

// ========== ADD CSS FOR ANIMATIONS ==========
if (!document.querySelector('#mobile-animations')) {
    const style = document.createElement('style');
    style.id = 'mobile-animations';
    style.textContent = `
        @keyframes ripple {
            to {
                transform: scale(4);
                opacity: 0;
            }
        }
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.1); }
            100% { transform: scale(1); }
        }
    `;
    document.head.appendChild(style);
}

// ========== PREVENT ACCIDENTAL ZOOM ==========
document.addEventListener('gesturestart', function(e) {
    e.preventDefault();
});

// ========== EXPOSE FUNCTIONS FOR OTHER PAGES ==========
window.mobileUtils = {
    isMobile: isMobileDevice,
    addToCart: mobileAddToCart,
    updateCartCount: updateCartCount
};
</script>
</body>
</html>