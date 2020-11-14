import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import database.*;

@WebServlet(name = "LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        Connection connection = LibraryDatabase.getInstance().getConnection();
        String query = "SELECT * FROM users";
        boolean index = false;
        try {
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(query);
            Integer id = 0;
            while (resultSet.next()) {
                if (resultSet.getString(4).equals(username) && resultSet.getString(7).equals(password)) {
                    index = true;
                    id = resultSet.getInt(1);
                }
            }
            HttpSession session;
            if (index) {
                query = "SELECT roles_id FROM users_roles WHERE user_id = " + id;
                resultSet = statement.executeQuery(query);
                resultSet.next();

                if (resultSet.getInt(1) == 1) {
                    response.sendRedirect("adminpage.jsp");
                } else if (resultSet.getInt(1) == 2) {
                    response.sendRedirect("mainpage.jsp");
                } else if (resultSet.getInt(1) == 3) {
                    response.sendRedirect("creatorpage.jsp");
                } else if (resultSet.getInt(1) == 4) {
                    response.sendRedirect("moderatorpage.jsp");
                }
                session = request.getSession(false);
                session.setAttribute("id", id);
            } else {
                session = request.getSession(false);
                session.invalidate();
                String message = "Incorrect login or password";
                request.setAttribute("message", message);
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (SQLException throwables) {
            System.out.println("ERROR OCCURED: " + throwables.getMessage());
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
