#!/bin/bash

# Function to make a payment
make_payment() {
    read -p "Enter payer's username: " payer_username
    read -p "Enter payee's username: " payee_username
    read -p "Enter amount: " amount

    # Get sender_id and receiver_id from users table
    sender_id=$(psql -U postgres -d bank -h localhost -p 5432 -c "SELECT id FROM users WHERE username = '$payer_username';")
    receiver_id=$(psql -U postgres -d bank -h localhost -p 5432 -c "SELECT id FROM users WHERE username = '$payee_username';")

    # Check if sender and receiver exist
    if [[ -z "$sender_id" || -z "$receiver_id" ]]; then
        echo "Invalid usernames. Please try again."
        return
    fi

    # Perform payment transaction in the database
    psql -U postgres -d bank -h localhost -p 5432 -c "INSERT INTO transactions (sender_id, receiver_id, amount) VALUES ('$sender_id', '$receiver_id', '$amount');"
    echo "Payment successful!"
}