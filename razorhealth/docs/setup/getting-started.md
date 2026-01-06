# Getting Started with Razor Health

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

### Required
- **Java 17** or higher
```bash
  java -version
  # Should show: openjdk version "17.x.x" or higher
```

- **Maven 3.6+**
```bash
  mvn -version
```

- **MySQL 8.0+**
```bash
  mysql --version
```

### Recommended
- **IntelliJ IDEA** (Community or Ultimate)
- **Git**
- **Postman** or **curl** (for API testing)

---

## 🗄️ Database Setup

### Step 1: Create Database
```bash
# Log into MySQL
mysql -u root -p

# Create database
CREATE DATABASE project_razor_health;

# Create application user
CREATE USER 'app_user'@'localhost' IDENTIFIED BY 'your_password';
GRANT ALL PRIVILEGES ON project_razor_health.* TO 'app_user'@'localhost';
FLUSH PRIVILEGES;

EXIT;
```

### Step 2: Import Schema
```bash
# Navigate to project directory
cd razor-health

# Import schema
mysql -u app_user -p project_razor_health < docs/database/full-schema.sql
```

### Step 3: Verify Data
```bash
mysql -u app_user -p project_razor_health

# Check tables
SHOW TABLES;

# Verify sample data
SELECT * FROM rz_clients;
```

You should see 5 clients (Alice Johnson, Robert White, etc.).

---

## 🚀 Application Setup

### Step 1: Clone Repository
```bash
git clone <repository-url>
cd razor-health
```

### Step 2: Configure Database Connection

Edit `razor-health-api/src/main/resources/application.properties`:
```properties
spring.datasource.username=app_user
spring.datasource.password=your_password_here
```

### Step 3: Build Project
```bash
# Clean and install
mvn clean install

# You should see:
# [INFO] BUILD SUCCESS
```

### Step 4: Run Application

**Option A: Using Maven**
```bash
mvn spring-boot:run -pl razor-health-api
```

**Option B: Using IntelliJ**
1. Open `RazorHealthApiApplication.java`
2. Right-click → Run 'RazorHealthApiApplication'

### Step 5: Verify Application Started

Look for this in the logs:
```
Started RazorHealthApiApplication in X.XXX seconds
Tomcat started on port 8080
```

---

## ✅ Testing the API

### Using curl
```bash
# Get all clients
curl http://localhost:8080/api/clients

# Get specific client
curl http://localhost:8080/api/clients/1

# Expected response:
{
  "clientId": 1,
  "clientName": "Alice Johnson",
  "clientAddress": "123 Main St, Burnaby",
  "clientArea": "Burnaby",
  "clientImportance": "HIGH",
  "clientGender": "FEMALE",
  "clientHasPet": false,
  ...
}
```

### Using Browser

Navigate to:
```
http://localhost:8080/api/clients
```

### Using Postman

1. Create new request
2. Method: GET
3. URL: `http://localhost:8080/api/clients`
4. Send

---

## 📚 Next Steps

Once everything is running:

1. ✅ Read [Database Schema Documentation](../database/schema.md)
2. ✅ Explore [API Endpoints](../api/endpoints.md)
3. ✅ Start building additional entities
4. ✅ Implement Visit Generation Service

---
