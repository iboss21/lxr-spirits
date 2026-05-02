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
Config.Locale.ka = {
    prompt_start = 'სულიერი რიტუალის დაწყება',
    prompt_group = 'წმინდა ადგილი',
    ritual_started = '{ritual} დაიწყო. წრე არ დატოვო.',
    ritual_cancelled = 'რიტუალი შეწყდა.',
    too_far = 'წმინდა ადგილს ძალიან დაშორდი.',
    not_allowed = 'აქ ამ რიტუალის ჩატარების უფლება არ გაქვს.',
    native_job_required = 'ეს რიტუალი წმინდაა — მხოლოდ მშობლიური სისხლის მქონენი ასრულებენ მას.',
    missing_item = 'საჭირო შესაწირი არ გაქვს: {item}.',
    cooldown_active = 'სულები ჩუმად არიან. ხელახლა ცდამდე მოიცადე.',
    already_has_spirit = 'შენს სულს უკვე ჰყავს მფარველი სული.',
    needs_spirit = 'ამ წესის შესასრულებლად ჯერ შენი სულიერი მფარველი უნდა აღმოაჩინო.',
    invalid_ritual = 'არასწორი რიტუალის ტიპი.',
    no_location = 'ეს წმინდა ადგილი კონფიგში არ არსებობს.',
    cannot_dead = 'მკვდარი პერსონაჟით რიტუალს ვერ დაიწყებ.',
    cannot_mounted = 'რიტუალამდე ცხენიდან ჩამოდი.',
    command_disabled = 'კომანდით რიტუალის დაწყება გამორთულია.',
    command_status_empty = 'შენი სულიერი მფარველი ჯერ არ გამოვლენილა.',
    admin_no_permission = 'სულიერი ადმინ ხელსაწყოების გამოყენების უფლება არ გაქვს.',
    admin_reset = 'სულიერი პროფილი განულდა.',
    broadcast_reveal = '{name}-მა {spirit}-ის სული გააღვიძა.',
    nui_title = 'LXR-SPIRITS',
    nui_subtitle = 'wolves.land • The Lux Empire',
    nui_begin = 'წრე გაიხსნა. კვამლი მაღლა ადის. მოუსმინე.',
    nui_reveal = 'შენმა სულმა გიპასუხა.',
    nui_close = 'დახურვა',
    nui_profile = 'სულიერი პროფილი',
    prompt_connect = 'სულთან დაკავშირება',
    prompt_connect_group = 'სულიერი მეგზური',
    spirit_omen_message = 'შენი სულიერი მეგზური არის {spirit}. ის შენთან მოდის...',
    spirit_approach_message = 'შენი სულიერი მეგზური გელოდება. მიუახლოვდი და დაამყარე კავშირი.',
    bond_complete = 'კავშირი დასრულებულია.',
    spirit_faded = 'სული უხილავ სამყაროში ბრუნდება.',
    spirit_name_title = 'სულის სახელი',
    spirit_name_revealed = 'სულებმა შეგარქვეს: {name}.'
}
