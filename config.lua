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

Config = {}
Config.Version = '1.4.0'
Config.Debug = false
Config.Lang = 'en'
Config.Framework = 'auto' -- auto, lxr-core, rsg-core, vorp_core, redem_roleplay, qbr-core, qr-core, standalone

Config.Brand = {
    title = 'LXR-SPIRITS',
    subtitle = 'Immersive Ritual System for RedM',
    server = 'wolves.land — The Land of Wolves',
    company = 'The Lux Empire',
    author = 'iBoss21',
    website = 'https://www.wolves.land',
    store = 'https://theluxempire.tebex.io'
}

Config.Commands = {
    player = 'lxrspirit',
    start = 'lxrritual',
    admin = 'lxrspiritadmin'
}

Config.Keys = {
    interact = 0xCEFD9220, -- E
    cancel = 0x156F7119,   -- BACKSPACE
    menu = 0x760A9C6F      -- G
}

Config.NUI = {
    -- Cursor/focus behavior for RedM NUI. Keep these true if players cannot move the mouse on the ritual panel.
    focusOnBegin = true,
    focusOnReveal = true,
    focusOnProfile = true,
    focusOnMenu = true,
    focusOnWitness = false,
    keepGameInput = false,
    closeOnEscape = true
}


Config.Encounter = {
    enabled = true,
    -- The full reveal flow is: distant omen -> arrival transition -> close spirit -> connect prompt -> bond animation -> reveal profile.
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

Config.General = {
    usePromptLocations = true,
    allowCommandStart = true,
    allowOnlyOneSpirit = true,
    allowReroll = false,
    revealToPlayerOnly = true,
    broadcastResult = false,
    witnessBroadcast = true,
    nearbyWitnessRadius = 15.0,
    saveLogs = true,
    saveCooldowns = true,
    cleanupOnStop = true
}

Config.Security = {
    enabled = true,
    validateDistance = true,
    maxStartDistance = 7.0,
    maxCompleteDistance = 12.0,
    validateItemOwnership = true,
    validateJobAccess = true,
    blockIfMountedClientSide = true,
    blockIfDeadClientSide = true,
    serverActionRateMs = 1200,
    maxActionsPerMinute = 10,
    maxActiveRitualSecondsBuffer = 45,
    suspiciousLog = true,
    kickOnExploit = false,
    adminAces = { 'command', 'lxr.admin', 'lxr.spirits.admin' }
}

Config.Performance = {
    idleSleepMs = 1250,
    mediumSleepMs = 450,
    nearSleepMs = 0,
    promptDrawDistance = 24.0
}

Config.FrameworkSettings = {
    ['lxr-core'] = { resource = 'lxr-core', inventory = 'lxr-inventory' },
    ['rsg-core'] = { resource = 'rsg-core', inventory = 'rsg-inventory' },
    ['vorp_core'] = { resource = 'vorp_core', inventory = 'vorp_inventory' },
    ['redem_roleplay'] = { resource = 'redem_roleplay', inventory = 'redemrp_inventory' },
    ['qbr-core'] = { resource = 'qbr-core', inventory = 'qbr-inventory' },
    ['qr-core'] = { resource = 'qr-core', inventory = 'qr-inventory' },
    ['standalone'] = { resource = 'standalone', inventory = 'none' }
}

Config.Items = {
    ritualSageBundle = 'ritual_sage_bundle',
    dreamRoot = 'dream_root',
    blessedWater = 'blessed_water',
    spiritToken = 'spirit_token',
    spiritAsh = 'spirit_ash',
    spiritCandle = 'spirit_candle',
    ancestralTotem = 'ancestral_totem',
    moonWater = 'moon_water',
    ritualBoneCharm = 'ritual_bone_charm',
    ritualSpiritBowl = 'ritual_spirit_bowl',
    meatBigGame = 'provision_meat_big_game',
    meatGame = 'provision_meat_game',
    meatStringy = 'provision_meat_stringy',
    meatGameyBird = 'provision_meat_gamey_bird',
    meatMatureVenison = 'provision_meat_mature_venison',
    animalHeart = 'generic_animal_heart',
    animalTooth = 'generic_animal_tooth',
    birdFeather = 'provision_bird_feather_flight',
    bearClaw = 'provision_bear_claw',
    bearHeart = 'provision_bear_heart',
    cougarClaw = 'provision_cougar_claw',
    foxClaw = 'provision_fox_claw',
    ravenClaw = 'provision_raven_claw',
    ramHorn = 'provision_ram_horn',
    buckAntlers = 'provision_buck_antlers',
    beaverTail = 'provision_beaver_tail',
    beaverScentGland = 'provision_beaver_scentgland'
}

Config.Offerings = {
    defaultConsumeMode = 'first_available',

    initiation = {
        { item = 'ritual_sage_bundle', amount = 1, label = 'Ritual Sage Bundle' },
        { item = 'generic_animal_heart', amount = 1, label = 'Animal Heart' },
        { item = 'provision_bird_feather_flight', amount = 1, label = 'Bird Feather Flight' },
        { item = 'provision_bear_claw', amount = 1, label = 'Bear Claw' },
        { item = 'generic_animal_tooth', amount = 1, label = 'Animal Tooth' }
    },

    vision = {
        { item = 'dream_root', amount = 1, label = 'Dream Root' },
        { item = 'provision_raven_claw', amount = 1, label = 'Raven Claw' },
        { item = 'provision_bird_feather_flight', amount = 1, label = 'Bird Feather Flight' }
    },

    cleansing = {
        { item = 'blessed_water', amount = 1, label = 'Blessed Water' },
        { item = 'moon_water', amount = 1, label = 'Moon Water' },
        { item = 'generic_animal_heart', amount = 1, label = 'Animal Heart' }
    },

    bond = {
        { item = 'spirit_token', amount = 1, label = 'Spirit Token' },
        { item = 'ritual_bone_charm', amount = 1, label = 'Ritual Bone Charm' },
        { item = 'provision_bear_claw', amount = 1, label = 'Bear Claw' },
        { item = 'provision_cougar_claw', amount = 1, label = 'Cougar Claw' },
        { item = 'provision_fox_claw', amount = 1, label = 'Fox Claw' }
    },

    omen = false
}

Config.SpiritOfferings = {
    wolf   = { { item = 'generic_animal_tooth', amount = 1, label = 'Animal Tooth' }, { item = 'generic_animal_heart', amount = 1, label = 'Animal Heart' }, { item = 'ritual_sage_bundle', amount = 1, label = 'Ritual Sage Bundle' } },
    eagle  = { { item = 'provision_bird_feather_flight', amount = 1, label = 'Bird Feather Flight' }, { item = 'ritual_sage_bundle', amount = 1, label = 'Ritual Sage Bundle' } },
    bear   = { { item = 'provision_bear_claw', amount = 1, label = 'Bear Claw' }, { item = 'provision_bear_heart', amount = 1, label = 'Bear Heart' }, { item = 'provision_meat_big_game', amount = 1, label = 'Big Game Meat' } },
    cougar = { { item = 'provision_cougar_claw', amount = 1, label = 'Cougar Claw' }, { item = 'generic_animal_tooth', amount = 1, label = 'Animal Tooth' } },
    fox    = { { item = 'provision_fox_claw', amount = 1, label = 'Fox Claw' }, { item = 'provision_meat_stringy', amount = 1, label = 'Stringy Meat' } },
    raven  = { { item = 'provision_raven_claw', amount = 1, label = 'Raven Claw' }, { item = 'provision_bird_feather_flight', amount = 1, label = 'Bird Feather Flight' } },
    elk    = { { item = 'provision_buck_antlers', amount = 1, label = 'Buck Antlers' }, { item = 'provision_meat_mature_venison', amount = 1, label = 'Mature Venison Meat' } },
    bison  = { { item = 'provision_meat_big_game', amount = 1, label = 'Big Game Meat' }, { item = 'generic_animal_heart', amount = 1, label = 'Animal Heart' } },
    coyote = { { item = 'generic_animal_tooth', amount = 1, label = 'Animal Tooth' }, { item = 'provision_meat_stringy', amount = 1, label = 'Stringy Meat' } },
    owl    = { { item = 'provision_bird_feather_flight', amount = 1, label = 'Bird Feather Flight' }, { item = 'dream_root', amount = 1, label = 'Dream Root' } }
}

Config.RitualTypes = {
    initiation = {
        label = 'Spirit Initiation',
        durationMs = 42000,
        revealDelayMs = 30000,
        cooldownSeconds = 86400,
        requiresExistingSpirit = false,
        blocksIfHasSpirit = true,
        requiredItem = false,
        requiredItems = Config.Offerings.initiation,
        consumeItem = true,
        consumeMode = 'first_available',
        selectionMode = 'weighted_context',
        addBond = 5
    },
    vision = {
        label = 'Spirit Vision',
        durationMs = 26000,
        revealDelayMs = 16000,
        cooldownSeconds = 3600,
        requiresExistingSpirit = true,
        blocksIfHasSpirit = false,
        requiredItem = false,
        requiredItems = Config.Offerings.vision,
        consumeItem = true,
        consumeMode = 'first_available',
        selectionMode = 'existing'
    },
    cleansing = {
        label = 'Cleansing Rite',
        durationMs = 30000,
        revealDelayMs = 19000,
        cooldownSeconds = 7200,
        requiresExistingSpirit = true,
        blocksIfHasSpirit = false,
        requiredItem = false,
        requiredItems = Config.Offerings.cleansing,
        consumeItem = true,
        consumeMode = 'first_available',
        selectionMode = 'existing',
        clearsOmen = true
    },
    bond = {
        label = 'Spirit Bond',
        durationMs = 36000,
        revealDelayMs = 24000,
        cooldownSeconds = 21600,
        requiresExistingSpirit = true,
        blocksIfHasSpirit = false,
        requiredItem = false,
        requiredItems = Config.Offerings.bond,
        consumeItem = true,
        consumeMode = 'first_available',
        selectionMode = 'existing',
        addBond = 10
    },
    omen = {
        label = 'Omen Reading',
        durationMs = 22000,
        revealDelayMs = 12000,
        cooldownSeconds = 2700,
        requiresExistingSpirit = false,
        blocksIfHasSpirit = false,
        requiredItem = false,
        requiredItems = false,
        consumeItem = false,
        consumeMode = 'first_available',
        selectionMode = 'omen_only'
    }
}

Config.Cinematic = {
    scenario = 'WORLD_HUMAN_CROUCH_INSPECT',
    freezePlayer = true,
    fadeOutMs = 900,
    fadeInMs = 1200,
    postFx = 'PlayerDrunk01',
    usePostFx = true,
    cameraShake = true,
    shakeType = 'DRUNK_SHAKE',
    shakeIntensity = 0.18,
    spawnSpiritPed = true,
    spiritAlpha = 170,
    spiritLifetimeMs = 22000,
    spiritDistance = 8.5
}

Config.RitualProps = {
    enabled = true,
    lifetimeMs = 65000,
    objects = {
        { model = 'p_campfire05x', offset = vector3(0.0, 0.0, -0.95), heading = 0.0 },
        { model = 'p_candle01x', offset = vector3(1.15, 0.35, -0.95), heading = 0.0 },
        { model = 'p_candle01x', offset = vector3(-1.10, -0.30, -0.95), heading = 0.0 },
        { model = 'p_bowl04x', offset = vector3(0.45, -0.65, -0.95), heading = 0.0 }
    }
}

Config.Integrations = {
    lxr_reputation = { enabled = false, event = 'lxr-reputation:server:addReputation', amount = 2 },
    lxr_skills = { enabled = false, event = 'lxr-skills:server:addXP', skill = 'spirituality', amount = 10 },
    lxr_hud = { enabled = false, event = 'lxr-hud:client:spiritPulse' }
}

Config.Omens = {
    moon_blessing = { label = 'Moon Blessing', tone = 'good', text = 'The moon watches over your next path.', weight = 18 },
    black_smoke = { label = 'Black Smoke', tone = 'warning', text = 'A hidden debt follows your shadow.', weight = 12 },
    red_ember = { label = 'Red Ember', tone = 'danger', text = 'Blood remembers what men forget.', weight = 10 },
    white_feather = { label = 'White Feather', tone = 'good', text = 'A messenger will cross your trail.', weight = 14 },
    cold_wind = { label = 'Cold Wind', tone = 'neutral', text = 'Silence has become your teacher.', weight = 16 },
    broken_ring = { label = 'Broken Ring', tone = 'warning', text = 'A bond may break unless guarded.', weight = 8 }
}

Config.SpiritAnimals = {
    wolf = { label = 'Wolf', model = 'a_c_wolf', icon = '🐺', element = 'Moon', temperament = 'Loyal', weight = 28, title = 'The Pack-Bound Hunter', meaning = 'Loyalty, instinct, leadership, survival, and memory of the pack.', weakness = 'Isolation and betrayal.', bondBuff = 'Nearby allies become part of your story.', offerings = { 'generic_animal_tooth', 'generic_animal_heart', 'ritual_sage_bundle' }, omens = { 'moon_blessing', 'cold_wind' } },
    eagle = { label = 'Eagle', model = 'a_c_eagle_01', icon = '🦅', element = 'Sky', temperament = 'Judging', weight = 18, title = 'The Sky Watcher', meaning = 'Vision, distance, judgment, freedom, and the will to rise.', weakness = 'Pride and emotional distance.', bondBuff = 'Your path is clearest from high ground.', offerings = { 'provision_bird_feather_flight', 'ritual_sage_bundle' }, omens = { 'white_feather', 'moon_blessing' } },
    bear = { label = 'Bear', model = 'a_c_bear_01', icon = '🐻', element = 'Earth', temperament = 'Guardian', weight = 20, title = 'The Ancient Guardian', meaning = 'Strength, endurance, protection, solitude, and sacred defense.', weakness = 'Rage without restraint.', bondBuff = 'You endure storms that break lesser men.', offerings = { 'provision_bear_claw', 'provision_bear_heart', 'blessed_water' }, omens = { 'cold_wind', 'red_ember' } },
    cougar = { label = 'Cougar', model = 'a_c_cougar_01', icon = '🐆', element = 'Shadow', temperament = 'Patient', weight = 14, title = 'The Silent Stalker', meaning = 'Precision, independence, patience, danger, and decisive movement.', weakness = 'Loneliness and distrust.', bondBuff = 'Your best strike is the one unseen.', offerings = { 'ritual_sage_bundle' }, omens = { 'black_smoke', 'cold_wind' } },
    fox = { label = 'Fox', model = 'a_c_fox_01', icon = '🦊', element = 'Ember', temperament = 'Clever', weight = 12, title = 'The Trickster Flame', meaning = 'Cunning, adaptation, humor, deception, and survival through intelligence.', weakness = 'Games that become lies.', bondBuff = 'You survive through wit where force fails.', offerings = { 'dream_root' }, omens = { 'red_ember', 'broken_ring' } },
    raven = { label = 'Raven', model = 'a_c_raven_01', icon = '🪶', element = 'Death', temperament = 'Prophetic', weight = 11, title = 'The Omen Bearer', meaning = 'Memory, death, prophecy, secrets, and transformation.', weakness = 'Obsession with signs.', bondBuff = 'The dead leave whispers for those who listen.', offerings = { 'provision_raven_claw', 'provision_bird_feather_flight', 'dream_root' }, omens = { 'black_smoke', 'white_feather', 'broken_ring' } },
    elk = { label = 'Elk', model = 'a_c_elk_01', icon = '🫎', element = 'Pine', temperament = 'Noble', weight = 10, title = 'The Crowned Wanderer', meaning = 'Dignity, migration, stamina, and old noble blood.', weakness = 'Pride that refuses help.', bondBuff = 'Your road is long but your step remains steady.', offerings = { 'ritual_sage_bundle' }, omens = { 'cold_wind' } },
    bison = { label = 'Bison', model = 'a_c_buffalo_01', icon = '🐃', element = 'Plain', temperament = 'Unbroken', weight = 10, title = 'The Thunder of the Plains', meaning = 'Community, provision, impact, and ancient endurance.', weakness = 'Stubbornness before wisdom.', bondBuff = 'You carry weight without complaint.', offerings = { 'blessed_water' }, omens = { 'moon_blessing' } },
    coyote = { label = 'Coyote', model = 'a_c_coyote_01', icon = '🌵', element = 'Dust', temperament = 'Restless', weight = 12, title = 'The Laughing Dust', meaning = 'Trickery, survival, movement, hunger, and wild fortune.', weakness = 'Greed and carelessness.', bondBuff = 'Trouble finds you, but so does escape.', offerings = { 'dream_root' }, omens = { 'red_ember', 'broken_ring' } },
    owl = { label = 'Owl', model = 'a_c_owl_01', icon = '🦉', element = 'Night', temperament = 'Silent', weight = 9, title = 'The Night Judge', meaning = 'Wisdom, secrecy, patience, and judgment in darkness.', weakness = 'Cold detachment.', bondBuff = 'Night reveals what daylight conceals.', offerings = { 'provision_bird_feather_flight', 'dream_root' }, omens = { 'black_smoke', 'white_feather' } },
    white_deer = { label = 'White Deer', model = 'a_c_deer_01', icon = '🦌', element = 'Mist', temperament = 'Pure', weight = 7, title = 'The Pale Messenger', meaning = 'Mercy, rebirth, warning, innocence, and a path through grief.', weakness = 'Fragility and fear of corruption.', bondBuff = 'The unseen road opens when the heart is clean.', offerings = { 'provision_meat_mature_venison', 'moon_water', 'ritual_sage_bundle' }, omens = { 'white_feather', 'moon_blessing' } },
    great_bison = { label = 'Great Bison', model = 'a_c_buffalo_01', icon = '🐃', element = 'Earth', temperament = 'Ancient', weight = 6, title = 'The Ancient Thunder', meaning = 'Endurance, tribe, land, burden, and the strength to remain.', weakness = 'Stubbornness and slow anger.', bondBuff = 'The land remembers those who carry its weight.', offerings = { 'provision_meat_big_game', 'generic_animal_heart', 'ritual_bone_charm' }, omens = { 'red_sky', 'broken_ring' } },
    omen_wolf = { label = 'Omen Wolf', model = 'a_c_wolf', icon = '🐺', element = 'Moon', temperament = 'Haunting', weight = 5, title = 'The Moon-Scarred Omen', meaning = 'Prophecy, loyalty, threat, exile, and the call of the pack.', weakness = 'Possession by old wounds.', bondBuff = 'The pack hears you when the night is silent.', offerings = { 'generic_animal_tooth', 'generic_animal_heart', 'spirit_ash' }, omens = { 'black_smoke', 'moon_blessing' } }
}

Config.Locations = {
    { id = 'cotorra_springs', label = 'Cotorra Springs Sacred Steam', coords = vector3(-999.62, 817.78, 116.43), heading = 205.0, radius = 3.2, drawDistance = 24.0, allowedSpirits = { 'wolf', 'eagle', 'bear', 'elk', 'white_deer' }, fixedSpirit = nil, jobs = false, requiredItem = nil, timeBias = { night = 1.15 }, propSet = true },
    { id = 'owanjila_stone', label = 'Owanjila Ancestral Stone', coords = vector3(-2596.88, -131.01, 165.38), heading = 86.0, radius = 3.4, drawDistance = 24.0, allowedSpirits = { 'wolf', 'cougar', 'fox', 'bear', 'white_deer' }, fixedSpirit = nil, jobs = false, requiredItem = nil, timeBias = { dusk = 1.2 }, propSet = true },
    { id = 'roanoke_tree', label = 'Roanoke Whispering Tree', coords = vector3(2177.61, 1569.42, 83.82), heading = 14.0, radius = 3.0, drawDistance = 24.0, allowedSpirits = { 'raven', 'owl', 'fox', 'coyote' }, fixedSpirit = 'raven', jobs = false, requiredItem = nil, timeBias = { night = 1.25 }, propSet = true },
    { id = 'big_valley_moon_circle', label = 'Big Valley Moon Circle', coords = vector3(-1515.40, 1242.20, 312.10), heading = 180.0, radius = 4.0, drawDistance = 26.0, allowedSpirits = { 'wolf', 'eagle', 'bear', 'elk', 'bison', 'white_deer', 'great_bison' }, fixedSpirit = nil, jobs = false, requiredItem = nil, timeBias = { night = 1.3 }, propSet = true },
    { id = 'tall_trees_grave_wind', label = 'Tall Trees Grave Wind', coords = vector3(-1960.30, -1619.80, 116.20), heading = 245.0, radius = 4.0, drawDistance = 26.0, allowedSpirits = { 'raven', 'owl', 'wolf', 'cougar' }, fixedSpirit = nil, jobs = false, requiredItem = nil, timeBias = { night = 1.35 }, propSet = true },
    { id = 'heartlands_old_bones', label = 'Heartlands Old Bones', coords = vector3(-273.50, 778.20, 118.40), heading = 90.0, radius = 3.5, drawDistance = 24.0, allowedSpirits = { 'bison', 'coyote', 'eagle', 'fox', 'great_bison' }, fixedSpirit = nil, jobs = false, requiredItem = nil, timeBias = { dawn = 1.2 }, propSet = true }
}

Config.Locale = Config.Locale or {}

CreateThread(function()
    if IsDuplicityVersion() then
        print('^3╔══════════════════════════════════════════════════════════════════════════════╗^7')
        print('^3║^7 🐺 LXR-SPIRITS v' .. Config.Version .. ' | wolves.land | The Lux Empire       ^3║^7')
        print('^3║^7 Resource identity locked: lxr-spirits | Rename protection enabled       ^3║^7')
        print('^3╚══════════════════════════════════════════════════════════════════════════════╝^7')
    end
end)
