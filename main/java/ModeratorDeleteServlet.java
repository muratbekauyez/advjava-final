import database.LibraryDatabase;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "ModeratorDeleteServlet")
public class ModeratorDeleteServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection connection = LibraryDatabase.getInstance().getConnection();
        String query = "DELETE FROM threads WHERE id = ?";
        try{
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, Integer.parseInt(request.getParameter("id")));
            preparedStatement.executeUpdate();
            preparedStatement.close();
            response.sendRedirect("moderatorpage.jsp");
            connection.close();
        }catch (Exception throwables){
            System.out.println("ERROR OCCURED: " + throwables.getMessage());
        }
    }
}
