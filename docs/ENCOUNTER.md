# 🐺 LXR-SPIRITS — Cinematic Spirit Encounter System

## Purpose

Version `1.4.0` replaces the simple reveal flow with a complete in-world spirit encounter.

The correct flow is now:

```text
Ritual Start
→ Vision FX
→ Distant Omen Apparition
→ Transition Fade
→ Close Spirit Materialization
→ Approach Spirit
→ Connect With Spirit [G]
→ Bond Animation
→ Spirit Dissolve
→ Final Reveal/Profile UI
```

## Configuration

Main settings live in `config.lua`:

```lua
Config.Encounter = {
    enabled = true,
    omenDistance = 38.0,
    omenAlpha = 105,
    omenScale = 3.0,
    omenDurationMs = 6500,
    transitionFadeMs = 850,
    closeDistance = 8.5,
    closeAlpha = 195,
    closeScale = 1.0,
    connectDistance = 3.2,
    encounterLifetimeMs = 65000,
    bondScenario = 'WORLD_HUMAN_PRAY',
    finalRevealMs = 12000,
    allowFallbackReveal = true
}
```

## Important Behavior

- The distant omen is intentionally large and semi-transparent.
- The close spirit spawns in front of the player with ground-Z correction.
- Player must walk to the visible spirit and hold `G`.
- The spirit does not instantly disappear after reveal.
- The resource includes `/lxrspiritclearvision` and `/lxrspiritfixcursor` for dev testing.

## Special Spirits Added

- `white_deer`
- `great_bison`
- `omen_wolf`

These are configured in `Config.SpiritAnimals` and can be used in location `allowedSpirits`.

## Notes

Some RedM animal models may vary depending on artifact/build. If a model does not spawn, change that spirit model in `Config.SpiritAnimals` to a known-good model on your server.
