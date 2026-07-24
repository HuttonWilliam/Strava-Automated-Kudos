```bash
#!/bin/bash

# Configuration: Replace these variables with your actual Strava API credentials
CLIENT_ID="YOUR_CLIENT_ID"
CLIENT_SECRET="YOUR_CLIENT_SECRET"
REFRESH_TOKEN="YOUR_REFRESH_TOKEN"

# Ensure required utilities are installed
for cmd in curl jq; do
    if ! command -v "$cmd" &> /dev/null; then
        echo "Error: Required utility '$cmd' is not installed." >&2
        exit 1
    fi
done

echo "Exchanging refresh token for a fresh access token..."
AUTH_RESPONSE=$(curl -s -X POST "https://www.strava.com/oauth/token" \
    -d client_id="$CLIENT_ID" \
    -d client_secret="$CLIENT_SECRET" \
    -d grant_type="refresh_token" \
    -d refresh_token="$REFRESH_TOKEN")

ACCESS_TOKEN=$(echo "$AUTH_RESPONSE" | jq -r '.access_token')

if [ -z "$ACCESS_TOKEN" ] || [ "$ACCESS_TOKEN" = "null" ]; then
    echo "Error: Failed to retrieve access token. Check your credentials." >&2
    exit 1
fi

echo "Fetching recent activities from your Strava feed..."
ACTIVITIES=$(curl -s -X GET "https://www.strava.com/api/v3/athlete/activities?per_page=15" \
    -H "Authorization: Bearer $ACCESS_TOKEN")

# Verify the response is a valid JSON array before looping
if ! echo "$ACTIVITIES" | jq -e 'type == "array"' > /dev/null 2>&1; then
    echo "Error: Unexpected response from Strava API:" >&2
    echo "$ACTIVITIES" >&2
    exit 1
fi

echo "$ACTIVITIES" | jq -c '.[] | select(.has_kudoed == false) | {id: .id, name: .name}' | while read -r item; do
    ACTIVITY_ID=$(echo "$item" | jq -r '.id')
    ACTIVITY_NAME=$(echo "$item" | jq -r '.name')

    echo "Giving kudo to: \"$ACTIVITY_NAME\" (ID: $ACTIVITY_ID)"
    
    RESPONSE_CODE=$(curl -s -o /dev/null -w "%{http_code}" -X POST "https://www.strava.com/api/v3/activities/$ACTIVITY_ID/kudos" \
        -H "Authorization: Bearer $ACCESS_TOKEN")

    if [ "$RESPONSE_CODE" -eq 201 ]; then
        echo "Successfully gave kudo."
    else
        echo "Failed to give kudo (HTTP status: $RESPONSE_CODE)."
    fi

    # Randomized brief pause to respect rate limits and mimic organic behavior
    sleep $((RANDOM % 3 + 2))
done

echo "All eligible activities processed successfully."

```
