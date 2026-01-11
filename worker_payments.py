
import os
import sys
import random
import datetime
from pathlib import Path


COMPANY_NAME = "Highridge Construction Company"
CURRENCY = "USD"
TODAY = datetime.date.today()


FIRST_NAMES_MALE = [
    'James', 'John', 'Robert', 'Michael', 'William', 'David', 'Richard',
    'Joseph', 'Thomas', 'Charles', 'Christopher', 'Daniel', 'Matthew',
    'Anthony', 'Donald', 'Mark', 'Paul', 'Steven', 'Andrew', 'Kenneth',
    'Joshua', 'Kevin', 'Brian', 'George', 'Edward', 'Ronald', 'Timothy',
    'Jason', 'Jeffrey', 'Ryan', 'Jacob', 'Gary', 'Nicholas', 'Eric',
    'Jonathan', 'Stephen', 'Larry', 'Justin', 'Scott', 'Brandon'
]

FIRST_NAMES_FEMALE = [
    'Mary', 'Patricia', 'Jennifer', 'Linda', 'Elizabeth', 'Barbara',
    'Susan', 'Jessica', 'Sarah', 'Karen', 'Nancy', 'Margaret', 'Lisa',
    'Betty', 'Dorothy', 'Sandra', 'Ashley', 'Kimberly', 'Donna', 'Emily',
    'Michelle', 'Carol', 'Amanda', 'Melissa', 'Deborah', 'Stephanie',
    'Rebecca', 'Laura', 'Sharon', 'Cynthia', 'Kathleen', 'Amy', 'Shirley',
    'Angela', 'Helen', 'Anna', 'Brenda', 'Pamela', 'Nicole', 'Emma'
]

LAST_NAMES = [
    'Smith', 'Johnson', 'Williams', 'Brown', 'Jones', 'Garcia', 'Miller',
    'Davis', 'Rodriguez', 'Martinez', 'Hernandez', 'Lopez', 'Gonzalez',
    'Wilson', 'Anderson', 'Thomas', 'Taylor', 'Moore', 'Jackson', 'Martin',
    'Lee', 'Perez', 'Thompson', 'White', 'Harris', 'Sanchez', 'Clark',
    'Ramirez', 'Lewis', 'Robinson', 'Walker', 'Young', 'Allen', 'King',
    'Wright', 'Scott', 'Torres', 'Nguyen', 'Hill', 'Flores', 'Green',
    'Adams', 'Nelson', 'Baker', 'Hall', 'Rivera', 'Campbell', 'Mitchell',
    'Carter', 'Roberts'
]


def create_workers_list(num_workers=400):
    """
    Dynamically creates a list of workers with random data.
    Args:
        num_workers (int): Number of workers to create (minimum 400)
    Returns:
        list: List of worker dictionaries
    """
    if num_workers < 400:
        print(f"Warning: Minimum 400 workers required. Using 400 instead of {num_workers}.")
        num_workers = 400
    
    workers = []
    for i in range(num_workers):
        
        gender = random.choice(['M', 'F'])
        
       
        if gender == 'M':
            first_name = random.choice(FIRST_NAMES_MALE)
        else:
            first_name = random.choice(FIRST_NAMES_FEMALE)
        
        last_name = random.choice(LAST_NAMES)
        full_name = f"{first_name} {last_name}"
        
       
        salary = round(random.uniform(5000, 35000), 2)
        
      
        worker_id = f"HRC{i+1:04d}"
        
        worker = {
            'id': worker_id,
            'name': full_name,
            'gender': gender,
            'salary': salary,
            'level': ''  
        }
        workers.append(worker)
    
    return workers


