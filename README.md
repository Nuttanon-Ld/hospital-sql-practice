# hospital-sql-practice
SQL queries for hospital management system – focusing on appointments, billing, doctor performance, and KPIs.

# Hospital SQL Practice

This project includes SQL queries used to explore and analyze hospital data in SQLite. The queries demonstrate skills in:

- SELECT and JOIN across multiple tables
- Aggregations and GROUP BY
- Creating KPI metrics such as total revenue, no-show patients, and most active doctors
- Creating a SQL VIEW for doctor performance

## File Included

- `Hos_test.sql` – contains all SQL practice queries

## Sample Queries

### 1. Doctors with more than 5 years of experience
```
SELECT first_name || ' ' || last_name AS Name,
       specialization,
       years_experience  
FROM doctors
WHERE years_experience > 5
ORDER BY years_experience DESC;
```
### 2. Revenue per doctor (VIEW)
```
CREATE VIEW doctor_kpis AS
SELECT doctors.first_name || ' ' || doctors.last_name AS doctor_name,
       COUNT(DISTINCT appointments.appointment_id) AS num_appointment,
       SUM(billing.amount) AS total_revenue
FROM billing
JOIN treatments ON treatments.treatment_id = billing.treatment_id
JOIN appointments ON appointments.appointment_id = treatments.appointment_id
JOIN doctors ON doctors.doctor_id = appointments.doctor_id
GROUP BY doctor_name
ORDER BY total_revenue DESC;
```
