/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package databaseConnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 *
 * @author kush
 */
public class MySqlDatabaseConnector {
    
    private final String username, password, databaseName, link;
    private Connection connection;
    private Statement statement;
    private ResultSet resultSet;

    public MySqlDatabaseConnector(String link, String databaseName, String username, String password) {
        this.username = username;
        this.password = password;
        this.databaseName = databaseName;
        this.link = link;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(link+databaseName, username, password);
            statement = connection.createStatement();
        } catch(Exception e) {
            System.err.println("**Exception**\n" + e);
        }
    }
    
    public int insert(String userId, String cED, String cText, String cEdType, String cCText) {
        int value = 0;
        try {
            value = statement.executeUpdate("insert into history_details values('" + userId + "','" + cED + "','" + cText + "','" + cEdType + "','" + cCText + "');");
            
        } catch(Exception e) {
            System.err.println(e);
        }
        return value;
    }
    
    public ResultSet getAllTuples(String userId) {
        ResultSet r = null;
        try{
            r = statement.executeQuery("select * from history_details where user_id='" + userId + "';");
        } catch(Exception e) {
            System.err.println(e);
        }
        return r;
    }
    
    public ResultSet getAllEncryptionTuples(String userId) {
        ResultSet r = null;
        try{
            r = statement.executeQuery("select * from history_details where user_id='" + userId + "' and c_ed = 'e';");
        } catch(Exception e) {
            System.err.println(e);
        }
        return r;
    }
    
    public ResultSet getAllDecryptionTuples(String userId) {
        ResultSet r = null;
        try{
            r = statement.executeQuery("select * from history_details where user_id='" + userId + "' and c_ed = 'd';");
        } catch(Exception e) {
            System.err.println(e);
        }
        return r;
    }
    
}
