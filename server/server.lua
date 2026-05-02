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

local RESOURCE = 'lxr-spirits'
local cooldownMs = {}
local actionWindows = {}
local activeRituals = {}
local memoryProfiles = {}
local memoryCooldowns = {}

local function hasDb() return MySQL ~= nil end
local function now() return os.time() end
local function nowMs() return GetGameTimer() end
local function encode(v) return json.encode(v or {}) end

CreateThread(function()
    local currentName = GetCurrentResourceName()
    if currentName ~= RESOURCE then
        print(('^1[%s] FATAL: Resource name mismatch.^7'):format(RESOURCE))
        print(('^1[%s] Expected folder name: %s^7'):format(RESOURCE, RESOURCE))
        print(('^1[%s] Current folder name: %s^7'):format(RESOURCE, currentName))
        print(('^1[%s] This resource is locked by design and cannot be renamed in config.^7'):format(RESOURCE))
        StopResource(currentName)
        return
    end

    math.randomseed(os.time() + GetGameTimer())
    print('^3╔══════════════════════════════════════════════════════════════════════════════╗^7')
    print('^3║^7 🐺 LXR-SPIRITS SERVER ONLINE | wolves.land | The Lux Empire              ^3║^7')
    print('^3║^7 Resource identity locked: lxr-spirits | Server validation active         ^3║^7')
    print('^3╚══════════════════════════════════════════════════════════════════════════════╝^7')
end)

local function dbSingle(q, p, cb) if hasDb() then MySQL.single(q, p or {}, cb) else cb(nil) end end
local function dbUpdate(q, p, cb) if hasDb() then MySQL.update(q, p or {}, cb or function() end) elseif cb then cb(0) end end

local function suspicious(src, reason, extra)
    if not Config.Security.suspiciousLog then return end
    print(('^1[%s SECURITY]^7 %s [%s] %s'):format(RESOURCE, GetPlayerName(src) or 'unknown', tostring(src), reason))
    if extra then print(encode(extra)) end
    if Config.Security.kickOnExploit then DropPlayer(src, 'lxr-spirits security violation') end
end

local function rateLimited(src, action)
    if not Config.Security.enabled then return false end
    local key = tostring(src) .. ':' .. tostring(action)
    local last = cooldownMs[key]
    local gap = Config.Security.serverActionRateMs or 1200
    if last and nowMs() - last < gap then suspicious(src, 'rate limit', { action = action }) return true end
    cooldownMs[key] = nowMs()
    local t = now()
    actionWindows[src] = actionWindows[src] or { start = t, count = 0 }
    local w = actionWindows[src]
    if t - w.start >= 60 then w.start = t; w.count = 0 end
    w.count = w.count + 1
    if w.count > (Config.Security.maxActionsPerMinute or 10) then suspicious(src, 'too many actions', { action = action, count = w.count }) return true end
    return false
end

local function getLocation(id)
    for _, loc in ipairs(Config.Locations or {}) do if loc.id == id then return loc end end
    return nil
end

local function distance(a,b) return #(vector3(a.x,a.y,a.z) - vector3(b.x,b.y,b.z)) end

local function characterKey(c)
    return c.charid or c.citizenid or c.identifier or 'unknown'
end

local function isAdmin(src)
    if src == 0 then return true end
    for _, ace in ipairs(Config.Security.adminAces or {}) do
        if IsPlayerAceAllowed(src, ace) then return true end
    end
    return false
end

local function getProfile(c, cb)
    local key = characterKey(c)
    if hasDb() then
        dbSingle('SELECT * FROM lxr_spirits_profiles WHERE char_key = ? LIMIT 1', { key }, cb)
    else
        cb(memoryProfiles[key])
    end
end

