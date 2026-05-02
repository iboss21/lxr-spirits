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

local IS_SERVER = IsDuplicityVersion()
Framework = Framework or { Type = nil, Object = nil }

local function started(name)
    local s = GetResourceState(name)
    return s == 'started' or s == 'starting'
end

local function safeGetCore(resource)
    local ok, obj = pcall(function() return exports[resource]:GetCoreObject() end)
    if ok then return obj end
    return nil
end

function Framework.Init()
    if Config.Framework and Config.Framework ~= 'auto' then
        Framework.Type = Config.Framework
    else
        for _, r in ipairs({ 'lxr-core', 'rsg-core', 'vorp_core', 'redem_roleplay', 'qbr-core', 'qr-core' }) do
            if started(r) then Framework.Type = r break end
        end
        Framework.Type = Framework.Type or 'standalone'
    end

    if Framework.Type == 'lxr-core' then Framework.Object = safeGetCore('lxr-core')
    elseif Framework.Type == 'rsg-core' then Framework.Object = safeGetCore('rsg-core')
    elseif Framework.Type == 'qbr-core' then Framework.Object = safeGetCore('qbr-core')
    elseif Framework.Type == 'qr-core' then Framework.Object = safeGetCore('qr-core')
    elseif Framework.Type == 'redem_roleplay' then Framework.Object = safeGetCore('redem_roleplay')
    elseif Framework.Type == 'vorp_core' and exports.vorp_core then
        local ok, obj = pcall(function() return exports.vorp_core:GetCore() end)
        if ok then Framework.Object = obj end
    end

    if Config.Debug then print(('^3[lxr-spirits]^7 Framework detected: ^2%s^7'):format(tostring(Framework.Type))) end
end

CreateThread(function() Wait(250) Framework.Init() end)

function Framework.Locale(key, vars)
    local lang = Config.Lang or 'en'
    local msg = key
    if Config.Locale and Config.Locale[lang] and Config.Locale[lang][key] then msg = Config.Locale[lang][key]
    elseif Config.Locale and Config.Locale.en and Config.Locale.en[key] then msg = Config.Locale.en[key] end
    if vars then
        for k, v in pairs(vars) do msg = tostring(msg):gsub('{' .. k .. '}', tostring(v)) end
    end
    return msg
end

function Framework.Notify(a, b, c, d)
    if IS_SERVER then
        local src, msg, typ, duration = a, b, c or 'inform', d or 4500
        if not src or src <= 0 then print(('[lxr-spirits] %s'):format(msg or '')) return end
        if Framework.Type == 'vorp_core' then TriggerClientEvent('vorp:TipBottom', src, msg, duration)
        elseif Framework.Type == 'redem_roleplay' then TriggerClientEvent('redem_roleplay:Notify', src, typ, msg, duration)
        elseif started('ox_lib') then TriggerClientEvent('ox_lib:notify', src, { type = typ, description = msg, duration = duration })
        else TriggerClientEvent('chat:addMessage', src, { args = { 'lxr-spirits', msg } }) end
    else
        local msg, typ, duration = a, b or 'inform', c or 4500
        if Framework.Type == 'vorp_core' then TriggerEvent('vorp:TipBottom', msg, duration)
        elseif Framework.Type == 'redem_roleplay' then TriggerEvent('redem_roleplay:Notify', typ, msg, duration)
        elseif started('ox_lib') then exports.ox_lib:notify({ type = typ, description = msg, duration = duration })
        else TriggerEvent('chat:addMessage', { args = { 'lxr-spirits', msg } }) end
    end
end

