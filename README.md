Highridge Construction Company Payment Slips System
Module 1 Assignment Submission

Student Information
Name: [Charles Orji]
Course: [BAN6420 Programming in R and Python]
Date: [11/01/2026]
Institution: [Nextford]

## Assignment Overview
This project implements a payroll system for Highridge Construction Company that generates weekly payment slips for workers. The system meets all assignment requirements with both Python and R implementations.

## ✅ Requirements Checklist

| Requirement | Status | Implementation Details |
|------------|--------|------------------------|
| Create list of workers dynamically (≥400) | ✅ Complete | Both Python & R generate exactly 400 workers |
| Use for loop to generate payment slips | ✅ Complete | Loop iterates through all workers |
| Implement conditional statements | ✅ Complete | A1 & A5-F levels assigned based on salary & gender |
| Add exception handling | ✅ Complete | Comprehensive try-catch blocks in both languages |
| Convert Python code to R | ✅ Complete | Full R implementation included |
| Package with README | ✅ Complete | This documentation file |

## 📁 Project Structure

Python Implementation
Requirements
- Python 3.6 or higher
- No external dependencies required (uses standard library only)




## How to Run

### Python Implementation

# 1. Navigate to project directory
cd ASSIGNMENT
# 2. Run the Python script
python payroll_system.py
# 3. Output will be created in:
#    - payment_slips_python/ (individual slips)
#    - workers_summary.csv (summary file)


 #R Implementation
# 1. Navigate to project directory
cd ASSIGNMENT
# 2. Run the R script
Rscript payroll_system.R
# 3. Output will be created in:
#    - payment_slips_r/ (individual slips)
#    - workers_summary_r.csv (summary file)
#    - payroll_statistics.csv (statistics)

ASSIGNMENT/
├── payroll_system.py # Python implementation
├── payroll_system.R # R implementation
├── README.md # This documentation
├── payment_slips_python/ # Generated Python slips
│ └── HRC0001_John_Smith.txt
│ └── HRC0002_Mary_Johnson.txt
│ └── ... (400+ files)
├── payment_slips_r/ # Generated R slips
│ └── HRC0001_Worker_1.txt
│ └── HRC0002_Worker_2.txt
│ └── ... (400+ files)
├── workers_summary.csv # Python summary
├── workers_summary_r.csv # R summary
└── payroll_statistics.csv # R statistics

# Implementation Details
Worker Generation
Total Workers: 400 (minimum requirement met)
Salary Range: $5,000 - $35,000 (randomly generated)
Gender Distribution: Approximately 50/50 male/female
Worker IDs: Format HRC0001, HRC0002, ..., HRC0400
Conditional Logic
The system implements two business rules:
Level A1: Salary > $10,000 AND salary < $20,000
Level A5-F: Salary > $7,500 AND salary < $30,000 AND gender = 'F'
Rule Priority: A5-F overrides A1 if both conditions apply

# Error Handling
Both implementations include comprehensive error handling:
File I/O errors (permissions, disk space)
Data validation errors
Memory allocation errors
User interruption handling
General exception catching


# Payment Format
==================================================
Highridge Construction Company
Weekly Payment Slip
==================================================

Employee Details:
-----------------
Employee ID: HRC0123
Full Name:   Mary Johnson
Gender:      Female
Salary:      USD 15,250.50
Level:       A5-F

Payment Information:
-------------------
Payment Date: March 15, 2024
Payment Week: Week ending 2024-03-15

==================================================
Notes:
- This is an automatically generated payment slip.
- Contact HR for any discrepancies.
==================================================

