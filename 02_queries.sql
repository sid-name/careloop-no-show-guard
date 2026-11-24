-- using the noshowgurad database
USE noshowguard;
-- PART 1 

select * from appointments; 
select * from clinics;
-- Check with COUNT(*) and SUM(no_show)
select count(*) from appointments;
select count(*) from clinics;

select sum(no_show) from appointments;

-- PART 2.1: Primary Key Test

-- Duplicate appointment_id test:
-- INSERT INTO appointments VALUES
-- ('A0001','P999','C01','2025-01-01','2025-01-02',
-- 30,'M',5.0,500,'Online','General','Yes',0,'Booked',1,0);

-- Expected result after manually testing:
-- ERROR 1062: Duplicate entry 'A0001' for key 'appointments.PRIMARY'


-- PART 2 no_shows and no_show_pct with having 

select
clinics.clinic_name,
clinics.city,
count(*) as appointments,
sum(appointments.no_show) as no_shows,
ROUND(100.0 * SUM(no_show) / COUNT(*), 1) as no_show_pct
from appointments 
join clinics 
on appointments.clinic_id = clinics.clinic_id
group by clinics.clinic_name,clinics.city,clinics.clinic_id
having count(*) >= 95 
order by no_show_pct desc;

-- revome having 
SELECT
    clinics.clinic_name,
    clinics.city,
    COUNT(*) AS appointments,
    SUM(appointments.no_show) AS no_shows,
    ROUND(100.0 * SUM(appointments.no_show) / COUNT(*), 1) AS no_show_pct
FROM appointments 
JOIN clinics  ON appointments.clinic_id = clinics.clinic_id
GROUP BY clinics.clinic_id, clinics.clinic_name, clinics.city
ORDER BY no_show_pct DESC;


-- part 3 GROUP BY groups rows with the same lead_days band

select appointments.lead_days from appointments;


select 
case
when lead_days <=7 then "1-7"
when lead_days <=14 then "8-14"
when lead_days <=30 then "15-30"
else "31+" end as lead_band,
COUNT(*) AS appointments,
SUM(appointments.no_show) AS no_shows,
ROUND(100.0 * SUM(appointments.no_show) / COUNT(*), 1) AS no_show_pct
FROM appointments
group by 
lead_band
order by min(lead_days);


-- part 4 Tracking monthly no-show rates and compares each month with the previous month

with monthly as ( select SUBSTR(appt_date,1,7) as month,
COUNT(*) AS appointments,
SUM(appointments.no_show) AS no_shows,
ROUND(100.0 * SUM(appointments.no_show) / COUNT(*), 1) AS no_show_pct
FROM appointments
group by month)
select 
month, appointments, no_show_pct,
no_show_pct - lag(no_show_pct) over(order by month) as change_pct_points
from monthly 
order by month;

-- part 5 Ranks clinics within each city and compares their no_show rates with the overall rate


with clinic_rates as(
select
clinics.clinic_name,
clinics.city,
ROUND(100.0 * SUM(appointments.no_show) / COUNT(*), 1) AS no_show_pct
FROM appointments join clinics on clinics.clinic_id = appointments.clinic_id
group by 
clinics.clinic_name,clinics.city,clinics.clinic_id
)
select 
clinic_name,
city,
no_show_pct,
RANK() OVER (PARTITION BY city ORDER BY no_show_pct DESC) as rank_in_city,
CASE
WHEN no_show_pct > (SELECT 100.0 * SUM(no_show) / COUNT(*)FROM appointments) THEN "above"
WHEN no_show_pct < (SELECT 100.0 * SUM(no_show) / COUNT(*)FROM appointments) THEN "below"
ELSE "equal"
END AS vs_overall
FROM clinic_rates
ORDER BY city, rank_in_city;
