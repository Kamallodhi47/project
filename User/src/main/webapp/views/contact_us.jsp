<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Contact Us</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 90%;
            max-width: 900px;
            margin: 40px auto;
            background: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
        }
        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 10px;
        }
        .subtitle {
            text-align: center;
            color: #666;
            margin-bottom: 30px;
        }
        .row {
            display: flex;
            gap: 30px;
            flex-wrap: wrap;
        }
        .info, .form-box {
            flex: 1;
            min-width: 280px;
        }
        .info h3 {
            color: #007bff;
            margin-bottom: 10px;
        }
        .info p {
            color: #555;
            font-size: 15px;
            line-height: 1.6;
        }
        .info p strong {
            color: #333;
        }
        .form-box label {
            display: block;
            margin-bottom: 5px;
            color: #444;
            font-weight: bold;
        }
        .form-box input,
        .form-box textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-size: 14px;
        }
        .form-box textarea {
            resize: vertical;
            height: 120px;
        }
        .form-box button {
            background: #007bff;
            color: #fff;
            border: none;
            padding: 12px 25px;
            border-radius: 5px;
            font-size: 15px;
            cursor: pointer;
        }
        .form-box button:hover {
            background: #0056b3;
        }
        footer {
            text-align: center;
            margin-top: 30px;
            color: #777;
            font-size: 14px;
        }
    </style>
</head>

<body>

<div class="container">
    <h1>Contact Us</h1>
    <p class="subtitle">
        We’d love to hear from you. Please reach out with any questions or feedback.
    </p>

    <div class="row">
        <!-- Contact Information -->
        <div class="info">
            <h3>📍 Our Office</h3>
            <p>
                Your Company Name<br>
                123 Business Street,<br>
                New Delhi, India
            </p>

            <h3>📧 Email</h3>
            <p>support@yourapp.com</p>

            <h3>📞 Phone</h3>
            <p>+91 98765 43210</p>

            <h3>⏰ Working Hours</h3>
            <p>Monday – Saturday<br>9:00 AM – 6:00 PM</p>
        </div>

        <!-- Contact Form -->
        <div class="form-box">
            <form action="contactSubmit" method="post">
                <label>Name</label>
                <input type="text" name="name" placeholder="Enter your name" required>

                <label>Email</label>
                <input type="email" name="email" placeholder="Enter your email" required>

                <label>Message</label>
                <textarea name="message" placeholder="Write your message here..." required></textarea>

                <button type="submit">Send Message</button>
            </form>
        </div>
    </div>

    <footer>
        © 2026 Your Application Name. All rights reserved.
    </footer>
</div>

</body>
</html>
