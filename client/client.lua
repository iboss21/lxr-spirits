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

if GetCurrentResourceName() ~= RESOURCE then
    print(('^1[%s] FATAL: Resource name mismatch. Folder must be named exactly %s. Current: %s^7'):format(RESOURCE, RESOURCE, GetCurrentResourceName()))
    return
end

local prompt = nil
local connectPrompt = nil
local promptGroup = GetRandomIntInRange(0, 0xffffff)
local connectPromptGroup = GetRandomIntInRange(0, 0xffffff)
local currentLocation = nil
local ritualActive = false
local spawned = {}
local encounter = {
    active = false,
    stage = 'idle',
    entity = nil,
    omenEntity = nil,
    spirit = nil,
    spiritKey = nil,
    spiritName = nil,
    location = nil,
    ritualType = nil,
    bond = 0,
    omen = nil,
    omenKey = nil,
    expiresAt = 0,
    connected = false
}

local function loc(k, vars) return Framework.Locale(k, vars) end
local function notify(msg, typ) Framework.Notify(msg, typ or 'inform') end
local function hash(model) return type(model) == 'number' and model or joaat(model) end

local function setNuiCursor(enabled)
    SetNuiFocus(enabled, enabled)
    if SetNuiFocusKeepInput then
        SetNuiFocusKeepInput(enabled and (Config.NUI and Config.NUI.keepGameInput == true) or false)
    end
end

local function nui(action, data)
    SendNUIMessage({
        action = action,
        brand = Config.Brand,
        lang = Config.Lang,
        locale = {
            title = loc('nui_title'), subtitle = loc('nui_subtitle'), beginText = loc('nui_begin'),
            revealText = loc('nui_reveal'), close = loc('nui_close'), profile = loc('nui_profile')
        },
        data = data or {}
    })
end

local function closeNui()
    SendNUIMessage({ action = 'close' })
    setNuiCursor(false)
end

local function createPrompt()
    if prompt then return end
    prompt = PromptRegisterBegin()
    PromptSetControlAction(prompt, Config.Keys.interact)
    PromptSetText(prompt, CreateVarString(10, 'LITERAL_STRING', loc('prompt_start')))
    PromptSetEnabled(prompt, true)
    PromptSetVisible(prompt, true)
    PromptSetHoldMode(prompt, true)
    PromptSetGroup(prompt, promptGroup)
    PromptRegisterEnd(prompt)
end

local function createConnectPrompt()
    if connectPrompt then return end
    connectPrompt = PromptRegisterBegin()
    PromptSetControlAction(connectPrompt, Config.Keys.menu or 0x760A9C6F)
    PromptSetText(connectPrompt, CreateVarString(10, 'LITERAL_STRING', loc('prompt_connect') or 'Connect With Spirit'))
    PromptSetEnabled(connectPrompt, true)
    PromptSetVisible(connectPrompt, true)
    PromptSetHoldMode(connectPrompt, true)
    PromptSetGroup(connectPrompt, connectPromptGroup)
    PromptRegisterEnd(connectPrompt)
end

local function deletePrompt()
    if prompt then PromptDelete(prompt); prompt = nil end
    if connectPrompt then PromptDelete(connectPrompt); connectPrompt = nil end
end

local function loadModel(model)
    local h = hash(model)
    if not IsModelValid(h) then
        print(('^1[%s] Invalid model: %s^7'):format(RESOURCE, tostring(model)))
        return nil
    end
    RequestModel(h)
    local timeout = GetGameTimer() + 10000
    while not HasModelLoaded(h) and GetGameTimer() < timeout do Wait(25) end
    if not HasModelLoaded(h) then
        print(('^1[%s] Model load timeout: %s^7'):format(RESOURCE, tostring(model)))
        return nil
    end
    return h
end

local function cleanupEntities()
    for _, ent in ipairs(spawned) do
        if ent and DoesEntityExist(ent) then DeleteEntity(ent) end
    end
    spawned = {}
