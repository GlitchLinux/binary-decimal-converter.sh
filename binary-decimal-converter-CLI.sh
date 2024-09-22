#!/bin/bash

# Set the original dimensions
WIDTH=300
HEIGHT=200

# Calculate the new dimensions (10% bigger)
NEW_WIDTH=$((WIDTH + WIDTH / 10))
NEW_HEIGHT=$((HEIGHT + HEIGHT / 10))

while true; do
    # Display the options
    echo "Number Conversion"
    echo "1. BINARY to DECIMAL"
    echo "2. DECIMAL to BINARY"
    echo "0. Exit"
    read -p "Choose an option (1/2/0): " OPTION

    # Exit if the user chooses 0
    if [[ "$OPTION" -eq 0 ]]; then
        exit 0
    fi

    # First option: Binary to Decimal
    if [[ "$OPTION" -eq 1 ]]; then
        read -p "Enter a binary number: " INPUT
        
        # Check if the input is a valid binary number
        if [[ ! "$INPUT" =~ ^[01]+$ ]]; then
            echo "Invalid binary number. Please try again."
            continue
        fi
        
        # Convert binary to decimal
        RESULT=$((2#$INPUT))
        CONVERSION="Binary: $INPUT\nDecimal: $RESULT"

    # Second option: Decimal to Binary
    elif [[ "$OPTION" -eq 2 ]]; then
        read -p "Enter a decimal number: " INPUT
        
        # Check if the input is a valid decimal number
        if [[ ! "$INPUT" =~ ^[0-9]+$ ]]; then
            echo "Invalid decimal number. Please try again."
            continue
        fi
        
        # Convert decimal to binary
        RESULT=$(echo "obase=2; $INPUT" | bc)
        CONVERSION="Decimal: $INPUT\nBinary: $RESULT"
    else
        echo "Invalid option. Please try again."
        continue
    fi

    # Display the result
    echo -e "Conversion Result:\n$CONVERSION"
    echo "Press any key for a new calculation or Ctrl+C to exit."
    read -n 1
done
