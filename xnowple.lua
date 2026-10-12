--==================================================
-- UJAYY | RIDE A PET | ROBLOX
-- Version: V1.0.5 (Free) — V1.0.4 + BYPASS
-- Author: Xnowplee
-- Discord: https://discord.gg/6byStpCzv
--==================================================

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

-- ═══════════════════════════════════════════════════
-- SERVICES
-- ═══════════════════════════════════════════════════
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local LocalPlayer = Players.LocalPlayer

-- ═══════════════════════════════════════════════════
-- FORWARD DECLARE
-- ═══════════════════════════════════════════════════
local Window

-- ═══════════════════════════════════════════════════
-- REMOTES
-- ═══════════════════════════════════════════════════
local Remotes = ReplicatedStorage:FindFirstChild("Remotes")
local GameRemotes = Remotes and Remotes:FindFirstChild("Game")
local EggPickup = GameRemotes and GameRemotes:FindFirstChild("EggPickup")
local EggArrivalClaim = GameRemotes and GameRemotes:FindFirstChild("EggArrivalClaim") -- ⭐ BYPASS
local CollectCandy = GameRemotes and GameRemotes:FindFirstChild("CollectCandy")
local CandyState = GameRemotes and GameRemotes:FindFirstChild("CandyState")
local GetCandyState = GameRemotes and GameRemotes:FindFirstChild("GetCandyState")
local HalloweenCandyDeposited = GameRemotes and GameRemotes:FindFirstChild("HalloweenCandyDeposited")
local HalloweenCandySpoiled = GameRemotes and GameRemotes:FindFirstChild("HalloweenCandySpoiled")

local EggsData = nil
pcall(function()
    EggsData = require(ReplicatedStorage.GameData:WaitForChild("Eggs"))
end)

-- ═══════════════════════════════════════════════════
-- STATE
-- ═══════════════════════════════════════════════════
local HIDDEN_RARITY = {Common=true, Rare=true, Epic=true, Legendary=true}
local RARITY_COLOR = {
    Epic = Color3.fromRGB(180, 80, 255), Legendary = Color3.fromRGB(255, 200, 50),
    Mythic = Color3.fromRGB(255, 120, 50), Divine = Color3.fromRGB(255, 60, 60),
    Ethereal = Color3.fromRGB(255, 255, 255),
}
local RARITY_TIER = {Common=1, Rare=2, Epic=3, Legendary=4, Mythic=5, Divine=6, Ethereal=7}

local state = {
    infJump = false, speedValue = 16, jumpValue = 50,
    mutationWait = 10,
    baseEggPos = nil, baseCandyPos = nil,
    candyAutoCollect = false, candyReturnBase = true,
    candyIncludePumpkin = true, candyIncludeRitual = false,
    candyLoopMode = false, candyPickupDelay = 0.15,
    candyBetweenDelay = 1.5, candyCooldownPerCandy = 2,
    candyRunning = false,
    espEgg = false, espCandy = false, espPlayer = false, espYinYang = false,
    noclip = false,
    -- ⭐ BYPASS STATE
    useMutation = false,
    instantSpam = 20,
    instantSpamDelay = 0.05,
    instantBreakOffset = 1,
    SAFE_POS = Vector3.new(-5049, 41261, -3541),
    ALT_SAFE_POS = Vector3.new(-4990, 41274, -3649),
    TITIK_EGG = Vector3.new(-5327, 40912, -3578),
    KAWAH = Vector3.new(-5102, 41415, -3489),
    hideGarden = false, noLag = false, boostFps = false,
    webhookURL = "", webhookRarity = "Mythic",
    stats = {
        farmed = 0, skipped = 0, startTime = os.clock(),
        rarityCount = {Common=0, Rare=0, Epic=0, Legendary=0, Mythic=0, Divine=0, Ethereal=0},
        bestEgg = nil,
    },
}

local candyRespawnAt, candyAmounts, candyLastCollect = {}, {}, {}
local GLOBAL_CANDY_COOLDOWN = 0

-- ═══════════════════════════════════════════════════
-- HELPERS
-- ═══════════════════════════════════════════════════
local function GetRarity(name)
    if not EggsData then return "Common" end
    local d = EggsData[name]; return d and d.Rarity or "Common"
end
local function IsHiddenRarity(name) return HIDDEN_RARITY[GetRarity(name)] == true end
local function IsEggModel(o)
    if not o:IsA("Model") then return false end
    if o:GetAttribute("Egg") or o:GetAttribute("EggKey") then return true end
    if o:HasTag("Egg") then return true end
    return false
end
local function GetEggPos(o)
    local pos = o:GetAttribute("Position")
    if typeof(pos) == "Vector3" then return pos end
    local ok, pivot = pcall(function() return o:GetPivot() end)
    if ok and pivot then return pivot.Position end
    return nil
end
local function GetEggWeight(o)
    local w = o:GetAttribute("Weight")
    if typeof(w) == "number" then return w end
    return nil
end
local function ScanAllEggs()
    local eggs, seen = {}, {}
    local function add(o)
        if seen[o] then return end
        seen[o] = true
        local name = o:GetAttribute("Egg") or o.Name
        if IsHiddenRarity(name) then return end
        local pos = GetEggPos(o)
        if pos then
            table.insert(eggs, {model=o, name=name, pos=pos,
                weight=GetEggWeight(o) or 0, rarity=GetRarity(name)})
        end
    end
    local r = workspace:FindFirstChild("RenderedEggs")
    if r then for _, o in ipairs(r:GetChildren()) do if IsEggModel(o) then add(o) end end end
    local sd = ReplicatedStorage:FindFirstChild("ServerData")
    local ae = (sd or ReplicatedStorage):FindFirstChild("ActiveEggs")
    if ae then for _, o in ipairs(ae:GetChildren()) do
        if not o:GetAttribute("Delivering") then add(o) end
    end end
    return eggs
end
local function GetChar()
    local c = LocalPlayer.Character; if not c then return nil end
    return c:FindFirstChild("HumanoidRootPart")
end
local function GetHumanoid()
    local c = LocalPlayer.Character; if not c then return nil end
    return c:FindFirstChildOfClass("Humanoid")
end
local lastTP = 0
local function TP(pos)
    local hrp = GetChar(); if not hrp then return false end
    local now = tick()
    local waitNeeded = 0.08 + math.random() * 0.04
    if now - lastTP < waitNeeded then
        task.wait(waitNeeded - (now - lastTP))
    end
    lastTP = tick()
    hrp.CFrame = CFrame.new(pos)
    hrp.AssemblyLinearVelocity = Vector3.new(0,0,0)
    task.wait(0.1); return true
end
local function UnequipAll()
    local char = LocalPlayer.Character; if not char then return end
    local humanoid = char:FindFirstChildOfClass("Humanoid"); if not humanoid then return end
    for _, child in ipairs(char:GetChildren()) do
        if child:IsA("Tool") then humanoid:UnequipTools(); task.wait(0.05); break end
    end
    if humanoid.Sit then humanoid.Sit = false; task.wait(0.05) end
    humanoid.PlatformStand = false; task.wait(0.05)
end
local function AutoGetBaseplate()
    local ok, plot = pcall(function()
        local general = require(ReplicatedStorage.GameServices:WaitForChild("General"))
        return general:GetPlot(LocalPlayer)
    end)
    if ok and plot then
        local bp = plot:FindFirstChild("Baseplate")
        if bp then return bp.Position + Vector3.new(0, 5, 0) end
    end
    return nil