local function saveProfile(c, data, cb)
    local key = characterKey(c)
    local row = {
        char_key = key,
        identifier = c.identifier,
        citizenid = c.citizenid,
        charid = c.charid,
        player_name = c.name,
        spirit = data.spirit,
        label = data.label,
        title = data.title,
        meaning = data.meaning,
        element = data.element,
        temperament = data.temperament,
        weakness = data.weakness,
        bond = tonumber(data.bond or 0) or 0,
        omen = data.omen,
        spirit_name = data.spirit_name,
        location_id = data.location_id,
        metadata = encode(data.metadata or {})
    }
    if hasDb() then
        dbUpdate([[INSERT INTO lxr_spirits_profiles
            (char_key, identifier, citizenid, charid, player_name, spirit, label, title, meaning, element, temperament, weakness, bond, omen, spirit_name, location_id, metadata)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            ON DUPLICATE KEY UPDATE identifier=VALUES(identifier), citizenid=VALUES(citizenid), charid=VALUES(charid), player_name=VALUES(player_name), spirit=VALUES(spirit), label=VALUES(label), title=VALUES(title), meaning=VALUES(meaning), element=VALUES(element), temperament=VALUES(temperament), weakness=VALUES(weakness), bond=VALUES(bond), omen=VALUES(omen), spirit_name=VALUES(spirit_name), location_id=VALUES(location_id), metadata=VALUES(metadata), updated_at=CURRENT_TIMESTAMP]],
            { row.char_key, row.identifier, row.citizenid, row.charid, row.player_name, row.spirit, row.label, row.title, row.meaning, row.element, row.temperament, row.weakness, row.bond, row.omen, row.spirit_name, row.location_id, row.metadata }, cb)
    else
        memoryProfiles[key] = row
        if cb then cb(1) end
    end
end

local function logRitual(c, ritualType, locationId, spirit, result, metadata)
    if not Config.General.saveLogs then return end
    if hasDb() then
        dbUpdate('INSERT INTO lxr_spirits_logs (char_key, identifier, player_name, ritual_type, location_id, spirit, result, metadata) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
            { characterKey(c), c.identifier, c.name, ritualType, locationId, spirit, result, encode(metadata or {}) })
    end
end

local function getCooldown(c, ritualType, cb)
    local key = characterKey(c) .. ':' .. ritualType
    if hasDb() and Config.General.saveCooldowns then
        dbSingle('SELECT cooldown_until FROM lxr_spirits_cooldowns WHERE char_key = ? AND ritual_type = ? LIMIT 1', { characterKey(c), ritualType }, function(row)
            cb(row and tonumber(row.cooldown_until) or 0)
        end)
    else
        cb(memoryCooldowns[key] or 0)
    end
end

local function setCooldown(c, ritualType, seconds)
    local untilTs = now() + tonumber(seconds or 0)
    local key = characterKey(c) .. ':' .. ritualType
    if hasDb() and Config.General.saveCooldowns then
        dbUpdate('INSERT INTO lxr_spirits_cooldowns (char_key, ritual_type, cooldown_until) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE cooldown_until=VALUES(cooldown_until)', { characterKey(c), ritualType, untilTs })
    else
        memoryCooldowns[key] = untilTs
    end
end

