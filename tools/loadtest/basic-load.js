// k6 load test template. Thresholds should mirror the target stack's SLO.md
// so a failing threshold means "this deploy would violate the SLO."
//
// Usage:
//   k6 run -e TARGET_URL=https://example.com tools/loadtest/basic-load.js
import http from "k6/http";
import { check, sleep } from "k6";

const TARGET_URL = __ENV.TARGET_URL || "http://localhost:8080";

export const options = {
  scenarios: {
    steady_state: {
      executor: "constant-vus",
      vus: 20,
      duration: "2m",
    },
    spike: {
      executor: "ramping-vus",
      startVUs: 0,
      stages: [
        { duration: "10s", target: 0 },
        { duration: "10s", target: 500 }, // sudden spike
        { duration: "1m", target: 500 },
        { duration: "10s", target: 0 },
      ],
      startTime: "2m", // runs right after steady_state
    },
  },
  thresholds: {
    // Keep these in sync with the target stack's SLO.md
    http_req_duration: ["p(99)<300"], // p99 < 300ms
    http_req_failed: ["rate<0.001"],  // < 0.1% error rate ~= 99.9% availability
  },
};

export default function () {
  const res = http.get(TARGET_URL);
  check(res, {
    "status is 200": (r) => r.status === 200,
  });
  sleep(1);
}