end
local function PickupEgg(eggModel)
    if not EggPickup then return false end
    return pcall(function() EggPickup:FireServer(eggModel.Name) end)
end

-- ═══════════════════════════════════════════════════
-- ⭐ BYPASS CORE
-- ═══════════════════════════════════════════════════
local function ApplyInstantBypass()
    local basket = LocalPlayer:FindFirstChild("Basket")
    if not basket then return 0 end
    local now = workspace:GetServerTimeNow()
    local count = 0
    for _, egg in ipairs(basket:GetChildren()) do
        local ok = pcall(function()
            egg:SetAttribute("VolcanoDipped", true)
            egg:SetAttribute("BreakAt", now - state.instantBreakOffset)
            egg:SetAttribute("BreakGraceSeconds", 0)
            egg:SetAttribute("BreakSeconds", 0)
        end)
        if ok then count = count + 1 end
    end
    return count
end

local function FireInstantClaim()
    if not EggArrivalClaim then return false end
    local basket = LocalPlayer:FindFirstChild("Basket")
    if not basket then return false end
    local ids = {}
    for _, egg in ipairs(basket:GetChildren()) do
        table.insert(ids, egg.Name)
    end
    if #ids == 0 then return false end
    local basePos = AutoGetBaseplate() or (GetChar() and GetChar().Position)
    if not basePos then return false end
    for i = 1, state.instantSpam do
        pcall(function()
            EggArrivalClaim:FireServer(workspace:GetServerTimeNow(), basePos, ids)
        end)
        task.wait(state.instantSpamDelay)
    end
    return true
end

-- ═══════════════════════════════════════════════════
-- NOTIF HELPER
-- ═══════════════════════════════════════════════════
local function Notif(title, content, icon, duration)
    print(string.format("[NOTIF] %s: %s", title, content))
    if not Window then return end

    local args = {
        Title = title, Content = content,
        Icon = icon or "info", Duration = duration or 3,
    }

    local ok = pcall(function() Window:Notification(args) end)
    if not ok then ok = pcall(function() Window:Notify(args) end) end
    if not ok then
        pcall(function()
            Window:Dialog({
                Title = title, Content = content,
                Buttons = { { Title = "OK", Variant = "Primary", Callback = function() end } },
            })
        end)
    end
end

-- ═══════════════════════════════════════════════════
-- WEBHOOK
-- ═══════════════════════════════════════════════════
local WebhookQueue = {items = {}, processing = false}
local function ProcessWebhookQueue()
    if WebhookQueue.processing then return end
    WebhookQueue.processing = true
    task.spawn(function()
        while #WebhookQueue.items > 0 do
            local item = table.remove(WebhookQueue.items, 1)
            pcall(function()
                HttpService:PostAsync(item.url, item.body, Enum.HttpContentType.ApplicationJson)
            end)
            task.wait(0.6)
        end
        WebhookQueue.processing = false
    end)
end
local function SendWebhook(eggName, rarity, weight)
    if not state.webhookURL or state.webhookURL == "" then return end
    if (RARITY_TIER[rarity] or 0) < (RARITY_TIER[state.webhookRarity] or 5) then return end
    local data = {
        username = "Ujayy Notifier",
        embeds = {{
            title = "Rare Egg Found!",
            color = 0x0091FF,
            fields = {
                {name="Player", value=LocalPlayer.Name, inline=true},
                {name="Egg", value=eggName, inline=true},
                {name="Rarity", value=rarity, inline=true},
                {name="Weight", value=string.format("%.1f kg", weight or 0), inline=true},
            },
            footer = {text = "Ujayy V1.0.5"},
            timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
        }}
    }
    table.insert(WebhookQueue.items, {
        url = state.webhookURL,
        body = HttpService:JSONEncode(data),
    })
    ProcessWebhookQueue()
end

-- ═══════════════════════════════════════════════════
-- VOLCANO
-- ═══════════════════════════════════════════════════
local function IsValidated()
    return LocalPlayer:GetAttribute("VolcanoValidated") == true
       and LocalPlayer:GetAttribute("InVolcano") == true
end
local function PrepareVolcano()
    local hrp = GetChar(); if not hrp then return false end
    hrp.CFrame = CFrame.new(state.SAFE_POS); hrp.AssemblyLinearVelocity = Vector3.new(0,0,0)
    local t = tick()
    while tick() - t < 2.5 do
        if IsValidated() then return true end
        task.wait(0.1)
    end
    hrp.CFrame = CFrame.new(state.ALT_SAFE_POS); hrp.AssemblyLinearVelocity = Vector3.new(0,0,0)
    t = tick()
    while tick() - t < 2.5 do
        if IsValidated() then return true end
        task.wait(0.1)
    end
    return false
end
local function TPTrigger()
    local hrp = GetChar()
    local volcano = workspace:FindFirstChild("Volcano")
    if not hrp or not volcano then return false end
    local entrance = volcano:FindFirstChild("VolcanoEntrance")
    local validate = volcano:FindFirstChild("VolcanoValidate")
    if not entrance or not validate then return false end
    hrp.CFrame = CFrame.new(entrance.Position + Vector3.new(0, 5, 0))
    hrp.AssemblyLinearVelocity = Vector3.new(0,0,0); task.wait(0.3)
    hrp.CFrame = CFrame.new(validate.Position + Vector3.new(0, 5, 0))
    hrp.AssemblyLinearVelocity = Vector3.new(0,0,0); task.wait(0.3)
    return true
end
local function CariEgg(keyword)
    local r = workspace:FindFirstChild("RenderedEggs")
    if r then
        for _, o in ipairs(r:GetChildren()) do
            local name = o:GetAttribute("Egg") or o.Name
            if string.find(string.lower(name), string.lower(keyword)) then
                local pos = o:GetAttribute("Position")
                if not pos then
                    local ok, p = pcall(function() return o:GetPivot().Position end)
                    pos = ok and p
                end
                if pos then return {model=o, pos=pos, name=name, weight=GetEggWeight(o) or 0, rarity=GetRarity(name)} end
            end
        end
    end
    local sd = ReplicatedStorage:FindFirstChild("ServerData") or ReplicatedStorage
    local ae = sd:FindFirstChild("ActiveEggs")
    if ae then
        for _, o in ipairs(ae:GetChildren()) do
            local name = o:GetAttribute("Egg") or o.Name
            if string.find(string.lower(name), string.lower(keyword)) then
                local pos = o:GetAttribute("Position")
                if pos then return {model=o, pos=pos, name=name, weight=GetEggWeight(o) or 0, rarity=GetRarity(name)} end
            end
        end
    end
    return nil
end
local function RecordFarm(egg)
    state.stats.farmed = state.stats.farmed + 1
    local r = egg.rarity or "Common"
    state.stats.rarityCount[r] = (state.stats.rarityCount[r] or 0) + 1
    local w = egg.weight or 0
    if not state.stats.bestEgg or (RARITY_TIER[r] or 0) > (RARITY_TIER[state.stats.bestEgg.rarity] or 0)
       or ((RARITY_TIER[r] or 0) == (RARITY_TIER[state.stats.bestEgg.rarity] or 0) and w > (state.stats.bestEgg.weight or 0)) then
        state.stats.bestEgg = {name = egg.name, rarity = r, weight = w}
    end
    Notif("Egg Farmed!", string.format("[%s] %s (%.1f kg)", r, egg.name, w), "star", 3)
    task.spawn(function() SendWebhook(egg.name, r, w) end)
end

