# lxr-spirits — Security Model

The client never decides the final spirit. The server validates and assigns results.

## Server-Side Validation

- Resource name guard
- Per-action rate limit
- Per-minute abuse window
- Active ritual state tracking
- Location ID validation
- Server distance check using player ped coordinates
- Optional job gate
- Optional item ownership validation
- Optional item consumption server-side
- Repeat/reroll lock based on identifier

## Exploit Cases Covered

| Exploit Attempt | Defense |
|---|---|
| Trigger complete event without starting | Active ritual state required |
| Trigger ritual from across map | Server distance validation |
| Spam start/complete events | Rate limiter and action window |
| Fake location id | Config location lookup required |
| Reroll spirit repeatedly | SQL record lock unless reroll enabled |
| Start without item | Server-side inventory check |

## Resource Identity Lock

The resource folder name is hard-locked to `lxr-spirits`. There is no config option to rename it. If the folder is renamed, the server/client guard will stop the resource.
