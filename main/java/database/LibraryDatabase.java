package database;

import tools.MyThread;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;

public class LibraryDatabase {
    private static LibraryDatabase instance = new LibraryDatabase();

    public static LibraryDatabase getInstance() {
        return instance;
    }

    private LibraryDatabase() {}

    public Connection getConnection()
    {
        Context initialContext;
        Connection connection = null;
        try
        {
            initialContext = new InitialContext();
            Context envCtx = (Context)initialContext.lookup("java:comp/env");
            DataSource ds = (DataSource)envCtx.lookup("jdbc/postgres");
            connection = ds.getConnection();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        return connection;
    }

    public ArrayList<MyThread> search (String title){
        ArrayList<MyThread> threadList = new ArrayList();
        LibraryDatabase connection = null;
        PreparedStatement ps = null;
        try {
            ps = LibraryDatabase.getInstance().getConnection().prepareStatement("SELECT * FROM threads WHERE title = ?");
            ps.setString(1,title);
            ResultSet rs = ps.executeQuery();
            ResultSetMetaData md = rs.getMetaData();
            int numberOfColumns = md.getColumnCount();
            MyThread myThread;
            while (rs.next()){
                String [] threadFields = new String[numberOfColumns];
                for (int i = 1; i < numberOfColumns; i++) {
                    threadFields[i-1] = rs.getObject(i).toString();
                }
                myThread = new MyThread(threadFields);
                threadList.add(myThread);
            }
            ps.close();
        }catch (SQLException throwables){
            throwables.printStackTrace();
        }
        return threadList;
    }


}