-- ═══════════════════════════════════════════════════
-- PROCESS EGG (⭐ 2 MODE)
-- ═══════════════════════════════════════════════════
local function ProcessNormalEgg(egg)
    UnequipAll(); task.wait(0.1)

    -- 1. TP ke egg
    TP(egg.pos + Vector3.new(0, 3, 0)); task.wait(0.3)

    -- 2. Pickup egg
    PickupEgg(egg.model); task.wait(0.5)

    -- 3. Tunggu egg masuk basket
    local basket = LocalPlayer:FindFirstChild("Basket")
    local waitStart = tick()
    while tick() - waitStart < 3 do
        if basket and #basket:GetChildren() > 0 then break end
        task.wait(0.1)
    end

    -- 4. Cek mode
    if state.useMutation then
        -- ⭐ MODE MUTASI KAWAH (AMAN)
        print("[FARM] Mode: MUTASI KAWAH")
        TP(state.KAWAH + Vector3.new(0, 10, 0)); task.wait(0.2)
        local volcano = workspace:FindFirstChild("Volcano")
        local vTop = volcano and volcano:FindFirstChild("VolcanoTop")
        if vTop then TP(vTop.Position + Vector3.new(0, 30, 0)) end
        task.wait(state.mutationWait)
        if not state.baseEggPos then state.baseEggPos = AutoGetBaseplate() end
        if state.baseEggPos then TP(state.baseEggPos) end
        task.wait(0.3)
        if EggArrivalClaim and basket and state.baseEggPos then
            local ids = {}
            for _, e in ipairs(basket:GetChildren()) do
                table.insert(ids, e.Name)
            end
            if #ids > 0 then
                pcall(function()
                    EggArrivalClaim:FireServer(workspace:GetServerTimeNow(), state.baseEggPos, ids)
                end)
            end
        end
    else
        -- ⭐ MODE INSTANT BYPASS
        print("[FARM] Mode: INSTANT BYPASS")
        local count = ApplyInstantBypass()
        print("[BYPASS] Spoof", count, "egg")
        task.wait(0.2)
        if not state.baseEggPos then state.baseEggPos = AutoGetBaseplate() end
        if state.baseEggPos then TP(state.baseEggPos) end
        task.wait(0.3)
        local ok = FireInstantClaim()
        print("[BYPASS] Claim:", ok)
    end

    RecordFarm(egg)
end
local function ProcessVolcanicEgg()
    local hrp = GetChar(); if not hrp then return end
    UnequipAll(); task.wait(0.05)
    local egg = nil
    local startT = tick()
    while tick() - startT < 300 do
        egg = CariEgg("volcanic")
        if egg then break end
        task.wait(0.5)
    end
    if not egg then return end
    TPTrigger(); task.wait(1.5)
    local ok = IsValidated() or PrepareVolcano()
    if not ok then return end
    TP(egg.pos + Vector3.new(0, 3, 0)); task.wait(0.4)
    PickupEgg(egg.model)
    task.wait(0.5)

    local basket = LocalPlayer:FindFirstChild("Basket")

    if state.useMutation then
        -- Mode mutasi
        if not state.baseEggPos then state.baseEggPos = AutoGetBaseplate() end
        if state.baseEggPos then TP(state.baseEggPos) else TP(state.KAWAH + Vector3.new(0, 10, 0)) end
        task.wait(0.3)
        local volcano = workspace:FindFirstChild("Volcano")
        local vTop = volcano and volcano:FindFirstChild("VolcanoTop")
        if vTop then TP(vTop.Position + Vector3.new(0, 30, 0)) else TP(state.KAWAH + Vector3.new(0, 10, 0)) end
        task.wait(state.mutationWait)
        if state.baseEggPos then TP(state.baseEggPos) end
    else
        -- Mode instant
        ApplyInstantBypass(); task.wait(0.2)
        if not state.baseEggPos then state.baseEggPos = AutoGetBaseplate() end
        if state.baseEggPos then TP(state.baseEggPos) end
        task.wait(0.3)
        FireInstantClaim()
    end

    RecordFarm(egg)
end

-- ═══════════════════════════════════════════════════
-- FARM LOGIC
-- ═══════════════════════════════════════════════════
local FarmSingle = { selectedEggObj = nil, isRunning = false }
function FarmSingle.SelectEgg(eggName)
    FarmSingle.selectedEggObj = nil
    for _, e in ipairs(ScanAllEggs()) do
        if e.name == eggName then FarmSingle.selectedEggObj = e; break end
    end
end
function FarmSingle.Clear() FarmSingle.selectedEggObj = nil end
function FarmSingle.Start()
    if not FarmSingle.selectedEggObj then return end
    if FarmSingle.isRunning then return end
    local hrp = GetChar(); if hrp then state.baseEggPos = hrp.Position end
    FarmSingle.isRunning = true
    task.spawn(function()
        local egg = FarmSingle.selectedEggObj
        if string.find(string.lower(egg.name), "volcanic") then
            ProcessVolcanicEgg()
        else
            ProcessNormalEgg(egg)
        end
        FarmSingle.isRunning = false
    end)
end
function FarmSingle.Stop() FarmSingle.isRunning = false end

local SmartFarm = {
    mode = false, running = false,
    filterRarity = {Epic=true, Legendary=true, Mythic=true, Divine=true, Ethereal=true},
    minWeight = 0, priority = "Rarity", cycleDelay = 2,
}
function SmartFarm.Pick()
    local eggs = ScanAllEggs()
    local filtered = {}
    for _, e in ipairs(eggs) do
        if SmartFarm.filterRarity[e.rarity] and (e.weight or 0) >= SmartFarm.minWeight then
            table.insert(filtered, e)
        else
            state.stats.skipped = state.stats.skipped + 1
        end
    end
    if #filtered == 0 then return nil end
    local hrp = GetChar()
    if SmartFarm.priority == "Rarity" then
        table.sort(filtered, function(a, b)
            return (RARITY_TIER[a.rarity] or 0) > (RARITY_TIER[b.rarity] or 0)
        end)
    elseif SmartFarm.priority == "Weight" then
        table.sort(filtered, function(a, b) return (a.weight or 0) > (b.weight or 0) end)
    elseif SmartFarm.priority == "Nearest" and hrp then
        table.sort(filtered, function(a, b)
            return (a.pos - hrp.Position).Magnitude < (b.pos - hrp.Position).Magnitude
        end)
    end
    return filtered[1]
end
function SmartFarm.Start()
    if SmartFarm.running then return end
    SmartFarm.mode = true
    SmartFarm.running = true
    if not state.baseEggPos then
        local bp = AutoGetBaseplate()
        if bp then state.baseEggPos = bp end
    end
    task.spawn(function()
        while SmartFarm.mode do
            local target = SmartFarm.Pick()
            if target then ProcessNormalEgg(target) end
            task.wait(SmartFarm.cycleDelay)
        end
        SmartFarm.running = false
    end)
end
function SmartFarm.Stop() SmartFarm.mode = false end

-- ═══════════════════════════════════════════════════
-- CANDY LOGIC
-- ═══════════════════════════════════════════════════
local function CandyApplySnapshot()
    if not GetCandyState then return end
    local ok, result = pcall(function() return GetCandyState:InvokeServer() end)
    if not ok or type(result) ~= "table" then return end
    if type(result.RespawnAt) == "table" then
        for id, t in pairs(result.RespawnAt) do
            if type(id) == "string" and type(t) == "number" then candyRespawnAt[id] = t end
        end
    end
    if type(result.Amounts) == "table" then
        for id, amt in pairs(result.Amounts) do
            if type(id) == "string" and type(amt) == "number" then candyAmounts[id] = amt end
        end
    end
end

