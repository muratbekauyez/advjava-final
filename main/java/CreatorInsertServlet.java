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

@WebServlet(name = "CreatorInsertServlet")
public class CreatorInsertServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String type = request.getParameter("type");

        Connection connection = LibraryDatabase.getInstance().getConnection();
        String query = "INSERT INTO threads (title, content, status) VALUES (?,?,?)";
        try {
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1,title);
            ps.setString(2,content);
            ps.setString(3,type);
            ps.executeUpdate();
            ps.close();
            request.getRequestDispatcher("creatorpage.jsp").forward(request, response);
            connection.close();
        }catch (SQLException throwables){
            System.out.println("ERROR OCCURED: " + throwables.getMessage());
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