end

local function resetEncounter()
    encounter.active = false
    encounter.stage = 'idle'
    encounter.entity = nil
    encounter.omenEntity = nil
    encounter.spirit = nil
    encounter.spiritKey = nil
    encounter.spiritName = nil
    encounter.location = nil
    encounter.ritualType = nil
    encounter.bond = 0
    encounter.omen = nil
    encounter.omenKey = nil
    encounter.expiresAt = 0
    encounter.connected = false
end

local function safeGroundZ(x, y, z)
    for i = 1, 8 do
        local probeZ = z + 25.0 - (i * 5.0)
        local found, groundZ = GetGroundZFor_3dCoord(x, y, probeZ, false)
        if found then return groundZ end
        Wait(0)
    end
    return z
end

local function forwardCoords(distance, headingOverride)
    local ped = PlayerPedId()
    local pc = GetEntityCoords(ped)
    local hd = headingOverride or GetEntityHeading(ped)
    local x = pc.x + math.sin(math.rad(hd)) * distance
    local y = pc.y + math.cos(math.rad(hd)) * distance
    local z = safeGroundZ(x, y, pc.z)
    return vector3(x, y, z), hd
end

local function spawnObject(model, coords, heading)
    local h = loadModel(model)
    if not h then return nil end
    local obj = CreateObject(h, coords.x, coords.y, coords.z, false, false, false, false, false)
    if obj and DoesEntityExist(obj) then
        SetEntityHeading(obj, heading or 0.0)
        PlaceObjectOnGroundProperly(obj)
        FreezeEntityPosition(obj, true)
        table.insert(spawned, obj)
    end
    SetModelAsNoLongerNeeded(h)
    return obj
end

local function spawnRitualProps(locData)
    if not Config.RitualProps.enabled or not locData or locData.propSet == false then return end
    for _, p in ipairs(Config.RitualProps.objects or {}) do
        local off = p.offset or vector3(0, 0, 0)
        local c = vector3(locData.coords.x + off.x, locData.coords.y + off.y, locData.coords.z + off.z)
        spawnObject(p.model, c, (locData.heading or 0.0) + (p.heading or 0.0))
    end
end

local function setSpiritVisual(ent, alpha, scale, freeze)
    if not ent or not DoesEntityExist(ent) then return end
    SetEntityAsMissionEntity(ent, true, true)
    SetEntityInvincible(ent, true)
    SetBlockingOfNonTemporaryEvents(ent, true)
    SetPedCanRagdoll(ent, false)
    SetEntityAlpha(ent, alpha or 180, false)
    if SetPedScale and scale and scale ~= 1.0 then SetPedScale(ent, scale) end
    if freeze ~= nil then FreezeEntityPosition(ent, freeze) end
end

local function fadeEntity(ent, fromAlpha, toAlpha, steps, stepMs)
    if not ent or not DoesEntityExist(ent) then return end
    steps = steps or 10
    stepMs = stepMs or 80
    for i = 0, steps do
        if not DoesEntityExist(ent) then return end
        local a = math.floor(fromAlpha + ((toAlpha - fromAlpha) * (i / steps)))
        SetEntityAlpha(ent, a, false)
        Wait(stepMs)
    end
end

local function spawnSpiritEntity(spirit, distance, alpha, scale, freeze, headingOffset)
    if not spirit or not spirit.model then return nil end
    local h = loadModel(spirit.model)
    if not h then return nil end
    local coords, hd = forwardCoords(distance or 8.0)
    local ent = CreatePed(h, coords.x, coords.y, coords.z, hd + (headingOffset or 180.0), false, false, false, false)
    if ent and DoesEntityExist(ent) then
        PlaceEntityOnGroundProperly(ent, false)
        setSpiritVisual(ent, alpha or 160, scale or 1.0, freeze)
        table.insert(spawned, ent)
    end
    SetModelAsNoLongerNeeded(h)
    return ent
