-- preview DATA
SELECT * 
FROM patients
LIMIT 5;

-- show a doctors who have an exps more than 5 years
SELECT first_name ||' '|| last_name as Name,specialization,years_experience  
FROM doctors
WHERE years_experience > 5
ORDER by years_experience DESC;

-- show patient name and doctor name make appointment
SELECT patients.first_name as PatientName,
		doctors.first_name as DoctorName,
		appointments.appointment_date
FROM appointments 
JOIN doctors  on appointments.doctor_id = doctors.doctor_id
JOIN patients  on appointments.patient_id = patients.patient_id 
ORDER by appointments.appointment_date ASC; 

-- summarize how many time each of appointment in each type
SELECT treatment_type,count(*) as TreatmentCount,sum(cost) as Total_cost
FROM treatments
GROUP by treatment_type
ORDER by Total_Cost DESC;

-- revenue for the month (include treatment from billing)
SELECT strftime('%Y-%m',bill_date) as billing_month,
		sum(amount) as Total_Revenue
From billing
group by billing_month
ORDER by billing_month;

-- total revenue from each doctors
SELECT doctors.first_name ||' '|| doctors.last_name as doctor_name,
		sum(billing.amount) as revenue
FROM billing
JOIN treatments on treatments.treatment_id = billing.treatment_id
JOIN appointments on appointments.appointment_id = treatments.appointment_id
JOIN doctors on doctors.doctor_id = appointments.doctor_id
GROUP by doctor_name
ORDER by revenue DESC;

-- patient who has most appointment
SELECT patients.first_name ||' '|| patients.last_name as Patient_Name,
		count(*) as total_appointment
FROM appointments
JOIN patients on patients.patient_id = appointments.patient_id
GROUP by Patient_Name
ORDER by total_appointment DESC;

-- for patient who did appointment but not showing up
SELECT patients.first_name||' '||patients.last_name as patient_name,
	count(*) as missed
from appointments
JOIN patients on appointments.patient_id = patients.patient_id
WHERE status ='No-show'
GROUP by patient_name
ORDER by missed DESC
limit 5;

-- KPI : income per doctor and time of appointment
SELECT doctors.first_name||' '|| doctors.last_name as doctor_name,
		count(distinct appointments.appointment_id) as num_appointment,
		sum(billing.amount) as total_revenue
FROM billing
join treatments on treatments.treatment_id = billing.treatment_id
JOIN appointments on appointments.appointment_id = treatments.appointment_id
JOIN doctors on doctors.doctor_id = appointments.doctor_id
GROUP by doctor_name
ORDER by total_revenue DESC;

SELECT doctors.first_name||' '|| doctors.last_name as doctor_name,
		count(distinct appointments.appointment_id) as num_appointment,
		sum(billing.amount) as total_revenue
FROM billing
join treatments on treatments.treatment_id = billing.treatment_id
JOIN appointments on appointments.appointment_id = treatments.appointment_id
JOIN doctors on doctors.doctor_id = appointments.doctor_id
GROUP by doctor_name
ORDER by total_revenue DESC;

--view for doctor_kpis
CREATE VIEW doctor_kpis AS
SELECT doctors.first_name||' '|| doctors.last_name as doctor_name,
		count(distinct appointments.appointment_id) as num_appointment,
		sum(billing.amount) as total_revenue
FROM billing
join treatments on treatments.treatment_id = billing.treatment_id
JOIN appointments on appointments.appointment_id = treatments.appointment_id
JOIN doctors on doctors.doctor_id = appointments.doctor_id
GROUP by doctor_name
ORDER by total_revenue DESC;

SELECT *
FROM doctor_kpis;
