package com.demo;

import java.io.IOException;
import java.util.regex.Pattern;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Regex patterns for validation
    private static final String USERNAME_PATTERN = "^[A-Z][a-zA-Z]{2,}$";  // Starts with capital, min 3 chars
    private static final String PASSWORD_PATTERN = "^(?=.*[A-Z])(?=.*\\d)(?=.*[@#$%^&+=])(?!.*[@#$%^&+=]{2,}).{8,}$";
    // At least 8 chars, 1 uppercase, 1 number, exactly 1 special char

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("user");
        String password = request.getParameter("pwd");

        // Validate username and password
        if (isValidUsername(username) && isValidPassword(password)) {
            // Redirect to success page
            request.setAttribute("user", username);
            RequestDispatcher dispatcher = request.getRequestDispatcher("LoginSuccess.jsp");
            dispatcher.forward(request, response);
        } else {
            // Redirect back to login page with error message
            request.setAttribute("errorMessage", "Invalid Username or Password. Please try again.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("login.html");
            dispatcher.forward(request, response);
        }
    }

    // Method to validate username
    private boolean isValidUsername(String username) {
        return Pattern.matches(USERNAME_PATTERN, username);
    }

    // Method to validate password
    private boolean isValidPassword(String password) {
        return Pattern.matches(PASSWORD_PATTERN, password);
    }
}
