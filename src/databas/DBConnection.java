package databas; /**
 * Created by Nicklas on 12/04/16.
 */
import com.mongodb.*;
import com.mongodb.diagnostics.logging.Logger;

import java.sql.*;
public class DBConnection {
    Connection con;
    String url;
    String db2;
    String driver;
    String userName;
    String password;
    ResultSet rs;
    Statement st;
    MongoClient mongoClient;
    DB db1;
    DBCollection coll;


    public DBConnection(){
        con = null;
        url = "jdbc:mysql://localhost:3306/";
        db2 = "world?useSSL=false";
        driver = "com.mysql.jdbc.Driver";
        userName = "root";
        password = "Nicklasupm692";
        rs = null;
        mongoClient = new MongoClient( "localhost" , 27017 );
        db1 = mongoClient.getDB( "mongodatabase" );
        coll = db1.getCollection("mongocollection");


    }

    public ResultSet getResultSet() {
        try {
            Class.forName(driver).newInstance();
            con = DriverManager.getConnection(url + db2, userName, password);
            String query = "select * from country";
            st = con.createStatement();
            rs = st.executeQuery(query);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rs;
    }

    public DBCursor getCursor(){
        DBCursor cursor = coll.find();
        return cursor;
    }

    public void SQLtoMongo(){
        try {

            Class.forName(driver).newInstance();
            con = DriverManager.getConnection(url + db2, userName, password);
            String query = "select * from country";
            st = con.createStatement();
            rs = st.executeQuery(query);
            ResultSetMetaData rsmd = rs.getMetaData();
            int columnsNumber = rsmd.getColumnCount();
            while (rs.next()) {
                BasicDBObject document = new BasicDBObject();
                for(int i = 1; i <= columnsNumber; i++) {
                    document.put(rs.getMetaData().getColumnName(i), rs.getString(i));
                }
                coll.insert(document);

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public void clearMongo(){
        db1.getCollection("mongocollection").drop();
    }




}
