```markdown
# Strava API Token & Activity Utility

A lightweight Bash script that demonstrates how to authenticate with the **Strava API** using OAuth2 refresh tokens, fetch recent activities, and interact with the Strava v3 endpoints using `curl` and `jq`.

## ⚠️ Important Note on Scope
This script interacts with the standard Strava API endpoint (`/athlete/activities`), which retrieves **your own personal activities**, not your general social feed. Strava's public API does not currently provide a feed endpoint for other users' activities due to platform privacy and terms of service. 

## Features
* **OAuth2 Token Refresh:** Automatically exchanges a long-lived refresh token for a fresh short-lived access token.
* **JSON Parsing:** Uses `jq` to parse API responses securely and validate data structures.
* **API Interaction:** Fetches recent activities and demonstrates how to make authenticated POST/GET requests to Strava endpoints.

## Prerequisites
Before running the script, ensure you have the following installed on your system:
* `curl` (for making HTTP requests)
* `jq` (for parsing JSON data in the terminal)

## Setup & Usage

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/HuttonWilliam/Strava-Automated-Kudos.git](https://github.com/HuttonWilliam/Strava-Automated-Kudos.git)
   cd Strava-Automated-Kudos

```

2. **Configure your API credentials:**
Open the script (`strava_kudos.sh`) and replace the placeholder variables with your own Strava API credentials:
```bash
CLIENT_ID="YOUR_CLIENT_ID"
CLIENT_SECRET="YOUR_CLIENT_SECRET"
REFRESH_TOKEN="YOUR_REFRESH_TOKEN"

```


*(You can generate these by creating an API application on your [Strava API Settings page](https://www.strava.com/settings/api?utm_source=gemini).)*
3. **Make the script executable:**
```bash
chmod +x strava_kudos.sh

```


4. **Run the script:**
```bash
./strava_kudos.sh

```



## License

This project is open-source and available under the GNU GPL 3.0 License (https://github.com/HuttonWilliam/Strava-Automated-Kudos/blob/main/LICENSE

```
