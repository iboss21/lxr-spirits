# lxr-spirits — Installation Guide

## Requirements

- RedM server
- A supported framework: LXR-Core, RSG-Core, VORP, RedEM:RP, QBR, QR, or Standalone
- `oxmysql` for persistent spirit records
- Optional: `ox_lib` for notifications on LXR/RSG/QBR/QR

## Server.cfg Order

```cfg
ensure oxmysql
ensure lxr-core # or rsg-core / vorp_core
ensure lxr-spirits
```

## SQL

Import:

```sql
sql/lxr_spirits.sql
```

## Folder Name

The resource has a name guard. The folder must be:

```text
lxr-spirits
```

Renaming the resource intentionally stops startup to protect exports, events, and escrow distribution consistency.

## Resource Identity Lock

The resource folder name is hard-locked to `lxr-spirits`. There is no config option to rename it. If the folder is renamed, the server/client guard will stop the resource.


## Items & Hunting Offerings

This version includes complete item support:

- Dedicated ritual items in `items/rsg_items.lua`
- Optional VORP item SQL in `sql/vorp_items_optional.sql`
- Hunting-part offering support using your existing RedM animal parts
- Flexible `requiredItems` lists with `first_available` / `all_required` consume modes

Read:

```text
docs/ITEMS.md
docs/HUNTING_OFFERINGS.md
```