local function chooseOmen(spiritData)
    local candidates = {}
    if spiritData and spiritData.omens then
        for _, id in ipairs(spiritData.omens) do if Config.Omens[id] then candidates[#candidates+1] = id end end
    end
    if #candidates == 0 then for id in pairs(Config.Omens) do candidates[#candidates+1] = id end end
    local total = 0
    for _, id in ipairs(candidates) do total = total + (Config.Omens[id].weight or 1) end
    local roll = math.random(1, math.max(total, 1))
    local cursor = 0
    for _, id in ipairs(candidates) do
        cursor = cursor + (Config.Omens[id].weight or 1)
        if roll <= cursor then return id, Config.Omens[id] end
    end
    local id = candidates[1]
    return id, Config.Omens[id]
end

local function hourMultiplier(loc)
    local h = tonumber(os.date('%H')) or 12
    local bucket = 'day'
    if h >= 20 or h <= 4 then bucket = 'night' elseif h >= 5 and h <= 8 then bucket = 'dawn' elseif h >= 17 and h <= 19 then bucket = 'dusk' end
    if loc.timeBias and loc.timeBias[bucket] then return tonumber(loc.timeBias[bucket]) or 1.0 end
    return 1.0
end

local function chooseSpiritName(spiritKey)
    local pool = Config.SpiritNames and Config.SpiritNames[spiritKey]
    if not pool or #pool == 0 then return nil end
    return pool[math.random(1, #pool)]
end

local function chooseSpirit(loc, existing, ritual)
    if ritual.selectionMode == 'existing' and existing and existing.spirit and Config.SpiritAnimals[existing.spirit] then
        return existing.spirit, Config.SpiritAnimals[existing.spirit]
    end
    if ritual.selectionMode == 'omen_only' then
        local key = existing and existing.spirit or 'wolf'
        return key, Config.SpiritAnimals[key] or Config.SpiritAnimals.wolf
    end
    if ritual.selectionMode == 'fixed_by_location' and loc.fixedSpirit and Config.SpiritAnimals[loc.fixedSpirit] then
        return loc.fixedSpirit, Config.SpiritAnimals[loc.fixedSpirit]
    end
    local pool = {}
    if loc.allowedSpirits and #loc.allowedSpirits > 0 then
        for _, id in ipairs(loc.allowedSpirits) do if Config.SpiritAnimals[id] then pool[#pool+1] = id end end
    else
        for id in pairs(Config.SpiritAnimals) do pool[#pool+1] = id end
    end
    local total = 0
    local mult = hourMultiplier(loc)
    local weights = {}
    for _, id in ipairs(pool) do
        local s = Config.SpiritAnimals[id]
        local weight = tonumber(s.weight or 1) or 1
        if loc.fixedSpirit == id then weight = weight * 1.45 end
        weight = weight * mult
        weights[id] = weight
        total = total + weight
    end
    local roll = math.random() * math.max(total, 1)
    local cursor = 0
    for _, id in ipairs(pool) do
        cursor = cursor + weights[id]
        if roll <= cursor then return id, Config.SpiritAnimals[id] end
    end
    local id = pool[1] or 'wolf'
    return id, Config.SpiritAnimals[id]
end

local function jobAllowed(src, loc)
    if not Config.Security.validateJobAccess then return true end
    if not loc.jobs or type(loc.jobs) ~= 'table' then return true end
    local job, grade = Framework.GetJob(src)
    local req = loc.jobs[job]
    return req ~= nil and tonumber(grade or 0) >= tonumber(req or 0)
end

local function normalizeOfferingList(required)
    if required == nil or required == false or required == '' then return {} end
    if type(required) == 'string' then return { { item = required, amount = 1, label = required } } end
    if type(required) ~= 'table' then return {} end
    local out = {}
    for _, entry in ipairs(required) do
        if type(entry) == 'string' then
            out[#out + 1] = { item = entry, amount = 1, label = entry }
        elseif type(entry) == 'table' and entry.item then
            out[#out + 1] = { item = entry.item, amount = tonumber(entry.amount or entry.count or entry.quantity or 1) or 1, label = entry.label or entry.item }
        end
    end
    return out
end

local function buildRequiredOfferings(ritualType, ritual, loc, existing)
    local list = {}
    local function addMany(src)
        for _, v in ipairs(normalizeOfferingList(src)) do list[#list + 1] = v end
    end

    addMany(loc.requiredItems)
    addMany(loc.requiredItem)
    addMany(ritual.requiredItems)
    addMany(ritual.requiredItem)

    -- Spirit Bond accepts global bond offerings plus offerings connected to the player's existing spirit.
    if ritualType == 'bond' and existing and existing.spirit and Config.SpiritOfferings and Config.SpiritOfferings[existing.spirit] then
        addMany(Config.SpiritOfferings[existing.spirit])
    end

    local seen, clean = {}, {}
    for _, item in ipairs(list) do
        local key = tostring(item.item) .. ':' .. tostring(item.amount or 1)
        if item.item and not seen[key] then
            clean[#clean + 1] = item
            seen[key] = true
        end
    end
    return clean
end

local function findAvailableOffering(src, offerings, consumeMode)
    if not offerings or #offerings == 0 then return true, nil, nil end
    consumeMode = consumeMode or (Config.Offerings and Config.Offerings.defaultConsumeMode) or 'first_available'

    if consumeMode == 'all_required' then
        local missing = {}
        for _, req in ipairs(offerings) do
            if not Framework.HasItem(src, req.item, req.amount or 1) then missing[#missing + 1] = req end
        end
        if #missing > 0 then return false, nil, missing end
        return true, offerings, nil
    end

    for _, req in ipairs(offerings) do
        if Framework.HasItem(src, req.item, req.amount or 1) then return true, req, nil end
    end

    return false, nil, offerings
end

local function formatMissingOfferings(missing)
    if not missing or #missing == 0 then return 'unknown' end
    local labels = {}
    for _, req in ipairs(missing) do labels[#labels + 1] = tostring(req.label or req.item) end
    return table.concat(labels, ' / ')
end

local function consumeOffering(src, selected)
    if not selected then return end
    if selected[1] then
        for _, req in ipairs(selected) do Framework.RemoveItem(src, req.item, req.amount or 1) end
    elseif selected.item then
        Framework.RemoveItem(src, selected.item, selected.amount or 1)
    end
end


local function validateStart(src, ritualType, locationId, cb)
    if rateLimited(src, 'start') then cb(false, 'cooldown_active') return end
    local ritual = Config.RitualTypes[ritualType or 'initiation']
    if not ritual then cb(false, 'invalid_ritual') return end
    local loc = getLocation(locationId)
    if not loc then cb(false, 'no_location') return end
    local ped = GetPlayerPed(src)
    if not ped or ped == 0 then cb(false, 'ritual_cancelled') return end
    if Config.Security.validateDistance then
        local coords = GetEntityCoords(ped)
        if distance(coords, loc.coords) > (Config.Security.maxStartDistance or 7.0) then
            suspicious(src, 'start distance mismatch', { ritualType = ritualType, locationId = locationId })
            cb(false, 'too_far') return
        end
    end
    if not jobAllowed(src, loc) then cb(false, 'not_allowed') return end
    local c = Framework.GetCharacter(src)
    getCooldown(c, ritualType, function(untilTs)
        if untilTs and untilTs > now() then cb(false, 'cooldown_active', { seconds = untilTs - now() }) return end
        getProfile(c, function(existing)
            if ritual.requiresExistingSpirit and not existing then cb(false, 'needs_spirit') return end
            if Config.General.allowOnlyOneSpirit and ritual.blocksIfHasSpirit and existing and not Config.General.allowReroll then cb(false, 'already_has_spirit', { existing = existing }) return end
            local offerings = buildRequiredOfferings(ritualType, ritual, loc, existing)
            local okOffer, selectedOffering, missingOfferings = findAvailableOffering(src, offerings, ritual.consumeMode)
            if Config.Security.validateItemOwnership and not okOffer then
                cb(false, 'missing_item', { item = formatMissingOfferings(missingOfferings), offerings = missingOfferings })
                return
            end
            cb(true, nil, { char = c, ritual = ritual, loc = loc, existing = existing, requiredOffering = selectedOffering, requiredItem = selectedOffering and (selectedOffering.item or 'multiple') or nil })
        end)
    end)
end

RegisterNetEvent('lxr-spirits:server:requestStart', function(ritualType, locationId)
    local src = source
    validateStart(src, ritualType or 'initiation', locationId, function(ok, err, ctx)
        if not ok then
            if err == 'already_has_spirit' and ctx and ctx.existing then TriggerClientEvent('lxr-spirits:client:showProfile', src, ctx.existing) end
            Framework.Notify(src, Framework.Locale(err or 'ritual_cancelled', ctx or {}), 'error')
            return
        end
        local ritual, loc, c = ctx.ritual, ctx.loc, ctx.char
        if ctx.requiredOffering and ritual.consumeItem then consumeOffering(src, ctx.requiredOffering) end
        activeRituals[src] = { ritualType = ritualType, locationId = locationId, started = now(), char = c, requiredOffering = ctx.requiredOffering, requiredItem = ctx.requiredItem }
        TriggerClientEvent('lxr-spirits:client:startRitual', src, ritualType, loc, ritual, Config.Cinematic)
        Framework.Notify(src, Framework.Locale('ritual_started', { ritual = ritual.label }), 'inform')
        logRitual(c, ritualType, locationId, nil, 'started', { requiredItem = ctx.requiredItem })
    end)
end)

RegisterNetEvent('lxr-spirits:server:completeRitual', function(ritualType, locationId)
    local src = source
    if rateLimited(src, 'complete') then return end
    local active = activeRituals[src]
    if not active or active.ritualType ~= ritualType or active.locationId ~= locationId then suspicious(src, 'complete without active ritual', { ritualType = ritualType, locationId = locationId }) return end
    local ritual = Config.RitualTypes[ritualType]
    local loc = getLocation(locationId)
    if not ritual or not loc then activeRituals[src] = nil return end
    local maxAge = math.floor((ritual.durationMs or 30000) / 1000) + (Config.Security.maxActiveRitualSecondsBuffer or 45)
    if now() - active.started > maxAge then suspicious(src, 'ritual completion too late', { age = now() - active.started }) activeRituals[src] = nil return end
    if Config.Security.validateDistance then
        local ped = GetPlayerPed(src)
        local coords = GetEntityCoords(ped)
        if distance(coords, loc.coords) > (Config.Security.maxCompleteDistance or 12.0) then
            suspicious(src, 'complete distance mismatch', { locationId = locationId })
            activeRituals[src] = nil
            Framework.Notify(src, Framework.Locale('too_far'), 'error')
            return
        end
    end
    local c = Framework.GetCharacter(src)
    getProfile(c, function(existing)
        local spiritKey, spirit = chooseSpirit(loc, existing, ritual)
        local omenKey, omen = chooseOmen(spirit)
        local bond = tonumber(existing and existing.bond or 0) or 0
        if ritual.addBond then bond = math.min(100, bond + ritual.addBond) end
        if ritualType == 'initiation' then bond = math.max(bond, 5) end
        -- Only assign a spirit name on initiation (first bonding) or if none exists yet
        local spiritName = (existing and existing.spirit_name) or chooseSpiritName(spiritKey)
        local profile = {
            spirit = spiritKey,
            label = spirit.label,
            title = spirit.title,
            meaning = spirit.meaning,
            element = spirit.element,
            temperament = spirit.temperament,
            weakness = spirit.weakness,
            bond = bond,
            omen = ritual.clearsOmen and nil or omenKey,
            spirit_name = spiritName,
            location_id = loc.id,
            metadata = { ritual = ritualType, omen = omen, bondBuff = spirit.bondBuff, completedAt = os.date('!%Y-%m-%dT%H:%M:%SZ') }
        }
        if ritual.selectionMode == 'omen_only' and existing then
            profile.spirit, profile.label, profile.title, profile.meaning = existing.spirit, existing.label, existing.title, existing.meaning
            profile.element, profile.temperament, profile.weakness = existing.element, existing.temperament, existing.weakness
            profile.spirit_name = existing.spirit_name or spiritName
        end
        saveProfile(c, profile)
        setCooldown(c, ritualType, ritual.cooldownSeconds or 1800)
        activeRituals[src] = nil
        TriggerClientEvent('lxr-spirits:client:revealSpirit', src, spiritKey, spirit, loc, omenKey, omen, ritualType, bond, profile.spirit_name)
        TriggerEvent('lxr-spirits:server:ritualComplete', src, c, ritualType, spiritKey, profile)
        logRitual(c, ritualType, locationId, spiritKey, 'completed', { omen = omenKey, bond = bond, spirit_name = profile.spirit_name })
        if Config.General.broadcastResult and not Config.General.revealToPlayerOnly then
            TriggerClientEvent('chat:addMessage', -1, { args = { 'LXR-Spirits', Framework.Locale('broadcast_reveal', { name = c.name, spirit = spirit.label }) } })
        elseif Config.General.witnessBroadcast then
            local srcCoords = GetEntityCoords(GetPlayerPed(src))
            for _, pid in ipairs(GetPlayers()) do
                local playerId = tonumber(pid)
                if playerId ~= src then
                    TriggerClientEvent('lxr-spirits:client:witnessPulse', playerId, srcCoords, c.name, spirit.label)
                end
            end
        end
        if Config.Integrations.lxr_reputation.enabled then TriggerEvent(Config.Integrations.lxr_reputation.event, src, Config.Integrations.lxr_reputation.amount) end
        if Config.Integrations.lxr_skills.enabled then TriggerEvent(Config.Integrations.lxr_skills.event, src, Config.Integrations.lxr_skills.skill, Config.Integrations.lxr_skills.amount) end
    end)
end)

RegisterNetEvent('lxr-spirits:server:cancelRitual', function(reason)
    local src = source
    local active = activeRituals[src]
    if active then logRitual(active.char or Framework.GetCharacter(src), active.ritualType, active.locationId, nil, 'cancelled', { reason = reason }) end
    activeRituals[src] = nil
    Framework.Notify(src, Framework.Locale('ritual_cancelled'), 'warning')
end)

RegisterNetEvent('lxr-spirits:server:requestProfile', function()
    local src = source
    if rateLimited(src, 'profile') then return end
    local c = Framework.GetCharacter(src)
    getProfile(c, function(profile)
        if profile then TriggerClientEvent('lxr-spirits:client:showProfile', src, profile)
        else Framework.Notify(src, Framework.Locale('command_status_empty'), 'inform') end
    end)
end)

RegisterCommand(Config.Commands.player, function(src)
    if src <= 0 then return end
    local c = Framework.GetCharacter(src)
    getProfile(c, function(profile)
        if profile then TriggerClientEvent('lxr-spirits:client:showProfile', src, profile)
        else Framework.Notify(src, Framework.Locale('command_status_empty'), 'inform') end
    end)
end, false)

RegisterCommand(Config.Commands.start, function(src, args)
    if src <= 0 then return end
    if not Config.General.allowCommandStart then Framework.Notify(src, Framework.Locale('command_disabled'), 'error') return end
    local ritualType = args[1] or 'initiation'
    local locId = args[2]
    if not locId then Framework.Notify(src, '/' .. Config.Commands.start .. ' [initiation|vision|cleansing|bond|omen] [locationId]', 'inform') return end
    validateStart(src, ritualType, locId, function(ok, err, ctx)
        if not ok then Framework.Notify(src, Framework.Locale(err or 'ritual_cancelled', ctx or {}), 'error') return end
        local ritual, loc, c = ctx.ritual, ctx.loc, ctx.char
        if ctx.requiredOffering and ritual.consumeItem then consumeOffering(src, ctx.requiredOffering) end
        activeRituals[src] = { ritualType = ritualType, locationId = locId, started = now(), char = c, requiredOffering = ctx.requiredOffering, requiredItem = ctx.requiredItem }
        TriggerClientEvent('lxr-spirits:client:startRitual', src, ritualType, loc, ritual, Config.Cinematic)
        Framework.Notify(src, Framework.Locale('ritual_started', { ritual = ritual.label }), 'inform')
        logRitual(c, ritualType, locId, nil, 'started', { requiredItem = ctx.requiredItem })
    end)
end, false)

local function adminHelp(src)
    local msg = table.concat({
        '/lxrspiritadmin help',
        '/lxrspiritadmin show [serverId]',
        '/lxrspiritadmin set [serverId] [spirit]',
        '/lxrspiritadmin reset [serverId]',
        '/lxrspiritadmin bond [serverId] [0-100]',
        '/lxrspiritadmin cooldown [serverId] [ritualType] clear'
    }, '\n')
    if src > 0 then Framework.Notify(src, msg, 'inform', 9000) else print(msg) end
end

RegisterCommand(Config.Commands.admin, function(src, args)
    if not isAdmin(src) then if src > 0 then Framework.Notify(src, Framework.Locale('admin_no_permission'), 'error') end return end
    local action = args[1] or 'help'
    if action == 'help' then adminHelp(src) return end
    local target = tonumber(args[2] or '0')
    if not target or target <= 0 then adminHelp(src) return end
    local c = Framework.GetCharacter(target)
    if action == 'show' then
        getProfile(c, function(profile)
            local msg = profile and encode(profile) or 'No spirit profile.'
            if src > 0 then Framework.Notify(src, msg, 'inform', 10000) else print(msg) end
        end)
    elseif action == 'reset' then
        if hasDb() then dbUpdate('DELETE FROM lxr_spirits_profiles WHERE char_key = ?', { characterKey(c) }) else memoryProfiles[characterKey(c)] = nil end
        Framework.Notify(target, Framework.Locale('admin_reset'), 'warning')
        if src > 0 then Framework.Notify(src, Framework.Locale('admin_reset'), 'success') end
        logRitual(c, 'admin', nil, nil, 'reset', { admin = src })
    elseif action == 'set' then
        local spiritKey = args[3]
        local spirit = Config.SpiritAnimals[spiritKey or '']
        if not spirit then if src > 0 then Framework.Notify(src, 'Invalid spirit key.', 'error') else print('Invalid spirit key') end return end
        local omenKey, omen = chooseOmen(spirit)
        local spiritName = chooseSpiritName(spiritKey)
        saveProfile(c, { spirit = spiritKey, label = spirit.label, title = spirit.title, meaning = spirit.meaning, element = spirit.element, temperament = spirit.temperament, weakness = spirit.weakness, bond = 10, omen = omenKey, spirit_name = spiritName, location_id = 'admin', metadata = { admin = src, omen = omen } })
        TriggerClientEvent('lxr-spirits:client:revealSpirit', target, spiritKey, spirit, { id = 'admin', label = 'Admin Vision', coords = GetEntityCoords(GetPlayerPed(target)), heading = 0.0 }, omenKey, omen, 'admin', 10, spiritName)
        if src > 0 then Framework.Notify(src, 'Spirit assigned.', 'success') end
    elseif action == 'bond' then
        local bond = math.max(0, math.min(100, tonumber(args[3] or 0) or 0))
        getProfile(c, function(existing)
            if not existing then if src > 0 then Framework.Notify(src, 'Target has no spirit.', 'error') end return end
            saveProfile(c, { spirit = existing.spirit, label = existing.label, title = existing.title, meaning = existing.meaning, element = existing.element, temperament = existing.temperament, weakness = existing.weakness, bond = bond, omen = existing.omen, location_id = existing.location_id, metadata = { adminBond = src } })
            if src > 0 then Framework.Notify(src, 'Bond updated.', 'success') end
        end)
    elseif action == 'cooldown' and args[4] == 'clear' then
        local ritualType = args[3] or 'initiation'
        if hasDb() then dbUpdate('DELETE FROM lxr_spirits_cooldowns WHERE char_key = ? AND ritual_type = ?', { characterKey(c), ritualType }) else memoryCooldowns[characterKey(c)..':'..ritualType] = nil end
        if src > 0 then Framework.Notify(src, 'Cooldown cleared.', 'success') end
    else
        adminHelp(src)
    end
end, false)

exports('GetPlayerSpirit', function(src)
    local p = promise.new()
    getProfile(Framework.GetCharacter(src), function(profile) p:resolve(profile) end)
    return Citizen.Await(p)
end)

exports('HasSpirit', function(src, spirit)
    local profile = exports[RESOURCE]:GetPlayerSpirit(src)
    return profile and profile.spirit == spirit
end)

exports('ResetPlayerSpirit', function(src)
    local c = Framework.GetCharacter(src)
    if hasDb() then dbUpdate('DELETE FROM lxr_spirits_profiles WHERE char_key = ?', { characterKey(c) }) else memoryProfiles[characterKey(c)] = nil end
    return true
end)

AddEventHandler('playerDropped', function()
    local src = source
    activeRituals[src] = nil
    actionWindows[src] = nil
end)

RegisterNetEvent('lxr-spirits:server:spiritConnected', function(spiritKey, ritualType)
    local src = source
    if rateLimited(src, 'connect') then return end
    local c = Framework.GetCharacter(src)
    logRitual(c, ritualType or 'unknown', nil, spiritKey, 'connected', { cinematicEncounter = true })
end)