end

local function startVisionFx()
    local cin = Config.Cinematic or {}
    if cin.usePostFx then AnimpostfxPlay(cin.postFx or 'PlayerDrunk01') end
    if cin.cameraShake then ShakeGameplayCam(cin.shakeType or 'DRUNK_SHAKE', cin.shakeIntensity or 0.18) end
end

local function stopVisionFx()
    local cin = Config.Cinematic or {}
    if cin.usePostFx then AnimpostfxStop(cin.postFx or 'PlayerDrunk01') end
    if cin.cameraShake then StopGameplayCamShaking(true) end
end

local function hardCleanup()
    ritualActive = false
    ClearPedTasksImmediately(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), false)
    stopVisionFx()
    cleanupEntities()
    resetEncounter()
    closeNui()
end

-- Runs animation phases in a loop until ritualActive becomes false.
-- Phases are played in order then restart from the beginning.
local function startAnimChain(ped, phases)
    if not phases or #phases == 0 then return end
    CreateThread(function()
        local idx = 1
        while ritualActive do
            local phase = phases[idx]
            local phaseDuration = phase and phase.durationMs or 5000
            if phase and phase.scenario then
                -- Add 300ms grace so the scenario has time to start before we begin tracking duration
                TaskStartScenarioInPlace(ped, joaat(phase.scenario), phaseDuration + 300, true, false, false, false)
            end
            Wait(phaseDuration)
            if not ritualActive then break end
            ClearPedTasksImmediately(ped)
            Wait(120) -- brief pause between phases to let the engine clear the previous task
            idx = idx + 1
            if idx > #phases then idx = 1 end
        end
    end)
end

local function cancelRitual(reason)
    if not ritualActive and not encounter.active then return end
    hardCleanup()
    TriggerServerEvent('lxr-spirits:server:cancelRitual', reason or 'client_cancel')
end

local function playerBlocked()
    local ped = PlayerPedId()
    if Config.Security.blockIfDeadClientSide and IsEntityDead(ped) then notify(loc('cannot_dead'), 'error') return true end
    if Config.Security.blockIfMountedClientSide and IsPedOnMount(ped) then notify(loc('cannot_mounted'), 'error') return true end
    return false
end

local function playBondAnimation(spirit)
    local ped = PlayerPedId()
    FreezeEntityPosition(ped, true)
    ClearPedTasksImmediately(ped)
    local scenario = (Config.Encounter and Config.Encounter.bondScenario) or 'WORLD_HUMAN_PRAY'
    TaskStartScenarioInPlace(ped, joaat(scenario), 9000, true, false, false, false)
    Wait(3500)
    if encounter.entity and DoesEntityExist(encounter.entity) then
        TaskLookAtEntity(encounter.entity, ped, 4500, 0, 51, 0)
        fadeEntity(encounter.entity, 220, 40, 12, 90)
        Wait(350)
        DeleteEntity(encounter.entity)
    end
    Wait(2000)
    ClearPedTasks(ped)
    FreezeEntityPosition(ped, false)
    notify(loc('bond_complete') or 'The bond is complete.', 'success')
end

local function finishEncounter()
    if not encounter.active or encounter.stage ~= 'connect' then return end
    encounter.stage = 'bond'
    encounter.connected = true
    playBondAnimation(encounter.spirit)
    nui('reveal', {
        key = encounter.spiritKey,
        spirit = encounter.spirit,
        spirit_name = encounter.spiritName,
        location = encounter.location,
        omenKey = encounter.omenKey,
        omen = encounter.omen,
        ritualType = encounter.ritualType,
        bond = encounter.bond
    })
    if Config.NUI and Config.NUI.focusOnReveal then setNuiCursor(true) end
    if encounter.spiritName then
        notify(loc('spirit_name_revealed', { name = encounter.spiritName }) or ('The spirits have named you: ' .. encounter.spiritName), 'success')
    end
    TriggerServerEvent('lxr-spirits:server:spiritConnected', encounter.spiritKey, encounter.ritualType)
    SetTimeout((Config.Encounter and Config.Encounter.finalRevealMs) or 12000, function()
        closeNui()
        cleanupEntities()
        resetEncounter()
    end)
