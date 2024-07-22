#!/bin/bash

# Description: This script retrieves employee information using an Employee ID. 
# If the user exists, it prints the ID and name. In a real-life scenario, 
# it should connect to a real MySQL database.

# Prompt user to enter Employee ID
read -p "Enter Employee ID: " employee_id

# Query MySQL database for employee information
result=$(mysql -u username -p'password' -D mydata_base -se "SELECT name FROM employees WHERE id='$employee_id';")

# Define a message
good_bye_message="Thank you and have a good day!"

# Check if the result is empty
if [ -n "$result" ]; then
    # Employee found, print the ID and name
    echo "Employee ID: $employee_id, Name: $result"
    echo $good_bye_message
else
    # Employee not found, prompt the user to create a new employee
    echo "Employee not found!"

    # Ask if the user wants to create a new employee
    read -p "Do you want to create a new employee with this ID? (y/n): " create_choice
    if [ "$create_choice" = "y" ]; then
        # Get the new employee name
        read -p "Enter Employee Name: " employee_name

        # Insert new employee into the MySQL database
        mysql -u username -p'password' -D mydata_base -e "INSERT INTO employees (id, name) VALUES ('$employee_id', '$employee_name');"
        
        # Confirm the addition then print the goodbye message
        echo "Employee ID: $employee_id, Name: $employee_name has been added to the database."
        echo $good_bye_message
    else
        # If the user chose not to create a new employee, print the goodbye message then exit
        echo "No new employee created."
        echo $good_bye_message
        exit 1
    fi
fi
