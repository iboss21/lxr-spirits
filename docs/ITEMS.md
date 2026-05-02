# 🐺 LXR-SPIRITS — Items & Offerings Guide

`lxr-spirits` supports dedicated ritual items plus existing RedM hunting parts already used by your server economy.

## Add Dedicated RSG Items

Copy:

```text
items/rsg_items.lua
```

Into:

```text
rsg-core/shared/items.lua
```

Place the entries inside `RSGShared.Items = { ... }`.

## Dedicated Ritual Items

| Item | Purpose |
|---|---|
| `ritual_sage_bundle` | Main initiation offering |
| `dream_root` | Vision rite offering |
| `blessed_water` | Cleansing rite offering |
| `moon_water` | Cleansing alternative |
| `spirit_token` | Spirit bond offering |
| `spirit_ash` | Omen/ritual economy item |
| `spirit_candle` | Ritual economy item |
| `ancestral_totem` | Advanced RP/crafting item |
| `ritual_bone_charm` | Bond rite alternative |
| `ritual_spirit_bowl` | Ritual RP/crafting item |

## Existing Hunting Parts Used as Offerings

Do not duplicate these if your server already has them.

| Item | Used For |
|---|---|
| `generic_animal_heart` | Initiation / cleansing / wolf / bison |
| `generic_animal_tooth` | Initiation / wolf / cougar / coyote |
| `provision_bird_feather_flight` | Initiation / eagle / raven / owl / vision |
| `provision_bear_claw` | Initiation / bear / bond |
| `provision_bear_heart` | Bear spirit offering |
| `provision_cougar_claw` | Cougar spirit offering / bond |
| `provision_fox_claw` | Fox spirit offering / bond |
| `provision_raven_claw` | Raven spirit offering / vision |
| `provision_buck_antlers` | Elk spirit offering |
| `provision_ram_horn` | Optional config economy expansion |
| `provision_meat_big_game` | Bear / bison offering |
| `provision_meat_stringy` | Fox / coyote offering |
| `provision_meat_mature_venison` | Elk offering |

## Flexible Offering Logic

Rituals use `requiredItems` lists.

```lua
requiredItems = Config.Offerings.initiation,
consumeMode = 'first_available',
consumeItem = true,
```

With `first_available`, a player only needs one valid offering from the list.
With `all_required`, a player must bring every listed item.