end

local function beginSpiritEncounter(spiritKey, spirit, locData, omenKey, omen, ritualType, bond, spiritName)
    if not Config.Cinematic.spawnSpiritPed then
        nui('reveal', { key = spiritKey, spirit = spirit, spirit_name = spiritName, location = locData, omenKey = omenKey, omen = omen, ritualType = ritualType, bond = bond })
        if Config.NUI and Config.NUI.focusOnReveal then setNuiCursor(true) end
        if spiritName then notify(loc('spirit_name_revealed', { name = spiritName }) or ('The spirits have named you: ' .. spiritName), 'success') end
        return
    end

    cleanupEntities()
    resetEncounter()
    closeNui()

    local cfg = Config.Encounter or {}
    encounter.active = true
    encounter.stage = 'omen'
    encounter.spirit = spirit
    encounter.spiritKey = spiritKey
    encounter.spiritName = spiritName
    encounter.location = locData
    encounter.ritualType = ritualType
    encounter.bond = bond or 0
    encounter.omen = omen
    encounter.omenKey = omenKey
    encounter.expiresAt = GetGameTimer() + (cfg.encounterLifetimeMs or 60000)

    local ped = PlayerPedId()
    ClearPedTasksImmediately(ped)
    FreezeEntityPosition(ped, false)
    startVisionFx()

    notify((loc('spirit_omen_message', { spirit = spirit.label }) or ('Your spirit guide is the ' .. (spirit.label or 'Spirit') .. '. It is coming to you...')), 'inform')

    local omenEnt = spawnSpiritEntity(spirit, cfg.omenDistance or 35.0, cfg.omenAlpha or 95, cfg.omenScale or 3.0, true, 180.0)
    encounter.omenEntity = omenEnt
    if omenEnt and DoesEntityExist(omenEnt) then
        TaskLookAtEntity(ped, omenEnt, cfg.omenDurationMs or 6500, 0, 51, 0)
        fadeEntity(omenEnt, 20, cfg.omenAlpha or 95, 10, 100)
        Wait(cfg.omenDurationMs or 6500)
        fadeEntity(omenEnt, cfg.omenAlpha or 95, 0, 10, 90)
        if DoesEntityExist(omenEnt) then DeleteEntity(omenEnt) end
    else
        Wait(2500)
    end

    encounter.stage = 'arrival'
    DoScreenFadeOut(cfg.transitionFadeMs or 800)
    Wait(cfg.transitionFadeMs or 800)
    local closeEnt = spawnSpiritEntity(spirit, cfg.closeDistance or 9.0, cfg.closeAlpha or 185, cfg.closeScale or 1.0, false, 180.0)
    DoScreenFadeIn(cfg.transitionFadeMs or 800)

    if not closeEnt or not DoesEntityExist(closeEnt) then
        stopVisionFx()
        nui('reveal', { key = spiritKey, spirit = spirit, spirit_name = spiritName, location = locData, omenKey = omenKey, omen = omen, ritualType = ritualType, bond = bond })
        if Config.NUI and Config.NUI.focusOnReveal then setNuiCursor(true) end
        if spiritName then notify(loc('spirit_name_revealed', { name = spiritName }) or ('The spirits have named you: ' .. spiritName), 'success') end
        SetTimeout(Config.Cinematic.spiritLifetimeMs or 22000, function() cleanupEntities(); closeNui(); resetEncounter() end)
        return
    end

    encounter.entity = closeEnt
    encounter.stage = 'connect'
    fadeEntity(closeEnt, 35, cfg.closeAlpha or 185, 12, 80)
    TaskLookAtEntity(ped, closeEnt, 8000, 0, 51, 0)
    TaskLookAtEntity(closeEnt, ped, 8000, 0, 51, 0)
    TaskWanderStandard(closeEnt, 1.0, 5)
    notify(loc('spirit_approach_message') or 'Your spirit guide awaits. Approach and make the connection.', 'success')
