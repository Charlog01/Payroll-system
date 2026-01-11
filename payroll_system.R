
company_name <- "Highridge Construction Company"
currency <- "USD"
today <- Sys.Date()


first_names_male <- c(
  'James', 'John', 'Robert', 'Michael', 'William', 'David', 'Richard',
  'Joseph', 'Thomas', 'Charles', 'Christopher', 'Daniel', 'Matthew',
  'Anthony', 'Donald', 'Mark', 'Paul', 'Steven', 'Andrew', 'Kenneth',
  'Joshua', 'Kevin', 'Brian', 'George', 'Edward', 'Ronald', 'Timothy',
  'Jason', 'Jeffrey', 'Ryan', 'Jacob', 'Gary', 'Nicholas', 'Eric',
  'Jonathan', 'Stephen', 'Larry', 'Justin', 'Scott', 'Brandon'
)

first_names_female <- c(
  'Mary', 'Patricia', 'Jennifer', 'Linda', 'Elizabeth', 'Barbara',
  'Susan', 'Jessica', 'Sarah', 'Karen', 'Nancy', 'Margaret', 'Lisa',
  'Betty', 'Dorothy', 'Sandra', 'Ashley', 'Kimberly', 'Donna', 'Emily',
  'Michelle', 'Carol', 'Amanda', 'Melissa', 'Deborah', 'Stephanie',
  'Rebecca', 'Laura', 'Sharon', 'Cynthia', 'Kathleen', 'Amy', 'Shirley',
  'Angela', 'Helen', 'Anna', 'Brenda', 'Pamela', 'Nicole', 'Emma'
)

last_names <- c(
  'Smith', 'Johnson', 'Williams', 'Brown', 'Jones', 'Garcia', 'Miller',
  'Davis', 'Rodriguez', 'Martinez', 'Hernandez', 'Lopez', 'Gonzalez',
  'Wilson', 'Anderson', 'Thomas', 'Taylor', 'Moore', 'Jackson', 'Martin',
  'Lee', 'Perez', 'Thompson', 'White', 'Harris', 'Sanchez', 'Clark',
  'Ramirez', 'Lewis', 'Robinson', 'Walker', 'Young', 'Allen', 'King',
  'Wright', 'Scott', 'Torres', 'Nguyen', 'Hill', 'Flores', 'Green',
  'Adams', 'Nelson', 'Baker', 'Hall', 'Rivera', 'Campbell', 'Mitchell',
  'Carter', 'Roberts'
)


create_workers_list <- function(num_workers = 400) {
  """
  Dynamically creates a list of workers with random data.
  Args:
    num_workers (int): Number of workers to create (minimum 400)
  Returns:
    data.frame: Data frame containing worker information
  """
  if (num_workers < 400) {
    cat("Warning: Minimum 400 workers required. Using 400 instead of", num_workers, "\n")
    num_workers <- 400
  }
  
  
  ids <- character(num_workers)
  names <- character(num_workers)
  genders <- character(num_workers)
  salaries <- numeric(num_workers)
  levels <- character(num_workers)
  

  set.seed(42)
  
  for (i in 1:num_workers) {
    tryCatch({
    
      gender <- sample(c("M", "F"), 1)
      
  
      if (gender == "M") {
        first_name <- sample(first_names_male, 1)
      } else {
        first_name <- sample(first_names_female, 1)
      }
      
      last_name <- sample(last_names, 1)
      full_name <- paste(first_name, last_name)
      
    
      salary <- round(runif(1, 5000, 35000), 2)
      
    
      worker_id <- sprintf("HRC%04d", i)
      
     
      ids[i] <- worker_id
      names[i] <- full_name
      genders[i] <- gender
      salaries[i] <- salary
      levels[i] <- ""  
      
    }, error = function(e) {
      cat("Error creating worker", i, ":", e$message, "\n")
      
      ids[i] <- paste0("HRC", sprintf("%04d", i))
      names[i] <- "Unknown Worker"
      genders[i] <- "U"
      salaries[i] <- 0
      levels[i] <- "Error"
    })
  }
  
  workers <- data.frame(
    ID = ids,
    Name = names,
    Gender = genders,
    Salary = salaries,
    Level = levels,
    stringsAsFactors = FALSE
  )
  
  return(workers)
}


determine_level <- function(salary, gender) {
  """
  Determine employee level based on salary and gender.
  Args:
    salary (numeric): Employee salary
    gender (character): Employee gender ("M" or "F")
  Returns:
    character: Employee level
  """
  level <- "General"
  

  if (salary > 10000 && salary < 20000) {
    level <- "A1"
  }
  

  if (gender == "F" && salary > 7500 && salary < 30000) {
    level <- "A5-F"
  }
  
  return(level)
}

