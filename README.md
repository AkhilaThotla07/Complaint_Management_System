# Complaint Management System

A web-based Complaint Management System built using JSP, Servlets, JDBC, and MySQL.

## 👨‍💻 Features

### Employee
- Register & Login
- Raise Complaint
- Cancel Complaint
- View Complaint Status

### Admin
- View All Complaints
- Resolve / Reject Complaints
- Add Resolution Remarks

## 🛠 Tech Stack
- Java (JSP + JDBC)
- MySQL
- HTML CSS
- Apache Tomcat

## 🗄 Database

Database Name: complaintsystem

### Users Table
- name
- email
- password
- phone
- role

### Complaints Table
- complaint_id
- user_name
- user_email
- complaint_text
- status
- admin_remark
- raised_at
- resolved_at

## ▶️ How to Run
1. Import project in Eclipse / IntelliJ
2. Setup MySQL database
3. Run on Apache Tomcat Server
4. Open: http://localhost:8080/ComplaintSystem

---

⭐ If you like this project, give it a star!