#!/bin/bash

# Function to authenticate user
authenticate_user() {
    read -p "Enter username: " username
    read -s -p "Enter password: " password
    echo

    # Check if username and password match
    user_count=$(psql -U postgres -d bank -h localhost -p 5432 -c "SELECT COUNT(*) FROM users WHERE username = '$username' AND password = '$password';")

    if [[ $user_count -eq 1 ]]; then
        echo "Authentication successful!"
        return 0
    else
        echo "Authentication failed. Please try again."
        return 1
    fi
}