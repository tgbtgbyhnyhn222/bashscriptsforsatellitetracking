#Automated TLE (Two-Line Element) Data Fetcher Script 

#!/bin/bash 

#Configuration
URL="https://celestrak.org/NORAD/elements/gp.php?GROUP=weather&FORMAT=TLE"
USER_AGENT="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
OUTPUT_DIR="$HOME/Desktop/satcom/tle_data"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S") 
OUTPUT_FILE="$OUTPUT_DIR/weather_tle_$TIMESTAMP.txt" 

#1. Create directory if it doesn't exist 
mkdir -p "$OUTPUT_DIR" 

#2. Fetch the TLE data
echo "Fetching latest Weather Satellite TLEs..."
if curl -sf -A "$USER_AGENT" "$URL" -o "$OUTPUT_FILE"; then 
    echo "Success! Saved to $OUTPUT_FILE"

#3. Create a symlink to the latest data for easy access by other app
# This had to be fixed: Using cd ensures the symlink uses a reliable relative path.
(cd "$OUTPUT_DIR" && ln -sf "weather_tle_$TIMESTAMP.txt")
else 
echo "Error: Failed to fetch TLE data." >&2 
exit 1
fi


