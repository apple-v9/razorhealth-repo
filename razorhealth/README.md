# 🏥 Razor Health - Home Care Scheduling System

> Automated scheduling system for home healthcare workers and clients

## 📋 Project Overview

**Razor Health** is a visit-based scheduling system designed for home healthcare agencies. It automates worker assignment based on client needs, availability, and business constraints.

### Key Features
- ✅ Client contract management (DAILY, WEEKLY, BIWEEKLY)
- ✅ Automatic visit generation from contracts
- ✅ Intelligent worker assignment with constraints
- ✅ Manual override capabilities for schedulers
- ✅ Time-off request management
- 🚧 Client schedule change requests (coming soon)

## 🏗️ Architecture

- **Backend:** Spring Boot 3.5.6, Java 17
- **Database:** MySQL 8.0.25
- **Build Tool:** Maven (Multi-module)
- **ORM:** Hibernate/JPA



## 🚀 Quick Start

### Prerequisites
- Java 17+
- MySQL 8.0+
- Maven 3.6+

### Setup

1. **Clone the repository**
```bash
git clone <repository-url>
cd razor-health
```

2. **Set up database**
```bash
mysql -u root -p < docs/database/schema.sql
```

3. **Configure database connection**

Edit `razor-health-api/src/main/resources/application.properties`:
```properties
spring.datasource.username=your_username
spring.datasource.password=your_password
```

4. **Build and run**
```bash
mvn clean install
mvn spring-boot:run -pl razor-health-api
```

5. **Test the API**
```bash
curl http://localhost:8080/api/clients
```

## 📖 Documentation

- [Setup Guide](docs/setup/getting-started.md)
- [Database Schema](docs/database/schema.md)
- [API Documentation](docs/api/endpoints.md)


## 📊 Project Status

**Current Phase:** Phase 1 - Foundation & Core Domain  
**Version:** 0.0.1-SNAPSHOT  
**Last Updated:** January 4, 2026

### Completed
- [x] Database schema design (visit-based model)
- [x] Spring Boot project setup
- [x] Client entity and REST API
- [x] Basic CRUD operations

### In Progress
- [ ] Complete all domain entities
- [ ] Visit generation service
- [ ] Auto-scheduler service

### Planned
- [ ] Manual override API
- [ ] Admin dashboard
- [ ] Worker view dashboard
- [ ] Client view dashboard
- [ ] Handling Scheduling constraints 


## ⚠️ Disclaimer

Razor Health is a fictional project created for learning and demonstration
purposes only, focused on understanding scheduling algorithms, Spring Boot, and domain-driven design.
It does not represent a real healthcare provider, system,
or service.


## 📝 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.