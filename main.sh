#!/bin/bash

# Log file path
LOG_FILE="payment_system.log"

# Function to log messages
log() {
    local log_message="$1"
    echo "$(date +"%Y-%m-%d %H:%M:%S") - $log_message" >> "$LOG_FILE"
}

# Redirect all output to log file and duplicate to terminal using tee
exec &> >(tee -a "$LOG_FILE")
export PGPASSFILE="C:/Users/mdsuh/OneDrive/Desktop/Freelance/bank/.pgpass"
# Include necessary scripts
source auth.sh
source menu.sh
source payment.sh
source history.sh
source registration.sh

# Main program
echo "Welcome to the Payment System"
log "Payment System started"

while true; do
    read -p "Are you a registered user? (yes/no): " registered
    case $registered in
        yes|Yes|YES)
            authenticate_user
            if [[ $? -eq 0 ]]; then
                break
            fi
            ;;
        no|No|NO)
            register_user
            authenticate_user
            if [[ $? -eq 0 ]]; then
                break
            fi
            ;;
        *)
            echo "Invalid input. Please enter 'yes' or 'no'."
            ;;
    esac
done

while true; do
    display_menu
    read -p "Enter your choice: " choice

    case $choice in
        1) make_payment ;;
        2) view_transaction_history ;;
        3) register_user ;;
        4) echo "Exiting..." && exit ;;
        *) echo "Invalid choice. Please try again." ;;
    esac
done

# Log when the script ends
log "Payment System ended"
