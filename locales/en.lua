--[[
    ██╗     ██╗  ██╗██████╗        ███████╗██████╗ ██╗██████╗ ██╗████████╗███████╗
    ██║     ╚██╗██╔╝██╔══██╗      ██╔════╝██╔══██╗██║██╔══██╗██║╚══██╔══╝██╔════╝
    ██║      ╚███╔╝ ██████╔╝█████╗███████╗██████╔╝██║██████╔╝██║   ██║   ███████╗
    ██║      ██╔██╗ ██╔══██╗╚════╝╚════██║██╔═══╝ ██║██╔══██╗██║   ██║   ╚════██║
    ███████╗██╔╝ ██╗██║  ██║      ███████║██║     ██║██║  ██║██║   ██║   ███████║
    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝      ╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝╚═╝   ╚═╝   ╚══════╝

    🐺 LXR Core - Spirit Guide / Immersive Ritual System

    Production-grade RedM resource for wolves.land — The Land of Wolves.
    Players discover, persist, cleanse, strengthen, and roleplay around ancestral
    spirit animals through cinematic ritual gameplay, server-authoritative validation,
    NUI vision overlays, SQL persistence, and multi-framework bridge support.

    ═══════════════════════════════════════════════════════════════════════════════
    SERVER INFORMATION
    ═══════════════════════════════════════════════════════════════════════════════

    Server:      The Land of Wolves 🐺
    Tagline:     Georgian RP 🇬🇪 | მგლების მიწა - რჩეულთა ადგილი!
    Description: ისტორია ცოცხლდება აქ! (History Lives Here!)
    Type:        Serious Hardcore Roleplay
    Access:      Discord & Whitelisted

    Developer:   iBoss21 / The Lux Empire
    Website:     https://www.wolves.land
    Discord:     https://discord.gg/CrKcWdfd3A
    GitHub:      https://github.com/iBoss21
    Store:       https://theluxempire.tebex.io
    Server:      https://servers.redm.net/servers/detail/8gj7eb

    ═══════════════════════════════════════════════════════════════════════════════
    RESOURCE IDENTITY — LOCKED
    ═══════════════════════════════════════════════════════════════════════════════

    Resource folder name is hard-locked to: lxr-spirits
    This is not configurable. Do not rename this resource.

    ═══════════════════════════════════════════════════════════════════════════════

    Version: 1.4.0
    Performance Target: 0.00ms idle / production-safe server validation

    Tags: RedM, Georgian, SeriousRP, Whitelist, Spirits, Rituals, Wolves, LXR

    Framework Support:
    - LXR Core (Primary)
    - RSG Core (Primary Compatible)
    - VORP Core (Compatible)
    - RedEM:RP (Compatible)
    - QBR Core (Compatible)
    - QR Core (Compatible)
    - Standalone (Fallback)

    ═══════════════════════════════════════════════════════════════════════════════
    CREDITS
    ═══════════════════════════════════════════════════════════════════════════════

    Script Author: iBoss21 / The Lux Empire for The Land of Wolves
    System Build: LXR production resource standard

    © 2026 iBoss21 / The Lux Empire | wolves.land | All Rights Reserved
]]

Config.Locale = Config.Locale or {}
Config.Locale.en = {
    prompt_start = 'Begin spirit ritual',
    prompt_group = 'Sacred Ground',
    ritual_started = 'The {ritual} has begun. Do not break the circle.',
    ritual_cancelled = 'The ritual was broken.',
    too_far = 'You moved too far from the sacred ground.',
    not_allowed = 'You are not permitted to perform this ritual here.',
    missing_item = 'You lack the required offering. Bring one of these: {item}.',
    cooldown_active = 'The spirits are silent. Wait before attempting this again.',
    already_has_spirit = 'Your soul already carries a spirit guide.',
    needs_spirit = 'You must discover your spirit before performing this rite.',
    invalid_ritual = 'Invalid ritual type.',
    no_location = 'This sacred ground is not configured.',
    cannot_dead = 'You cannot begin a ritual while dead.',
    cannot_mounted = 'Dismount before beginning the ritual.',
    command_disabled = 'Command ritual start is disabled.',
    command_status_empty = 'You do not have a revealed spirit guide yet.',
    admin_no_permission = 'You do not have permission to use spirit admin tools.',
    admin_reset = 'Spirit profile reset.',
    broadcast_reveal = '{name} has awakened the spirit of the {spirit}.',
    nui_title = 'LXR-SPIRITS',
    nui_subtitle = 'wolves.land • The Lux Empire',
    nui_begin = 'The circle opens. Smoke rises. Listen.',
    nui_reveal = 'Your spirit has answered.',
    nui_close = 'Close',
    nui_profile = 'Spirit Profile',
    prompt_connect = 'Connect With Spirit',
    prompt_connect_group = 'SPIRIT GUIDE',
    spirit_omen_message = 'Your spirit guide is the {spirit}. It is coming to you...',
    spirit_approach_message = 'Your spirit guide awaits. Approach and make the connection.',
    bond_complete = 'The bond is complete.',
    spirit_faded = 'The spirit fades back into the unseen world.',
    spirit_name_title = 'Spirit Name',
    spirit_name_revealed = 'The spirits have named you: {name}.'
}
