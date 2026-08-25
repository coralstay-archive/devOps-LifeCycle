# SLO — example-dev

Template. Copy this file into each new `live/<project>` and fill in real numbers with the team before going to production.

## Service level indicators (SLI)

- **Availability**: proportion of successful requests (non-5xx) over total requests
- **Latency**: request duration at p50/p95/p99

## Service level objectives (SLO)

| SLI | Target | Measurement window |
|---|---|---|
| Availability | 99.9% | rolling 30 days |
| Latency (p99) | 300ms | rolling 30 days |

## Error budget

99.9% availability over 30 days = ~43 minutes of allowed downtime.

- **Policy**: when > 50% of the error budget is consumed in a rolling 7-day window, freeze non-critical deploys until the burn rate drops.
- **Alerting**: fast-burn alert (budget exhausted in < 1 day at current rate) pages on-call immediately; slow-burn alert (exhausted in < 3 days) opens a ticket.

## Notes

This example stack has no compute/traffic yet (vpc + s3 only), so these numbers are placeholders to demonstrate the template shape. Real targets get set once a scenario with actual request traffic (e.g. `standard-web`) is implemented.
