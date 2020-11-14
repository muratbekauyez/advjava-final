package tools;

public class User {
    int id;
    String fname, lname, major;
    String username, password;

    public User (String username, String password){
        this.username = username;
        this.password = password;
    }
    public User(int id, String fname, String lname, String major, String username, String password) {
        this.id = id;
        this.fname = fname;
        this.lname = lname;
        this.major = major;
        this.username = username;
        this.password = password;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFname() {
        return fname;
    }

    public void setFname(String fname) {
        this.fname = fname;
    }

    public String getLname() {
        return lname;
    }

    public void setLname(String lname) {
        this.lname = lname;
    }

    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}
