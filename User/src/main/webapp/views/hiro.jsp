<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Dynamic content variables
    String title = request.getParameter("title") != null ? 
                   request.getParameter("title") : "आपका शानदार हेडलाइन";
    String subtitle = request.getParameter("subtitle") != null ? 
                      request.getParameter("subtitle") : "यहाँ आपकी उप-शीर्षक आएगी";
    String buttonText = request.getParameter("buttonText") != null ? 
                        request.getParameter("buttonText") : "शुरू करें";
    String buttonLink = request.getParameter("buttonLink") != null ? 
                        request.getParameter("buttonLink") : "#";
    String bgImage = request.getParameter("bgImage") != null ? 
                     request.getParameter("bgImage") : "default-hero.jpg";
    String textColor = request.getParameter("textColor") != null ? 
                       request.getParameter("textColor") : "text-white";
%>

<style>
    .hero-section {
        background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), 
                    url('<%= bgImage %>');
        background-size: cover;
        background-position: center;
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        text-align: center;
        padding: 20px;
    }
    
    .hero-content {
        max-width: 800px;
        margin: 0 auto;
    }
    
    .hero-title {
        font-size: 3.5rem;
        font-weight: bold;
        margin-bottom: 20px;
        line-height: 1.2;
    }
    
    .hero-subtitle {
        font-size: 1.5rem;
        margin-bottom: 30px;
        opacity: 0.9;
    }
    
    .hero-button {
        display: inline-block;
        padding: 15px 40px;
        background-color: #007bff;
        color: white;
        text-decoration: none;
        border-radius: 50px;
        font-size: 1.2rem;
        font-weight: bold;
        transition: all 0.3s ease;
        border: none;
        cursor: pointer;
    }
    
    .hero-button:hover {
        background-color: #0056b3;
        transform: translateY(-3px);
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
    }
    
    @media (max-width: 768px) {
        .hero-title {
            font-size: 2.5rem;
        }
        
        .hero-subtitle {
            font-size: 1.2rem;
        }
    }
</style>

<div class="hero-section">
    <div class="hero-content">
        <h1 class="hero-title <%= textColor %>"><%= title %></h1>
        <p class="hero-subtitle <%= textColor %>"><%= subtitle %></p>
        <a href="<%= buttonLink %>" class="hero-button"><%= buttonText %></a>
    </div>
</div>