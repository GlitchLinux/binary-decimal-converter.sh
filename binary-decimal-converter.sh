#!/bin/bash

# Set the original dimensions
WIDTH=300
HEIGHT=200

# Calculate the new dimensions (10% bigger)
NEW_WIDTH=$((WIDTH + WIDTH / 10))
NEW_HEIGHT=$((HEIGHT + HEIGHT / 10))

while true; do
    # First window for selection
    OPTION=$(zenity --list --title="Number Conversion" --column="Choose Conversion" \
        "BINARY to DECIMAL" "DECIMAL to BINARY" --height=$NEW_HEIGHT --width=$NEW_WIDTH)

    # Exit if the user cancels the selection
    if [ $? -ne 0 ]; then
        exit 0
    fi

    # Second window for input
    if [[ "$OPTION" == "BINARY to DECIMAL" ]]; then
        INPUT=$(zenity --entry --title="Binary to Decimal" --text="Enter a binary number:" --height=$NEW_HEIGHT --width=$NEW_WIDTH)
        
        # Check if the input is a valid binary number
        if [[ ! "$INPUT" =~ ^[01]+$ ]]; then
            zenity --error --text="Invalid binary number. Please try again."
            continue
        fi
        
        # Convert binary to decimal
        RESULT=$((2#$INPUT))
        CONVERSION="Binary: $INPUT\nDecimal: $RESULT"

    elif [[ "$OPTION" == "DECIMAL to BINARY" ]]; then
        INPUT=$(zenity --entry --title="Decimal to Binary" --text="Enter a decimal number:" --height=$NEW_HEIGHT --width=$NEW_WIDTH)
        
        # Check if the input is a valid decimal number
        if [[ ! "$INPUT" =~ ^[0-9]+$ ]]; then
            zenity --error --text="Invalid decimal number. Please try again."
            continue
        fi
        
        # Convert decimal to binary
        RESULT=$(echo "obase=2; $INPUT" | bc)
        CONVERSION="Decimal: $INPUT\nBinary: $RESULT"
    fi

    # Third window to display the result
    zenity --info --title="Conversion Result" --text="$CONVERSION" --ok-label="NEW CALCULATION" --height=$NEW_HEIGHT --width=$NEW_WIDTH
done
