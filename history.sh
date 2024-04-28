#!/bin/bash

# Function to view transaction history
view_transaction_history() {
    read -p "Enter username: " username

    # Get user ID from users table
    user_id=$(psql -U postgres -d bank -h localhost -p 5432 -c "SELECT id FROM users WHERE username = '$username';")

    # Retrieve transaction history from the database
    psql -U postgres -d bank -h localhost -p 5432 -c "SELECT * FROM transactions WHERE sender_id = '$user_id' OR receiver_id = '$user_id';"
}