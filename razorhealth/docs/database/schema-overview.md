# Database Schema Overview

**Database:** `project_razor_health`  
**Version:** 2.0 (Visit-Based Model)  
**Last Updated:** January 4, 2026

---

## 📊 Tables Summary

| Table | Purpose | Rows (Sample) |
|-------|---------|---------------|
| `rz_clients` | Client information | 5 |
| `rz_client_service_contract` | Care agreements | 1 |
| `rz_client_service_days` | Service days (MON/WED/FRI) | 3 |
| `rz_visits` | Individual visit instances | 3 |
| `rz_workers` | Home care workers | 5 |
| `rz_worker_availability` | Working days/hours | 5 |
| `rz_schedule_assignments` | Visit → Worker mapping | 3 |
| `rz_employees` | Base employee data | 11 |
| `rz_schedulers` | Admin users | 6 |
| `rz_worker_time_off_requests` | Time off management | 3 |
| `rz_client_schedule_requests` | Client change requests | 0 |
| `rz_logical_date` | Testing date simulation | 1 |

---

## 🔄 Data Flow
```
Client Contract (WEEKLY, MON/WED/FRI)
         ↓
   Service Days (MON, WED, FRI)
         ↓
   Visit Generator Service
         ↓
Individual Visits (Jan 6, Jan 8, Jan 10)
         ↓
   Auto-Scheduler
         ↓
Worker Assignments (Worker 1 → Visit 101)
```

---



## 🔑 Key Design Principles

**1. Visit-Based Model**
- Visits are generated from contracts
- Scheduler assigns workers to visits
- Not slot-based (no pre-created time blocks)

**2. Pattern-Based Availability**
- Workers have recurring availability patterns
- One row per worker
- Format: "MON,WED,FRI" or "MON-FRI"

**3. Versioned Assignments**
- Each assignment tracks who created it (AUTO vs MANUAL)
- Can track reassignments

**4. Flexible Contracts**
- Support DAILY, WEEKLY, BIWEEKLY frequencies
- Extendable to MONTHLY later

---

## 📝 Sample Data

### Client 1: Alice Johnson
```
Contract: WEEKLY (MON/WED/FRI) at 10 AM for 60 min
Visits Generated:
  - Jan 6 (Mon) 10:00
  - Jan 8 (Wed) 10:00
  - Jan 10 (Fri) 10:00
All assigned to Worker 1
```

---

For complete schema details, see [razorhealth-full-schema.sql](razorhealth-full-schema.sql)