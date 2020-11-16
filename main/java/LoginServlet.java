import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.google.gson.Gson;
import tools.*;

import database.*;




@WebServlet(name = "LoginServlet")
public class LoginServlet extends HttpServlet {
    public User user = new User("","");
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String submit = request.getParameter("submit");
        if(submit.equals("search")){
            String title = request.getParameter("title");
            ArrayList<MyThread> threadList = LibraryDatabase.getInstance().search(title);
            response.setContentType("text/html;charset=UTF-8");
            String json = new Gson().toJson(threadList);
            response.getWriter().write(json);
            return;
        }


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

                Cookie usernameCookie = new Cookie("username",username);
                response.addCookie(usernameCookie);
                usernameCookie.setMaxAge(3600);

                Cookie passwordCookie = new Cookie("password",password);
                response.addCookie(passwordCookie);
                passwordCookie.setMaxAge(3600);

                session = request.getSession(false);
                session.setAttribute("id", id);
            } else {
                session = request.getSession(false);
                session.invalidate();
                String message = "Incorrect login or password";
                request.setAttribute("message", message);
                request.getRequestDispatcher("login.jsp").forward(request, response);

            }
            connection.close();

        } catch (SQLException throwables) {
            System.out.println("ERROR OCCURED: " + throwables.getMessage());
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
