package database;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;

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
}