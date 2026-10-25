// Automatically select the local FastAPI backend during local development.
// On Vercel or another same-origin deployment, use that site's /api routes.
const host = window.location.hostname;
const isLocal = host === "localhost" || host === "127.0.0.1";
window.CYBER_PASS_API_BASE = isLocal ? "http://127.0.0.1:8000" : "";
