# API Documentation

**Base URL:** `http://localhost:8080`  
**Version:** 0.0.1-SNAPSHOT

---

## 📋 Client Endpoints

### Get All Clients
```http
GET /api/clients
```

**Response:**
```json
[
  {
    "clientId": 1,
    "clientName": "Alice Johnson",
    "clientAddress": "123 Main St, Burnaby",
    "clientArea": "Burnaby",
    "clientImportance": "HIGH",
    "clientGender": "FEMALE",
    "clientHasPet": false,
    "rzCreatedAt": "2025-10-04T19:10:36",
    "rzLastUpdatedAt": "2025-10-04T19:16:17"
  }
]
```

---

### Get Client by ID
```http
GET /api/clients/{id}
```

**Parameters:**
- `id` (path) - Client ID (integer)

**Example:**
```bash
curl http://localhost:8080/api/clients/1
```

**Response:**
```json
{
  "clientId": 1,
  "clientName": "Alice Johnson",
  "clientAddress": "123 Main St, Burnaby",
  "clientArea": "Burnaby",
  "clientImportance": "HIGH",
  "clientGender": "FEMALE",
  "clientHasPet": false,
  "rzCreatedAt": "2025-10-04T19:10:36",
  "rzLastUpdatedAt": "2025-10-04T19:16:17"
}
```

---

### Create New Client
```http
POST /api/clients
```

**Request Body:**
```json
{
  "clientName": "Jack Ryan Johnson",
  "clientAddress": "123 Grover St, Langley",
  "clientArea": "Langley",
  "clientImportance": "HIGH",
  "clientGender": "MALE",
  "clientHasPet": false
}
```

**Response:** Created client object with generated ID
```json
{
"clientId": 6,
"clientName": "Jack Ryan Johnson",
"clientAddress": "123 Grover St, Langley",
"clientArea": "Langley",
"clientImportance": "HIGH",
"clientGender": "MALE",
"clientHasPet": false,
"rzCreatedAt": "2026-01-04T20:57:35.9894353",
"rzLastUpdatedAt": "2026-01-04T20:57:35.9894353"
}
```
---

## 🚧 Coming Soon

- Worker endpoints
- Visit endpoints
- Scheduler endpoints
- Manual assignment endpoints
```
