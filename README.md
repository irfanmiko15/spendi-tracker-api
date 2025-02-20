# 💰 Spending Tracker API
![alt text](https://github.com/irfanmiko15/spendi-tracker-api/blob/main/image/vapor.png)

## 📌 Overview
Spending Tracker API is a backend service designed to help users track their spending efficiently. Built with **Swift Vapor**, it provides a robust and scalable API to manage expenses, authenticate users securely, and send notifications.

## 🛠️ Tech Stack
- **Backend:** Swift Vapor  
- **Database:** PostgreSQL  
- **Authentication:** JWT Token  
- **Email Service:** Mailgun (for email verification, password reset, etc.)  
- **Queue Processing:** Redis (for handling background jobs efficiently)  

## 🚀 Features
- ✅ **User Authentication** – Secure login & registration using JWT  
- ✅ **Email Verification & Password Reset** – Integrated with Mailgun  
- ✅ **Expense Tracking** – CRUD operations for managing spending records  
- ✅ **Secure API Access** – JWT authentication for protecting endpoints  
- ✅ **Asynchronous Job Processing** – Uses Redis for background tasks  

---

## 📦 Installation

### 1️⃣ Clone the Repository
```sh
git clone https://github.com/irfanmiko15/spendi-tracker-api.git
cd spendi-tracker-api
```

### 2️⃣ Set Up Environment Variables
Copy env.example to .env and configure your database, Mailgun, and Redis settings


### 3️⃣ Migrate Database
![alt text](https://github.com/irfanmiko15/spendi-tracker-api/blob/main/image/db_schema.png)

run ```swift run App migrate``` to migrate database and it will seed data for ```expense_type``` and ```spending_method``` table

### 4️⃣ Run App
```swift run App```

### 5️⃣ Test your endpoint
here is collection postman to test all of the endpoint
[Here!](https://github.com/irfanmiko15/spendi-tracker-api/blob/main/Collection/Spendi-Tracker.postman_collection.json)

