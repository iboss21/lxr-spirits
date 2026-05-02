# 🐺 LXR-Spirits

Production-grade RedM spirit ritual system for wolves.land / The Lux Empire.

## First-release systems included

- Server-authoritative ritual validation
- Five ritual types: initiation, vision, cleansing, bond, omen
- Persistent spirit profiles, ritual logs, and cooldowns
- Weighted contextual spirit selection
- 10 configured spirit animals with lore, element, temperament, weakness, offerings, omens, and bond metadata
- Six sacred locations
- NUI ritual menu, reveal screen, profile screen, witness pulse
- Ritual props, cinematic effects, spirit animal manifestation
- Multi-framework bridge: LXR-Core, RSG-Core, VORP, RedEM, QBR, QR, Standalone
- Admin tools and exports
- English and Georgian locales

## Install

1. Import `sql/lxr_spirits.sql`.
2. Place folder as exactly `lxr-spirits`.
3. Add:

```cfg
ensure oxmysql
ensure lxr-spirits
```

## Player commands

- `/lxrspirit` opens spirit profile.
- `/lxrritual initiation cotorra_springs` starts by command if enabled.
- Hold **E** at configured sacred grounds.
- Press **G** at a sacred ground to choose ritual type.

## Admin command

`/lxrspiritadmin help`

## Important

This is an original resource. Do not copy another creator's protected code, UI, assets, text, or escrowed implementation.

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


## v1.4.0 Cinematic Encounter System

This release adds the full in-world spirit reveal loop:

```text
Ritual Start → Distant Omen → Close Spirit → Connect With Spirit [G] → Bond Animation → Spirit Dissolve → Final Reveal
```

New testing commands:

```text
/lxrspiritfixcursor
/lxrspiritclearvision
```

See `docs/ENCOUNTER.md` for all encounter settings.