end

local function startLocalRitual(ritualType, locData, ritual, cinematic)
    if ritualActive or playerBlocked() then return end
    ritualActive = true
    currentLocation = locData
    local ped = PlayerPedId()
    local startCoords = GetEntityCoords(ped)

    DoScreenFadeOut(cinematic.fadeOutMs or 900)
    Wait(cinematic.fadeOutMs or 900)
    SetEntityHeading(ped, locData.heading or GetEntityHeading(ped))
    spawnRitualProps(locData)
    if cinematic.freezePlayer then FreezeEntityPosition(ped, true) end

    -- Use per-ritual animation phase sequence (loops until ritual ends)
    local phases = (Config.RitualAnimations and (Config.RitualAnimations[ritualType] or Config.RitualAnimations.default)) or {}
    if #phases > 0 then
        startAnimChain(ped, phases)
    elseif cinematic.scenario and cinematic.scenario ~= '' then
        TaskStartScenarioInPlace(ped, joaat(cinematic.scenario), ritual.durationMs or 30000, true, false, false, false)
    end

    startVisionFx()
    nui('begin', { ritual = ritual, location = locData, ritualType = ritualType })
    if Config.NUI and Config.NUI.focusOnBegin then setNuiCursor(true) end
    DoScreenFadeIn(cinematic.fadeInMs or 1200)

    local endAt = GetGameTimer() + (ritual.durationMs or 30000)
    local pulseAt = GetGameTimer() + (ritual.revealDelayMs or 18000)
    while ritualActive and GetGameTimer() < endAt do
        Wait(150)
        local coords = GetEntityCoords(ped)
        if #(coords - startCoords) > (Config.Security.maxCompleteDistance or 12.0) then cancelRitual('moved') return end
        if IsControlJustPressed(0, Config.Keys.cancel) then cancelRitual('cancel_key') return end
        if GetGameTimer() >= pulseAt then pulseAt = 999999999; nui('pulse', { ritualType = ritualType }) end
    end

    ritualActive = false
    ClearPedTasks(ped)
    FreezeEntityPosition(ped, false)
    closeNui()
    TriggerServerEvent('lxr-spirits:server:completeRitual', ritualType, locData.id)
end

RegisterNetEvent('lxr-spirits:client:startRitual', function(ritualType, locData, ritual, cinematic)
    startLocalRitual(ritualType, locData, ritual, cinematic or Config.Cinematic)
end)

RegisterNetEvent('lxr-spirits:client:revealSpirit', function(spiritKey, spirit, locData, omenKey, omen, ritualType, bond, spiritName)
    beginSpiritEncounter(spiritKey, spirit, locData, omenKey, omen, ritualType, bond, spiritName)
end)

RegisterNetEvent('lxr-spirits:client:showProfile', function(profile)
    if profile then
        -- Enrich with live config data not stored in DB
        local sa = Config.SpiritAnimals and Config.SpiritAnimals[profile.spirit]
        if sa then
            profile.icon     = sa.icon
            profile.bondBuff = sa.bondBuff
        end
        -- Resolve omen key string → omen object so NUI can render label/text
        local omenKey = profile.omen
        if omenKey and type(omenKey) == 'string' then
            profile.omen = Config.Omens and Config.Omens[omenKey] or nil
        end
    end
    nui('profile', profile)
    if not Config.NUI or Config.NUI.focusOnProfile then setNuiCursor(true) end
end)

