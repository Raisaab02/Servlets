package com.demo;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.regex.Pattern;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;

@WebServlet(
        description = "Login Servlet Testing",
        urlPatterns = { "/LoginServlet" },
        initParams = {
                @WebInitParam(name = "user", value = "Narayan"),
                @WebInitParam(name = "password", value = "BridgeLabz@1")
        }
)
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Validation patterns
    private static final String USERNAME_PATTERN = "^[A-Z][a-zA-Z]{2,}$";  // Capital letter + min 3 chars
    private static final String PASSWORD_PATTERN = "^(?=.*[A-Z])(?=.*\\d)(?=.*[@#$%^&+=])(?!.*[@#$%^&+=]{2,}).{8,}$";
    // At least 8 chars, 1 uppercase, 1 number, exactly 1 special char

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String user = request.getParameter("user");
        String pwd = request.getParameter("pwd");

        // Get servlet config params (stored credentials)
        String userID = getServletConfig().getInitParameter("user");
        String password = getServletConfig().getInitParameter("password");

        // Validate username & password
        if (isValidUsername(user) && isValidPassword(pwd)) {
            if (userID.equals(user) && password.equals(pwd)) {
                request.setAttribute("user", user);
                RequestDispatcher dispatcher = request.getRequestDispatcher("LoginSuccess.jsp");
                dispatcher.forward(request, response);
            } else {
                redirectToLogin(request, response, "Invalid username or password.");
            }
        } else {
            redirectToLogin(request, response, "Invalid input! Follow username & password rules.");
        }
    }

    private boolean isValidUsername(String username) {
        return Pattern.matches(USERNAME_PATTERN, username);
    }

    private boolean isValidPassword(String password) {
        return Pattern.matches(PASSWORD_PATTERN, password);
    }

    private void redirectToLogin(HttpServletRequest request, HttpServletResponse response, String errorMessage)
            throws ServletException, IOException {
        request.setAttribute("errorMessage", errorMessage);
        RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
        dispatcher.forward(request, response);
    }
}