create_payment_slip <- function(worker, output_dir) {
  """
  Create a payment slip for a worker.
  Args:
    worker (list): Worker information
    output_dir (character): Output directory path
  Returns:
    logical: TRUE if successful, FALSE otherwise
  """
  tryCatch({

    level <- determine_level(worker$Salary, worker$Gender)
    

    slip_content <- paste(
      paste(rep("=", 50), collapse = ""),
      company_name,
      "Weekly Payment Slip",
      paste(rep("=", 50), collapse = ""),
      "",
      "Employee Details:",
      "-----------------",
      paste("Employee ID:", worker$ID),
      paste("Full Name:  ", worker$Name),
      paste("Gender:     ", ifelse(worker$Gender == "M", "Male", "Female")),
      paste("Salary:     ", currency, format(worker$Salary, nsmall = 2, big.mark = ",")),
      paste("Level:      ", level),
      "",
      "Payment Information:",
      "-------------------",
      paste("Payment Date:", format(today, "%B %d, %Y")),
      paste("Payment Week: Week ending", format(today, "%Y-%m-%d")),
      "",
      paste(rep("=", 50), collapse = ""),
      "Notes:",
      "- This is an automatically generated payment slip.",
      "- Contact HR for any discrepancies.",
      paste(rep("=", 50), collapse = ""),
      sep = "\n"
    )
    

    safe_name <- gsub(" ", "_", worker$Name)
    filename <- file.path(output_dir, paste0(worker$ID, "_", safe_name, ".txt"))

    writeLines(slip_content, filename, useBytes = TRUE)
    
    worker$Level <- level
    
    return(list(success = TRUE, worker = worker))
    
  }, error = function(e) {
    cat("Error creating slip for", worker$ID, ":", e$message, "\n")
    return(list(success = FALSE, worker = worker))
  })
}


main <- function() {
  cat(paste(rep("=", 60), collapse = ""), "\n")
  cat(company_name, "- Weekly Payment System (R Implementation)\n")
  cat(paste(rep("=", 60), collapse = ""), "\n\n")
  

  output_dir <- "payment_slips_r"
  if (!dir.exists(output_dir)) {
    dir.create(output_dir, recursive = TRUE)
  }
  
  tryCatch({

    cat("Creating worker list...\n")
    workers <- create_workers_list(400)  
    cat("✓ Created list of", nrow(workers), "workers\n\n")
    

    cat("Generating payment slips...\n")
    successful_slips <- 0
    updated_workers <- list()
    
   
    for (i in 1:nrow(workers)) {
      worker <- workers[i, ]
      
   
      result <- tryCatch({
        create_payment_slip(worker, output_dir)
      }, error = function(e) {
        cat("  ✗ Error processing worker", worker$ID, ":", e$message, "\n")
        return(list(success = FALSE, worker = worker))
      })
      
      if (result$success) {
        successful_slips <- successful_slips + 1
        updated_workers[[i]] <- result$worker
      } else {
        updated_workers[[i]] <- worker
      }
      
  
      if (i %% 50 == 0) {
        cat("  Processed", i, "of", nrow(workers), "workers...\n")
      }
    }
    
    workers_updated <- do.call(rbind, updated_workers)
    

    cat("\n", paste(rep("=", 60), collapse = ""), "\n")
    cat("PROCESSING SUMMARY\n")
    cat(paste(rep("=", 60), collapse = ""), "\n")
    cat("Total workers processed:", nrow(workers_updated), "\n")
    cat("Successful payment slips:", successful_slips, "\n")
    cat("Failed to generate:", nrow(workers_updated) - successful_slips, "\n")
    cat("Output directory:", normalizePath(output_dir), "\n")
    
  
    a1_count <- sum(workers_updated$Level == "A1")
    a5f_count <- sum(workers_updated$Level == "A5-F")
    female_count <- sum(workers_updated$Gender == "F")
    male_count <- sum(workers_updated$Gender == "M")
    
    cat("\nStatistics:\n")
    cat("  - Female workers:", female_count, "\n")
    cat("  - Male workers:", male_count, "\n")
    cat("  - Level A1 assigned:", a1_count, "\n")
    cat("  - Level A5-F assigned:", a5f_count, "\n")
    cat("  - General level:", nrow(workers_updated) - a1_count - a5f_count, "\n")
    
   
    tryCatch({
      summary_file <- "workers_summary_r.csv"
      write.csv(workers_updated, summary_file, row.names = FALSE)
      cat("\n✓ Summary saved to:", summary_file, "\n")
    }, error = function(e) {
      cat("\n⚠ Could not save CSV summary:", e$message, "\n")
    })
    
    stats <- data.frame(
      Metric = c("Total Workers", "Female Workers", "Male Workers", 
                 "Level A1", "Level A5-F", "General Level", "Total Salary"),
      Value = c(nrow(workers_updated), female_count, male_count,
                a1_count, a5f_count, nrow(workers_updated) - a1_count - a5f_count,
                sum(workers_updated$Salary))
    )
    
    write.csv(stats, "payroll_statistics.csv", row.names = FALSE)
    
    cat("\n", paste(rep("=", 60), collapse = ""), "\n")
    cat("PROCESS COMPLETED SUCCESSFULLY!\n")
    cat(paste(rep("=", 60), collapse = ""), "\n")
    
    return(0)
    
  }, error = function(e) {
    cat("\n❌ ERROR:", e$message, "\n")
    return(1)
  })
}


if (interactive()) {

  main()
} else {
  quit(status = main())
}