RegisterNetEvent('lxr-spirits:client:witnessPulse', function(coords, playerName, spiritLabel)
    local my = GetEntityCoords(PlayerPedId())
    if #(my - vector3(coords.x, coords.y, coords.z)) <= (Config.General.nearbyWitnessRadius or 15.0) then
        nui('witness', { name = playerName, spirit = spiritLabel })
        if Config.NUI and Config.NUI.focusOnWitness then setNuiCursor(true) end
        if Config.Integrations.lxr_hud.enabled then TriggerEvent(Config.Integrations.lxr_hud.event, spiritLabel) end
        SetTimeout(6500, closeNui)
    end
end)

RegisterCommand('lxrspiritfixcursor', function()
    hardCleanup()
end, false)

RegisterCommand('lxrspiritclearvision', function()
    hardCleanup()
    notify('Spirit vision cleared.', 'success')
end, false)

RegisterCommand(Config.Commands.player, function()
    TriggerServerEvent('lxr-spirits:server:requestProfile')
end, false)

CreateThread(function()
    if Config.General.usePromptLocations then createPrompt() end
    createConnectPrompt()

    while true do
        local sleep = Config.Performance.idleSleepMs or 1250
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

        if encounter.active and encounter.stage == 'connect' and encounter.entity and DoesEntityExist(encounter.entity) then
            sleep = 0
            local ecoords = GetEntityCoords(encounter.entity)
            local d = #(coords - ecoords)
            if d <= ((Config.Encounter and Config.Encounter.connectDistance) or 3.2) then
                PromptSetActiveGroupThisFrame(connectPromptGroup, CreateVarString(10, 'LITERAL_STRING', loc('prompt_connect_group') or 'SPIRIT GUIDE'))
                if PromptHasHoldModeCompleted(connectPrompt) or IsControlJustPressed(0, Config.Keys.menu or 0x760A9C6F) then
                    finishEncounter()
                    Wait(1200)
                end
            end
            if GetGameTimer() > encounter.expiresAt then
                notify(loc('spirit_faded') or 'The spirit fades back into the unseen world.', 'warning')
                stopVisionFx()
                cleanupEntities()
                resetEncounter()
            end
        else
            local near = nil
            for _, l in ipairs(Config.Locations or {}) do
                local d = #(coords - l.coords)
                if d <= (l.drawDistance or Config.Performance.promptDrawDistance or 24.0) then
                    near = l
                    sleep = d <= ((l.radius or 3.0) + 3.0) and (Config.Performance.nearSleepMs or 0) or (Config.Performance.mediumSleepMs or 450)
                    if prompt and d <= (l.radius or 3.0) and not ritualActive then
                        PromptSetActiveGroupThisFrame(promptGroup, CreateVarString(10, 'LITERAL_STRING', l.label or loc('prompt_group')))
                        if PromptHasHoldModeCompleted(prompt) then
                            if not playerBlocked() then TriggerServerEvent('lxr-spirits:server:requestStart', 'initiation', l.id) end
                            Wait(1400)
                        end
                        if IsControlJustPressed(0, Config.Keys.menu) then
                            nui('menu', { location = l, ritualTypes = Config.RitualTypes })
                            if not Config.NUI or Config.NUI.focusOnMenu then setNuiCursor(true) end
                        end
                    end
                    break
                end
            end
            currentLocation = near
        end
        Wait(sleep)
    end
end)

RegisterNUICallback('close', function(_, cb) closeNui(); cb({ ok = true }) end)
RegisterNUICallback('startRitual', function(data, cb)
    closeNui()
    if currentLocation and data and data.ritualType then TriggerServerEvent('lxr-spirits:server:requestStart', data.ritualType, currentLocation.id) end
    cb({ ok = true })
end)
RegisterNUICallback('profile', function(_, cb) TriggerServerEvent('lxr-spirits:server:requestProfile'); cb({ ok = true }) end)

AddEventHandler('onResourceStop', function(res)
    if res ~= GetCurrentResourceName() then return end
    deletePrompt()
    hardCleanup()
end)