if CandyState then
    CandyState.OnClientEvent:Connect(function(id, respawnAt, amount)
        if type(id) == "string" then
            candyRespawnAt[id] = respawnAt
            if type(amount) == "number" then candyAmounts[id] = amount end
        end
    end)
end

if HalloweenCandyDeposited then
    HalloweenCandyDeposited.OnClientEvent:Connect(function()
        GLOBAL_CANDY_COOLDOWN = os.clock()
    end)
end

if HalloweenCandySpoiled then
    HalloweenCandySpoiled.OnClientEvent:Connect(function()
        print("[Candy] Bag penuh! Stop sementara...")
        state.candyAutoCollect = false
        state.candyRunning = false
        Notif("Bag Penuh!", "Candy gak bisa dipickup, deposit dulu.", "alert-triangle", 4)
    end)
end

local function FindCandyList()
    local list = {}
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj:HasTag("HalloweenCandySpawn") then
            local isRitual = obj:GetAttribute("RitualDrop") == true
            local isPumpkin = obj:GetAttribute("PumpkinDrop") == true
            local skip = (isRitual and not state.candyIncludeRitual)
                      or (isPumpkin and not state.candyIncludePumpkin)
            if not skip then
                local id = obj:GetAttribute("Id")
                if type(id) ~= "string" or id == "" then id = obj:GetFullName() end
                table.insert(list, {
                    part = obj,
                    id = id,
                    pos = obj.Position,
                    isRitual = isRitual,
                    isPumpkin = isPumpkin,
                })
            end
        end
    end
    return list
end

local function IsCandyAvailable(candy)
    if LocalPlayer:GetAttribute("InHalloweenZone") ~= true then return false end
    local noSave = LocalPlayer:FindFirstChild("NoSaveData")
    local carried = noSave and noSave:FindFirstChild("CarriedCandy")
    if carried and carried:IsA("IntValue") and carried.Value > 0 then
        return false
    end
    local now = os.clock()
    local serverNow = workspace:GetServerTimeNow()
    local respawnAt = candyRespawnAt[candy.id]
    if respawnAt and serverNow < respawnAt then return false end
    local last = candyLastCollect[candy.id]
    if last and (now - last) < state.candyCooldownPerCandy then return false end
    if now < GLOBAL_CANDY_COOLDOWN then return false end
    return true
end

local function CollectOneCandy(candy)
    local hrp = GetChar(); if not hrp then return false end
    if not IsCandyAvailable(candy) then return false end
    hrp.CFrame = CFrame.new(candy.pos + Vector3.new(0, 3, 0))
    hrp.AssemblyLinearVelocity = Vector3.new(0,0,0)
    task.wait(state.candyPickupDelay)
    local ok = pcall(function() CollectCandy:FireServer(candy.id) end)
    if not ok then return false end
    local now = os.clock()
    candyLastCollect[candy.id] = now
    GLOBAL_CANDY_COOLDOWN = now + 2
    return true
end

local function ReturnToBaseCandy()
    if not state.baseCandyPos then state.baseCandyPos = AutoGetBaseplate() end
    if not state.baseCandyPos then return false end
    local hrp = GetChar(); if not hrp then return false end
    hrp.CFrame = CFrame.new(state.baseCandyPos)
    hrp.AssemblyLinearVelocity = Vector3.new(0,0,0)
    task.wait(0.3); return true
end

local function CandyCycleLoop()
    if state.candyRunning then return end
    state.candyRunning = true
    task.spawn(function()
        repeat
            local noSave = LocalPlayer:FindFirstChild("NoSaveData")
            local carried = noSave and noSave:FindFirstChild("CarriedCandy")
            if carried and carried.Value > 0 then
                task.wait(1)
            else
                local candies = FindCandyList()
                local hrp = GetChar()
                if hrp then
                    table.sort(candies, function(a, b)
                        return (a.pos - hrp.Position).Magnitude < (b.pos - hrp.Position).Magnitude
                    end)
                end
                local target = nil
                for _, candy in ipairs(candies) do
                    if IsCandyAvailable(candy) then target = candy; break end
                end
                if target then
                    CollectOneCandy(target)
                    if state.candyReturnBase then ReturnToBaseCandy() end
                    task.wait(state.candyBetweenDelay)
                else
                    task.wait(1)
                end
            end
            if not state.candyAutoCollect then break end
        until not state.candyAutoCollect
        state.candyRunning = false
    end)
end

-- ═══════════════════════════════════════════════════
-- ESP
-- ═══════════════════════════════════════════════════
local RenderedEggESP, RenderedCandyESP, RenderedPlayerESP, RenderedYinYangESP = {}, {}, {}, {}

local function ClearTable(tbl)
    for k, data in pairs(tbl) do
        if data.Highlight then pcall(function() data.Highlight:Destroy() end) end
        if data.Billboard then pcall(function() data.Billboard:Destroy() end) end
        if data.Anchor then pcall(function() data.Anchor:Destroy() end) end
        tbl[k] = nil
    end
end

local function BuildEggESP(eggData)
    if RenderedEggESP[eggData.model] then return end
    local pos = eggData.pos; if not pos then return end
    local color = RARITY_COLOR[eggData.rarity] or Color3.fromRGB(255, 30, 30)
    local weightStr = eggData.weight and eggData.weight > 0 and (" W:" .. string.format("%.1f", eggData.weight)) or ""
    local hl = Instance.new("Highlight")
    hl.FillTransparency = 0.7; hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.FillColor = color; hl.OutlineColor = color
    hl.Adornee = eggData.model; hl.Parent = eggData.model
    local anchor = Instance.new("Part")
    anchor.Anchored = true; anchor.CanCollide = false
    anchor.CanQuery = false; anchor.CanTouch = false
    anchor.Transparency = 1; anchor.Size = Vector3.new(0.5, 0.5, 0.5)
    anchor.Position = pos; anchor.Parent = workspace
    local bb = Instance.new("BillboardGui")
    bb.Size = UDim2.new(0, 200, 0, 60); bb.StudsOffset = Vector3.new(0, 3, 0)
    bb.AlwaysOnTop = true; bb.MaxDistance = 999999
    bb.Adornee = anchor; bb.Parent = anchor
    local nL = Instance.new("TextLabel")
    nL.Size = UDim2.new(1, 0, 0.5, 0); nL.BackgroundTransparency = 1
    nL.Text = "[" .. eggData.rarity .. "] " .. eggData.name .. weightStr
    nL.TextColor3 = color; nL.TextStrokeTransparency = 0.3
    nL.Font = Enum.Font.GothamBold; nL.TextSize = 13; nL.Parent = bb
    local dL = Instance.new("TextLabel")
    dL.Size = UDim2.new(1, 0, 0.5, 0); dL.Position = UDim2.new(0, 0, 0.5, 0)
    dL.BackgroundTransparency = 1; dL.Text = "0m"
    dL.TextColor3 = Color3.fromRGB(255, 255, 255)
    dL.TextStrokeTransparency = 0.5; dL.Font = Enum.Font.Gotham
    dL.TextSize = 11; dL.Parent = bb
    RenderedEggESP[eggData.model] = {Highlight=hl, Billboard=bb, Anchor=anchor, Dist=dL}
end

local function RefreshEggESP()
    if not state.espEgg then ClearTable(RenderedEggESP); return end
    for _, e in ipairs(ScanAllEggs()) do BuildEggESP(e) end
    for egg, data in pairs(RenderedEggESP) do
        if egg.Parent then
            local pos = GetEggPos(egg)
            if pos and data.Anchor then data.Anchor.Position = pos end
        else
            if data.Highlight then data.Highlight:Destroy() end
            if data.Billboard then data.Billboard:Destroy() end
            if data.Anchor then data.Anchor:Destroy() end
            RenderedEggESP[egg] = nil
        end
    end
