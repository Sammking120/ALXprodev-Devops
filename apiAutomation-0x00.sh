#!/bin/bash

# Set variables
POKEMON="pikachu"
API_URL="https://pokeapi.co/api/v2/pokemon/$POKEMON"
OUTPUT_FILE="data.json"
ERROR_FILE="errors.txt"

# Make API request and handle response
curl -s -o "$OUTPUT_FILE" "$API_URL" || {
    echo "$(date): Failed to fetch data for $POKEMON" >> "$ERROR_FILE"
    exit 1
}

# Check if response is valid JSON
if ! jq . "$OUTPUT_FILE" >/dev/null 2>&1; then
    echo "$(date): Invalid JSON response for $POKEMON" >> "$ERROR_FILE"
    rm "$OUTPUT_FILE"
    exit 1
fi

echo "Successfully fetched data for $POKEMON and saved to $OUTPUT_FILE"