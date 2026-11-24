# Careloop-no-show-guard
Analysing clinic appointments and predicting patient no-shows using Python, SQL, Machine Learning, and GenAI.


# CareLoop Clinics — No-Show Guard

**GitHub Repository:** https://github.com/sid-name/careloop-no-show-guard

## Project Overview

This project analyses missed appointments at CareLoop Clinics using Python, SQL, Machine Learning, and Generative AI. The goal is to understand why patients miss appointments and help clinics identify high-risk bookings early so they can take action.

## 1. Four-Part Project Summary

- **Part 1 – Data Cleaning:** Cleaned the appointment data and prepared 990 records, including 218 no-shows (22.0%).
- **Part 2 – Data Analysis:** Found that no-show rates across four booking lead-time groups were 16.2%, 17.4%, 30.0%, and 60.5%.
- **Part 3 – Machine Learning:** Selected Logistic Regression, achieving a test AUC of approximately 0.79 with a threshold of 0.35.
- **Part 4 – GenAI:** Analysed 10 follow-up notes using Gemini, including 9 non-blank notes, and found that 5 of the 10 appointments had no reminder recorded.

## 2. Business Recommendation

CareLoop Clinics should use the Logistic Regression model to identify patients who are at risk of missing their appointments and contact them before the appointment date. The dataset contained 990 cleaned appointments, with 218 no-shows (22.0%). The analysis also showed that no-show rates increased across booking lead-time groups, reaching 60.5% in the highest-rate group. The selected model achieved a test AUC of approximately 0.79, using a threshold of 0.35 to identify higher-risk bookings. The clinic should give more attention to high-risk patients through phone calls and timely reminders. Gemini analysed 10 follow-up notes, of which 5 appointments had no reminder recorded. The clinics should also improve reminder communication and review common reasons such as forgetting, transport, cost, illness, and work schedules. These actions can help reduce missed appointments and make better use of doctors' available time.

## 3. Selected Machine Learning Model

**Selected Model: Logistic Regression**

I selected Logistic Regression because it provided useful prediction performance and produces understandable risk scores. It achieved:

- Cross-validation AUC: Approximately 0.77
- Test AUC: Approximately 0.79
- Selected threshold: 0.35

The threshold of 0.35 was selected to identify bookings that may need extra attention from the front desk.

## 4. Project Limitations

1. **Limited follow-up notes:** Only 10 notes were analysed, so they cannot represent the actual reasons for missed appointments across all clinics.
2. **Random train-test split:** The data was split randomly rather than using past appointments to predict future appointments.
3. **Call capacity:** The selected threshold depends on how many high-risk patients the clinic staff can realistically call.

## 5. Conclusion

This project combines data cleaning, analysis, machine learning, and Generative AI to understand and predict missed appointments. The results can help CareLoop Clinics identify risky bookings, understand patient reasons, and improve their follow-up process.