end

local function BuildCandyESP(candy)
    if RenderedCandyESP[candy.part] then return end
    local color = Color3.fromRGB(255, 130, 30)
    if candy.isRitual then
        color = Color3.fromRGB(180, 80, 255)
    elseif candy.isPumpkin then
        color = Color3.fromRGB(255, 200, 50)
    end
    local hl = Instance.new("Highlight")
    hl.FillTransparency = 0.6; hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.FillColor = color; hl.OutlineColor = color
    hl.Adornee = candy.part; hl.Parent = candy.part
    local bb = Instance.new("BillboardGui")
    bb.Size = UDim2.new(0, 150, 0, 40); bb.StudsOffset = Vector3.new(0, 3, 0)
    bb.AlwaysOnTop = true; bb.MaxDistance = 999999
    bb.Adornee = candy.part; bb.Parent = candy.part
    local nameL = Instance.new("TextLabel")
    nameL.Size = UDim2.new(1, 0, 0.5, 0); nameL.BackgroundTransparency = 1
    nameL.Text = "Candy"; nameL.TextColor3 = color
    nameL.TextStrokeTransparency = 0.3; nameL.Font = Enum.Font.GothamBold
    nameL.TextSize = 12; nameL.Parent = bb
    local distL = Instance.new("TextLabel")
    distL.Size = UDim2.new(1, 0, 0.5, 0); distL.Position = UDim2.new(0, 0, 0.5, 0)
    distL.BackgroundTransparency = 1; distL.Text = "0m"
    distL.TextColor3 = Color3.fromRGB(255, 255, 255)
    distL.TextStrokeTransparency = 0.5; distL.Font = Enum.Font.Gotham
    distL.TextSize = 11; distL.Parent = bb
    RenderedCandyESP[candy.part] = {Highlight=hl, Billboard=bb, Dist=distL, Part=candy.part}
end

local function RefreshCandyESP()
    if not state.espCandy then ClearTable(RenderedCandyESP); return end
    local current = {}
    for _, c in ipairs(FindCandyList()) do
        current[c.part] = true
        BuildCandyESP(c)
    end
    for part, data in pairs(RenderedCandyESP) do
        if not current[part] or not part.Parent then
            if data.Highlight then data.Highlight:Destroy() end
            if data.Billboard then data.Billboard:Destroy() end
            RenderedCandyESP[part] = nil
        end
    end
end

local function BuildPlayerESP(plr)
    if plr == LocalPlayer then return end
    if RenderedPlayerESP[plr] then return end
    local char = plr.Character; if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
    local hl = Instance.new("Highlight")
    hl.FillTransparency = 0.7; hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.FillColor = Color3.fromRGB(255, 60, 60)
    hl.OutlineColor = Color3.fromRGB(255, 60, 60)
    hl.Adornee = char; hl.Parent = char
    local bb = Instance.new("BillboardGui")
    bb.Size = UDim2.new(0, 200, 0, 50); bb.StudsOffset = Vector3.new(0, 3, 0)
    bb.AlwaysOnTop = true; bb.MaxDistance = 999999
    bb.Adornee = hrp; bb.Parent = hrp
    local nL = Instance.new("TextLabel")
    nL.Size = UDim2.new(1, 0, 0.5, 0); nL.BackgroundTransparency = 1
    nL.Text = plr.Name; nL.TextColor3 = Color3.fromRGB(255, 60, 60)
    nL.TextStrokeTransparency = 0.3; nL.Font = Enum.Font.GothamBold
    nL.TextSize = 13; nL.Parent = bb
    local dL = Instance.new("TextLabel")
    dL.Size = UDim2.new(1, 0, 0.5, 0); dL.Position = UDim2.new(0, 0, 0.5, 0)
    dL.BackgroundTransparency = 1; dL.Text = "0m"
    dL.TextColor3 = Color3.fromRGB(255, 255, 255)
    dL.TextStrokeTransparency = 0.5; dL.Font = Enum.Font.Gotham
    dL.TextSize = 11; dL.Parent = bb
    RenderedPlayerESP[plr] = {Highlight=hl, Billboard=bb, Dist=dL, Char=char}
end

local function RefreshPlayerESP()
    if not state.espPlayer then ClearTable(RenderedPlayerESP); return end
    for _, plr in ipairs(Players:GetPlayers()) do BuildPlayerESP(plr) end
    for plr, data in pairs(RenderedPlayerESP) do
        if not plr.Parent or not plr.Character or plr.Character ~= data.Char then
            if data.Highlight then data.Highlight:Destroy() end
            if data.Billboard then data.Billboard:Destroy() end
            RenderedPlayerESP[plr] = nil
        end
    end
end

-- ═══ ESP YINYANG ═══
local function FindYinYangSockets()
    local list, seen = {}, {}
    local function add(obj)
        if seen[obj] or not obj:IsA("BasePart") then return end
        local n = obj.Name
        if n == "YinSocket" or n == "YangSocket" then
            seen[obj] = true
            table.insert(list, obj)
        end
    end
    local rsv = workspace:FindFirstChild("RitualSealVisuals")
    if rsv then for _, obj in ipairs(rsv:GetDescendants()) do add(obj) end end
    for _, obj in ipairs(workspace:GetDescendants()) do add(obj) end
    return list
end

local function BuildYinYangESP(socket)
    if RenderedYinYangESP[socket] then return end
    if not socket.Parent then return end
    local isYin = socket.Name == "YinSocket"
    local color = isYin and Color3.fromRGB(80, 120, 255) or Color3.fromRGB(255, 220, 80)
    local label = isYin and "YIN SOCKET" or "YANG SOCKET"

    local hl = Instance.new("Highlight")
    hl.FillTransparency = 0.5
    hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.FillColor = color
    hl.OutlineColor = color
    hl.Adornee = socket
    hl.Parent = socket

    local bb = Instance.new("BillboardGui")
    bb.Size = UDim2.new(0, 140, 0, 40)
    bb.StudsOffset = Vector3.new(0, 4, 0)
    bb.AlwaysOnTop = true
    bb.MaxDistance = 999999
    bb.Adornee = socket
    bb.Parent = socket

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0.5, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = label
    lbl.TextColor3 = color
    lbl.TextStrokeTransparency = 0.3
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 14
    lbl.Parent = bb

    local distL = Instance.new("TextLabel")
    distL.Size = UDim2.new(1, 0, 0.5, 0)
    distL.Position = UDim2.new(0, 0, 0.5, 0)
    distL.BackgroundTransparency = 1
    distL.Text = "0m"
    distL.TextColor3 = Color3.fromRGB(255, 255, 255)
    distL.TextStrokeTransparency = 0.5
    distL.Font = Enum.Font.Gotham
    distL.TextSize = 11
    distL.Parent = bb

    RenderedYinYangESP[socket] = {Highlight=hl, Billboard=bb, Dist=distL, Socket=socket}
end

local function RefreshYinYangESP()
    if not state.espYinYang then
        for k, data in pairs(RenderedYinYangESP) do
            if data.Highlight then pcall(function() data.Highlight:Destroy() end) end
            if data.Billboard then pcall(function() data.Billboard:Destroy() end) end
            RenderedYinYangESP[k] = nil
        end
        return
    end
    local current = {}
    for _, socket in ipairs(FindYinYangSockets()) do
        current[socket] = true
        BuildYinYangESP(socket)
    end
    for sock, data in pairs(RenderedYinYangESP) do
        if not current[sock] or not sock.Parent then
            if data.Highlight then pcall(function() data.Highlight:Destroy() end) end
            if data.Billboard then pcall(function() data.Billboard:Destroy() end) end
            RenderedYinYangESP[sock] = nil
        end
    end
