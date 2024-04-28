#!/bin/bash

# Function to register a new user
register_user() {
    read -p "Enter username: " username
    read -p "Enter password: " password
    read -p "Enter email: " email

    # Check if username or email already exists
    existing_username=$(psql -U postgres -d bank -h localhost -p 5432 -c "SELECT username FROM users WHERE username = '$username';")
    existing_email=$(psql -U postgres -d bank -h localhost -p 5432 -c "SELECT email FROM users WHERE email = '$email';")

    if [[ -n "$existing_username" ]]; then
        echo "Username already exists. Please choose a different username."
        return
    fi

    if [[ -n "$existing_email" ]]; then
        echo "Email already exists. Please use a different email address."
        return
    fi

    # Add new user to the database
    psql -U postgres -d bank -h localhost -p 5432 -c "INSERT INTO users (username, password, email) VALUES ('$username', '$password', '$email');"
    echo "User registration successful!"
}