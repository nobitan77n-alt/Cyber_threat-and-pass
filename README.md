# Cyber-Pass — Local + Vercel deployment

Cyber-Pass includes a browser-based password strength estimate, a Pwned Passwords breach-range check, and a threat-intelligence lookup backed by public APIs. No personal VirusTotal or AlienVault OTX keys are required.

## Threat-intelligence sources

- **PhishDestroy Public API** — domain/URL-oriented threat checks.
- **SCAMRA Public API** — public checks for supported indicators such as domains, URLs, and IPs.
- **OpenPhish Community API** — phishing URL/domain matching.

These are third-party community/public sources. They may rate-limit requests, change availability, or return no match for a malicious indicator. A clean result is not proof of safety. File hashes may not be supported by these sources.

## Run locally on Windows

1. Install Python 3.10+ and make sure Python is on PATH.
2. Extract this folder.
3. Double-click `run-local.bat`. It creates a virtual environment, installs requirements, starts the FastAPI backend and frontend, and opens the site. First run needs internet to install dependencies.
4. Backend health check: `http://127.0.0.1:8000/api/health`.

## Run locally on macOS/Linux

From this folder, create a virtual environment and install dependencies:

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
uvicorn api.index:app --host 127.0.0.1 --port 8000
```

In a second terminal, run `python3 -m http.server 5500`, then open `http://127.0.0.1:5500`.

## Deploy to Vercel

1. Upload the contents of this folder to the root of a GitHub repository (`index.html`, `vercel.json`, and `requirements.txt` should be at the root).
2. Import the repository into Vercel and deploy.
3. No threat-intelligence API keys or environment variables are required.
4. Test `https://YOUR-PROJECT.vercel.app/api/health`; it should return JSON with `status: "ok"` and list the public sources.

## Password privacy and limitations

- Password strength is estimated locally in the browser.
- Password breach lookup uses the Pwned Passwords range API and needs internet. Only the first five characters of the SHA-1 hash are sent to the service; the raw password is not sent. Network metadata may still be visible to the provider.
- Threat lookups send the entered indicator to this project's backend and the public threat-intelligence providers. Do not submit private URLs or sensitive internal indicators unless authorized.
- Without internet, external APIs cannot be queried. Local password-strength checking still works.
- Never commit private credentials or `.env` files to GitHub.

The package has been configured for local and Vercel use, but live deployment and real public API responses should be tested before submission. Third-party providers can change their endpoints, response formats, and rate limits.