end

-- ═══════════════════════════════════════════════════
-- CREATE WINDOW
-- ═══════════════════════════════════════════════════
Window = WindUI:CreateWindow({
    Title = "Ujayy | Ride A Pet | Roblox",
    Icon = "rbxassetid://94929645863607",
    Author = "by Xnowplee",
    Folder = "Ujayy",
    Size = UDim2.fromOffset(580, 460),
    Transparent = true,
    Theme = "Dark",
    User = { Enabled = true, Anonymous = false },
    SideBarWidth = 180,
})

print("[Ujayy] Window created — V1.0.5 (Free)")

-- ═══════════════════════════════════════════════════
-- TAB 1: MAIN SCRIPT
-- ═══════════════════════════════════════════════════
local MainTab = Window:Tab({ Title = "Main Script", Icon = "house", Desc = "Movement & Utility" })

local AuthorSection = MainTab:Section({ Title = "Author", Opened = true })
AuthorSection:Paragraph({ Title = "Xnowplee", Desc = "Script Developer | V1.0.5 (Free) | discord.gg/6byStpCzv" })

local MoveSection = MainTab:Section({ Title = "Movement" })
local infJumpToggle = MoveSection:Toggle({
    Title = "Infinite Jump", Desc = "Enable infinite jump", Value = false,
    Callback = function(v) state.infJump = v end,
})
local speedSlider = MoveSection:Slider({
    Title = "Speed Control", Desc = "Adjust walk speed",
    Value = { Min = 16, Max = 200, Default = 16 },
    Callback = function(v)
        state.speedValue = v
        local hum = GetHumanoid(); if hum then hum.WalkSpeed = v end
    end,
})
local jumpSlider = MoveSection:Slider({
    Title = "Jump Control", Desc = "Adjust jump power",
    Value = { Min = 50, Max = 500, Default = 50 },
    Callback = function(v)
        state.jumpValue = v
        local hum = GetHumanoid(); if hum then hum.JumpPower = v end
    end,
})
MoveSection:Button({
    Title = "Reset Semua", Desc = "Reset speed, jump, inf jump",
    Callback = function()
        state.infJump = false; state.speedValue = 16; state.jumpValue = 50
        local hum = GetHumanoid()
        if hum then hum.WalkSpeed = 16; hum.JumpPower = 50 end
        if infJumpToggle then infJumpToggle:Set(false) end
        if speedSlider then speedSlider:Set(16) end
        if jumpSlider then jumpSlider:Set(50) end
    end,
})
UserInputService.JumpRequest:Connect(function()
    if state.infJump then
        local hum = GetHumanoid(); if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end)

-- ═══════════════════════════════════════════════════
-- TAB 2: FARM
-- ═══════════════════════════════════════════════════
local FarmTab = Window:Tab({ Title = "Farm", Icon = "pickaxe", Desc = "Farm Single + Volcanic" })

-- ⭐ MODE TOGGLE (BYPASS)
local ModeSection = FarmTab:Section({ Title = "Mode Farm", Opened = true })
local modeToggle = ModeSection:Toggle({
    Title = "Mutasi Kawah Dulu",
    Desc = "ON = Mutasi kawah (aman) | OFF = Instant bypass",
    Value = false,
    Callback = function(v)
        state.useMutation = v
        print("[Ujayy] Mode:", v and "MUTASI KAWAH" or "INSTANT BYPASS")
        Notif("Mode Farm", v and "Mutasi Kawah" or "Instant Bypass", "settings", 2)
    end,
})
ModeSection:Paragraph({
    Title = "Info Mode",
    Desc = "ON = Pickup → Drop kawah → Tunggu → Balik → Claim\nOFF = Pickup → Spoof Attribute → Balik → Spam Claim",
})

local BypassSection = FarmTab:Section({ Title = "Bypass Settings" })
BypassSection:Slider({
    Title = "Spam Claim Count",
    Value = { Min = 1, Max = 50, Default = 20 },
    Callback = function(v) state.instantSpam = v end,
})
BypassSection:Slider({
    Title = "Spam Delay (s)",
    Value = { Min = 0.02, Max = 0.5, Default = 0.05, Decimals = 2 },
    Callback = function(v) state.instantSpamDelay = v end,
})
BypassSection:Slider({
    Title = "BreakAt Offset (s)",
    Value = { Min = 0.5, Max = 30, Default = 1 },
    Callback = function(v) state.instantBreakOffset = v end,
})

local FarmSection = FarmTab:Section({ Title = "Farm Single", Opened = true })

local function getEggOptions()
    local opts = {}
    for _, e in ipairs(ScanAllEggs()) do
        local w = e.weight and e.weight > 0 and string.format(" W:%.1f", e.weight) or ""
        table.insert(opts, "["..e.rarity.."] "..e.name..w)
    end
    return opts
end

local eggDropdown = FarmSection:Dropdown({
    Title = "Pilih Egg", Values = getEggOptions(), Value = nil,
    Callback = function(opt)
        local cleanName = opt:gsub("^%[%w+%]%s*", ""):gsub(" W:[%d%.]+", ""):gsub(" W:", "")
        FarmSingle.SelectEgg(cleanName)
    end,
})
FarmSection:Button({
    Title = "Refresh Egg List (Reset)",
    Callback = function()
        FarmSingle.Clear()
        eggDropdown:Refresh(getEggOptions())
    end,
})
FarmSection:Button({ Title = "Start Farm (1x)", Callback = function() FarmSingle.Start() end })
FarmSection:Button({ Title = "Stop Farm", Callback = function() FarmSingle.Stop() end })

local VolcanicSection = FarmTab:Section({ Title = "Volcanic" })
local noclipToggle = VolcanicSection:Toggle({
    Title = "Enable Noclip", Desc = "Anti-collision", Value = false,
    Callback = function(v)
        state.noclip = v
        local char = LocalPlayer.Character
        if not char then return end
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide ~= nil then
                if v then part.CanCollide = false
                elseif part.Name ~= "HumanoidRootPart" then part.CanCollide = true end
            end
        end
    end,
})
VolcanicSection:Button({ Title = "TP ke TITIK EGG", Callback = function() TP(state.TITIK_EGG + Vector3.new(0, 5, 0)) end })
VolcanicSection:Button({ Title = "Test PrepareVolcano", Callback = function()
    local ok = PrepareVolcano()
    print("[Ujayy] Volcanic:", ok and "Prepare OK" or "Prepare GAGAL")
end })

task.spawn(function() while task.wait(5) do pcall(function() eggDropdown:Refresh(getEggOptions()) end) end end)

-- ═══════════════════════════════════════════════════
-- TAB 3: SMART FARM
-- ═══════════════════════════════════════════════════
local SmartTab = Window:Tab({ Title = "Smart Farm", Icon = "sparkles", Desc = "Auto Cycle + Filter" })

local SmartSection = SmartTab:Section({ Title = "Smart Farm", Opened = true })
local smartToggle = SmartSection:Toggle({
    Title = "Enable Smart Auto Farm", Desc = "Auto cycle farm", Value = false,
    Callback = function(v) if v then SmartFarm.Start() else SmartFarm.Stop() end end,
})