def main():
    """
    Main function that implements all assignment requirements:
    1. Creates list of workers dynamically (at least 400)
    2. Uses for loop to generate payment slips
    3. Implements conditional statements within the loop
    4. Adds exception handling
    """
    print("=" * 60)
    print(f"{COMPANY_NAME} - Weekly Payment System")
    print("=" * 60)
    

    output_dir = Path("payment_slips_python")
    output_dir.mkdir(exist_ok=True)
    
    try:
        print("\nCreating worker list...")
        workers = create_workers_list(400)  
        print(f"✓ Created list of {len(workers)} workers")
        
       
        print("\nGenerating payment slips...")
        successful_slips = 0
        
        for worker in workers:  
            try:
               
                salary = worker['salary']
                gender = worker['gender']
                level = "General"  
                
               
                if salary > 10000 and salary < 20000:
                    level = "A1"
                
                
                if gender == 'F' and salary > 7500 and salary < 30000:
                    level = "A5-F"
                
                worker['level'] = level
                
                
                slip_content = f"""
{'=' * 50}
{COMPANY_NAME}
Weekly Payment Slip
{'=' * 50}

Employee Details:
-----------------
Employee ID: {worker['id']}
Full Name:   {worker['name']}
Gender:      {'Male' if gender == 'M' else 'Female'}
Salary:      {CURRENCY} {salary:,.2f}
Level:       {level}

Payment Information:
-------------------
Payment Date: {TODAY.strftime('%B %d, %Y')}
Payment Week: Week ending {TODAY.strftime('%Y-%m-%d')}

{'=' * 50}
Notes:
- This is an automatically generated payment slip.
- Contact HR for any discrepancies.
{'=' * 50}
"""
                
                filename = f"{worker['id']}_{worker['name'].replace(' ', '_')}.txt"
                filepath = output_dir / filename
                
                with open(filepath, 'w', encoding='utf-8') as f:
                    f.write(slip_content)
                
                successful_slips += 1
                
         
            except KeyError as e:
                print(f"  ✗ Error: Missing key in worker data - {e}")
                continue
            except TypeError as e:
                print(f"  ✗ Error: Data type issue - {e}")
                continue
            except ValueError as e:
                print(f"  ✗ Error: Invalid value - {e}")
                continue
            except IOError as e:
                print(f"  ✗ Error: File operation failed - {e}")
                continue
            except Exception as e:
                print(f"  ✗ Unexpected error for worker {worker.get('id', 'Unknown')}: {e}")
                continue
        
       
        print(f"\n{'=' * 60}")
        print("PROCESSING SUMMARY")
        print('=' * 60)
        print(f"Total workers processed: {len(workers)}")
        print(f"Successful payment slips: {successful_slips}")
        print(f"Failed to generate: {len(workers) - successful_slips}")
        print(f"Output directory: {output_dir.absolute()}")
     
        a1_count = sum(1 for w in workers if w['level'] == 'A1')
        a5f_count = sum(1 for w in workers if w['level'] == 'A5-F')
        female_count = sum(1 for w in workers if w['gender'] == 'F')
        male_count = sum(1 for w in workers if w['gender'] == 'M')
        
        print(f"\nStatistics:")
        print(f"  - Female workers: {female_count}")
        print(f"  - Male workers: {male_count}")
        print(f"  - Level A1 assigned: {a1_count}")
        print(f"  - Level A5-F assigned: {a5f_count}")
        print(f"  - General level: {len(workers) - a1_count - a5f_count}")
        
      
        try:
            import csv
            summary_file = "workers_summary.csv"
            with open(summary_file, 'w', newline='', encoding='utf-8') as csvfile:
                fieldnames = ['ID', 'Name', 'Gender', 'Salary', 'Level']
                writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
                writer.writeheader()
                for worker in workers:
                    writer.writerow({
                        'ID': worker['id'],
                        'Name': worker['name'],
                        'Gender': worker['gender'],
                        'Salary': f"{worker['salary']:.2f}",
                        'Level': worker['level']
                    })
            print(f"\n✓ Summary saved to: {summary_file}")
        except Exception as e:
            print(f"\n⚠ Could not save CSV summary: {e}")
        
        print(f"\n{'=' * 60}")
        print("PROCESS COMPLETED SUCCESSFULLY!")
        print('=' * 60)
        
  
    except ValueError as e:
        print(f"\n❌ VALUE ERROR: {e}")
        print("Please check your input parameters.")
        return 1
    except MemoryError as e:
        print(f"\n❌ MEMORY ERROR: {e}")
        print("The program requires too much memory.")
        return 1
    except KeyboardInterrupt:
        print(f"\n\n⚠ Program interrupted by user.")
        return 1
    except Exception as e:
        print(f"\n❌ UNEXPECTED ERROR: {type(e).__name__}: {e}")
        print("An unexpected error occurred. Please contact support.")
        return 1
    
    return 0


if __name__ == "__main__":
    sys.exit(main())