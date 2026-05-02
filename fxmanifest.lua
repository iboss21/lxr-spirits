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

fx_version 'cerulean'
game 'rdr3'

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

lua54 'yes'

name 'lxr-spirits'
author 'iBoss21 / The Lux Empire'
description 'lxr-spirits — cinematic ancestral spirit guide ritual system for RedM'
version '1.4.0'

ui_page 'html/index.html'

shared_scripts {
    'config.lua',
    'locales/en.lua',
    'locales/ka.lua',
    'shared/framework.lua'
}

client_scripts {
    'client/client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/server.lua'
}

files {
    'html/index.html',
    'html/style.css',
    'html/app.js',
    'html/assets/*.png',
    'html/assets/*.jpg',
    'html/assets/*.webp'
}

escrow_ignore {
    'config.lua',
    'shared/framework.lua',
    'locales/*.lua',
    'sql/*.sql',
    'docs/**/*.md',
    'README.md'
}

dependencies {
    'oxmysql'
}