local FilterSection = SmartTab:Section({ Title = "Filter Rarity" })
FilterSection:Dropdown({
    Title = "Rarity yang di-farm",
    Values = {"Epic", "Legendary", "Mythic", "Divine", "Ethereal"},
    Value = "Epic",
    Callback = function(opt) SmartFarm.filterRarity = {[opt] = true} end,
})
local minWeightSlider = FilterSection:Slider({
    Title = "Min Weight", Desc = "Filter berat minimum",
    Value = { Min = 0, Max = 500, Default = 0 },
    Callback = function(v) SmartFarm.minWeight = v end,
})

local PrioritySection = SmartTab:Section({ Title = "Priority" })
PrioritySection:Dropdown({
    Title = "Priority Mode",
    Values = {"Rarity", "Weight", "Nearest"},
    Value = "Rarity",
    Callback = function(opt) SmartFarm.priority = opt end,
})
local cycleDelaySlider = PrioritySection:Slider({
    Title = "Cycle Delay", Desc = "Jeda antar siklus (detik)",
    Value = { Min = 0.5, Max = 10, Default = 2 },
    Callback = function(v) SmartFarm.cycleDelay = v end,
})

-- ═══════════════════════════════════════════════════
-- TAB 4: FARM CANDY
-- ═══════════════════════════════════════════════════
local CandyTab = Window:Tab({ Title = "Farm Candy", Icon = "candy", Desc = "Auto Collect Candy" })

local CandySection = CandyTab:Section({ Title = "Auto Candy", Opened = true })
local candyAutoToggle = CandySection:Toggle({
    Title = "Auto Collect Candy", Value = false,
    Callback = function(v)
        state.candyAutoCollect = v
        if v then
            if not state.baseCandyPos then
                local bp = AutoGetBaseplate()
                if bp then state.baseCandyPos = bp end
            end
            CandyApplySnapshot()
            CandyCycleLoop()
            Notif("Auto Candy", "Started!", "candy", 2)
        end
    end,
})
local candyLoopToggle = CandySection:Toggle({
    Title = "Loop Mode", Desc = "Ulang terus", Value = false,
    Callback = function(v) state.candyLoopMode = v end,
})
local candyReturnToggle = CandySection:Toggle({
    Title = "Balik Base Setelah Pickup", Value = true,
    Callback = function(v) state.candyReturnBase = v end,
})
local candyPumpkinToggle = CandySection:Toggle({
    Title = "Include Pumpkin Drop", Value = true,
    Callback = function(v) state.candyIncludePumpkin = v end,
})
local candyRitualToggle = CandySection:Toggle({
    Title = "Include Ritual Drop", Value = false,
    Callback = function(v) state.candyIncludeRitual = v end,
})

