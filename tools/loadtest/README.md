# tools/loadtest

k6 load test templates used to verify a stack meets its `SLO.md` targets before it's trusted in production, and specifically to rehearse the "sudden spike" case (see the plan's SRE design principles — this is item 4, load testing).

## Usage

1. Install k6: `brew install k6`
2. Deploy or point at the target stack, then run:
   ```
   k6 run -e TARGET_URL=https://<your-endpoint> tools/loadtest/basic-load.js
   ```
3. Compare the `http_req_duration` p99 and `http_req_failed` rate against the target stack's `SLO.md`. k6 will exit non-zero if the `thresholds` in the script are violated — wire this into CI once a stack has a real endpoint to hit.

## `basic-load.js`

Two scenarios in one run:
- `steady_state`: constant moderate load, to catch regressions under normal traffic
- `spike`: ramps from 0 to 500 VUs in 10 seconds, to rehearse Google/Spotify-style sudden traffic spikes and confirm autoscaling (Karpenter/HPA/ElastiCache read replicas) reacts fast enough

## Status

Template only — thresholds are placeholders. Update them per-scenario once that scenario's `SLO.md` has real numbers.
