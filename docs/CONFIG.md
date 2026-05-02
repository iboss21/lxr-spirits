# lxr-spirits — Configuration Reference

## `Config.Framework`

Use `auto` for automatic detection. Manual values:

- `lxr-core`
- `rsg-core`
- `vorp_core`
- `redem_roleplay`
- `qbr-core`
- `qr-core`
- `standalone`

## `Config.General`

Controls commands, persistence, repeated rituals, result rerolls, and broadcast behavior.

## `Config.Ritual`

Controls duration, reveal timing, spirit ped spawning, required ritual item, and selection mode.

Recommended production values:

```lua
allowRepeatRitual = false
allowResultReroll = false
persistResults = true
selectionMode = 'weighted_random'
```

## `Config.SpiritAnimals`

Each animal supports:

```lua
label, model, nuiIcon, weight, title, meaning
```

Use valid RedM animal model names. Invalid models are ignored client-side.

## `Config.Locations`

Each ritual ground supports:

```lua
id, label, coords, heading, radius, drawDistance, fixedSpirit, jobs
```

Set `jobs = false` for public access. Set job grades like:

```lua
jobs = { sheriff = 4, marshal = 2 }
```

## Resource Identity Lock

The resource folder name is hard-locked to `lxr-spirits`. There is no config option to rename it. If the folder is renamed, the server/client guard will stop the resource.


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
