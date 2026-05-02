# lxr-spirits — Troubleshooting

## Resource stops immediately

The folder name is wrong. Rename it to exactly:

```text
lxr-spirits
```

## Spirit result does not save

Check that `oxmysql` is started before `lxr-spirits` and that `sql/lxr_spirits.sql` was imported.

## Notifications do not show

For LXR/RSG/QBR/QR, install/start `ox_lib` or adjust `Framework.Notify` in `shared/framework.lua`.

## Animal does not appear

The configured model is invalid or unavailable in RedM. Replace the model in `Config.SpiritAnimals`.

## Player cannot start ritual

Check:

- distance from `Config.Locations`
- `Config.Ritual.requiredItemEnabled`
- `Config.Security.validateJobAccess`
- cooldown settings
- whether the player already has a spirit record

## Resource Identity Lock

The resource folder name is hard-locked to `lxr-spirits`. There is no config option to rename it. If the folder is renamed, the server/client guard will stop the resource.

## Mouse cursor does not move on the ritual NUI

If the ritual panel is visible but the player cannot move/click the mouse, enable NUI focus in `config.lua`:

```lua
Config.NUI = {
    focusOnBegin = true,
    focusOnReveal = true,
    focusOnProfile = true,
    focusOnMenu = true,
    focusOnWitness = false,
    keepGameInput = false,
    closeOnEscape = true
}
```

Emergency client command if a test session gets stuck:

```text
/lxrspiritfixcursor
```

This closes the NUI, clears player tasks, and releases freeze/focus.


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
