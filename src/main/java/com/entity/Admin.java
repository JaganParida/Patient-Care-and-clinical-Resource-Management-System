package com.entity;

public class Admin {
    private int id;
    private String fullName;
    private String employeeId;
    private String department;
    private String position;
    private String email;
    private String phone;
    private String password;
    private String accessLevel;

    public Admin() { }

    public Admin(String fullName, String employeeId, String department, String position,
                 String email, String phone, String password, String accessLevel) {
        this.fullName = fullName;
        this.employeeId = employeeId;
        this.department = department;
        this.position = position;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.accessLevel = accessLevel;
    }

    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmployeeId() { return employeeId; }
    public void setEmployeeId(String employeeId) { this.employeeId = employeeId; }

    public String getDepartment() { return department; }
    public void setDepartment(String department) { this.department = department; }

    public String getPosition() { return position; }
    public void setPosition(String position) { this.position = position; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getAccessLevel() { return accessLevel; }
    public void setAccessLevel(String accessLevel) { this.accessLevel = accessLevel; }
}
