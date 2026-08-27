# tools/loadtest

k6 load test templates used to verify a stack meets its `SLO.md` targets before it's trusted in production, and specifically to rehearse the "sudden spike" case (see the plan's SRE design principles — this is item 4, load testing).

## Usage

**Locally:**
1. Install k6: `brew install k6`
2. Deploy or point at the target stack, then run:
   ```
   k6 run -e TARGET_URL=https://<your-endpoint> tools/loadtest/basic-load.js
   ```
3. Compare the `http_req_duration` p99 and `http_req_failed` rate against the target stack's `SLO.md`. k6 exits non-zero if the `thresholds` in the script are violated.

**In CI:** `.github/workflows/loadtest.yml` runs this same script — trigger it manually (Actions tab → "Load Test" → "Run workflow") with `target_url` pointing at an already-deployed endpoint. It's `workflow_dispatch`-only (never on push/PR) and requests **no AWS credentials at all** — it only makes plain HTTP requests to whatever URL you give it, so there's no OIDC role to assume and nothing to leak. Only repo collaborators with write access can trigger it. Defaults to a 10s/1-VU smoke check (`smoke_test: true`) to confirm the target is actually reachable before anyone runs the real steady-state+spike scenario against it — only point it at endpoints you're authorized to load test.

## `basic-load.js`

Two scenarios in one run:
- `steady_state`: constant moderate load, to catch regressions under normal traffic
- `spike`: ramps from 0 to 500 VUs in 10 seconds, to rehearse Google/Spotify-style sudden traffic spikes and confirm autoscaling (Karpenter/HPA/ElastiCache read replicas) reacts fast enough

## Status

Wired into CI as a manually-triggered workflow (see above). The thresholds in `basic-load.js` are still placeholders — update them per-scenario once that scenario's `SLO.md` has real numbers.
