<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            text-align: center;
            margin: 0;
            padding: 50px;
        }
        .container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            display: inline-block;
        }
        input {
            width: 90%;
            padding: 10px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .error {
            color: red;
            font-size: 14px;
        }
        button {
            background-color: #007bff;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
    <script>
        function validateForm() {
            let username = document.getElementById("user").value;
            let password = document.getElementById("pwd").value;
            let errorMsg = document.getElementById("error-message");

            let usernameRegex = /^[A-Z][a-zA-Z]{2,}$/; // Capital letter, min 3 chars
            let passwordRegex = /^(?=.*[A-Z])(?=.*\d)(?=.*[@#$%^&+=])(?!.*[@#$%^&+=]{2,}).{8,}$/;
            // At least 8 chars, 1 uppercase, 1 number, exactly 1 special char

            if (!usernameRegex.test(username)) {
                errorMsg.innerHTML = "Username must start with a capital letter and be at least 3 characters long.";
                return false;
            }
            if (!passwordRegex.test(password)) {
                errorMsg.innerHTML = "Password must have 8+ chars, 1 uppercase, 1 number, and exactly 1 special char.";
                return false;
            }
            return true; // Allow form submission
        }
    </script>
</head>
<body>

<div class="container">
    <h2>Login</h2>

    <!-- Show error message if exists -->
    <p id="error-message" class="error">
        <% String error = (String) request.getAttribute("errorMessage");
        if (error != null) { out.print(error); } %>
    </p>

    <form action="LoginServlet" method="post" onsubmit="return validateForm()">
        <label>Username:</label>
        <input type="text" id="user" name="user" required>

        <label>Password:</label>
        <input type="password" id="pwd" name="pwd" required>

        <button type="submit">Login</button>
    </form>
</div>

</body>
</html>