if IS_SERVER then
    function Framework.GetPlayer(src)
        if not src then return nil end
        if (Framework.Type == 'lxr-core' or Framework.Type == 'rsg-core' or Framework.Type == 'qbr-core' or Framework.Type == 'qr-core') and Framework.Object and Framework.Object.Functions then
            return Framework.Object.Functions.GetPlayer(src)
        elseif Framework.Type == 'vorp_core' and Framework.Object then
            return Framework.Object.getUser(src)
        elseif Framework.Type == 'redem_roleplay' and Framework.Object then
            return Framework.Object.GetPlayer(src)
        end
        return { source = src, identifier = GetPlayerIdentifier(src, 0) }
    end

    function Framework.GetIdentifiers(src)
        local license, steam, discord = nil, nil, nil
        for i = 0, GetNumPlayerIdentifiers(src) - 1 do
            local id = GetPlayerIdentifier(src, i)
            if id:find('license:') == 1 then license = id elseif id:find('steam:') == 1 then steam = id elseif id:find('discord:') == 1 then discord = id end
        end
        return license or steam or ('src:' .. tostring(src)), steam, discord
    end

    function Framework.GetCharacter(src)
        local Player = Framework.GetPlayer(src)
        local identifier, steam, discord = Framework.GetIdentifiers(src)
        local data = { identifier = identifier, steam = steam, discord = discord, citizenid = nil, charid = nil, name = GetPlayerName(src) or 'Unknown', job = 'unemployed', grade = 0 }
        if (Framework.Type == 'lxr-core' or Framework.Type == 'rsg-core' or Framework.Type == 'qbr-core' or Framework.Type == 'qr-core') and Player and Player.PlayerData then
            local pd = Player.PlayerData
            local ci = pd.charinfo or {}
            local job = pd.job or {}
            data.citizenid = pd.citizenid or pd.citizenId or pd.identifier
            data.charid = pd.cid or pd.charid or data.citizenid
            data.name = ((ci.firstname or '') .. ' ' .. (ci.lastname or '')):gsub('^%s+', ''):gsub('%s+$', '')
            if data.name == '' then data.name = GetPlayerName(src) or 'Unknown' end
            data.job = job.name or 'unemployed'
            data.grade = tonumber((type(job.grade) == 'table' and (job.grade.level or job.grade.grade)) or job.grade or 0) or 0
        elseif Framework.Type == 'vorp_core' and Player and Player.getUsedCharacter then
            local ch = Player.getUsedCharacter
            data.charid = ch.charIdentifier or ch.charid or ch.identifier
            data.citizenid = data.charid
            data.name = ((ch.firstname or '') .. ' ' .. (ch.lastname or '')):gsub('^%s+', ''):gsub('%s+$', '')
            if data.name == '' then data.name = GetPlayerName(src) or 'Unknown' end
            data.job = ch.job or 'unemployed'
            data.grade = tonumber(ch.jobGrade or 0) or 0
        elseif Framework.Type == 'redem_roleplay' and Player then
            data.charid = Player.charid or Player.identifier
            data.citizenid = data.charid
            data.job = Player.job or 'unemployed'
            data.grade = tonumber(Player.jobgrade or 0) or 0
        end
        return data
    end

    function Framework.GetIdentifier(src)
        local c = Framework.GetCharacter(src)
        return c.charid or c.citizenid or c.identifier
    end

    function Framework.GetJob(src)
        local c = Framework.GetCharacter(src)
        return c.job or 'unemployed', tonumber(c.grade or 0) or 0
    end

    function Framework.HasItem(src, item, amount)
        amount = amount or 1
        if item == false or item == nil or item == '' then return true end
        local Player = Framework.GetPlayer(src)
        if (Framework.Type == 'lxr-core' or Framework.Type == 'rsg-core' or Framework.Type == 'qbr-core' or Framework.Type == 'qr-core') and Player and Player.Functions then
            local it = Player.Functions.GetItemByName(item)
            return it and tonumber(it.amount or it.count or 0) >= amount
        elseif Framework.Type == 'vorp_core' and exports.vorp_inventory then
            local ok, count = pcall(function() return exports.vorp_inventory:getItemCount(src, nil, item) end)
            return ok and tonumber(count or 0) >= amount
        elseif Framework.Type == 'redem_roleplay' and exports.redemrp_inventory then
            local ok, itemData = pcall(function() return exports.redemrp_inventory:GetItem(src, item) end)
            return ok and itemData and tonumber(itemData.ItemAmount or 0) >= amount
        end
        return Framework.Type == 'standalone'
    end

    function Framework.RemoveItem(src, item, amount)
        amount = amount or 1
        if item == false or item == nil or item == '' then return true end
        local Player = Framework.GetPlayer(src)
        if (Framework.Type == 'lxr-core' or Framework.Type == 'rsg-core' or Framework.Type == 'qbr-core' or Framework.Type == 'qr-core') and Player and Player.Functions then
            Player.Functions.RemoveItem(item, amount)
            return true
        elseif Framework.Type == 'vorp_core' and exports.vorp_inventory then
            exports.vorp_inventory:subItem(src, item, amount)
            return true
        elseif Framework.Type == 'redem_roleplay' and exports.redemrp_inventory then
            exports.redemrp_inventory:RemoveItem(src, item, amount)
            return true
        end
        return Framework.Type == 'standalone'
    end
end

_G.Framework = Framework
