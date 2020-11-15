import database.LibraryDatabase;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

@WebServlet(name = "ModeratorUpdateServlet")
public class ModeratorUpdateServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection connection = LibraryDatabase.getInstance().getConnection();
        String query = "UPDATE threads SET title = ?, content = ? WHERE id = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1,request.getParameter("title"));
            ps.setString(2,request.getParameter("content"));
            ps.setInt(3, Integer.parseInt(request.getParameter("id")));
            ps.executeUpdate();
            ps.close();
            response.sendRedirect("moderatorpage.jsp");
        }catch (Exception throwables){
            System.out.println("ERROR OCCURED: " + throwables.getMessage());
        }
    }
}