local CandyDelaySection = CandyTab:Section({ Title = "Delay" })
local candyPickupSlider = CandyDelaySection:Slider({
    Title = "Pickup Delay", Value = { Min = 0.05, Max = 1, Default = 0.15 },
    Callback = function(v) state.candyPickupDelay = v end,
})
local candyBetweenSlider = CandyDelaySection:Slider({
    Title = "Antar Candy Delay", Value = { Min = 0.5, Max = 5, Default = 1.5 },
    Callback = function(v) state.candyBetweenDelay = v end,
})
local candyCooldownSlider = CandyDelaySection:Slider({
    Title = "Cooldown Per Candy", Value = { Min = 0.5, Max = 5, Default = 2 },
    Callback = function(v) state.candyCooldownPerCandy = v end,
})
CandyDelaySection:Button({ Title = "Refresh Candy Snapshot", Callback = function() CandyApplySnapshot() end })
CandyDelaySection:Button({
    Title = "Scan Candy Sekarang",
    Callback = function()
        print("[Ujayy] Candy:", #FindCandyList(), "candy ditemukan")
        Notif("Scan Candy", tostring(#FindCandyList()) .. " candy ditemukan", "search", 3)
    end,
})

-- ═══════════════════════════════════════════════════
-- TAB 5: INTEGRATION
-- ═══════════════════════════════════════════════════
local IntTab = Window:Tab({ Title = "Integration", Icon = "link", Desc = "ESP + Base + Webhook" })

local EspSection = IntTab:Section({ Title = "ESP", Opened = true })
local espEggToggle = EspSection:Toggle({
    Title = "ESP Egg (Rarity + Weight)", Value = false,
    Callback = function(v)
        state.espEgg = v
        if v then RefreshEggESP() else ClearTable(RenderedEggESP) end
    end,
})
local espCandyToggle = EspSection:Toggle({
    Title = "ESP Candy", Value = false,
    Callback = function(v)
        state.espCandy = v
        if v then RefreshCandyESP() else ClearTable(RenderedCandyESP) end
    end,
})
local espPlayerToggle = EspSection:Toggle({
    Title = "ESP Player", Value = false,
    Callback = function(v)
        state.espPlayer = v
        if v then RefreshPlayerESP() else ClearTable(RenderedPlayerESP) end
    end,
})
local espYinYangToggle = EspSection:Toggle({
    Title = "ESP YinYang Socket", Value = false,
    Callback = function(v)
        state.espYinYang = v
        RefreshYinYangESP()
        if v then
            local n = #FindYinYangSockets()
            Notif("ESP YinYang", "Found " .. n .. " socket(s)", "target", 3)
        end
    end,
})
EspSection:Button({
    Title = "Debug YinYang Sockets",
    Callback = function()
        local sockets = FindYinYangSockets()
        print("═══ YinYang Debug ═══")
        print("Total:", #sockets)
        for i, s in ipairs(sockets) do
            print(i, s:GetFullName(), "| Parent:", s.Parent and s.Parent.Name or "nil")
        end
        print("RitualSealVisuals exists:", workspace:FindFirstChild("RitualSealVisuals") ~= nil)
        print("═══════════════════")
        Notif("YinYang Debug", "Found " .. #sockets .. " socket(s) — cek console", "bug", 4)
    end,
})

local BaseSection = IntTab:Section({ Title = "Simpen Base" })
BaseSection:Button({
    Title = "Simpen Base Buat Egg",
    Callback = function() local hrp = GetChar(); if hrp then state.baseEggPos = hrp.Position end Notif("Base Saved", "Posisi egg base disimpen", "save", 2) end,
})
BaseSection:Button({
    Title = "Simpen Base Buat Candy",
    Callback = function() local hrp = GetChar(); if hrp then state.baseCandyPos = hrp.Position end Notif("Base Saved", "Posisi candy base disimpen", "save", 2) end,
})

local WebhookSection = IntTab:Section({ Title = "Webhook Discord" })
WebhookSection:Input({
    Title = "Webhook URL", Value = "",
    Placeholder = "https://discord.com/api/webhooks/...",
    Callback = function(v) state.webhookURL = v end,
})
WebhookSection:Dropdown({
    Title = "Notif Rarity Minimum",
    Values = {"Epic", "Legendary", "Mythic", "Divine", "Ethereal"},
    Value = "Mythic",
    Callback = function(opt) state.webhookRarity = opt end,
})
WebhookSection:Button({
    Title = "Test Webhook",
    Callback = function()
        if state.webhookURL == "" then Notif("Webhook", "URL kosong!", "alert-circle", 2); return end
        SendWebhook("Test Egg", state.webhookRarity, 99.9)
        Notif("Webhook Test", "Terkirim ke Discord", "check", 2)
    end,
})

-- ═══════════════════════════════════════════════════
-- TAB 6: UTILITY
-- ═══════════════════════════════════════════════════
local UtilTab = Window:Tab({ Title = "Utility", Icon = "settings", Desc = "Server & Performance" })

local ServerSection = UtilTab:Section({ Title = "Server", Opened = true })
ServerSection:Button({
    Title = "Server Hop",
    Callback = function()
        local ok, servers = pcall(function()
            return HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..
                game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
        end)
        if ok and servers and servers.data then
            for _, s in ipairs(servers.data) do
                if s.playing < s.maxPlayers and s.id ~= game.JobId then
                    TeleportService:TeleportToPlaceInstance(game.PlaceId, s.id, LocalPlayer)
                    return
                end
            end
        end
    end,
})
ServerSection:Button({ Title = "Rejoin", Callback = function() TeleportService:Teleport(game.PlaceId, LocalPlayer) end })

local PerfSection = UtilTab:Section({ Title = "Performance" })
local noLagToggle = PerfSection:Toggle({
    Title = "No Lag", Value = false,
    Callback = function(v)
        state.noLag = v
        if v then
            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") then
                    obj.Enabled = false
                end
            end
        end
    end,
})
local boostFpsToggle = PerfSection:Toggle({
    Title = "Boost FPS", Value = false,
    Callback = function(v)
        state.boostFps = v
        if v then
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        else
            settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
        end
    end,
})
local hideGardenToggle = PerfSection:Toggle({
    Title = "Hide All Garden", Value = false,
    Callback = function(v)
        state.hideGarden = v
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and (string.find(string.lower(obj.Name), "garden") or string.find(string.lower(obj.Name), "plant")) then
                obj.Parent = v and nil or workspace
            end
        end
    end,
})

local TPSection = UtilTab:Section({ Title = "Teleport" })
TPSection:Button({ Title = "TP ke Base", Callback = function() local bp = AutoGetBaseplate() if bp then TP(bp) end end })
TPSection:Button({ Title = "TP ke Volcano", Callback = function() TP(state.KAWAH + Vector3.new(0, 10, 0)) end })
TPSection:Button({ Title = "TP ke TITIK EGG", Callback = function() TP(state.TITIK_EGG + Vector3.new(0, 5, 0)) end })

local ThemeSection = UtilTab:Section({ Title = "Appearance" })
ThemeSection:Dropdown({
    Title = "Select Theme",
    Values = {"Dark", "Light", "Rose", "Plant", "Red", "Indigo", "Sky", "Violet", "Amber", "Emerald", "Midnight", "Crimson", "MonokaiPro", "CottonCandy", "Mellowsi", "Rainbow"},
    Value = "Dark",
    Callback = function(opt)
        if WindUI.SetTheme then
            WindUI:SetTheme(opt)
        elseif Window.SetTheme then
            Window:SetTheme(opt)
        end
        print("[Ujayy] Theme:", opt)
    end,
})

-- ═══════════════════════════════════════════════════
-- TAB 7: INFO
-- ═══════════════════════════════════════════════════
local InfoTab = Window:Tab({ Title = "Info", Icon = "info", Desc = "About Ujayy" })

local AboutSection = InfoTab:Section({ Title = "About", Opened = true })
AboutSection:Paragraph({
    Title = "Ujayy | Ride A Pet | Roblox",
    Desc = "Version: V1.0.5 (Free)\nAuthor: Xnowplee\nBased on: WindUI by Footagesus\n\nFitur baru: Bypass Toggle (Instant / Mutasi Kawah)",
})

local DiscordSection = InfoTab:Section({ Title = "Discord Community" })
DiscordSection:Paragraph({ Title = "Join Our Discord", Desc = "https://discord.gg/6byStpCzv" })
DiscordSection:Button({
    Title = "Copy Discord Link",
    Callback = function()
        if setclipboard then setclipboard("https://discord.gg/6byStpCzv") end
        Notif("Discord", "Link copied!", "check", 2)
    end,
})

local DebugSection = InfoTab:Section({ Title = "Debug" })
DebugSection:Button({
    Title = "Debug All (Print Info)",
    Callback = function()
        print("═══ Ujayy Debug ═══")
        print("Version: V1.0.5")
        print("Mode:", state.useMutation and "MUTASI KAWAH" or "INSTANT BYPASS")
        print("Eggs found:", #ScanAllEggs())
        print("Candies found:", #FindCandyList())
        print("YinYang sockets:", #FindYinYangSockets())
        print("Players:", #Players:GetPlayers())
        print("Speed:", state.speedValue)
        print("Jump:", state.jumpValue)
        print("Inf Jump:", state.infJump)
        print("ESP Egg:", state.espEgg)
        print("ESP Candy:", state.espCandy)
        print("ESP Player:", state.espPlayer)
        print("ESP YinYang:", state.espYinYang)
        print("Noclip:", state.noclip)
        print("Smart Farm:", SmartFarm.mode)
        print("Stats Farmed:", state.stats.farmed)
        print("Bypass Spam Count:", state.instantSpam)
        print("Bypass Break Offset:", state.instantBreakOffset)
        print("InHalloweenZone:", LocalPlayer:GetAttribute("InHalloweenZone"))
        local noSave = LocalPlayer:FindFirstChild("NoSaveData")
        local carried = noSave and noSave:FindFirstChild("CarriedCandy")
        print("CarriedCandy:", carried and carried.Value or "N/A")
        print("═══════════════════════")
        Notif("Debug", "Info printed to console", "terminal", 3)
    end,
})
DebugSection:Button({
    Title = "Test Notif",
    Callback = function()
        Notif("Test Notif", "Kalo lu liat ini, berarti notif jalan!", "check-circle", 4)
    end,
})
DebugSection:Button({
    Title = "Test Bypass (Sekali)",
    Callback = function()
        local count = ApplyInstantBypass()
        Notif("Test Bypass", "Spoof " .. count .. " egg", "zap", 3)
        task.wait(0.3)
        local ok = FireInstantClaim()
        Notif("Test Bypass", "Claim: " .. tostring(ok), "zap", 3)
    end,
})

-- ═══════════════════════════════════════════════════
-- LOOPS
-- ═══════════════════════════════════════════════════
RunService.Heartbeat:Connect(function()
    local hrp = GetChar()
    if hrp then
        for _, data in pairs(RenderedEggESP) do
            if data.Dist and data.Anchor then
                data.Dist.Text = string.format("%.0fm", (data.Anchor.Position - hrp.Position).Magnitude)
            end
        end
        for _, data in pairs(RenderedPlayerESP) do
            if data.Dist and data.Char then
                local h = data.Char:FindFirstChild("HumanoidRootPart")
                if h then data.Dist.Text = string.format("%.0fm", (h.Position - hrp.Position).Magnitude) end
            end
        end
        for _, data in pairs(RenderedCandyESP) do
            if data.Dist and data.Part and data.Part.Parent then
                data.Dist.Text = string.format("%.0fm", (data.Part.Position - hrp.Position).Magnitude)
            end
        end
        for _, data in pairs(RenderedYinYangESP) do
            if data.Dist and data.Socket and data.Socket.Parent then
                data.Dist.Text = string.format("%.0fm", (data.Socket.Position - hrp.Position).Magnitude)
            end
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if state.espEgg then pcall(RefreshEggESP) end
        if state.espCandy then pcall(RefreshCandyESP) end
        if state.espPlayer then pcall(RefreshPlayerESP) end
        if state.espYinYang then pcall(RefreshYinYangESP) end
        if state.noclip then
            local char = LocalPlayer.Character
            if char then
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
        end
    end
end)

-- ═══════════════════════════════════════════════════
-- LOADED
-- ═══════════════════════════════════════════════════
