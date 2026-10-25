--[[ 
__   __ _____  _______   _ 
\ \ / // __  \|___  / | | |
 \ V / `' / /'   / /| | | |
 /   \   / /    / / | | | |
/ /^\ \./ /___./ /__| |_| |
\/   \/\_____/\_____/\___/

          Created by: v0rtexd
           Modified by: x2zu
      Discord: discord.gg/nemesishub
  in the end you ended up here to take my idea
use .l or .deobfprom or .deobprom to get this source lmao fuck u
if u found it goodjob bro
]]

local blacklistedExecutors = {
    "xeno",
    "solara",
    "vegax",
    "codex",
    "velocity",
}

local function checkExecutorAndKick()
    local execName = ""
    if type(identifyexecutor) == "function" then
        execName = identifyexecutor()
    elseif type(getexecutorname) == "function" then
        execName = getexecutorname()
    end
    
    if type(execName) == "string" and execName ~= "" then
        local lowerExecName = string.lower(execName)
        
        for _, blacklistName in ipairs(blacklistedExecutors) do
            if string.find(lowerExecName, blacklistName) then
                local player = game:GetService("Players").LocalPlayer
                if player then
                    player:Kick("Please change your executor. The executor you're currently using (" .. execName .. ") is unsupported and incompatible with NEMESISHUB")
                end
                error("Blacklisted Executor Detected: " .. execName)
                return
            end
        end
    end
end
pcall(checkExecutorAndKick)

local x2zuDev = cloneref or function(service) return service end
local oMgThisTweenServiceIsSoCool = x2zuDev(game:GetService("TweenService"))
local thisInputServiceGoesHard = x2zuDev(game:GetService("UserInputService"))
local runServiceMoreLikeWalkService = x2zuDev(game:GetService("RunService"))
local playersAreNoobs = x2zuDev(game:GetService("Players"))
local textServiceBeLikeText = x2zuDev(game:GetService("TextService"))
local coreGuiMoreLikeBoreGui = x2zuDev(game:GetService("CoreGui"))
local guiServiceIsCool = x2zuDev(game:GetService("GuiService"))
local httpServiceNoCap = x2zuDev(game:GetService("HttpService"))
local lightingServiceLooksClean = x2zuDev(game:GetService("Lighting"))
local lucideIcons = {} 


local lucideIcons = {}
pcall(function()
    lucideIcons = loadstring(game:HttpGet("https://raw.githubusercontent.com/x2zu/loader/main/Icon/lucideIcons.lua"))()
end)

local function getRealIcon(iconStr, defaultFallback)
    if type(iconStr) ~= "string" then return iconStr or defaultFallback end
    if string.sub(iconStr, 1, 7) == "lucide:" then
        local iconName = string.sub(iconStr, 8) 
        return lucideIcons[iconName] or defaultFallback
    end
    return iconStr
end

-- [NEMESIS+] pick the first lucide icon that exists (names differ between icon packs)
local function pickLucide(names, fallback)
    for _, n in ipairs(names) do
        if lucideIcons[n] then return lucideIcons[n] end
    end
    return fallback
end

-- [NEMESIS+] state styling (Locked / Premium / Fixing) shared by Button, Toggle and friends
local GOLD_COLOR = Color3.fromRGB(255, 200, 66)
-- vivid but not harsh version of the accent (used by sliders / progress / highlights)
local function neonOf(color)
    local h, sat = color:ToHSV()
    return Color3.fromHSV(h, math.clamp(sat * 0.9, 0.5, 0.82), 1)
end
local NEMESIS_STATE = {
    Locked  = {Label = "LOCKED",  Suffix = " (Locked)",           Text = Color3.fromRGB(70, 70, 70),  Badge = Color3.fromRGB(110, 110, 110), Msg = "This feature is locked."},
    Premium = {Label = "PREMIUM", Suffix = "",                    Text = Color3.fromRGB(255, 200, 66), Badge = Color3.fromRGB(255, 200, 66),  Msg = "This feature is Premium only."},
    Fixing  = {Label = "FIXING",  Suffix = " (Perbaikan / Fixing)", Text = Color3.fromRGB(70, 70, 70),  Badge = Color3.fromRGB(240, 150, 80),  Msg = "Under maintenance (Perbaikan / Fixing)."},
}
local function resolveElementState(cfg, library)
    -- Priority: Fixing > Premium (if user isn't premium) > Locked
    if cfg.Fixing then return "Fixing" end
    if cfg.Premium and not (cfg.Unlocked or (library and library.config and library.config.IsPremium)) then return "Premium" end
    if cfg.Locked then return "Locked" end
    return nil
end

-- CURSOR CUSTOM whyNotX2zu
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

if UserInputService.MouseEnabled then
    UserInputService.MouseIconEnabled = false
    local existingCursor = CoreGui:FindFirstChild("NemesisCursorPure")
    if existingCursor then existingCursor:Destroy() end
    
    local cursorGui = Instance.new("ScreenGui")
    cursorGui.Name = "NemesisCursorPure"
    cursorGui.DisplayOrder = 999999
    cursorGui.IgnoreGuiInset = true
    pcall(function() cursorGui.Parent = gethui and gethui() or CoreGui end)
    
    local cursorArrow = Instance.new("TextLabel")
    cursorArrow.Name = "ArrowShape"
    cursorArrow.BackgroundTransparency = 1
    cursorArrow.Size = UDim2.new(0, 24, 0, 24)
    cursorArrow.AnchorPoint = Vector2.new(0.2, 0.2) 
    cursorArrow.Font = Enum.Font.GothamBlack
    cursorArrow.Text = "↖" 
    cursorArrow.TextSize = 28
    cursorArrow.TextColor3 = Color3.fromRGB(105, 13, 191)
    cursorArrow.Parent = cursorGui
    
    local outline = Instance.new("UIStroke")
    outline.Color = Color3.fromRGB(255, 255, 255)
    outline.Thickness = 1
    outline.Parent = cursorArrow
    
    RunService.RenderStepped:Connect(function()
        local mousePos = UserInputService:GetMouseLocation()
        cursorArrow.Position = UDim2.new(0, mousePos.X, 0, mousePos.Y)
    end)
end
-- END CURSOR

local superMegaAwesomeLibrary = {}
superMegaAwesomeLibrary.__index = superMegaAwesomeLibrary

local theOneAndOnlyPlayer = playersAreNoobs.LocalPlayer
local mouseGoClickClick = theOneAndOnlyPlayer:GetMouse()

local isMobileUserSadly = thisInputServiceGoesHard.TouchEnabled and not thisInputServiceGoesHard.KeyboardEnabled
local mobileScaleFactor = isMobileUserSadly and 0.7 or 1
-- v6: skala adaptif mengikuti ukuran layar (HP kecil -> tablet -> PC)
pcall(function()
    local cam = workspace.CurrentCamera
    if not cam then return end
    local vp = cam.ViewportSize
    local fit = math.min(vp.X / 980, vp.Y / 620)
    if isMobileUserSadly then
        mobileScaleFactor = math.clamp(fit, 0.55, 0.85)
    else
        mobileScaleFactor = math.clamp(fit, 0.7, 1)
    end
    mobileScaleFactor = math.floor(mobileScaleFactor * 100 + 0.5) / 100
end)

-- ==========================================================================
-- [NEMESIS+] Luarmor sync (Free / Premium) + badge assets
-- Free  user  -> "Member" badge     (LRM_IsUserPremium == false / nil)
-- Premium     -> "VIP" badge        (LRM_IsUserPremium == true)
-- Owner       -> crown + 3D text    (UserId 8610857394 / pannfinesyet)
-- Runtime variables come from https://docs.luarmor.net (Runtime Variables section).
-- ==========================================================================
local OWNER_USER_ID, OWNER_NAME = 8610857394, "pannfinesyet"
local BADGE_ASSETS = {
    Owner      = "rbxassetid://72360604858105",   -- 561031-king
    Member     = "rbxassetid://76671224669768",   -- member (new)
    VIP        = "rbxassetid://137339007929839",  -- 55280-msp-star-vip
    Rank       = "rbxassetid://102542712798760",  -- 405334-rank
    Rank1      = "rbxassetid://114813736875344",  -- 88283-ranked-one-above-all
    Rank2      = "rbxassetid://80562990151415",   -- 60102-ranked-enternity
    Rank3      = "rbxassetid://119165975706088",  -- 94048-ranked-celestial
    SignalGood = "rbxassetid://110864770527051",  -- 207980-signal (green)
    SignalMid  = "rbxassetid://116563943635127",  -- 479553-signal (pink)
    SignalBad  = "rbxassetid://95732253600602",   -- 478058-signal (red / warning)
}
local TIER_INFO = {
    Owner  = {Label = "OWNER",  Color = Color3.fromRGB(255, 196, 64),  Asset = BADGE_ASSETS.Owner,  Premium = true,  Fallback = {"crown"}},
    VIP    = {Label = "VIP",    Color = Color3.fromRGB(255, 214, 90),  Asset = BADGE_ASSETS.VIP,    Premium = true,  Fallback = {"gem", "diamond"}},
    Member = {Label = "MEMBER", Color = Color3.fromRGB(165, 170, 195), Asset = BADGE_ASSETS.Member, Premium = false, Fallback = {"user", "circle-user"}},
}

local LUARMOR_T0 = os.time()
local luarmorOverride = {} -- filled by Library:SetLuarmor{...} / config.Luarmor / the key-check API

local function readRuntimeGlobal(name)
    local value
    pcall(function() if getgenv then value = getgenv()[name] end end)
    if value == nil then pcall(function() value = _G[name] end) end
    if value == nil then pcall(function() value = getfenv(1)[name] end) end
    return value
end

local function getLuarmorInfo()
    local info = {}
    local premium = luarmorOverride.Premium
    if premium == nil then premium = readRuntimeGlobal("LRM_IsUserPremium") end
    if premium ~= nil then info.Premium = premium == true end
    local executions = luarmorOverride.Executions
    if executions == nil then executions = readRuntimeGlobal("LRM_TotalExecutions") end
    if tonumber(executions) then info.Executions = math.floor(tonumber(executions)) end
    local left
    if luarmorOverride.ExpireAt then
        left = (luarmorOverride.ExpireAt <= 0) and math.huge or math.max(0, luarmorOverride.ExpireAt - os.time())
    else
        local raw = tonumber(readRuntimeGlobal("LRM_SecondsLeft"))
        if raw then left = (raw == math.huge or raw > 3e9) and math.huge or math.max(0, raw - (os.time() - LUARMOR_T0)) end
    end
    info.SecondsLeft = left
    info.Note = luarmorOverride.Note or readRuntimeGlobal("LRM_UserNote")
    info.DiscordId = readRuntimeGlobal("LRM_LinkedDiscordID")
    info.ScriptVersion = readRuntimeGlobal("LRM_ScriptVersion")
    info.ScriptName = readRuntimeGlobal("LRM_ScriptName")
    info.Status = luarmorOverride.Status
    info.Available = info.Premium ~= nil or info.Executions ~= nil
    return info
end

local function isOwnerUser(userId, name)
    return userId == OWNER_USER_ID or (type(name) == "string" and string.lower(name) == OWNER_NAME)
end

local function tierOfUser(userId, name, premium)
    if isOwnerUser(userId, name) then return "Owner" end
    if premium then return "VIP" end
    return "Member"
end

local function formatTimeLeft(seconds)
    if seconds == nil then return nil end
    if seconds == math.huge then return "Lifetime" end
    seconds = math.floor(seconds)
    if seconds >= 86400 then return string.format("%dd left", math.floor(seconds / 86400)) end
    if seconds >= 3600 then return string.format("%dh left", math.floor(seconds / 3600)) end
    return string.format("%dm left", math.max(1, math.floor(seconds / 60)))
end

local function makeThingExist(className, properties)
    if className == "UIStroke" then
        -- thin, soft outlines everywhere
        properties.Thickness = math.min(properties.Thickness or 1, 0.8)
        properties.Transparency = math.max(properties.Transparency or 0, 0.3)
        properties.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    elseif className == "UIGradient" and properties.Parent and properties.Parent:IsA("UIStroke") then
        -- gradient strokes were heavy to render and made the outlines look thick: build it but never attach it
        properties = table.clone(properties)
        properties.Parent = nil
    end
    local whatWeJustMade = Instance.new(className)
    -- [v7] matikan border bawaan Roblox (garis biru tipis) di semua elemen GUI
    if properties.BorderSizePixel == nil and (className == "Frame" or className == "ScrollingFrame" or className == "TextLabel"
        or className == "TextButton" or className == "TextBox" or className == "ImageLabel" or className == "ImageButton"
        or className == "CanvasGroup" or className == "ViewportFrame") then
        pcall(function() whatWeJustMade.BorderSizePixel = 0 end)
    end
    for property, value in pairs(properties) do
        if property ~= "Parent" then
            pcall(function()
                whatWeJustMade[property] = value
            end)
        end
    end
    if properties.Parent then
        whatWeJustMade.Parent = properties.Parent
    end
    return whatWeJustMade
end

local function smoothMoveGoWoosh(instance, properties, duration, easingStyle, easingDirection)
    local tweenInfoYay = TweenInfo.new(duration or 0.22, easingStyle or Enum.EasingStyle.Quint, easingDirection or Enum.EasingDirection.Out)
    local tweenGoVroom = oMgThisTweenServiceIsSoCool:Create(instance, tweenInfoYay, properties)
    tweenGoVroom:Play()
    return tweenGoVroom
end

-- ==========================================================================
-- [NEMESIS+] 3D text, level system, VIP mark for Premium elements
-- ==========================================================================
local TEXT3D_FONT = Enum.Font.LuckiestGuy
local TEXT3D_PALETTES = {
    Owner  = {Top = Color3.fromRGB(255, 244, 176), Mid = Color3.fromRGB(255, 190, 56),  Bot = Color3.fromRGB(226, 120, 18),  Side = Color3.fromRGB(104, 54, 6),  Depth = 4},
    VIP    = {Top = Color3.fromRGB(255, 238, 168), Mid = Color3.fromRGB(255, 208, 84),  Bot = Color3.fromRGB(226, 156, 36),  Side = Color3.fromRGB(96, 62, 12),  Depth = 3},
    Member = {Top = Color3.fromRGB(238, 240, 252), Mid = Color3.fromRGB(190, 196, 226), Bot = Color3.fromRGB(138, 146, 186), Side = Color3.fromRGB(46, 50, 76),  Depth = 2},
}
-- palette derived from any accent colour (used for the version tag so it follows the UI theme)
local function palette3D(color)
    return {
        Top = color:Lerp(Color3.new(1, 1, 1), 0.55), Mid = color, Bot = color:Lerp(Color3.new(0, 0, 0), 0.3),
        Side = color:Lerp(Color3.new(0, 0, 0), 0.72), Depth = 2,
    }
end
-- stacked darker copies make the extrusion, the face has a vertical gradient. Returns holder, width, height.
local function text3D(parent, str, size, x, y, pal)
    pal = pal or TEXT3D_PALETTES.Member
    local depth = pal.Depth or 2
    local width = textServiceBeLikeText:GetTextSize(str, size, TEXT3D_FONT, Vector2.new(600, 80)).X + depth + 2
    local height = size + depth + 2
    local holder = makeThingExist("Frame", {BackgroundTransparency = 1, Position = UDim2.new(0, x or 0, 0, y or 0), Size = UDim2.new(0, width, 0, height), Parent = parent})
    for layer = depth, 1, -1 do
        makeThingExist("TextLabel", {
            BackgroundTransparency = 1, Text = str, Font = TEXT3D_FONT, TextSize = size, TextXAlignment = Enum.TextXAlignment.Left,
            TextColor3 = pal.Side:Lerp(pal.Bot, ((depth - layer) / depth) * 0.35),
            Position = UDim2.new(0, layer * 0.75, 0, layer * 0.75), Size = UDim2.new(1, 0, 1, 0), ZIndex = 1 + (depth - layer), Parent = holder
        })
    end
    local face = makeThingExist("TextLabel", {
        BackgroundTransparency = 1, Text = str, Font = TEXT3D_FONT, TextSize = size, TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = Color3.new(1, 1, 1), Size = UDim2.new(1, 0, 1, 0), ZIndex = 10, Parent = holder
    })
    makeThingExist("UIGradient", {
        Rotation = 90, Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, pal.Top), ColorSequenceKeypoint.new(0.55, pal.Mid), ColorSequenceKeypoint.new(1, pal.Bot)
        }), Parent = face
    })
    return holder, width, height
end

-- level system: one icon at a time. Reaching the next level swaps the icon (level 1 disappears, level 2 appears ...).
-- XP = executions * 20 + minutes spent. Edit the XP column to rebalance.
local LEVELS = {
    {Level = 1, Name = "Newcomer", XP = 0,     Asset = "rbxassetid://126515628343460"},
    {Level = 2, Name = "Rookie",   XP = 100,   Asset = "rbxassetid://74550839320341"},
    {Level = 3, Name = "Regular",  XP = 300,   Asset = "rbxassetid://89431821782002"},
    {Level = 4, Name = "Skilled",  XP = 700,   Asset = "rbxassetid://105548044788737"},
    {Level = 5, Name = "Veteran",  XP = 1500,  Asset = "rbxassetid://84750310076581"},
    {Level = 6, Name = "Elite",    XP = 3000,  Asset = "rbxassetid://75371418294896"},
    {Level = 7, Name = "Master",   XP = 6000,  Asset = "rbxassetid://133661182779588"},
    {Level = 8, Name = "Legend",   XP = 12000, Asset = "rbxassetid://80341631966050"},
}
local function calcXP(executions, seconds)
    return math.floor((tonumber(executions) or 0) * 20 + (tonumber(seconds) or 0) / 60)
end
-- returns levelIndex, currentLevelData, nextLevelData (nil at max level)
local function levelOf(xp)
    local idx = 1
    for i, data in ipairs(LEVELS) do if xp >= data.XP then idx = i end end
    return idx, LEVELS[idx], LEVELS[idx + 1]
end

-- Premium toggle / button: the old "★" is replaced by the VIP icon
-- [v3.1] the icon no longer overlaps the text: the label gets a real UIPadding instead of a space prefix
local PREMIUM_PREFIX = ""
local function setPremiumMark(textLabel, on)
    local mark = textLabel:FindFirstChild("PremiumMark")
    local pad = textLabel:FindFirstChild("PremiumPad")
    local px = math.floor(16 * mobileScaleFactor)
    if on then
        if not mark then
            mark = Instance.new("ImageLabel")
            mark.Name = "PremiumMark"
            mark.BackgroundTransparency = 1
            mark.Image = BADGE_ASSETS.VIP
            mark.ScaleType = Enum.ScaleType.Fit
            mark.AnchorPoint = Vector2.new(0, 0.5)
            mark.Position = UDim2.new(0, -(px + 6), 0.5, 0) -- sits inside the padding area
            mark.Size = UDim2.fromOffset(px, px)
            mark.Parent = textLabel
        end
        if not pad then
            pad = Instance.new("UIPadding")
            pad.Name = "PremiumPad"
            pad.Parent = textLabel
        end
        pad.PaddingLeft = UDim.new(0, px + 6)
        mark.Visible = true
    else
        if mark then mark.Visible = false end
        if pad then pad.PaddingLeft = UDim.new(0, 0) end
    end
end
-- [v3.1] modern premium outline: soft gold gradient stroke + faint glow fill
local function setPremiumOutline(frame, on)
    local glow = frame:FindFirstChild("PremiumGlow")
    if on and not glow then
        glow = Instance.new("UIStroke")
        glow.Name = "PremiumGlow"
        glow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        glow.Thickness = 1.2
        glow.Color = Color3.new(1, 1, 1)
        glow.Transparency = 0.15
        local grad = Instance.new("UIGradient")
        grad.Rotation = 20
        grad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 226, 140)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 186, 60)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(190, 120, 30)),
        })
        grad.Parent = glow
        glow.Parent = frame
    end
    if glow then glow.Enabled = on == true end
    for _, child in ipairs(frame:GetChildren()) do
        if child:IsA("UIStroke") and child ~= glow then child.Enabled = not on end
    end
end

local function makeDraggableCuzWeCan(frame, handle, libraryRef)
    local amIDragging = false
    local activeDragInput
    local whereDidIStart
    local whereWasIBefore
    local targetDragPosition = frame.Position
    local dragLerpSpeed = isMobileUserSadly and 18 or 22
    
    handle = handle or frame
    
    local function updateTargetPositionYay(input)
        local howMuchDidIMove = input.Position - whereDidIStart
        targetDragPosition = UDim2.new(
            whereWasIBefore.X.Scale,
            whereWasIBefore.X.Offset + howMuchDidIMove.X,
            whereWasIBefore.Y.Scale,
            whereWasIBefore.Y.Offset + howMuchDidIMove.Y
        )
    end

    local renderDragConn = runServiceMoreLikeWalkService.RenderStepped:Connect(function(dt)
        if not frame or not frame.Parent then return end
        if not amIDragging then
            targetDragPosition = frame.Position
            return
        end
        local currentPos = frame.Position
        local goalPos = targetDragPosition
        local offsetDelta = math.abs(goalPos.X.Offset - currentPos.X.Offset) + math.abs(goalPos.Y.Offset - currentPos.Y.Offset)
        if offsetDelta <= 0.1 then
            frame.Position = goalPos
            return
        end
        local alpha = math.clamp(1 - math.exp(-dragLerpSpeed * dt), 0, 0.45)
        frame.Position = currentPos:Lerp(goalPos, alpha)
    end)
    
    local inputBeganConn = handle.InputBegan:Connect(function(input)
        local isMouse = input.UserInputType == Enum.UserInputType.MouseButton1
        local isTouch = input.UserInputType == Enum.UserInputType.Touch
        if not isMouse and not isTouch then
            return
        end

        amIDragging = true
        activeDragInput = isTouch and input or nil
        whereDidIStart = input.Position
        whereWasIBefore = frame.Position
        targetDragPosition = frame.Position
        
        local inputEndConn
        inputEndConn = input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                if frame and frame.Parent then
                    frame.Position = targetDragPosition
                end
                amIDragging = false
                activeDragInput = nil
                if inputEndConn then
                    inputEndConn:Disconnect()
                    inputEndConn = nil
                end
            end
        end)
        if libraryRef and type(libraryRef._TrackConnection) == "function" then
            libraryRef:_TrackConnection(inputEndConn)
        end
    end)
    
    local userInputChangedConn = thisInputServiceGoesHard.InputChanged:Connect(function(input)
        if not amIDragging then
            return
        end
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            updateTargetPositionYay(input)
        elseif input.UserInputType == Enum.UserInputType.Touch and (activeDragInput == nil or input == activeDragInput) then
            updateTargetPositionYay(input)
        end
    end)

    if libraryRef and type(libraryRef._TrackConnection) == "function" then
        libraryRef:_TrackConnection(renderDragConn)
        libraryRef:_TrackConnection(inputBeganConn)
        libraryRef:_TrackConnection(userInputChangedConn)
    end
end

local function getPlayerAvatarCuzTheyreBeautiful(userId)
    local didItWork, whatWeGot = pcall(function()
        return playersAreNoobs:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
    end)
    if didItWork then
        return whatWeGot
    end
    return "rbxassetid://135756197673563"
end

local function resolveAvatar3DUserIdFromRobloxEndpoint(defaultUserId)
    local fallbackUserId = tonumber(defaultUserId) or 1
    local endpoint = "https://thumbnails.roblox.com/v1/users/avatar-3d?userId=" .. tostring(fallbackUserId)

    local okBody, rawBody = pcall(function()
        return game:HttpGet(endpoint)
    end)
    if not okBody or type(rawBody) ~= "string" or rawBody == "" then
        return fallbackUserId, nil
    end

    local okDecode, payload = pcall(function()
        return httpServiceNoCap:JSONDecode(rawBody)
    end)
    if not okDecode or type(payload) ~= "table" then
        return fallbackUserId, nil
    end

    local resolvedUserId = tonumber(payload.targetId) or tonumber(payload.userId) or fallbackUserId
    local imageUrl = type(payload.imageUrl) == "string" and payload.imageUrl or nil
    return resolvedUserId, imageUrl
end

local function howWideIsThisText(text, textSize, font)
    local textBoundsYay = textServiceBeLikeText:GetTextSize(text, textSize, font or Enum.Font.GothamSemibold, Vector2.new(math.huge, math.huge))
    return textBoundsYay.X
end

local function truncateTextLikeABoss(text, maxWidth, textSize, font)
    local fullWidth = howWideIsThisText(text, textSize, font)
    if fullWidth <= maxWidth then
        return text
    end
    
    local truncated = text
    while howWideIsThisText(truncated .. "...", textSize, font) > maxWidth and #truncated > 0 do
        truncated = truncated:sub(1, -2)
    end
    return truncated .. "..."
end

local function normalizeSearchText(text)
    return string.lower(tostring(text or "")):gsub("^%s+", ""):gsub("%s+$", "")
end

local function serializeConfigValue(value)
    local valueType = typeof(value)
    if valueType == "Color3" then
        return {
            __type = "Color3",
            r = value.R,
            g = value.G,
            b = value.B
        }
    end
    if valueType == "EnumItem" and value.EnumType == Enum.KeyCode then
        return {
            __type = "KeyCode",
            value = value.Name
        }
    end
    return value
end

local function deserializeConfigValue(value)
    if type(value) ~= "table" or not value.__type then
        return value
    end
    if value.__type == "Color3" and value.r and value.g and value.b then
        return Color3.new(value.r, value.g, value.b)
    end
    if value.__type == "KeyCode" and value.value then
        return Enum.KeyCode[value.value] or Enum.KeyCode.Unknown
    end
    return value
end

local function sanitizeConfigName(name)
    local cleanName = tostring(name or "default")
    cleanName = cleanName:gsub("[\\/:*?\"<>|]", "_")
    cleanName = cleanName:gsub("^%s+", ""):gsub("%s+$", "")
    if cleanName == "" then
        cleanName = "default"
    end
    return cleanName
end

-- [NEMESIS+] Luarmor sync methods ------------------------------------------
function superMegaAwesomeLibrary:_RefreshPremiumElements()
    for index = #(self._stateElements or {}), 1, -1 do
        local entry = self._stateElements[index]
        local obj, cfg = entry.Obj, entry.Cfg
        if not obj or not obj.SetState then
            table.remove(self._stateElements, index)
        elseif cfg.Premium and not cfg.Fixing and (obj.stateKey == "Premium" or obj.stateKey == nil) then
            local want = resolveElementState(cfg, self)
            if want ~= obj.stateKey then pcall(obj.SetState, obj, want) end
        end
    end
end

function superMegaAwesomeLibrary:_SyncLuarmor()
    local info = getLuarmorInfo()
    if self.config.LuarmorSync ~= false and info.Premium ~= nil then
        self.config.IsPremium = info.Premium
    end
    local lp = playersAreNoobs.LocalPlayer
    local tier = tierOfUser(lp and lp.UserId, lp and lp.Name, self.config.IsPremium == true)
    if tier == "Owner" then self.config.IsPremium = true end
    local changed = tier ~= self._tier
    self._tier = tier
    self._luarmorInfo = info
    if changed then self:_RefreshPremiumElements() end
    for _, listener in ipairs(self._tierListeners or {}) do pcall(listener, tier, info, changed) end
end

-- Library:SetLuarmor{Premium = LRM_IsUserPremium, Executions = LRM_TotalExecutions, ...}
-- (only needed when the runtime variables are not visible from this file's environment)
function superMegaAwesomeLibrary:SetLuarmor(data)
    if type(data) == "table" then
        for key, value in pairs(data) do luarmorOverride[key] = value end
    end
    if self._SyncLuarmor then self:_SyncLuarmor() end
end
function superMegaAwesomeLibrary:GetTier() return self._tier or "Member" end

-- Optional: Luarmor key-check library (docs: "Key Check Library").
-- Window config: Luarmor = {ScriptId = "<your script id>", Key = script_key}
function superMegaAwesomeLibrary:_InitLuarmorKeyCheck()
    local lcfg = self.config.Luarmor
    if type(lcfg) ~= "table" or type(lcfg.ScriptId) ~= "string" then return end
    task.spawn(function()
        local key = lcfg.Key or readRuntimeGlobal("script_key")
        if type(key) ~= "string" or #key ~= 32 then return end
        local okApi, api = pcall(function() return loadstring(game:HttpGet("https://sdkapi-public.luarmor.net/library.lua"))() end)
        if not okApi or type(api) ~= "table" then return end
        api.script_id = lcfg.ScriptId
        local okCheck, status = pcall(api.check_key, key)
        if not okCheck or type(status) ~= "table" then return end
        luarmorOverride.Status = status.code
        if status.code == "KEY_VALID" then
            luarmorOverride.Premium = true
            if type(status.data) == "table" then
                luarmorOverride.ExpireAt = tonumber(status.data.auth_expire)
                luarmorOverride.Executions = tonumber(status.data.total_executions)
                luarmorOverride.Note = status.data.note
            end
        else
            luarmorOverride.Premium = false -- expired / banned / wrong HWID => Free
        end
        if not self._destroyed then self:_SyncLuarmor() end
    end)
    task.spawn(function()
        while not self._destroyed do
            task.wait(30)
            if not self._destroyed then pcall(self._SyncLuarmor, self) end
        end
    end)
end

-- [NEMESIS+] In-game badge: role icon + 3D role text (+ top 3 rank icon, level) above the player's head
function superMegaAwesomeLibrary:_RefreshInGameBadge()
    local gui = self._badgeGui
    if not gui or not gui.Parent then return end
    gui:ClearAllChildren()
    local tier = self._tier or "Member"
    local info = TIER_INFO[tier] or TIER_INFO.Member
    local pal = TEXT3D_PALETTES[tier] or TEXT3D_PALETTES.Member

    local root = makeThingExist("Frame", {BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), Parent = gui})
    makeThingExist("UIListLayout", {
        FillDirection = Enum.FillDirection.Vertical, HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 1), Parent = root
    })
    local row = makeThingExist("Frame", {BackgroundTransparency = 1, Size = UDim2.new(0, 0, 0, 32), AutomaticSize = Enum.AutomaticSize.X, LayoutOrder = 1, Parent = root})
    makeThingExist("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal, VerticalAlignment = Enum.VerticalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 5), Parent = row
    })
    local hidden = self._hiddenBadges or {}
    if not hidden.Tier then
        makeThingExist("ImageLabel", {BackgroundTransparency = 1, Image = info.Asset, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(28, 28), LayoutOrder = 1, Parent = row})
    end
    local holder = text3D(row, info.Label, 22, 0, 0, pal)
    holder.LayoutOrder = 2
    local rank = self._rank
    if rank and rank >= 1 and rank <= 3 and not hidden.Rank then
        local asset = rank == 1 and BADGE_ASSETS.Rank1 or rank == 2 and BADGE_ASSETS.Rank2 or BADGE_ASSETS.Rank3
        makeThingExist("ImageLabel", {BackgroundTransparency = 1, Image = asset, ScaleType = Enum.ScaleType.Fit, Size = UDim2.fromOffset(26, 26), LayoutOrder = 3, Parent = row})
    end
    if self._level and not hidden.Level then
        makeThingExist("TextLabel", {
            BackgroundTransparency = 1, Text = "Lv " .. tostring(self._level) .. "  ·  " .. LEVELS[self._level].Name, TextSize = 12, TextColor3 = pal.Top,
            FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold), TextStrokeTransparency = 0.55,
            Size = UDim2.new(1, 0, 0, 14), LayoutOrder = 2, Parent = root
        })
    end
end

function superMegaAwesomeLibrary:_InitInGameBadge()
    local lp = playersAreNoobs.LocalPlayer
    if not lp then return end
    self._badgeEnabled = self.config.InGameBadge ~= false
    local function attach(char)
        local head = char and (char:FindFirstChild("Head") or char:WaitForChild("Head", 10))
        if not head or self._destroyed or not self._badgeEnabled then return end
        if self._badgeGui then self._badgeGui:Destroy() end
        local gui = Instance.new("BillboardGui")
        gui.Name = "NemesisBadge"
        gui.Adornee = head
        gui.Size = UDim2.fromOffset(260, 60)
        gui.StudsOffset = Vector3.new(0, 3.6, 0)
        gui.AlwaysOnTop = false
        gui.MaxDistance = 150
        gui.LightInfluence = 0
        gui.ResetOnSpawn = false
        gui.Active = false
        gui.Parent = head
        self._badgeGui = gui
        self:_RefreshInGameBadge()
    end
    self._attachBadge = attach
    self:_TrackConnection(lp.CharacterAdded:Connect(function(char) task.spawn(attach, char) end))
    if lp.Character then task.spawn(attach, lp.Character) end
    table.insert(self._tierListeners, function() self:_RefreshInGameBadge() end)
end

-- Window:SetInGameBadge(false) hides the badge above your character, true shows it again
function superMegaAwesomeLibrary:SetInGameBadge(enabled)
    self._badgeEnabled = enabled ~= false
    if self._badgeEnabled then
        local lp = playersAreNoobs.LocalPlayer
        if self._attachBadge and lp and lp.Character and (not self._badgeGui or not self._badgeGui.Parent) then
            task.spawn(self._attachBadge, lp.Character)
        end
    elseif self._badgeGui then
        self._badgeGui:Destroy()
        self._badgeGui = nil
    end
end

function superMegaAwesomeLibrary.new(config)
    local self = setmetatable({}, superMegaAwesomeLibrary)
    
    self.config = config or {}
    self.config.Name = self.config.Name or "o11 vision"
    -- [v7] accent dikunci ke warna default; hanya bisa berubah lewat Theme preset / Accent color
    self.config.AccentColor = self.config.AccentColor or Color3.fromRGB(123, 47, 190) -- Royal (#7B2FBE)
    self.config.BackgroundColor = self.config.BackgroundColor or Color3.fromRGB(16, 16, 16)
    self.config.SecondaryColor = self.config.SecondaryColor or Color3.fromRGB(18, 18, 18)
    self.config.TextColor = self.config.TextColor or Color3.fromRGB(255, 255, 255)
    self.config.SubTextColor = self.config.SubTextColor or Color3.fromRGB(124, 124, 124)
    

    -- [NEMESIS+] Theme presets + Airflow-style window options
    local THEMES = {
        Default  = {},
        Midnight = {Accent = Color3.fromRGB(86, 130, 255),  Background = Color3.fromRGB(10, 12, 20),  Secondary = Color3.fromRGB(14, 17, 28)},
        Moss     = {Accent = Color3.fromRGB(120, 200, 130), Background = Color3.fromRGB(12, 16, 13),  Secondary = Color3.fromRGB(16, 21, 17)},
        Ember    = {Accent = Color3.fromRGB(255, 120, 60),  Background = Color3.fromRGB(18, 12, 10),  Secondary = Color3.fromRGB(24, 16, 13)},
        Rose     = {Accent = Color3.fromRGB(240, 100, 150), Background = Color3.fromRGB(18, 11, 14),  Secondary = Color3.fromRGB(24, 15, 19)},
        Mono     = {Accent = Color3.fromRGB(220, 220, 220), Background = Color3.fromRGB(14, 14, 14),  Secondary = Color3.fromRGB(20, 20, 20)},
    }
    superMegaAwesomeLibrary.Themes = THEMES
    local userConfig = config or {}
    local themeSpec = self.config.Theme
    local themeTable = type(themeSpec) == "string" and THEMES[themeSpec] or (type(themeSpec) == "table" and themeSpec or nil)
    if themeTable then
        -- explicit AccentColor/BackgroundColor in config always win over the preset
        if themeTable.Accent then self.config.AccentColor = themeTable.Accent end
        if themeTable.Background and not userConfig.BackgroundColor then self.config.BackgroundColor = themeTable.Background end
        if themeTable.Secondary and not userConfig.SecondaryColor then self.config.SecondaryColor = themeTable.Secondary end
        if themeTable.Text and not userConfig.TextColor then self.config.TextColor = themeTable.Text end
        if themeTable.SubText and not userConfig.SubTextColor then self.config.SubTextColor = themeTable.SubText end
    end
    self.config.LoadingSubtitle = self.config.LoadingSubtitle or ""
    self.config.Dashboard = self.config.Dashboard or self.config.Home -- "Home" kept as alias
    local saving = self.config.ConfigurationSaving
    if type(saving) == "table" and saving.Enabled then
        self._cfgFolder = tostring(saving.FolderName or "NemesisUIConfigs")
        self._cfgFile = tostring(saving.FileName or "default")
        self._autoSaveEnabled = true
    else
        self._cfgFolder = "NemesisUIConfigs"
        self._autoSaveEnabled = false
    end
    local keybindSpec = self.config.ToggleUIKeybind or self.config.ToggleKeybind

    self.sectionsAreAwesome = {}
    self.tabsGoWoosh = {}
    self.currentTabYay = nil
    self.notificationsAreCool = {}
    self.isToggledOn = true
    self.dropdownHolderRef = nil
    self.toggleKeyCode = Enum.KeyCode.RightControl
    if keybindSpec ~= nil then
        if typeof(keybindSpec) == "EnumItem" then
            self.toggleKeyCode = keybindSpec
        elseif type(keybindSpec) == "string" then
            local okKey, keyEnum = pcall(function() return Enum.KeyCode[keybindSpec] end)
            if okKey and keyEnum then self.toggleKeyCode = keyEnum end
        end
    end
    self.toggleButtonVisible = true
    self._destroyed = false
    self._connections = {}
    self._trackedControls = {}
    self._miniToggleRefs = {}
    self._smoothScrollFrames = {}
    self._stateElements = {}
    self._searchQuery = ""
    self._fpsRollingWindow = {}
    self._fpsRollingTotal = 0
    self._fpsRollingSize = 60
    self._latestFPSValue = 0
    self._blurEffectRef = nil
    self._snowflakes = {}
    self._snowSpawnAccumulator = 0
    self._snowMaxFlakes = isMobileUserSadly and 45 or 90
    self._overlayMode = "None"
    self._overlayModes = {"Snow", "Rain", "Stars", "None"}
    self._backgroundFxTime = 0
    self._textGradientAnimationTime = 0
    self._uiVisualSettings = {
        Blur = true,              -- default ON
        Snow = false,
        BackgroundEffects = true, -- default ON
        TextGradient = true,      -- default ON
        ESPSelfPreview = false
    }
    self._fontPresets = {
        {Name = "Gotham", EnumFont = Enum.Font.Gotham, Family = "rbxasset://fonts/families/GothamSSm.json", Weight = Enum.FontWeight.SemiBold},
        {Name = "Gotham Medium", EnumFont = Enum.Font.GothamMedium, Family = "rbxasset://fonts/families/GothamSSm.json", Weight = Enum.FontWeight.Medium},
        {Name = "Montserrat", EnumFont = Enum.Font.Gotham, Family = "rbxasset://fonts/families/Montserrat.json", Weight = Enum.FontWeight.SemiBold},
        {Name = "Nunito", EnumFont = Enum.Font.Gotham, Family = "rbxasset://fonts/families/Nunito.json", Weight = Enum.FontWeight.SemiBold},
        {Name = "Poppins", EnumFont = Enum.Font.Gotham, Loader = "Poppins", Weight = Enum.FontWeight.SemiBold},
        {Name = "Bodoni", EnumFont = Enum.Font.Bodoni},
        {Name = "Garamond", EnumFont = Enum.Font.Garamond},
        {Name = "Source Sans", EnumFont = Enum.Font.SourceSans, Family = "rbxasset://fonts/families/SourceSansPro.json", Weight = Enum.FontWeight.SemiBold},
        {Name = "Highway", EnumFont = Enum.Font.Highway},
        {Name = "Antique", EnumFont = Enum.Font.Antique},
        {Name = "Code", EnumFont = Enum.Font.Code}
    }
    self._fontPresetIndex = 3
    self._gradientLabels = {}
    self._espPreviewProvider = nil
    self._espPreviewData = nil
    self._espPreviewState = nil
    self._espPreviewResolveAccumulator = 0
    self._espPreviewPanel = nil
    self._espPreviewViewport = nil
    self._espPreviewWorldModel = nil
    self._espPreviewCamera = nil
    self._espPreviewCharacter = nil
    self._espPreviewLastCharacter = nil
    self._espPreviewPartDefaults = {}
    self._espPreviewHighlight = nil
    self._espPreviewHeaderTag = nil
    self._espPreviewBox = nil
    self._espPreviewBoxStroke = nil
    self._espPreviewHealthTrack = nil
    self._espPreviewHealthFill = nil
    self._espPreviewDot = nil
    self._espPreviewTracer = nil
    self._espPreviewName = nil
    self._espPreviewItem = nil
    self._espPreviewDistance = nil
    self._espPreviewWalkTrack = nil
    self._espPreviewAnimationId = nil
    self._espPreviewAvatar3DUserId = tonumber(theOneAndOnlyPlayer.UserId) or 0
    self._espPreviewAvatar3DImageUrl = nil
    self._espPreviewRotationYaw = math.rad(180)
    self._espPreviewRotationTargetYaw = math.rad(180)
    self._espPreviewPivotYOffset = -2
    self._espPreviewRotateCapture = nil
    self._espPreviewIsRotating = false
    self._espPreviewRotateInput = nil
    self._espPreviewRotateLastX = 0
    
    self._tierListeners = {}
    self:_SyncLuarmor()
    self:CreateUIBecauseWeNeedIt()
    self:_InitNemesisPlus()
    self:_InitLuarmorKeyCheck()

    return self
end

function superMegaAwesomeLibrary:_TrackConnection(conn)
    if conn then
        table.insert(self._connections, conn)
        if #self._connections % 100 == 0 then
            local activeConnections = {}
            for _, item in ipairs(self._connections) do
                if item and typeof(item) == "RBXScriptConnection" and item.Connected then
                    table.insert(activeConnections, item)
                end
            end
            self._connections = activeConnections
        end
    end
    return conn
end

function superMegaAwesomeLibrary:RegisterControl(flag, getter, setter)
    if type(flag) ~= "string" or flag == "" then return end
    if type(getter) ~= "function" or type(setter) ~= "function" then return end
    self._trackedControls[flag] = {
        get = getter,
        set = setter
    }
end

function superMegaAwesomeLibrary:_EnsureBlurEffect()
    if self._blurEffectRef and self._blurEffectRef.Parent then
        return self._blurEffectRef
    end
    local existingBlur = lightingServiceLooksClean:FindFirstChild("FlowUIBlurEffect")
    if existingBlur and existingBlur:IsA("BlurEffect") then
        self._blurEffectRef = existingBlur
        return existingBlur
    end
    self._blurEffectRef = makeThingExist("BlurEffect", {
        Name = "FlowUIBlurEffect",
        Size = 0,
        Enabled = true,
        Parent = lightingServiceLooksClean
    })
    return self._blurEffectRef
end

function superMegaAwesomeLibrary:_SetBlurActive(active, instant)
    local blur = self:_EnsureBlurEffect()
    local shouldEnable = self._uiVisualSettings.Blur and active
    local targetSize = shouldEnable and (isMobileUserSadly and 14 or 18) or 0
    if instant then
        blur.Size = targetSize
        return
    end
    smoothMoveGoWoosh(blur, {Size = targetSize}, 0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
end

function superMegaAwesomeLibrary:_ClearSnowflakes()
    for i = #self._snowflakes, 1, -1 do
        local snowObj = self._snowflakes[i]
        if snowObj and snowObj.instance and snowObj.instance.Parent then
            snowObj.instance:Destroy()
        end
        self._snowflakes[i] = nil
    end
end

function superMegaAwesomeLibrary:_SpawnSnowflake()
    if not self.snowLayerFrame or not self.snowLayerFrame.Parent then
        return
    end
    local viewportSize = self.screenGuiYay.AbsoluteSize
    local width = math.max(200, math.floor(viewportSize.X))
    local size = math.random(2, 7) * mobileScaleFactor
    local startX = math.random(-18, width + 18)
    local flake = makeThingExist("ImageLabel", {
        BackgroundTransparency = 1,
        Image = "rbxassetid://3570695787",
        ImageColor3 = Color3.fromRGB(236 + math.random(0, 19), 243 + math.random(0, 12), 255),
        ImageTransparency = math.random(22, 56) / 100,
        Size = UDim2.new(0, size, 0, size),
        Position = UDim2.new(0, startX, 0, -math.random(6, 80)),
        Rotation = math.random(0, 359),
        ZIndex = 2,
        Parent = self.snowLayerFrame
    })
    table.insert(self._snowflakes, {
        overlayType = "Snow",
        instance = flake,
        baseX = startX,
        fallSpeed = math.random(16, 42) * mobileScaleFactor,
        driftAmount = math.random(12, 42) * mobileScaleFactor,
        swirlAmount = math.random(2, 10) * mobileScaleFactor,
        driftSpeed = math.random(5, 15) / 10,
        twinkleSpeed = math.random(6, 15) / 10,
        baseTransparency = flake.ImageTransparency,
        phase = math.random() * math.pi * 2,
        spin = math.random(-14, 14),
        size = size,
        yOffset = flake.Position.Y.Offset
    })
end

function superMegaAwesomeLibrary:_SpawnRainDrop()
    if not self.snowLayerFrame or not self.snowLayerFrame.Parent then
        return
    end
    local viewportSize = self.screenGuiYay.AbsoluteSize
    local width = math.max(200, math.floor(viewportSize.X))
    local depthScale = math.random(62, 150) / 100
    local length = (math.random(12, 30) * depthScale + 3) * mobileScaleFactor
    local thickness = math.max(1, math.floor((0.8 + depthScale * 0.9) * mobileScaleFactor + 0.5))
    local startX = math.random(-58, width + 58)
    local startY = -math.random(30, 180)
    local windSpeed = (math.random(26, 88) * depthScale) * mobileScaleFactor
    local fallSpeed = (math.random(270, 560) * depthScale) * mobileScaleFactor
    local angle = math.deg(math.atan(fallSpeed / windSpeed)) - 90
    local drop = makeThingExist("Frame", {
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(176 + math.random(0, 26), 208 + math.random(0, 26), 255),
        BackgroundTransparency = math.random(15, 45) / 100,
        Position = UDim2.new(0, startX, 0, startY),
        Size = UDim2.new(0, thickness, 0, length),
        Rotation = angle,
        ZIndex = depthScale > 1 and 3 or 2,
        Parent = self.snowLayerFrame
    })
    makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = drop})
    table.insert(self._snowflakes, {
        overlayType = "RainDrop",
        instance = drop,
        xOffset = startX,
        yOffset = startY,
        velocityX = windSpeed,
        velocityY = fallSpeed,
        angle = angle,
        width = thickness,
        length = length,
        baseTransparency = drop.BackgroundTransparency,
        driftSpeed = math.random(11, 24) / 10,
        windJitter = math.random(6, 18) * mobileScaleFactor,
        stretchPulse = math.random(16, 30) / 10,
        splashChance = 0.55 + math.random() * 0.25,
        phase = math.random() * math.pi * 2
    })
end

function superMegaAwesomeLibrary:_SpawnRainSplash(xPosition, yPosition)
    if not self.snowLayerFrame or not self.snowLayerFrame.Parent then
        return
    end
    local startSize = math.random(2, 5) * mobileScaleFactor
    local splash = makeThingExist("Frame", {
        BorderSizePixel = 0,
        BackgroundColor3 = Color3.fromRGB(194 + math.random(0, 20), 224 + math.random(0, 22), 255),
        BackgroundTransparency = math.random(24, 42) / 100,
        Position = UDim2.new(0, xPosition, 0, yPosition),
        Size = UDim2.new(0, startSize, 0, math.max(1 * mobileScaleFactor, startSize * 0.5)),
        ZIndex = 3,
        Parent = self.snowLayerFrame
    })
    makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = splash})
    local life = math.random(8, 14) / 100
    table.insert(self._snowflakes, {
        overlayType = "RainSplash",
        instance = splash,
        baseX = xPosition,
        yOffset = yPosition,
        life = life,
        totalLife = life,
        startSize = startSize,
        startThickness = math.max(1 * mobileScaleFactor, startSize * 0.5),
        endSize = math.random(10, 20) * mobileScaleFactor,
        driftX = math.random(-14, 14) * mobileScaleFactor,
        baseTransparency = splash.BackgroundTransparency
    })
end

function superMegaAwesomeLibrary:_SpawnStarParticle()
    if not self.snowLayerFrame or not self.snowLayerFrame.Parent then
        return
    end
    local viewportSize = self.screenGuiYay.AbsoluteSize
    local width = math.max(200, math.floor(viewportSize.X))
    local height = math.max(240, math.floor(viewportSize.Y))
    local size = (math.random(10, 28) / 10) * mobileScaleFactor
    local startX = math.random(0, width)
    local startY = math.random(0, height)
    local star = makeThingExist("ImageLabel", {
        BackgroundTransparency = 1,
        Image = "rbxassetid://3570695787",
        ImageColor3 = Color3.fromRGB(224 + math.random(0, 28), 233 + math.random(0, 20), 255),
        ImageTransparency = math.random(22, 56) / 100,
        Position = UDim2.new(0, startX, 0, startY),
        Size = UDim2.new(0, size, 0, size),
        ZIndex = 3,
        Parent = self.snowLayerFrame
    })
    table.insert(self._snowflakes, {
        overlayType = "Stars",
        instance = star,
        xOffset = startX,
        yOffset = startY,
        velocityX = (math.random(-16, 16) / 10) * mobileScaleFactor,
        velocityY = (math.random(-9, 9) / 10) * mobileScaleFactor,
        baseSize = size,
        driftAmount = math.random(5, 18) * mobileScaleFactor,
        driftLift = math.random(4, 14) * mobileScaleFactor,
        driftSpeed = math.random(3, 10) / 10,
        twinkleSpeed = math.random(7, 18) / 10,
        pulseAmount = (math.random(8, 24) / 100),
        baseTransparency = star.ImageTransparency,
        phase = math.random() * math.pi * 2
    })
end

function superMegaAwesomeLibrary:_SetSnowEnabled(enabled)
    self._uiVisualSettings.Snow = enabled == true
    if self.snowLayerFrame then
        self.snowLayerFrame.Visible = self._uiVisualSettings.Snow and self.isToggledOn and self._overlayMode ~= "None"
    end
    if not self._uiVisualSettings.Snow or not self.isToggledOn or self._overlayMode == "None" then
        self._snowSpawnAccumulator = 0
        self:_ClearSnowflakes()
    end
end

function superMegaAwesomeLibrary:_SetOverlayMode(mode)
    local normalized = string.lower(tostring(mode or "snow"))
    local resolved = "Snow"
    if normalized == "rain" then
        resolved = "Rain"
    elseif normalized == "stars" or normalized == "star" then
        resolved = "Stars"
    elseif normalized == "none" or normalized == "off" then
        resolved = "None"
    end
    local changed = self._overlayMode ~= resolved
    self._overlayMode = resolved
    if self.uiOverlayModeValueLabel then
        self.uiOverlayModeValueLabel.Text = resolved
    end
    if self.snowLayerFrame then
        self.snowLayerFrame.Visible = self.isToggledOn and self._uiVisualSettings.Snow and resolved ~= "None"
    end
    if changed or resolved == "None" then
        self._snowSpawnAccumulator = 0
        self:_ClearSnowflakes()
    end
end

function superMegaAwesomeLibrary:_SetBackgroundEffectsEnabled(enabled)
    self._uiVisualSettings.BackgroundEffects = enabled == true
    if self.mainBackgroundEffectsFrame then
        self.mainBackgroundEffectsFrame.Visible = self._uiVisualSettings.BackgroundEffects
    end
end

function superMegaAwesomeLibrary:_SetTextGradientEnabled(enabled)
    self._uiVisualSettings.TextGradient = enabled == true
    local accent = self.config.AccentColor
    local gradientSweepSpeed = 0.9
    local animationTime = tonumber(self._textGradientAnimationTime) or 0
    local sweepX = ((animationTime * gradientSweepSpeed) % 2) - 1
    for _, label in ipairs(self._gradientLabels) do
        if label and label.Parent then
            local gradientObj = label:FindFirstChild("FlowUITextGradient")
            if self._uiVisualSettings.TextGradient then
                if not gradientObj then
                    gradientObj = makeThingExist("UIGradient", {
                        Name = "FlowUITextGradient",
                        Rotation = 0,
                        Parent = label
                    })
                end
                gradientObj.Rotation = 0
                gradientObj.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, accent:Lerp(Color3.new(1, 1, 1), 0.2)),
                    ColorSequenceKeypoint.new(0.55, Color3.new(1, 1, 1)),
                    ColorSequenceKeypoint.new(1, accent:Lerp(Color3.new(1, 1, 1), 0.35))
                })
                gradientObj.Offset = Vector2.new(sweepX, 0)
            elseif gradientObj then
                gradientObj:Destroy()
            end
        end
    end
end

-- [v8] pastikan Blur / Background FX / Text Gradient yang statusnya ON benar-benar aktif.
-- Label yang dibuat setelah window jadi (tab, dashboard, dll) otomatis ikut gradient,
-- dan blur/bg fx yang terhapus game / ke-reset akan dipasang lagi.
function superMegaAwesomeLibrary:_SyncVisualDefaults()
    if self._destroyed then return end
    local vs = self._uiVisualSettings
    if vs.Blur and self.isToggledOn then
        local blur = self._blurEffectRef
        if not (blur and blur.Parent) then blur = self:_EnsureBlurEffect() end
        local target = isMobileUserSadly and 14 or 18
        if blur and not blur.Enabled then blur.Enabled = true end
        if blur and blur.Size < target - 0.5 and not self._blurTweening then
            self:_SetBlurActive(true, false)
        end
        if self.backdropDimFrame and self.backdropDimFrame.BackgroundTransparency > 0.6 then
            self.backdropDimFrame.BackgroundTransparency = 0.55
        end
    end
    if vs.BackgroundEffects and self.mainBackgroundEffectsFrame and not self.mainBackgroundEffectsFrame.Visible then
        self.mainBackgroundEffectsFrame.Visible = true
    end
    if vs.TextGradient then
        for _, label in ipairs(self._gradientLabels) do
            if label and label.Parent and not label:FindFirstChild("FlowUITextGradient") then
                self:_SetTextGradientEnabled(true)
                break
            end
        end
    end
end

function superMegaAwesomeLibrary:_AnimateTextGradients(dt)
    self._syncAccumulator = (self._syncAccumulator or 0) + (dt or 0)
    if self._syncAccumulator >= 1 then
        self._syncAccumulator = 0
        pcall(function() self:_SyncVisualDefaults() end)
    end
    if not self._uiVisualSettings.TextGradient then
        return
    end

    local gradientSweepSpeed = 0.9
    self._textGradientAnimationTime = (tonumber(self._textGradientAnimationTime) or 0) + (dt or 0)
    -- ~20 updates per second is invisible for a slow sweep, and nothing animates while the user is scrolling
    self._gradientAccumulator = (self._gradientAccumulator or 0) + (dt or 0)
    if self._gradientAccumulator < 0.05 or self._scrollDriver then
        return
    end
    self._gradientAccumulator = 0

    local sweepX = ((self._textGradientAnimationTime * gradientSweepSpeed) % 2) - 1
    local animatedOffset = Vector2.new(sweepX, 0)
    self._gradientCache = self._gradientCache or setmetatable({}, {__mode = "k"})

    for _, label in ipairs(self._gradientLabels) do
        if label and label.Parent and label.Visible then
            local gradientObj = self._gradientCache[label]
            if not gradientObj or not gradientObj.Parent then
                gradientObj = label:FindFirstChild("FlowUITextGradient")
                self._gradientCache[label] = gradientObj
            end
            if gradientObj then
                gradientObj.Offset = animatedOffset
            end
        end
    end
end

-- [v7] Poppins: diunduh sekali (Google Fonts) lalu dibuat jadi font family custom
local poppinsFamilyCache
local function buildPoppinsFamily()
    if poppinsFamilyCache then return poppinsFamilyCache end
    if not (writefile and isfile and getcustomasset and makefolder and isfolder) then return nil end
    local folder = "NemesisFonts"
    pcall(function() if not isfolder(folder) then makefolder(folder) end end)
    local faces = {}
    for _, def in ipairs({{"Regular", 400}, {"Medium", 500}, {"SemiBold", 600}, {"Bold", 700}}) do
        local path = folder .. "/Poppins-" .. def[1] .. ".ttf"
        local have = false
        pcall(function() have = isfile(path) end)
        if not have then
            local ok, data = pcall(function()
                return game:HttpGet("https://raw.githubusercontent.com/google/fonts/main/ofl/poppins/Poppins-" .. def[1] .. ".ttf")
            end)
            if not ok or type(data) ~= "string" or #data < 1000 then return nil end
            local wrote = pcall(writefile, path, data)
            if not wrote then return nil end
        end
        local okAsset, asset = pcall(getcustomasset, path)
        if not okAsset or not asset then return nil end
        table.insert(faces, {name = def[1], weight = def[2], style = "normal", assetId = asset})
    end
    local jsonPath = folder .. "/Poppins.json"
    local okJson = pcall(function() writefile(jsonPath, httpServiceNoCap:JSONEncode({name = "Poppins", faces = faces})) end)
    if not okJson then return nil end
    local okFam, family = pcall(getcustomasset, jsonPath)
    if okFam and family then poppinsFamilyCache = family end
    return poppinsFamilyCache
end

function superMegaAwesomeLibrary:ApplyFontPreset(index)
    if #self._fontPresets == 0 then
        return
    end
    local normalizedIndex = tonumber(index) or (self._fontPresetIndex + 1)
    if normalizedIndex > #self._fontPresets then
        normalizedIndex = 1
    elseif normalizedIndex < 1 then
        normalizedIndex = #self._fontPresets
    end
    self._fontPresetIndex = normalizedIndex
    local preset = self._fontPresets[self._fontPresetIndex]
    local targetFontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
    if preset.Loader == "Poppins" and not preset.Family then
        local family = poppinsFamilyCache
        if not family then
            if self.uiSettingsFontValueLabel then self.uiSettingsFontValueLabel.Text = "Poppins (loading...)" end
            local requested = self._fontPresetIndex
            task.spawn(function()
                local fam = buildPoppinsFamily()
                if fam then
                    preset.Family = fam
                    if self._fontPresetIndex == requested and not self._destroyed then self:ApplyFontPreset(requested) end
                elseif self.uiSettingsFontValueLabel then
                    self.uiSettingsFontValueLabel.Text = "Poppins (unavailable)"
                end
            end)
            return
        end
        preset.Family = family
    end
    if preset.Family then
        local okFont, generatedFont = pcall(function()
            return Font.new(preset.Family, preset.Weight or Enum.FontWeight.SemiBold, Enum.FontStyle.Normal)
        end)
        if okFont then
            targetFontFace = generatedFont
        end
    elseif preset.EnumFont then
        pcall(function()
            targetFontFace = Font.fromEnum(preset.EnumFont)
        end)
    end
    if self.screenGuiYay and self.screenGuiYay.Parent then
        for _, obj in ipairs(self.screenGuiYay:GetDescendants()) do
            if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
                if preset.EnumFont then
                    pcall(function()
                        obj.Font = preset.EnumFont
                    end)
                end
                pcall(function()
                    obj.FontFace = targetFontFace
                end)
            end
        end
    end
    if self.uiSettingsFontValueLabel then
        self.uiSettingsFontValueLabel.Text = preset.Name
    end
end

function superMegaAwesomeLibrary:_RefreshAccentCore()
    local accent = self.config.AccentColor
    -- Keep the watermark logo's original asset colors; do not tint it with the UI accent.
    if self.mainBackgroundAccentGlow then
        self.mainBackgroundAccentGlow.ImageColor3 = accent
    end
    if self.uiAccentPreviewFrame then
        self.uiAccentPreviewFrame.BackgroundColor3 = accent
    end
    if self.uiSettingsButtonStroke then
        self.uiSettingsButtonStroke.Color = self.uiSettingsOpen and accent:Lerp(Color3.fromRGB(20, 20, 20), 0.45) or Color3.fromRGB(45, 45, 45)
    end
    if self.currentTabYay and self.currentTabYay.buttonFrame then
        self.currentTabYay.buttonFrame.BackgroundColor3 = accent
    end
    self:_SetTextGradientEnabled(self._uiVisualSettings.TextGradient)
end

function superMegaAwesomeLibrary:_ApplyOpenCloseVisuals(instant)
    self:_SetBlurActive(self.isToggledOn, instant)
    if self.backdropDimFrame then
        local targetTransparency = (self.isToggledOn and self._uiVisualSettings.Blur) and 0.55 or 1
        if instant then
            self.backdropDimFrame.BackgroundTransparency = targetTransparency
        else
            smoothMoveGoWoosh(self.backdropDimFrame, {
                BackgroundTransparency = targetTransparency
            }, 0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        end
    end
    if self.snowLayerFrame then
        self.snowLayerFrame.Visible = self.isToggledOn and self._uiVisualSettings.Snow and self._overlayMode ~= "None"
    end
    if not self.isToggledOn or not self._uiVisualSettings.Snow or self._overlayMode == "None" then
        self._snowSpawnAccumulator = 0
        self:_ClearSnowflakes()
    end
    self:_UpdateESPPreview(0)
end

local function flowPreviewPullValue(sourceTable, keys)
    if type(sourceTable) ~= "table" then
        return nil
    end
    for _, key in ipairs(keys) do
        local value = sourceTable[key]
        if value ~= nil then
            return value
        end
    end
    return nil
end

local function flowPreviewToBool(value)
    if type(value) == "boolean" then
        return value
    end
    if type(value) == "number" then
        return value ~= 0
    end
    if type(value) == "string" then
        local normalized = string.lower(value)
        if normalized == "true" or normalized == "on" or normalized == "enabled" or normalized == "yes" or normalized == "1" then
            return true
        end
        if normalized == "false" or normalized == "off" or normalized == "disabled" or normalized == "no" or normalized == "0" then
            return false
        end
    end
    return nil
end

local function flowPreviewToColor3(value)
    if typeof(value) == "Color3" then
        return value
    end
    if type(value) ~= "table" then
        return nil
    end
    local r = value.r or value.R or value[1]
    local g = value.g or value.G or value[2]
    local b = value.b or value.B or value[3]
    if type(r) ~= "number" or type(g) ~= "number" or type(b) ~= "number" then
        return nil
    end
    if r > 1 or g > 1 or b > 1 then
        r, g, b = r / 255, g / 255, b / 255
    end
    return Color3.new(math.clamp(r, 0, 1), math.clamp(g, 0, 1), math.clamp(b, 0, 1))
end

local flowPreviewCoreBodyParts = {
    Head = true,
    UpperTorso = true,
    LowerTorso = true,
    Torso = true,
    LeftUpperArm = true,
    LeftLowerArm = true,
    LeftHand = true,
    RightUpperArm = true,
    RightLowerArm = true,
    RightHand = true,
    LeftUpperLeg = true,
    LeftLowerLeg = true,
    LeftFoot = true,
    RightUpperLeg = true,
    RightLowerLeg = true,
    RightFoot = true,
    ["Left Arm"] = true,
    ["Right Arm"] = true,
    ["Left Leg"] = true,
    ["Right Leg"] = true
}

function superMegaAwesomeLibrary:SetESPPreviewProvider(providerFn)
    if providerFn ~= nil and type(providerFn) ~= "function" then
        return false, "ESP preview provider must be a function or nil."
    end
    self._espPreviewProvider = providerFn
    self._espPreviewResolveAccumulator = 0.2
    return true
end

function superMegaAwesomeLibrary:SetESPPreviewData(previewData)
    if previewData ~= nil and type(previewData) ~= "table" then
        return false, "ESP preview data must be a table or nil."
    end
    self._espPreviewData = previewData
    self._espPreviewResolveAccumulator = 0.2
    return true
end

function superMegaAwesomeLibrary:SetESPPreviewEnabled(enabled)
    self._uiVisualSettings.ESPSelfPreview = enabled == true
    self:_UpdateESPPreview(0)
end

function superMegaAwesomeLibrary:_ResolveESPPreviewWalkAnimationId(sourceCharacter)
    if not sourceCharacter then
        return nil
    end
    local animateScript = sourceCharacter:FindFirstChild("Animate")
    if animateScript then
        local preferredFolders = {"walk", "run"}
        for _, folderName in ipairs(preferredFolders) do
            local folder = animateScript:FindFirstChild(folderName)
            if folder then
                local directAnimation = folder:FindFirstChildWhichIsA("Animation")
                if directAnimation and type(directAnimation.AnimationId) == "string" and directAnimation.AnimationId ~= "" then
                    return directAnimation.AnimationId
                end
                for _, child in ipairs(folder:GetDescendants()) do
                    if child:IsA("Animation") and type(child.AnimationId) == "string" and child.AnimationId ~= "" then
                        return child.AnimationId
                    end
                end
            end
        end
        for _, child in ipairs(animateScript:GetDescendants()) do
            if child:IsA("Animation") then
                local childName = string.lower(child.Name or "")
                if (string.find(childName, "walk", 1, true) or string.find(childName, "run", 1, true))
                    and type(child.AnimationId) == "string"
                    and child.AnimationId ~= "" then
                    return child.AnimationId
                end
            end
        end
    end
    return nil
end

function superMegaAwesomeLibrary:_StartESPPreviewWalkAnimation(sourceCharacter)
    if not self._espPreviewCharacter or not self._espPreviewCharacter.Parent then
        return
    end
    if self._espPreviewWalkTrack and self._espPreviewWalkTrack.IsPlaying and self._espPreviewAnimationId then
        pcall(function()
            self._espPreviewWalkTrack:AdjustSpeed(0.95)
        end)
        return
    end
    local previewHumanoid = self._espPreviewCharacter:FindFirstChildOfClass("Humanoid")
    if not previewHumanoid then
        return
    end
    local resolvedId = self:_ResolveESPPreviewWalkAnimationId(sourceCharacter)
    if not resolvedId then
        return
    end
    if self._espPreviewWalkTrack and self._espPreviewAnimationId ~= resolvedId then
        pcall(function()
            self._espPreviewWalkTrack:Stop(0.1)
        end)
        pcall(function()
            self._espPreviewWalkTrack:Destroy()
        end)
        self._espPreviewWalkTrack = nil
    end

    local animator = previewHumanoid:FindFirstChildOfClass("Animator")
    if not animator then
        animator = Instance.new("Animator")
        animator.Parent = previewHumanoid
    end
    if not self._espPreviewWalkTrack then
        local walkAnimation = Instance.new("Animation")
        walkAnimation.AnimationId = resolvedId
        local okTrack, track = pcall(function()
            return animator:LoadAnimation(walkAnimation)
        end)
        walkAnimation:Destroy()
        if not okTrack or not track then
            return
        end
        track.Looped = true
        self._espPreviewWalkTrack = track
        self._espPreviewAnimationId = resolvedId
    end
    if self._espPreviewWalkTrack and not self._espPreviewWalkTrack.IsPlaying then
        pcall(function()
            self._espPreviewWalkTrack:Play(0.15, 1, 1)
        end)
    end
    if self._espPreviewWalkTrack then
        pcall(function()
            self._espPreviewWalkTrack:AdjustSpeed(0.95)
        end)
    end
end

function superMegaAwesomeLibrary:_CreateESPPreviewFallbackCharacter()
    local fallbackModel = nil
    local created = false
    local previewUserId, previewImageUrl = resolveAvatar3DUserIdFromRobloxEndpoint(theOneAndOnlyPlayer.UserId)
    self._espPreviewAvatar3DUserId = previewUserId
    self._espPreviewAvatar3DImageUrl = previewImageUrl

    local okCreate = pcall(function()
        fallbackModel = playersAreNoobs:CreateHumanoidModelFromUserId(previewUserId)
    end)
    if not okCreate or not fallbackModel then
        local okDescription, humanoidDescription = pcall(function()
            return playersAreNoobs:GetHumanoidDescriptionFromUserId(previewUserId)
        end)
        if okDescription and humanoidDescription then
            pcall(function()
                fallbackModel = playersAreNoobs:CreateHumanoidModelFromDescription(humanoidDescription, Enum.HumanoidRigType.R15)
                created = true
            end)
        end
    end
    if fallbackModel then
        fallbackModel.Name = "FlowESPSelfPreviewAvatar"
        if created and not fallbackModel:FindFirstChildOfClass("Humanoid") then
            fallbackModel:Destroy()
            return nil
        end
    end
    return fallbackModel
end

function superMegaAwesomeLibrary:_DestroyESPPreviewCharacter()
    if self._espPreviewWalkTrack then
        pcall(function()
            self._espPreviewWalkTrack:Stop(0.1)
        end)
        pcall(function()
            self._espPreviewWalkTrack:Destroy()
        end)
    end
    self._espPreviewWalkTrack = nil
    self._espPreviewAnimationId = nil
    if self._espPreviewHighlight then
        self._espPreviewHighlight.Adornee = nil
        self._espPreviewHighlight.Enabled = false
    end
    self._espPreviewPartDefaults = {}
    if self._espPreviewCharacter and self._espPreviewCharacter.Parent then
        self._espPreviewCharacter:Destroy()
    end
    self._espPreviewCharacter = nil
    self._espPreviewLastCharacter = nil
    self._espPreviewPivotYOffset = -2
end

function superMegaAwesomeLibrary:_EnsureESPPreviewCharacter()
    if not self._espPreviewWorldModel then
        return
    end
    local liveCharacter = theOneAndOnlyPlayer.Character
    if self._espPreviewCharacter and self._espPreviewCharacter.Parent then
        if liveCharacter and self._espPreviewLastCharacter == liveCharacter then
            return
        end
        if not liveCharacter and self._espPreviewLastCharacter == false then
            return
        end
    end
    self:_DestroyESPPreviewCharacter()

    local function cloneFromLiveCharacter()
        if not liveCharacter then
            return nil
        end
        local previousArchivable = liveCharacter.Archivable
        local cloneCharacter = nil
        local clonedOk = pcall(function()
            liveCharacter.Archivable = true
            cloneCharacter = liveCharacter:Clone()
        end)
        pcall(function()
            liveCharacter.Archivable = previousArchivable
        end)
        if not clonedOk then
            return nil
        end
        return cloneCharacter
    end

    local function preparePreviewCharacter(model)
        if not model then
            return false
        end
        self._espPreviewPartDefaults = {}
        local rootPart = model:FindFirstChild("HumanoidRootPart")
            or model:FindFirstChild("UpperTorso")
            or model:FindFirstChild("Torso")
        local corePartCount = 0
        local visibleCorePartCount = 0
        local visiblePartCount = 0
        for _, obj in ipairs(model:GetDescendants()) do
            if obj:IsA("Script") or obj:IsA("LocalScript") then
                obj:Destroy()
            elseif obj:IsA("BasePart") then
                local isRootPart = obj.Name == "HumanoidRootPart"
                local isCoreBodyPart = flowPreviewCoreBodyParts[obj.Name] == true
                local sanitizedTransparency = math.clamp(tonumber(obj.Transparency) or 0, 0, 1)
                if isRootPart then
                    sanitizedTransparency = 1
                elseif isCoreBodyPart and sanitizedTransparency >= 0.98 then
                    sanitizedTransparency = 0
                end
                self._espPreviewPartDefaults[obj] = {
                    Color = obj.Color,
                    Material = obj.Material,
                    Transparency = sanitizedTransparency
                }
                obj.Transparency = sanitizedTransparency
                pcall(function()
                    obj.LocalTransparencyModifier = 0
                end)
                if isRootPart then
                    pcall(function()
                        obj.LocalTransparencyModifier = 1
                    end)
                end
                obj.CanCollide = false
                pcall(function()
                    obj.CanQuery = false
                end)
                pcall(function()
                    obj.CanTouch = false
                end)
                obj.Massless = true
                obj.CastShadow = false
                if rootPart == nil then
                    rootPart = obj
                end
                obj.Anchored = obj == rootPart

                if sanitizedTransparency < 0.985 and obj.Size.Magnitude > 0.05 then
                    visiblePartCount = visiblePartCount + 1
                end
                if isCoreBodyPart then
                    corePartCount = corePartCount + 1
                    if sanitizedTransparency < 0.985 then
                        visibleCorePartCount = visibleCorePartCount + 1
                    end
                end
            end
        end

        if corePartCount > 0 and visibleCorePartCount < math.min(4, corePartCount) then
            for part, originalData in pairs(self._espPreviewPartDefaults) do
                if part and part.Parent and originalData and flowPreviewCoreBodyParts[part.Name] then
                    originalData.Transparency = 0
                    part.Transparency = 0
                end
            end
            visibleCorePartCount = math.max(visibleCorePartCount, math.min(4, corePartCount))
        end

        if visiblePartCount < 6 then
            for _, obj in ipairs(model:GetDescendants()) do
                if obj:IsA("BasePart") and obj.Transparency >= 0.98 and obj.Name ~= "HumanoidRootPart" then
                    obj.Transparency = 0
                end
            end
            visiblePartCount = 6
        end

        if corePartCount > 0 and corePartCount < 3 then
            return false
        end
        if corePartCount >= 3 and visibleCorePartCount < 3 then
            return false
        end
        return visiblePartCount >= 6
    end

    local previewCharacter = self:_CreateESPPreviewFallbackCharacter()
    local hasReliableAvatar = preparePreviewCharacter(previewCharacter)
    if not hasReliableAvatar and previewCharacter and previewCharacter.Parent == nil then
        previewCharacter:Destroy()
        previewCharacter = nil
    end

    if not previewCharacter then
        previewCharacter = cloneFromLiveCharacter()
        local hasReliableClone = preparePreviewCharacter(previewCharacter)
        if not hasReliableClone and previewCharacter and previewCharacter.Parent == nil then
            previewCharacter:Destroy()
            previewCharacter = nil
        end
    end
    if not previewCharacter then
        return
    end

    previewCharacter.Parent = self._espPreviewWorldModel
    local previewHumanoid = previewCharacter:FindFirstChildOfClass("Humanoid")
    if previewHumanoid then
        previewHumanoid.AutoRotate = false
        previewHumanoid.PlatformStand = false
        pcall(function()
            previewHumanoid.BreakJointsOnDeath = false
        end)
    end
    local previewExtents = Vector3.new(4, 6, 3)
    local okPreviewExtents, calculatedPreviewExtents = pcall(function()
        return previewCharacter:GetExtentsSize()
    end)
    if okPreviewExtents and calculatedPreviewExtents then
        previewExtents = calculatedPreviewExtents
    end
    local pivotYOffset = -math.clamp(previewExtents.Y * 0.43, 1.2, 3.2)
    self._espPreviewPivotYOffset = pivotYOffset
    local initialYaw = tonumber(self._espPreviewRotationYaw) or tonumber(self._espPreviewRotationTargetYaw) or math.rad(180)
    self._espPreviewRotationYaw = initialYaw
    self._espPreviewRotationTargetYaw = initialYaw
    pcall(function()
        previewCharacter:PivotTo(CFrame.new(0, pivotYOffset, 0) * CFrame.Angles(0, initialYaw, 0))
    end)
    self._espPreviewCharacter = previewCharacter
    self._espPreviewLastCharacter = liveCharacter or false
    if self._espPreviewHighlight then
        self._espPreviewHighlight.Adornee = previewCharacter
    end

    if self._espPreviewCamera then
        local focus = Vector3.new(0, math.clamp(previewExtents.Y * 0.36, 1.2, 2.45), 0)
        local depth = math.clamp(math.max(8, previewExtents.Y * 1.35 + previewExtents.X * 0.75), 8, 24)
        self._espPreviewCamera.FieldOfView = 32
        self._espPreviewCamera.CFrame = CFrame.new(Vector3.new(0, focus.Y, depth), focus)
    end
    self:_StartESPPreviewWalkAnimation(liveCharacter)
end

function superMegaAwesomeLibrary:_CreateESPPreviewPanel()
    if self._espPreviewPanel and self._espPreviewPanel.Parent then
        return
    end
    if not self.screenGuiYay or not self.screenGuiYay.Parent then
        return
    end

    local panelWidth = 226 * mobileScaleFactor
    local panelHeight = 296 * mobileScaleFactor
    local defaultPanelPosition = UDim2.new(0, 14 * mobileScaleFactor, 0, 66 * mobileScaleFactor)
    if self.mainFrameYay and self.mainFrameYay.Parent then
        local mainPos = self.mainFrameYay.Position
        defaultPanelPosition = UDim2.new(
            mainPos.X.Scale,
            mainPos.X.Offset - (753 * mobileScaleFactor) / 2 - panelWidth - 12 * mobileScaleFactor,
            mainPos.Y.Scale,
            mainPos.Y.Offset - (493 * mobileScaleFactor) / 2 + 42 * mobileScaleFactor
        )
    end
    local panel = makeThingExist("Frame", {
        Name = "FlowESPSelfPreviewPanel",
        BackgroundColor3 = Color3.fromRGB(14, 14, 16),
        BackgroundTransparency = 0.06,
        BorderSizePixel = 0,
        Position = defaultPanelPosition,
        Size = UDim2.new(0, panelWidth, 0, panelHeight),
        Visible = false,
        ZIndex = 30,
        Parent = self.screenGuiYay
    })
    makeThingExist("UICorner", {CornerRadius = UDim.new(0, 10), Parent = panel})
    makeThingExist("UIStroke", {Color = Color3.fromRGB(40, 40, 44), Thickness = 1.1, Parent = panel})
    makeThingExist("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 24)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(12, 12, 14))
        }),
        Rotation = 90,
        Parent = panel
    })
    local panelDragHandle = makeThingExist("TextButton", {
        Name = "ESPPreviewDragHandle",
        Text = "",
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, 0, 0, 24 * mobileScaleFactor),
        Active = true,
        ZIndex = 36,
        Parent = panel
    })

    makeThingExist("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10 * mobileScaleFactor, 0, 8 * mobileScaleFactor),
        Size = UDim2.new(0, 110 * mobileScaleFactor, 0, 16 * mobileScaleFactor),
        Text = "ESP Preview",
        TextXAlignment = Enum.TextXAlignment.Left,
        TextColor3 = Color3.fromRGB(240, 240, 240),
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
        TextSize = 13 * mobileScaleFactor,
        ZIndex = 31,
        Parent = panel
    })

self._espPreviewHeaderTag = makeThingExist("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0.42, 0, 0, 8 * mobileScaleFactor),
        Size = UDim2.new(0.58, -8 * mobileScaleFactor, 0, 16 * mobileScaleFactor),
        Text = ".gg/nemesishub",  
        TextXAlignment = Enum.TextXAlignment.Right,
        TextColor3 = Color3.fromRGB(156, 156, 164),
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
        TextSize = 12 * mobileScaleFactor,
        TextTruncate = Enum.TextTruncate.AtEnd,
        ZIndex = 31,
        Parent = panel
    })

    local card = makeThingExist("Frame", {
        BackgroundColor3 = Color3.fromRGB(11, 11, 13),
        BorderSizePixel = 0,
        Position = UDim2.new(0, 8 * mobileScaleFactor, 0, 28 * mobileScaleFactor),
        Size = UDim2.new(1, -16 * mobileScaleFactor, 1, -34 * mobileScaleFactor),
        ZIndex = 30,
        Parent = panel
    })
    makeThingExist("UICorner", {CornerRadius = UDim.new(0, 8), Parent = card})
    makeThingExist("UIStroke", {Color = Color3.fromRGB(33, 33, 37), Parent = card})

    local viewport = makeThingExist("ViewportFrame", {
        BackgroundColor3 = Color3.fromRGB(15, 15, 18),
        BackgroundTransparency = 0.08,
        Position = UDim2.new(0, 6 * mobileScaleFactor, 0, 6 * mobileScaleFactor),
        Size = UDim2.new(1, -12 * mobileScaleFactor, 1, -44 * mobileScaleFactor),
        Active = true,
        LightColor = Color3.new(1, 1, 1),
        LightDirection = Vector3.new(-0.34, -1, -0.22),
        Ambient = Color3.fromRGB(122, 122, 130),
        ZIndex = 31,
        Parent = card
    })
    makeThingExist("UICorner", {CornerRadius = UDim.new(0, 7), Parent = viewport})
    local worldModel = makeThingExist("WorldModel", {Parent = viewport})
    local camera = makeThingExist("Camera", {
        CFrame = CFrame.new(Vector3.new(0, 1.4, 7.2), Vector3.new(0, 1.2, 0)),
        Parent = viewport
    })
    viewport.CurrentCamera = camera

    local rotateCapture = makeThingExist("TextButton", {
        Name = "ESPPreviewRotateCapture",
        Text = "",
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, 0, 1, 0),
        Active = true,
        Selectable = false,
        ZIndex = 35,
        Parent = viewport
    })

    self._espPreviewBox = makeThingExist("Frame", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0.18, 0, 0.07, 0),
        Size = UDim2.new(0.64, 0, 0.84, 0),
        Visible = false,
        ZIndex = 33,
        Parent = viewport
    })
    self._espPreviewBoxStroke = makeThingExist("UIStroke", {
        Color = self.config.AccentColor,
        Thickness = 1.5,
        Parent = self._espPreviewBox
    })

    self._espPreviewHealthTrack = makeThingExist("Frame", {
        BackgroundColor3 = Color3.fromRGB(28, 28, 32),
        BorderSizePixel = 0,
        Position = UDim2.new(0.15, 0, 0.07, 0),
        Size = UDim2.new(0, 3 * mobileScaleFactor, 0.84, 0),
        Visible = false,
        ZIndex = 33,
        Parent = viewport
    })
    self._espPreviewHealthFill = makeThingExist("Frame", {
        BackgroundColor3 = Color3.fromRGB(100, 255, 100),
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.new(0, 0, 1, 0),
        Size = UDim2.new(1, 0, 1, 0),
        ZIndex = 34,
        Parent = self._espPreviewHealthTrack
    })

    self._espPreviewDot = makeThingExist("Frame", {
        BackgroundColor3 = self.config.AccentColor,
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, -3 * mobileScaleFactor, 0.27, -3 * mobileScaleFactor),
        Size = UDim2.new(0, 6 * mobileScaleFactor, 0, 6 * mobileScaleFactor),
        Visible = false,
        ZIndex = 34,
        Parent = viewport
    })
    makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = self._espPreviewDot})

    self._espPreviewTracer = makeThingExist("Frame", {
        BackgroundColor3 = self.config.AccentColor,
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0.5, 1),
        Position = UDim2.new(0.5, -1 * mobileScaleFactor, 0.58, 0),
        Size = UDim2.new(0, 2 * mobileScaleFactor, 0.34, 0),
        Visible = false,
        ZIndex = 33,
        Parent = viewport
    })

    self._espPreviewName = makeThingExist("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 0, 1 * mobileScaleFactor),
        Size = UDim2.new(1, 0, 0, 15 * mobileScaleFactor),
        Text = tostring(theOneAndOnlyPlayer.Name),
        TextColor3 = self.config.AccentColor,
        TextXAlignment = Enum.TextXAlignment.Center,
        TextTruncate = Enum.TextTruncate.AtEnd,
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold, Enum.FontStyle.Normal),
        TextSize = 11 * mobileScaleFactor,
        Visible = false,
        ZIndex = 34,
        Parent = viewport
    })

    self._espPreviewDistance = makeThingExist("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 1, -18 * mobileScaleFactor),
        Size = UDim2.new(1, 0, 0, 14 * mobileScaleFactor),
        Text = "0m",
        TextColor3 = Color3.fromRGB(186, 186, 192),
        TextXAlignment = Enum.TextXAlignment.Center,
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
        TextSize = 11 * mobileScaleFactor,
        Visible = false,
        ZIndex = 34,
        Parent = card
    })

    self._espPreviewItem = makeThingExist("TextLabel", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 0, 1, -32 * mobileScaleFactor),
        Size = UDim2.new(1, 0, 0, 14 * mobileScaleFactor),
        Text = "None",
        TextColor3 = Color3.fromRGB(206, 206, 212),
        TextXAlignment = Enum.TextXAlignment.Center,
        TextTruncate = Enum.TextTruncate.AtEnd,
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
        TextSize = 11 * mobileScaleFactor,
        Visible = false,
        ZIndex = 34,
        Parent = card
    })

    self._espPreviewHighlight = makeThingExist("Highlight", {
        Enabled = false,
        DepthMode = Enum.HighlightDepthMode.AlwaysOnTop,
        Parent = worldModel
    })

    self._espPreviewPanel = panel
    self._espPreviewViewport = viewport
    self._espPreviewWorldModel = worldModel
    self._espPreviewCamera = camera
    self._espPreviewRotateCapture = rotateCapture

    local function stopESPPreviewRotate()
        self._espPreviewIsRotating = false
        self._espPreviewRotateInput = nil
    end

    self:_TrackConnection(rotateCapture.InputBegan:Connect(function(input)
        local isMouse = input.UserInputType == Enum.UserInputType.MouseButton1
        local isTouch = input.UserInputType == Enum.UserInputType.Touch
        if not isMouse and not isTouch then
            return
        end
        self._espPreviewIsRotating = true
        self._espPreviewRotateInput = isTouch and input or nil
        self._espPreviewRotateLastX = input.Position.X
    end))

    self:_TrackConnection(rotateCapture.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            stopESPPreviewRotate()
            return
        end
        if input.UserInputType == Enum.UserInputType.Touch and (self._espPreviewRotateInput == nil or input == self._espPreviewRotateInput) then
            stopESPPreviewRotate()
        end
    end))

    self:_TrackConnection(thisInputServiceGoesHard.InputChanged:Connect(function(input)
        if not self._espPreviewIsRotating then
            return
        end
        local isMouseMove = input.UserInputType == Enum.UserInputType.MouseMovement and self._espPreviewRotateInput == nil
        local isTouchMove = input.UserInputType == Enum.UserInputType.Touch and (self._espPreviewRotateInput == nil or input == self._espPreviewRotateInput)
        if not isMouseMove and not isTouchMove then
            return
        end

        local previousX = tonumber(self._espPreviewRotateLastX) or input.Position.X
        local deltaX = input.Position.X - previousX
        self._espPreviewRotateLastX = input.Position.X

        local rotationSensitivity = isMobileUserSadly and 0.02 or 0.015
        self._espPreviewRotationTargetYaw = (tonumber(self._espPreviewRotationTargetYaw) or math.rad(180)) - deltaX * rotationSensitivity
    end))

    self:_TrackConnection(thisInputServiceGoesHard.InputEnded:Connect(function(input)
        if not self._espPreviewIsRotating then
            return
        end
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            stopESPPreviewRotate()
            return
        end
        if input.UserInputType == Enum.UserInputType.Touch and (self._espPreviewRotateInput == nil or input == self._espPreviewRotateInput) then
            stopESPPreviewRotate()
        end
    end))

    makeDraggableCuzWeCan(panel, panelDragHandle, self)
    self:_EnsureESPPreviewCharacter()
    self:_UpdateESPPreview(0)
end

function superMegaAwesomeLibrary:_ResolveESPPreviewState()
    local state = {
        Enabled = true,
        ShowBox = false,
        ShowHealth = false,
        ShowName = false,
        UseDisplayName = false,
        ShowItem = false,
        ShowDistance = false,
        ShowTracers = false,
        ShowDot = false,
        ShowChams = false,
        ShowHighlight = false,
        ChamsTransparency = 0.55,
        HighlightFillTransparency = 0.5,
        HighlightOutlineTransparency = 0,
        Color = self.config.AccentColor,
        Name = tostring(theOneAndOnlyPlayer.Name),
        Item = "None",
        DistanceText = "0m",
        HealthPercent = 1
    }

    local liveCharacter = theOneAndOnlyPlayer.Character
    local liveHumanoid = liveCharacter and liveCharacter:FindFirstChildOfClass("Humanoid")
    if liveHumanoid and liveHumanoid.MaxHealth > 0 then
        state.HealthPercent = math.clamp(liveHumanoid.Health / liveHumanoid.MaxHealth, 0, 1)
    end
    if liveCharacter then
        for _, tool in ipairs(liveCharacter:GetChildren()) do
            if tool:IsA("Tool") then
                state.Item = tool.Name
                break
            end
        end
        local localRoot = liveCharacter:FindFirstChild("HumanoidRootPart")
        local cameraRef = workspace.CurrentCamera
        if localRoot and cameraRef then
            state.DistanceText = string.format("%.0fm", (cameraRef.CFrame.Position - localRoot.Position).Magnitude)
        end
    end

    local function applyStateFromTrackedControls()
        local touched = false
        for flagName, control in pairs(self._trackedControls) do
            if type(control) == "table" and type(control.get) == "function" then
                local okValue, controlValue = pcall(control.get)
                if okValue then
                    local rawFlag = string.lower(tostring(flagName or ""))
                    local compactFlag = rawFlag:gsub("[^%w]", "")
                    local function hasFlagToken(...)
                        local tokens = {...}
                        for _, token in ipairs(tokens) do
                            local rawToken = string.lower(tostring(token))
                            local compactToken = rawToken:gsub("[^%w]", "")
                            if rawToken ~= "" and string.find(rawFlag, rawToken, 1, true) then
                                return true
                            end
                            if compactToken ~= "" and string.find(compactFlag, compactToken, 1, true) then
                                return true
                            end
                        end
                        return false
                    end
                    local boolValue = flowPreviewToBool(controlValue)
                    if boolValue ~= nil then
                        if hasFlagToken("esp enabled", "espenabled", "esp toggle", "toggle esp", "enable esp") then
                            state.Enabled = boolValue
                            touched = true
                        elseif hasFlagToken("show box", "showbox", "box esp", "boxes") then
                            state.ShowBox = boolValue
                            touched = true
                        elseif hasFlagToken("show health", "health bar", "healthesp", "showhealth") then
                            state.ShowHealth = boolValue
                            touched = true
                        elseif hasFlagToken("show name", "name esp", "nametag", "showname") then
                            state.ShowName = boolValue
                            touched = true
                        elseif hasFlagToken("display name", "usedisplayname") then
                            state.UseDisplayName = boolValue
                            touched = true
                        elseif hasFlagToken("show equipped item", "show item", "show weapon", "item esp", "tool esp") then
                            state.ShowItem = boolValue
                            touched = true
                        elseif hasFlagToken("show distance", "distance esp", "showdistance") then
                            state.ShowDistance = boolValue
                            touched = true
                        elseif hasFlagToken("show tracers", "tracers", "tracer esp") then
                            state.ShowTracers = boolValue
                            touched = true
                        elseif hasFlagToken("show dot", "dot esp", "head dot", "headdot") then
                            state.ShowDot = boolValue
                            touched = true
                        elseif hasFlagToken("chams enabled", "chams", "use chams") then
                            state.ShowChams = boolValue
                            touched = true
                        elseif hasFlagToken("highlight enabled", "use highlight", "highlight") then
                            state.ShowHighlight = boolValue
                            touched = true
                        end
                    elseif typeof(controlValue) == "Color3" then
                        if hasFlagToken("esp color", "visual color", "highlight color", "chams color", "espcolour", "visualcolour") then
                            state.Color = controlValue
                            touched = true
                        end
                    elseif type(controlValue) == "number" then
                        if hasFlagToken("chams transparency", "cham transparency") then
                            state.ChamsTransparency = math.clamp(controlValue, 0, 1)
                            touched = true
                        elseif hasFlagToken("fill transparency", "highlight fill transparency") then
                            state.HighlightFillTransparency = math.clamp(controlValue, 0, 1)
                            touched = true
                        elseif hasFlagToken("outline transparency", "highlight outline transparency") then
                            state.HighlightOutlineTransparency = math.clamp(controlValue, 0, 1)
                            touched = true
                        end
                    end
                end
            end
        end
        return touched
    end

    local function applyStateFrom(sourceTable)
        if type(sourceTable) ~= "table" then
            return false
        end
        local touched = false
        local function setBoolField(targetField, keys)
            local rawValue = flowPreviewPullValue(sourceTable, keys)
            local boolValue = flowPreviewToBool(rawValue)
            if boolValue ~= nil then
                state[targetField] = boolValue
                touched = true
            end
        end
        local function setNumberField(targetField, keys, minValue, maxValue)
            local rawValue = flowPreviewPullValue(sourceTable, keys)
            if type(rawValue) == "number" then
                state[targetField] = math.clamp(rawValue, minValue, maxValue)
                touched = true
            end
        end

        setBoolField("Enabled", {"ESPEnabled", "Enabled", "ESP", "MasterEnabled", "MasterSwitch"})
        setBoolField("ShowBox", {"ShowBox", "Boxes", "Box", "BoxESP"})
        setBoolField("ShowHealth", {"ShowHealth", "Health", "HealthBar", "HealthESP"})
        setBoolField("ShowName", {"ShowName", "Names", "NameESP", "Nametags"})
        setBoolField("UseDisplayName", {"UseDisplayName", "DisplayName", "DisplayNames"})
        setBoolField("ShowItem", {"ShowEquippedItem", "ShowItem", "ItemESP", "ShowWeapon", "ShowTool"})
        setBoolField("ShowDistance", {"ShowDistance", "Distance", "DistanceESP"})
        setBoolField("ShowTracers", {"ShowTracers", "Tracers", "TracerESP"})
        setBoolField("ShowDot", {"ShowDot", "Dot", "DotESP", "HeadDot"})
        setBoolField("ShowChams", {"ChamsEnabled", "Chams", "UseChams", "CharacterMaterial"})
        setBoolField("ShowHighlight", {"HighlightEnabled", "Highlight", "UseHighlight"})

        setNumberField("ChamsTransparency", {"ChamsTransparency", "ChamTransparency", "ChamsAlpha"}, 0, 1)
        setNumberField("HighlightFillTransparency", {"HighlightFillTransparency", "HighlightFillAlpha"}, 0, 1)
        setNumberField("HighlightOutlineTransparency", {"HighlightOutlineTransparency", "HighlightOutlineAlpha"}, 0, 1)

        local colorValue = flowPreviewToColor3(flowPreviewPullValue(sourceTable, {
            "VisualColor", "ESPColor", "Color", "Colour", "MainColor", "ChamsColor", "HighlightColor"
        }))
        if colorValue then
            state.Color = colorValue
            touched = true
        end

        local suppliedName = flowPreviewPullValue(sourceTable, {"Name", "PlayerName", "DisplayName", "NameText"})
        if type(suppliedName) == "string" and suppliedName ~= "" then
            state.Name = suppliedName
            touched = true
        end
        local suppliedItem = flowPreviewPullValue(sourceTable, {"Item", "ItemName", "Tool", "ToolName", "Weapon", "WeaponName"})
        if type(suppliedItem) == "string" and suppliedItem ~= "" then
            state.Item = suppliedItem
            touched = true
        end
        local suppliedDistanceText = flowPreviewPullValue(sourceTable, {"DistanceText", "DistanceString", "DistanceLabel"})
        if type(suppliedDistanceText) == "string" and suppliedDistanceText ~= "" then
            state.DistanceText = suppliedDistanceText
            touched = true
        else
            local suppliedDistance = flowPreviewPullValue(sourceTable, {"Distance", "DistanceValue"})
            if type(suppliedDistance) == "number" then
                state.DistanceText = string.format("%.0fm", suppliedDistance)
                touched = true
            end
        end

        local suppliedHealthPercent = flowPreviewPullValue(sourceTable, {"HealthPercent", "HPPercent", "HealthRatio"})
        if type(suppliedHealthPercent) == "number" then
            if suppliedHealthPercent > 1 then
                suppliedHealthPercent = suppliedHealthPercent / 100
            end
            state.HealthPercent = math.clamp(suppliedHealthPercent, 0, 1)
            touched = true
        else
            local suppliedHealth = flowPreviewPullValue(sourceTable, {"Health", "HP"})
            local suppliedMaxHealth = flowPreviewPullValue(sourceTable, {"MaxHealth", "MaxHP", "HealthMax"})
            if type(suppliedHealth) == "number" and type(suppliedMaxHealth) == "number" and suppliedMaxHealth > 0 then
                state.HealthPercent = math.clamp(suppliedHealth / suppliedMaxHealth, 0, 1)
                touched = true
            end
        end

        return touched
    end

    local appliedTracked = applyStateFromTrackedControls()
    local appliedExternal = false
    if type(self._espPreviewData) == "table" then
        appliedExternal = applyStateFrom(self._espPreviewData) or appliedExternal
    end
    if type(self._espPreviewProvider) == "function" then
        local ok, providerResult = pcall(self._espPreviewProvider, self, state)
        if ok and type(providerResult) == "table" then
            appliedExternal = applyStateFrom(providerResult) or appliedExternal
        end
    end

    if not appliedExternal and not appliedTracked then
        local candidates = {}
        local candidateSet = {}
        local function addCandidate(candidate)
            if type(candidate) ~= "table" then
                return
            end
            if candidateSet[candidate] then
                return
            end
            candidateSet[candidate] = true
            table.insert(candidates, candidate)
        end
        local function addFromEnvironment(env)
            if type(env) ~= "table" then
                return
            end
            addCandidate(env.Settings)
            addCandidate(env.settings)
            addCandidate(env.ESPSettings)
            addCandidate(env.VisualSettings)
            addCandidate(env.Visuals)
            addCandidate(env.ESP)
            addCandidate(env.esp)
            addCandidate(env.Flags)
            addCandidate(env.flags)
            if type(env.Config) == "table" then
                addCandidate(env.Config.Settings)
                addCandidate(env.Config.ESP)
                addCandidate(env.Config.Visuals)
            end
        end
        if type(getgenv) == "function" then
            local okEnv, env = pcall(getgenv)
            if okEnv then
                addFromEnvironment(env)
            end
        end
        addFromEnvironment(_G)

        local knownKeys = {
            "ESPEnabled", "ShowBox", "ShowHealth", "ShowName", "UseDisplayName", "ShowEquippedItem",
            "ShowDistance", "ShowTracers", "ShowDot", "ChamsEnabled", "HighlightEnabled", "VisualColor"
        }
        local bestCandidate = nil
        local bestScore = 0
        for _, candidate in ipairs(candidates) do
            local score = 0
            for _, keyName in ipairs(knownKeys) do
                if candidate[keyName] ~= nil then
                    score = score + 1
                end
            end
            if score > bestScore then
                bestScore = score
                bestCandidate = candidate
            end
        end
        if bestCandidate and bestScore > 0 then
            applyStateFrom(bestCandidate)
        end
    end

    if state.UseDisplayName then
        state.Name = tostring(theOneAndOnlyPlayer.DisplayName or theOneAndOnlyPlayer.Name)
    elseif state.Name == "" or state.Name == nil then
        state.Name = tostring(theOneAndOnlyPlayer.Name)
    end
    return state
end

function superMegaAwesomeLibrary:_UpdateESPPreview(dt)
    if not self._espPreviewPanel or not self._espPreviewPanel.Parent then
        self:_CreateESPPreviewPanel()
    end
    if not self._espPreviewPanel then
        return
    end

    local shouldShow = self.isToggledOn and self._uiVisualSettings.ESPSelfPreview
    self._espPreviewPanel.Visible = shouldShow
    if not shouldShow then
        return
    end

    self._espPreviewResolveAccumulator = self._espPreviewResolveAccumulator + (dt or 0)
    if not self._espPreviewState or self._espPreviewResolveAccumulator >= 0.16 then
        self._espPreviewState = self:_ResolveESPPreviewState()
        self._espPreviewResolveAccumulator = 0
    end
    local state = self._espPreviewState or self:_ResolveESPPreviewState()
    local previewColor = state.Color or self.config.AccentColor

    self:_EnsureESPPreviewCharacter()
    if self._espPreviewCharacter and self._espPreviewCharacter.Parent then
        local currentYaw = tonumber(self._espPreviewRotationYaw) or math.rad(180)
        local targetYaw = tonumber(self._espPreviewRotationTargetYaw) or currentYaw
        local yawDelta = math.atan2(math.sin(targetYaw - currentYaw), math.cos(targetYaw - currentYaw))
        local yawAlpha = math.clamp((dt or (1 / 60)) * 14, 0.08, 0.58)
        if math.abs(yawDelta) > 0.0004 then
            currentYaw = currentYaw + yawDelta * yawAlpha
            self._espPreviewRotationYaw = currentYaw
            local pivotYOffset = tonumber(self._espPreviewPivotYOffset) or -2
            pcall(function()
                self._espPreviewCharacter:PivotTo(CFrame.new(0, pivotYOffset, 0) * CFrame.Angles(0, currentYaw, 0))
            end)
        end
    end
    if not self._espPreviewWalkTrack or not self._espPreviewWalkTrack.IsPlaying then
        self:_StartESPPreviewWalkAnimation(theOneAndOnlyPlayer.Character)
    end
if self._espPreviewHeaderTag then
        self._espPreviewHeaderTag.Text = ".gg/nemesishub" -- [TELAH DIUBAH] 
    end
    if not self._espPreviewCharacter then
        if self._espPreviewBox then self._espPreviewBox.Visible = false end
        if self._espPreviewHealthTrack then self._espPreviewHealthTrack.Visible = false end
        if self._espPreviewDot then self._espPreviewDot.Visible = false end
        if self._espPreviewTracer then self._espPreviewTracer.Visible = false end
        if self._espPreviewName then self._espPreviewName.Visible = false end
        if self._espPreviewItem then self._espPreviewItem.Visible = false end
        if self._espPreviewDistance then self._espPreviewDistance.Visible = false end
        if self._espPreviewHighlight then self._espPreviewHighlight.Enabled = false end
        return
    end

    if self._espPreviewBoxStroke then self._espPreviewBoxStroke.Color = previewColor end
    if self._espPreviewDot then self._espPreviewDot.BackgroundColor3 = previewColor end
    if self._espPreviewTracer then self._espPreviewTracer.BackgroundColor3 = previewColor end

    local viewportCamera = self._espPreviewCamera or (self._espPreviewViewport and self._espPreviewViewport.CurrentCamera)
    local viewportSize = self._espPreviewViewport and self._espPreviewViewport.AbsoluteSize or Vector2.new(0, 0)
    local hasProjectedBox = false
    local boxMinX, boxMinY = math.huge, math.huge
    local boxMaxX, boxMaxY = -math.huge, -math.huge
    local headScreenPos = nil
    local rootScreenPos = nil

    local function gatherProjectParts()
        local coreParts = {}
        local bodyParts = {}
        for _, part in ipairs(self._espPreviewCharacter:GetDescendants()) do
            if part:IsA("BasePart") and part.Transparency < 0.985 and part.Size.Magnitude > 0.05 then
                local parentObj = part.Parent
                local isAccessoryPart = parentObj and parentObj:IsA("Accessory")
                if flowPreviewCoreBodyParts[part.Name] == true then
                    table.insert(coreParts, part)
                elseif not isAccessoryPart then
                    table.insert(bodyParts, part)
                end
            end
        end
        if #coreParts >= 4 then
            return coreParts
        end
        if #bodyParts > 0 then
            return bodyParts
        end
        local fallbackParts = {}
        for _, part in ipairs(self._espPreviewCharacter:GetDescendants()) do
            if part:IsA("BasePart") and part.Transparency < 0.99 and part.Size.Magnitude > 0.05 then
                table.insert(fallbackParts, part)
            end
        end
        return fallbackParts
    end

    local projectParts = gatherProjectParts()

    local function getWorldBounds(parts)
        local minVec = Vector3.new(math.huge, math.huge, math.huge)
        local maxVec = Vector3.new(-math.huge, -math.huge, -math.huge)
        local partCount = 0
        for _, part in ipairs(parts) do
            if part and part.Parent then
                partCount = partCount + 1
                local halfSize = part.Size * 0.5
                local partCF = part.CFrame
                for xSign = -1, 1, 2 do
                    for ySign = -1, 1, 2 do
                        for zSign = -1, 1, 2 do
                            local worldPoint = partCF:PointToWorldSpace(Vector3.new(halfSize.X * xSign, halfSize.Y * ySign, halfSize.Z * zSign))
                            minVec = Vector3.new(
                                math.min(minVec.X, worldPoint.X),
                                math.min(minVec.Y, worldPoint.Y),
                                math.min(minVec.Z, worldPoint.Z)
                            )
                            maxVec = Vector3.new(
                                math.max(maxVec.X, worldPoint.X),
                                math.max(maxVec.Y, worldPoint.Y),
                                math.max(maxVec.Z, worldPoint.Z)
                            )
                        end
                    end
                end
            end
        end
        if partCount <= 0 then
            return nil, nil
        end
        return minVec, maxVec
    end

    if viewportCamera and viewportSize.X > 2 and viewportSize.Y > 2 and #projectParts > 0 then
        viewportCamera.FieldOfView = 32
        local boundsMin, boundsMax = getWorldBounds(projectParts)
        if boundsMin and boundsMax then
            local boundsSize = boundsMax - boundsMin
            local boundsCenter = boundsMin + boundsSize * 0.5
            local verticalFov = math.rad(math.clamp(viewportCamera.FieldOfView, 18, 80))
            local aspectRatio = math.max(0.35, viewportSize.X / viewportSize.Y)
            local horizontalHalfFov = math.atan(math.tan(verticalFov * 0.5) * aspectRatio)
            local fitDepthY = (boundsSize.Y * 0.5) / math.tan(verticalFov * 0.5)
            local fitDepthX = (boundsSize.X * 0.5) / math.tan(horizontalHalfFov)
            -- [v3.1] extra framing margin so the whole body (head to feet) is always visible
            local targetDepth = (math.max(fitDepthX, fitDepthY) * 1.18) + boundsSize.Z * 0.85 + 2.4
            targetDepth = math.clamp(targetDepth, 8, 26)
            local lookTarget = boundsCenter + Vector3.new(0, math.clamp(boundsSize.Y * 0.03, -0.1, 0.45), 0)
            local cameraPos = lookTarget + Vector3.new(0, math.clamp(boundsSize.Y * 0.08, -0.2, 0.6), targetDepth)
            local targetCFrame = CFrame.new(cameraPos, lookTarget)
            local lerpAlpha = math.clamp((dt or (1 / 60)) * 10, 0.12, 0.52)
            viewportCamera.CFrame = viewportCamera.CFrame:Lerp(targetCFrame, lerpAlpha)
        end
    end

    if viewportCamera and viewportSize.X > 2 and viewportSize.Y > 2 then
        for _, part in ipairs(projectParts) do
            if part and part.Parent and part.Transparency < 0.985 then
                local halfSize = part.Size * 0.5
                local partCF = part.CFrame
                for xSign = -1, 1, 2 do
                    for ySign = -1, 1, 2 do
                        for zSign = -1, 1, 2 do
                            local worldPoint = partCF:PointToWorldSpace(Vector3.new(halfSize.X * xSign, halfSize.Y * ySign, halfSize.Z * zSign))
                            local screenPoint = viewportCamera:WorldToViewportPoint(worldPoint)
                            if screenPoint.Z > 0 then
                                hasProjectedBox = true
                                boxMinX = math.min(boxMinX, screenPoint.X)
                                boxMinY = math.min(boxMinY, screenPoint.Y)
                                boxMaxX = math.max(boxMaxX, screenPoint.X)
                                boxMaxY = math.max(boxMaxY, screenPoint.Y)
                            end
                        end
                    end
                end
            end
        end

        local headPart = self._espPreviewCharacter:FindFirstChild("Head")
            or self._espPreviewCharacter:FindFirstChild("UpperTorso")
            or self._espPreviewCharacter:FindFirstChild("HumanoidRootPart")
        if headPart then
            local headWorld = headPart.Position + Vector3.new(0, math.max(0.12, headPart.Size.Y * 0.3), 0)
            local headPoint = viewportCamera:WorldToViewportPoint(headWorld)
            if headPoint.Z > 0 then
                headScreenPos = Vector2.new(headPoint.X, headPoint.Y)
            end
        end
        local rootPart = self._espPreviewCharacter:FindFirstChild("HumanoidRootPart")
        if rootPart then
            local rootPoint = viewportCamera:WorldToViewportPoint(rootPart.Position)
            if rootPoint.Z > 0 then
                rootScreenPos = Vector2.new(rootPoint.X, rootPoint.Y)
            end
        end
    end

    if hasProjectedBox then
        boxMinX = math.clamp(boxMinX, 0, viewportSize.X)
        boxMinY = math.clamp(boxMinY, 0, viewportSize.Y)
        boxMaxX = math.clamp(boxMaxX, 0, viewportSize.X)
        boxMaxY = math.clamp(boxMaxY, 0, viewportSize.Y)
        if boxMaxX - boxMinX < 2 or boxMaxY - boxMinY < 2 then
            hasProjectedBox = false
        end
    end

    if not hasProjectedBox and viewportSize.X > 2 and viewportSize.Y > 2 then
        local fallbackWidth = viewportSize.X * 0.44
        local fallbackHeight = viewportSize.Y * 0.78
        boxMinX = (viewportSize.X - fallbackWidth) * 0.5
        boxMaxX = boxMinX + fallbackWidth
        boxMinY = viewportSize.Y * 0.1
        boxMaxY = boxMinY + fallbackHeight
        hasProjectedBox = true
        if not headScreenPos then
            headScreenPos = Vector2.new((boxMinX + boxMaxX) * 0.5, boxMinY + 8 * mobileScaleFactor)
        end
        if not rootScreenPos then
            rootScreenPos = Vector2.new((boxMinX + boxMaxX) * 0.5, boxMaxY)
        end
    end

    local showMaster = state.Enabled ~= false
    if self._espPreviewBox then
        local showBox = showMaster and state.ShowBox == true and hasProjectedBox
        self._espPreviewBox.Visible = showBox
        if showBox then
            self._espPreviewBox.Position = UDim2.new(0, boxMinX, 0, boxMinY)
            self._espPreviewBox.Size = UDim2.new(0, boxMaxX - boxMinX, 0, boxMaxY - boxMinY)
        end
    end
    if self._espPreviewDot then
        local showDot = showMaster and state.ShowDot == true and headScreenPos ~= nil
        self._espPreviewDot.Visible = showDot
        if showDot then
            local dotSize = math.max(5 * mobileScaleFactor, 1)
            self._espPreviewDot.Position = UDim2.new(0, headScreenPos.X - dotSize * 0.5, 0, headScreenPos.Y - dotSize * 0.5)
            self._espPreviewDot.Size = UDim2.new(0, dotSize, 0, dotSize)
        end
    end
    if self._espPreviewTracer then
        local showTracer = showMaster and state.ShowTracers == true and (hasProjectedBox or rootScreenPos ~= nil)
        self._espPreviewTracer.Visible = showTracer
        if showTracer then
            local fromX = viewportSize.X * 0.5
            local fromY = viewportSize.Y - 1
            local toX = rootScreenPos and rootScreenPos.X or (boxMinX + (boxMaxX - boxMinX) * 0.5)
            local toY = rootScreenPos and rootScreenPos.Y or boxMaxY
            local dx = toX - fromX
            local dy = toY - fromY
            local length = math.sqrt(dx * dx + dy * dy)
            if length >= 2 then
                self._espPreviewTracer.Position = UDim2.new(0, fromX, 0, fromY)
                self._espPreviewTracer.Size = UDim2.new(0, 2 * mobileScaleFactor, 0, length)
                self._espPreviewTracer.Rotation = math.deg(math.atan2(dy, dx)) + 90
            else
                self._espPreviewTracer.Visible = false
            end
        end
    end

    if self._espPreviewName then
        local showName = showMaster and state.ShowName == true and (hasProjectedBox or headScreenPos ~= nil)
        self._espPreviewName.Visible = showName
        self._espPreviewName.Text = tostring(state.Name or theOneAndOnlyPlayer.Name)
        self._espPreviewName.TextColor3 = previewColor
        if showName then
            local nameWidth = hasProjectedBox and (boxMaxX - boxMinX + 20 * mobileScaleFactor) or (120 * mobileScaleFactor)
            nameWidth = math.clamp(nameWidth, 70 * mobileScaleFactor, viewportSize.X)
            local centerX = hasProjectedBox and (boxMinX + (boxMaxX - boxMinX) * 0.5) or headScreenPos.X
            local nameX = math.clamp(centerX - nameWidth * 0.5, 0, math.max(0, viewportSize.X - nameWidth))
            local nameY = hasProjectedBox and math.max(0, boxMinY - 16 * mobileScaleFactor) or math.max(0, headScreenPos.Y - 16 * mobileScaleFactor)
            self._espPreviewName.Position = UDim2.new(0, nameX, 0, nameY)
            self._espPreviewName.Size = UDim2.new(0, nameWidth, 0, 14 * mobileScaleFactor)
        end
    end

    if self._espPreviewItem then
        self._espPreviewItem.Visible = state.ShowItem == true and showMaster
        self._espPreviewItem.Text = tostring(state.Item or "None")
        self._espPreviewItem.TextColor3 = previewColor
    end

    if self._espPreviewDistance then
        self._espPreviewDistance.Visible = state.ShowDistance == true and showMaster
        self._espPreviewDistance.Text = tostring(state.DistanceText or "0m")
        self._espPreviewDistance.TextColor3 = previewColor
    end

    if self._espPreviewHealthTrack then
        local showHealth = state.ShowHealth == true and showMaster and hasProjectedBox
        self._espPreviewHealthTrack.Visible = showHealth
        if showHealth and self._espPreviewHealthFill then
            self._espPreviewHealthTrack.Position = UDim2.new(0, math.max(0, boxMinX - 5 * mobileScaleFactor), 0, boxMinY)
            self._espPreviewHealthTrack.Size = UDim2.new(0, 3 * mobileScaleFactor, 0, boxMaxY - boxMinY)
            local hpPercent = math.clamp(tonumber(state.HealthPercent) or 1, 0, 1)
            self._espPreviewHealthFill.Size = UDim2.new(1, 0, hpPercent, 0)
            self._espPreviewHealthFill.BackgroundColor3 = Color3.new(1 - hpPercent, hpPercent, 0)
        end
    end

    for part, originalData in pairs(self._espPreviewPartDefaults) do
        if part and part.Parent and originalData then
            if part.Name == "HumanoidRootPart" then
                pcall(function()
                    part.LocalTransparencyModifier = 1
                end)
            else
                pcall(function()
                    part.LocalTransparencyModifier = 0
                end)
            end
            if state.ShowChams == true and state.Enabled ~= false and part.Name ~= "HumanoidRootPart" then
                part.Material = Enum.Material.ForceField
                part.Color = previewColor
                part.Transparency = math.clamp(state.ChamsTransparency or 0.55, 0, 0.92)
            else
                part.Material = originalData.Material
                part.Color = originalData.Color
                if part.Name == "HumanoidRootPart" then
                    part.Transparency = 1
                elseif flowPreviewCoreBodyParts[part.Name] and (originalData.Transparency or 0) >= 0.98 then
                    part.Transparency = 0
                else
                    part.Transparency = originalData.Transparency
                end
            end
        end
    end

    if self._espPreviewHighlight then
        self._espPreviewHighlight.FillColor = previewColor
        self._espPreviewHighlight.OutlineColor = previewColor
        self._espPreviewHighlight.FillTransparency = math.clamp(state.HighlightFillTransparency or 0.5, 0, 1)
        self._espPreviewHighlight.OutlineTransparency = math.clamp(state.HighlightOutlineTransparency or 0, 0, 1)
        self._espPreviewHighlight.Enabled = state.ShowHighlight == true and state.Enabled ~= false
    end
end
-- [NEMESIS+] Smooth scrolling v2
-- * ONE driver connection that only runs while something is actually gliding (no per-frame polling of every tab)
-- * the animation no longer relies on a flag around CanvasPosition (property signals are deferred, which used to
--   make the target snap back to the current position and the scroll stutter)
-- * native wheel scrolling is switched off on PC, so the native step and the smooth step never fight each other
-- * nested lists (dropdowns inside a tab) take the wheel first, and hand it to the parent at the end of the list
function superMegaAwesomeLibrary:_StartScrollDriver()
    if self._scrollDriver then return end
    self._scrollDriver = runServiceMoreLikeWalkService.RenderStepped:Connect(function(dt)
        local anyActive = false
        for frame, state in pairs(self._smoothScrollFrames) do
            if state.active then
                if not frame.Parent then
                    self._smoothScrollFrames[frame] = nil
                else
                    local maxY = math.max(0, frame.AbsoluteCanvasSize.Y - frame.AbsoluteWindowSize.Y)
                    if state.targetY > maxY then state.targetY = maxY elseif state.targetY < 0 then state.targetY = 0 end
                    local current = frame.CanvasPosition.Y
                    local diff = state.targetY - current
                    if math.abs(diff) < 0.5 then
                        state.lastSetY = state.targetY
                        frame.CanvasPosition = Vector2.new(frame.CanvasPosition.X, state.targetY)
                        state.active = false
                    else
                        local nextY = current + diff * (1 - math.exp(-state.speed * dt))
                        state.lastSetY = nextY
                        frame.CanvasPosition = Vector2.new(frame.CanvasPosition.X, nextY)
                        anyActive = true
                    end
                end
            end
        end
        if not anyActive and self._scrollDriver then
            self._scrollDriver:Disconnect()
            self._scrollDriver = nil
        end
    end)
end

function superMegaAwesomeLibrary:EnableSmoothScrolling(scrollFrame, smoothSpeed)
    if not scrollFrame or self._smoothScrollFrames[scrollFrame] then return end

    local state = {
        targetY = scrollFrame.CanvasPosition.Y,
        lastSetY = scrollFrame.CanvasPosition.Y,
        active = false,
        speed = math.clamp((smoothSpeed or 18) * 0.75, 10, 20),
        lastWheel = 0,
        streak = 0,
    }
    self._smoothScrollFrames[scrollFrame] = state

    scrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y
    scrollFrame.ElasticBehavior = Enum.ElasticBehavior.Never
    -- [v4] scrollbar removed entirely (smooth scroll still works)
    scrollFrame.ScrollBarThickness = 0
    scrollFrame.ScrollBarImageTransparency = 1
    scrollFrame.VerticalScrollBarInset = Enum.ScrollBarInset.None
    -- PC: the wheel is handled by the glide below, so native wheel stepping is turned off (touch keeps native drag)
    if not thisInputServiceGoesHard.TouchEnabled then
        scrollFrame.ScrollingEnabled = false
    end

    -- external movement (touch drag, scripts) -> adopt it as the new target and stop gliding
    self:_TrackConnection(scrollFrame:GetPropertyChangedSignal("CanvasPosition"):Connect(function()
        local y = scrollFrame.CanvasPosition.Y
        if math.abs(y - state.lastSetY) > 0.75 then
            state.targetY = y
            state.lastSetY = y
            state.active = false
        end
    end))

    local function depthOf(frame)
        local depth, node = 0, frame
        while node do depth = depth + 1; node = node.Parent end
        return depth
    end

    self:_TrackConnection(scrollFrame.InputChanged:Connect(function(input)
        if input.UserInputType ~= Enum.UserInputType.MouseWheel then return end
        local maxY = math.max(0, scrollFrame.AbsoluteCanvasSize.Y - scrollFrame.AbsoluteWindowSize.Y)
        if maxY <= 0 then return end
        local delta = -input.Position.Z
        local base = state.active and state.targetY or scrollFrame.CanvasPosition.Y
        if (delta < 0 and base <= 0.5) or (delta > 0 and base >= maxY - 0.5) then return end -- at the edge: let the parent scroll

        -- several scroll frames can be under the cursor: only the innermost one that can still move reacts
        local pending = self._wheelPending
        local now = os.clock()
        if not pending or (pending.input ~= input and now - pending.t > 0.002) then
            pending = {input = input, t = now}
            self._wheelPending = pending
            task.defer(function()
                local best = pending.best
                if self._wheelPending == pending then self._wheelPending = nil end
                if best then best.apply() end
            end)
        end
        local depth = depthOf(scrollFrame)
        if not pending.best or depth > pending.best.depth then
            pending.best = {depth = depth, apply = function()
                local t = os.clock()
                state.streak = (t - state.lastWheel < 0.12) and math.min(state.streak + 1, 6) or 0
                state.lastWheel = t
                local step = 64 + state.streak * 12 -- gentle acceleration while the wheel keeps spinning
                local from = state.active and state.targetY or scrollFrame.CanvasPosition.Y
                state.targetY = math.clamp(from + delta * step, 0, maxY)
                state.active = true
                self:_StartScrollDriver()
            end}
        end
    end))
end

function superMegaAwesomeLibrary:ApplySearchFilter(rawQuery)
    local query = normalizeSearchText(rawQuery)
    self._searchQuery = query
    local firstVisibleTab = nil
    local function matchesAny(queryText, termList)
        if queryText == "" then return true end
        if type(termList) ~= "table" then return false end
        for _, term in ipairs(termList) do
            local normalized = normalizeSearchText(term)
            if normalized ~= "" and string.find(normalized, queryText, 1, true) ~= nil then
                return true
            end
        end
        return false
    end
    
    for _, section in ipairs(self.sectionsAreAwesome) do
        local sectionHasVisibleContent = false
        for _, tab in ipairs(section.tabsInSection) do
            local tabMatch = matchesAny(query, tab.searchTerms)
            local groupMatch = false
            
            for _, group in ipairs(tab.groupsInTab) do
                local visible = query == "" or tabMatch or matchesAny(query, group.searchTerms)
                if group.mainFrame then
                    group.mainFrame.Visible = visible
                end
                if visible then
                    groupMatch = true
                end
            end
            if tab._Reflow then tab:_Reflow() end
            
            local tabVisible = query == "" or tabMatch or groupMatch
            tab.isFilteredVisible = tabVisible
            if tab.buttonFrame then
                tab.buttonFrame.Visible = tabVisible
                if tab.defaultButtonSize then
                    tab.buttonFrame.Size = tabVisible and tab.defaultButtonSize or UDim2.new(tab.defaultButtonSize.X.Scale, tab.defaultButtonSize.X.Offset, tab.defaultButtonSize.Y.Scale, 0)
                end
            end
            if tabVisible and not firstVisibleTab then
                firstVisibleTab = tab
            end
            if tabVisible then
                sectionHasVisibleContent = true
            end
        end
        
        if section.containerFrame then
            section.containerFrame.Visible = sectionHasVisibleContent or query == ""
        end
        if section.RecalcHeight then section.RecalcHeight(true) end
    end
    
    -- [v7] pesan jika pencarian tidak menemukan apa pun
    if not self._searchEmptyLabel and self.contentHolderFrame then
        self._searchEmptyLabel = makeThingExist("TextLabel", {
            Name = "SearchEmptyMessage", BackgroundTransparency = 1, Text = "Nothing found or no match.",
            FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
            TextColor3 = Color3.fromRGB(125, 125, 135), TextSize = 14 * mobileScaleFactor, TextWrapped = true,
            AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.45, 0),
            Size = UDim2.new(0.8, 0, 0, 40 * mobileScaleFactor), Visible = false, ZIndex = 5, Parent = self.contentHolderFrame
        })
    end
    if self._searchEmptyLabel then
        self._searchEmptyLabel.Visible = (query ~= "" and firstVisibleTab == nil)
    end

    if self.currentTabYay and not self.currentTabYay.isFilteredVisible then
        if firstVisibleTab then
            firstVisibleTab:Activate()
        else
            self.currentTabYay:Deactivate()
            self.currentTabYay = nil
        end
    elseif not self.currentTabYay and firstVisibleTab then
        firstVisibleTab:Activate()
    end
end

function superMegaAwesomeLibrary:SaveConfig(fileName)
    if not writefile or not isfolder or not makefolder then
        return false, "writefile/makefolder APIs are unavailable in this executor."
    end
    
    local folder = self._cfgFolder or "NemesisUIConfigs"
    if not isfolder(folder) then
        local okMake, errMake = pcall(function()
            makefolder(folder)
        end)
        if not okMake then
            return false, "Failed to create config folder: " .. tostring(errMake)
        end
    end
    
    local configName = sanitizeConfigName(fileName)
    local payload = {
        version = 1,
        ui = self.config.Name,
        controls = {}
    }
    
    for flag, control in pairs(self._trackedControls) do
        local ok, value = pcall(control.get)
        if ok then
            payload.controls[flag] = serializeConfigValue(value)
        end
    end
    
    local encoded = httpServiceNoCap:JSONEncode(payload)
    local okWrite, errWrite = pcall(function()
        writefile(folder .. "/" .. configName .. ".json", encoded)
    end)
    if not okWrite then
        return false, "Failed to write config file: " .. tostring(errWrite)
    end
    return true
end

function superMegaAwesomeLibrary:LoadConfig(fileName)
    if not readfile or not isfile then
        return false, "readfile/isfile APIs are unavailable in this executor."
    end
    
    local folder = self._cfgFolder or "NemesisUIConfigs"
    local configName = sanitizeConfigName(fileName)
    local path = folder .. "/" .. configName .. ".json"
    if not isfile(path) then
        return false, "Config file not found: " .. path
    end
    
    local okDecode, data = pcall(function()
        return httpServiceNoCap:JSONDecode(readfile(path))
    end)
    if not okDecode or type(data) ~= "table" or type(data.controls) ~= "table" then
        return false, "Invalid config JSON format."
    end
    
    for flag, rawValue in pairs(data.controls) do
        local control = self._trackedControls[flag]
        if control then
            local decodedValue = deserializeConfigValue(rawValue)
            pcall(control.set, decodedValue)
        end
    end
    
    return true
end

function superMegaAwesomeLibrary:CreateUIBecauseWeNeedIt()
    -- ==========================================
    -- 1. DETEKSI LOKASI & HAPUS UI LAMA (ANTI-NUMPUK)
    -- ==========================================
    local targetFolder
    if syn then
        targetFolder = coreGuiMoreLikeBoreGui
    elseif gethui then
        targetFolder = gethui()
    else
        targetFolder = theOneAndOnlyPlayer:WaitForChild("PlayerGui")
    end
    
    local oldUI = targetFolder:FindFirstChild("x2zuBestUIEver")
    if oldUI then
        oldUI:Destroy()
    end

    -- ==========================================
    -- 2. KODE ASLI KAMU (TIDAK ADA YANG DIHAPUS)
    -- ==========================================
    self.screenGuiYay = makeThingExist("ScreenGui", {
        Name = "x2zuBestUIEver",
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        ResetOnSpawn = false,
        IgnoreGuiInset = true
    })
    
    if syn then
        syn.protect_gui(self.screenGuiYay)
        self.screenGuiYay.Parent = coreGuiMoreLikeBoreGui
    elseif gethui then
        self.screenGuiYay.Parent = gethui()
    else
        self.screenGuiYay.Parent = theOneAndOnlyPlayer:WaitForChild("PlayerGui")
    end
    
    -- [v8] matikan border bawaan Roblox (BorderSizePixel) di SEMUA GuiObject, termasuk yang dibuat langsung via Instance.new
    local function killBorder(obj)
        if obj:IsA("GuiObject") then
            pcall(function() if obj.BorderSizePixel ~= 0 then obj.BorderSizePixel = 0 end end)
        end
    end
    for _, d in ipairs(self.screenGuiYay:GetDescendants()) do killBorder(d) end
    self:_TrackConnection(self.screenGuiYay.DescendantAdded:Connect(killBorder))

    self.backdropDimFrame = makeThingExist("Frame", {
        Name = "BackdropDimForBlur",
        BackgroundColor3 = Color3.new(0, 0, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
        ZIndex = 0,
        Parent = self.screenGuiYay
    })

    self.snowLayerFrame = makeThingExist("CanvasGroup", {
        Name = "SnowLayerWhenOpen",
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
        ZIndex = 2,
        ClipsDescendants = true,
        Parent = self.screenGuiYay
    })
    
    self.dropdownHolderRef = makeThingExist("Frame", {
        Name = "DropdownHolderBecauseDropdownsNeedHomes",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        ZIndex = 9999,
        Parent = self.screenGuiYay
    })
    
    self:CreateWatermarkBecauseWeCool()
    self:CreateMainFrameYay()
    -- self:_CreateESPPreviewPanel()
    self:CreateNotificationHolderForCoolNotifs()
    self:CreateMobileToggleButton()
    self:ApplyFontPreset(self._fontPresetIndex)
    self:_SetTextGradientEnabled(self._uiVisualSettings.TextGradient)
    self:_SetBackgroundEffectsEnabled(self._uiVisualSettings.BackgroundEffects)
    self:_SetOverlayMode(self._overlayMode)
    self:_ApplyOpenCloseVisuals(true)
    task.delay(0.6, function() if not self._destroyed then pcall(function() self:_SyncVisualDefaults() end) end end)
    
    self:_TrackConnection(thisInputServiceGoesHard.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == self.toggleKeyCode then
            self:ToggleUI()
        end
    end))
    
    self:_TrackConnection(runServiceMoreLikeWalkService.RenderStepped:Connect(function(dt)
        if self._destroyed then return end
        
        table.insert(self._fpsRollingWindow, dt)
        self._fpsRollingTotal = self._fpsRollingTotal + dt
        if #self._fpsRollingWindow > self._fpsRollingSize then
            self._fpsRollingTotal = self._fpsRollingTotal - table.remove(self._fpsRollingWindow, 1)
        end
        if self._fpsRollingTotal > 0 then
            self._latestFPSValue = math.clamp(math.floor((#self._fpsRollingWindow / self._fpsRollingTotal) + 0.5), 1, 360)
        end
        
        -- self:_UpdateESPPreview(dt)
        self:_AnimateTextGradients(dt)

        -- background fx is static now (no rotating gradient / moving glow)

        if self.isToggledOn and self._uiVisualSettings.Snow and self.snowLayerFrame and self.snowLayerFrame.Visible and self._overlayMode ~= "None" then
            self._snowSpawnAccumulator = self._snowSpawnAccumulator + dt
            local overlayMode = self._overlayMode
            local spawnInterval
            local maxParticles
            if overlayMode == "Rain" then
                spawnInterval = isMobileUserSadly and 0.015 or 0.009
                maxParticles = isMobileUserSadly and 88 or 170
            elseif overlayMode == "Stars" then
                spawnInterval = isMobileUserSadly and 0.03 or 0.018
                maxParticles = isMobileUserSadly and 90 or 175
            else
                spawnInterval = isMobileUserSadly and 0.13 or 0.085
                maxParticles = isMobileUserSadly and 38 or 72
            end
            while self._snowSpawnAccumulator >= spawnInterval and #self._snowflakes < maxParticles do
                if overlayMode == "Rain" then
                    self:_SpawnRainDrop()
                elseif overlayMode == "Stars" then
                    self:_SpawnStarParticle()
                else
                    self:_SpawnSnowflake()
                end
                self._snowSpawnAccumulator = self._snowSpawnAccumulator - spawnInterval
            end
            local nowTick = os.clock()
            local viewportHeight = math.max(320, math.floor(self.screenGuiYay.AbsoluteSize.Y))
            local viewportWidth = math.max(200, math.floor(self.screenGuiYay.AbsoluteSize.X))
            for i = #self._snowflakes, 1, -1 do
                local flakeData = self._snowflakes[i]
                local flakeObj = flakeData and flakeData.instance
                if not flakeObj or not flakeObj.Parent then
                    table.remove(self._snowflakes, i)
                else
                    local overlayType = flakeData.overlayType or "Snow"
                    if overlayType == "RainDrop" then
                        flakeData.yOffset = flakeData.yOffset + flakeData.velocityY * dt
                        flakeData.xOffset = flakeData.xOffset + flakeData.velocityX * dt
                        local windOffset = math.sin(nowTick * flakeData.driftSpeed + flakeData.phase) * flakeData.windJitter
                        local xPos = flakeData.xOffset + windOffset
                        flakeObj.Position = UDim2.new(0, xPos, 0, flakeData.yOffset)
                        local stretchPulse = 0.82 + math.sin(nowTick * flakeData.stretchPulse + flakeData.phase) * 0.18
                        flakeObj.Size = UDim2.new(0, flakeData.width, 0, flakeData.length * stretchPulse)
                        flakeObj.Rotation = flakeData.angle
                        flakeObj.BackgroundTransparency = math.clamp(flakeData.baseTransparency + (math.sin(nowTick * 3.6 + flakeData.phase) * 0.07), 0.08, 0.9)
                        if flakeData.yOffset > viewportHeight + 20 then
                            if xPos > -40 and xPos < viewportWidth + 40 and math.random() < flakeData.splashChance then
                                self:_SpawnRainSplash(xPos, viewportHeight - math.random(1, 8))
                            end
                            flakeObj:Destroy()
                            table.remove(self._snowflakes, i)
                        end
                    elseif overlayType == "RainSplash" then
                        flakeData.life = flakeData.life - dt
                        if flakeData.life <= 0 then
                            flakeObj:Destroy()
                            table.remove(self._snowflakes, i)
                        else
                            local progress = 1 - (flakeData.life / flakeData.totalLife)
                            local widthNow = flakeData.startSize + flakeData.endSize * progress
                            local heightNow = math.max(1 * mobileScaleFactor, flakeData.startThickness * (1 - progress * 0.8))
                            flakeObj.Size = UDim2.new(0, widthNow, 0, heightNow)
                            flakeObj.Position = UDim2.new(0, flakeData.baseX + flakeData.driftX * progress, 0, flakeData.yOffset - progress * 1.2)
                            flakeObj.BackgroundTransparency = math.clamp(flakeData.baseTransparency + progress * 0.55, 0.2, 0.97)
                        end
                    elseif overlayType == "Stars" then
                        flakeData.xOffset = flakeData.xOffset + flakeData.velocityX * dt
                        flakeData.yOffset = flakeData.yOffset + flakeData.velocityY * dt
                        local driftX = math.sin(nowTick * flakeData.driftSpeed + flakeData.phase) * flakeData.driftAmount
                        local driftY = math.cos(nowTick * (flakeData.driftSpeed * 0.72) + flakeData.phase) * flakeData.driftLift
                        local xPos = flakeData.xOffset + driftX
                        local yPos = flakeData.yOffset + driftY
                        if xPos < -16 then
                            flakeData.xOffset = viewportWidth + 16
                            xPos = flakeData.xOffset
                        elseif xPos > viewportWidth + 16 then
                            flakeData.xOffset = -16
                            xPos = flakeData.xOffset
                        end
                        if yPos < -16 then
                            flakeData.yOffset = viewportHeight + 16
                            yPos = flakeData.yOffset
                        elseif yPos > viewportHeight + 16 then
                            flakeData.yOffset = -16
                            yPos = flakeData.yOffset
                        end
                        flakeObj.Position = UDim2.new(0, xPos, 0, yPos)
                        local sparkle = (math.sin(nowTick * flakeData.twinkleSpeed + flakeData.phase) + 1) * 0.5
                        local pulse = 1 + (math.sin(nowTick * (flakeData.twinkleSpeed * 0.75) + flakeData.phase) * flakeData.pulseAmount)
                        local sizeNow = math.max(1 * mobileScaleFactor, flakeData.baseSize * (0.82 + pulse * 0.36))
                        flakeObj.Size = UDim2.new(0, sizeNow, 0, sizeNow)
                        flakeObj.ImageTransparency = math.clamp(flakeData.baseTransparency - sparkle * 0.5, 0.01, 0.92)
                    else
                        flakeData.yOffset = flakeData.yOffset + flakeData.fallSpeed * dt
                        local driftX = math.sin(nowTick * flakeData.driftSpeed + flakeData.phase) * flakeData.driftAmount
                        local swirlX = math.cos(nowTick * (flakeData.driftSpeed * 0.58) + flakeData.phase) * flakeData.swirlAmount
                        flakeObj.Position = UDim2.new(0, flakeData.baseX + driftX + swirlX, 0, flakeData.yOffset)
                        flakeObj.Rotation = (flakeObj.Rotation + flakeData.spin * dt) % 360
                        local twinkle = (math.sin(nowTick * flakeData.twinkleSpeed + flakeData.phase) + 1) * 0.5
                        flakeObj.ImageTransparency = math.clamp(flakeData.baseTransparency + twinkle * 0.22, 0.08, 0.84)
                        if flakeData.yOffset > viewportHeight + 28 then
                            flakeObj:Destroy()
                            table.remove(self._snowflakes, i)
                        end
                    end
                end
            end
        end
    end))
end

function superMegaAwesomeLibrary:ToggleUI()
    if self._introRunning then return end
    self.isToggledOn = not self.isToggledOn
    smoothMoveGoWoosh(self.mainFrameYay, {
        Position = self.isToggledOn and UDim2.new(0.5, 0, 0.5, 0) or UDim2.new(0.5, 0, 1.5, 0)
    }, 0.4, Enum.EasingStyle.Quint, self.isToggledOn and Enum.EasingDirection.Out or Enum.EasingDirection.In)
    self:_ApplyOpenCloseVisuals(false)
end

function superMegaAwesomeLibrary:SetToggleButtonVisible(visible)
    self.toggleButtonVisible = visible
    if self.mobileToggleFrame then
        self.mobileToggleFrame.Visible = visible
    end
end

function superMegaAwesomeLibrary:SetToggleKey(keyCode)
    self.toggleKeyCode = keyCode
end

function superMegaAwesomeLibrary:SetName(name)
    if type(name) ~= "string" or name:gsub("%s", "") == "" then return end
    self.config.Name = name
    if self.watermarkTitleLabel and self.watermarkTitleLabel.Parent then
        self.watermarkTitleLabel.Text = name
    end
end

-- [Ouroboros] compact top-center pill: logo + FPS only.
-- The separate side bubble / meter and the old floating toggle are removed.
function superMegaAwesomeLibrary:CreateMobileToggleButton() end

function superMegaAwesomeLibrary:CreateWatermarkBecauseWeCool()
    local gui = self.screenGuiYay
    local TOUCH = isMobileUserSadly

    -- Ouroboros _buildMiniBar compact dimensions and placement.
    -- No secondary side widget is created: one pill only.
    local Mini = {
        Top = 8,
        Width = TOUCH and 176 or 168,
        Height = TOUCH and 36 or 32,
    }
    local Theme = {
        Background = Color3.fromRGB(15, 15, 15),
        Surface2 = Color3.fromRGB(25, 25, 25),
        Stroke = Color3.fromRGB(40, 40, 40),
        Text = Color3.fromRGB(255, 255, 255),
        Muted = Color3.fromRGB(140, 140, 140),
    }
    local BOLD = Font.new("rbxasset://fonts/families/BuilderSans.json", Enum.FontWeight.SemiBold)
    -- User-provided logo asset; preserve its original colors.
    local LOGO_ASSET = "rbxassetid://111669131217501"
    local function accent()
        return self.config.AccentColor
    end

    local displayName = tostring(self.config.WatermarkTitle or self.config.Name or "NEMESIS")

    -- Original Ouroboros Island / Compact hierarchy and dimensions.
    local island = makeThingExist("CanvasGroup", {
        Name = "Island",
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.new(0.5, 0, 0, Mini.Top),
        Size = UDim2.fromOffset(Mini.Width, Mini.Height),
        BackgroundColor3 = Theme.Background,
        BorderSizePixel = 0,
        ZIndex = 30,
        Active = true,
        Parent = gui,
    })
    makeThingExist("UICorner", {CornerRadius = UDim.new(0, Mini.Height / 2), Parent = island})
    makeThingExist("UIStroke", {Color = Theme.Stroke, Parent = island})
    local islandScale = makeThingExist("UIScale", {Parent = island})

    self.watermarkFrame = island
    self.mobileToggleFrame = island

    local compact = makeThingExist("CanvasGroup", {
        Name = "Compact",
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Theme.Surface2,
        BorderSizePixel = 0,
        Parent = island,
    })
    makeThingExist("UIGradient", {
        Rotation = 90,
        Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(120, 120, 120)),
        Parent = compact,
    })

    -- Accent logo disc, matching the pasted Ouroboros compact pill.
    local logoDisc = makeThingExist("Frame", {
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 5, 0.5, 0),
        Size = UDim2.fromOffset(Mini.Height - 10, Mini.Height - 10),
        BackgroundColor3 = accent(),
        BackgroundTransparency = 0.82,
        BorderSizePixel = 0,
        Parent = compact,
    })
    makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = logoDisc})

    local logo = makeThingExist("ImageLabel", {
        Name = "WatermarkLogo",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(32, 32), -- hanya logo diperbesar; ukuran pill dan elemen lain tetap
        BackgroundTransparency = 1,
        Image = LOGO_ASSET,
        ImageColor3 = Color3.new(1, 1, 1),
        ScaleType = Enum.ScaleType.Fit,
        Parent = logoDisc,
    })
    self.watermarkLogo = logo
    self.mobileToggleIcon = logo

    -- Window name: driven by Library.new({ Name = "NEMESIS" }).
    local titleLabel = makeThingExist("TextLabel", {
        Name = "WatermarkTitle",
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, Mini.Height + 2, 0.5, 0),
        Size = UDim2.new(1, -Mini.Height - 2 - 72, 0, 18),
        BackgroundTransparency = 1,
        Text = displayName,
        TextSize = 13,
        FontFace = BOLD,
        TextColor3 = Theme.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        Parent = compact,
    })
    self.watermarkTitleLabel = titleLabel
    -- Reuse the same animated text-gradient effect used by the main UI.
    table.insert(self._gradientLabels, titleLabel)

    -- Ouroboros compact right cluster: animated signal bars + live FPS value.
    -- Keep the FPS number only; no textual "FPS" label is displayed.
    local rightCluster = makeThingExist("Frame", {
        Name = "WatermarkActivity",
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -14, 0.5, 0),
        Size = UDim2.new(0, 0, 0, 18),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundTransparency = 1,
        Parent = compact,
    })
    makeThingExist("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 7),
        Parent = rightCluster,
    })

    local barsHolder = makeThingExist("Frame", {
        Name = "ActivityBars",
        Size = UDim2.fromOffset(18, 16),
        BackgroundTransparency = 1,
        LayoutOrder = 1,
        Parent = rightCluster,
    })
    local activityBars = {}
    for index = 1, 4 do
        local bar = makeThingExist("Frame", {
            Name = "ActivityBar" .. tostring(index),
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.new(0, (index - 1) * 5, 0.5, 0),
            Size = UDim2.fromOffset(3, 3),
            BackgroundColor3 = Theme.Muted,
            BorderSizePixel = 0,
            Parent = barsHolder,
        })
        makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = bar})
        activityBars[index] = bar
    end

    local toggleCountLabel = makeThingExist("TextLabel", {
        Name = "WatermarkFPSValue",
        Size = UDim2.fromOffset(0, 18),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundTransparency = 1,
        Text = tostring(self._latestFPSValue or 0),
        TextSize = 13,
        FontFace = BOLD,
        TextColor3 = Theme.Text,
        TextXAlignment = Enum.TextXAlignment.Right,
        TextTruncate = Enum.TextTruncate.None,
        LayoutOrder = 2,
        Parent = rightCluster,
    })
    self.watermarkActivityBars = activityBars
    self.watermarkFPSValueLabel = toggleCountLabel
    self.watermarkFPSLabel = nil -- no separate textual FPS label; only the numeric value is shown.
    -- Keep the FPS number synchronized with the UI's animated text gradient.
    table.insert(self._gradientLabels, toggleCountLabel)
    self:_SetTextGradientEnabled(self._uiVisualSettings.TextGradient)

    islandScale.Scale = 0.96
    smoothMoveGoWoosh(islandScale, {Scale = 1}, 0.45, Enum.EasingStyle.Back)

    -- Refresh the live FPS number and accent color.
    task.spawn(function()
        local lastFPS = -1
        while not self._destroyed and island.Parent do
            local fps = math.floor(tonumber(self._latestFPSValue) or 0)
            if fps ~= lastFPS then
                lastFPS = fps
                toggleCountLabel.Text = tostring(fps)
            end
            local acc = accent()
            logoDisc.BackgroundColor3 = acc
            for _, bar in ipairs(activityBars) do
                bar.BackgroundColor3 = acc
            end
            task.wait(0.1)
        end
    end)

    -- Port of Ouroboros' compact Render animation: staggered sine-wave bar heights.
    -- Animation runs continuously while the pill is visible; the number is live FPS.
    self:_TrackConnection(runServiceMoreLikeWalkService.RenderStepped:Connect(function()
        if self._destroyed or not island.Parent or not island.Visible then return end
        local now = os.clock()
        for index, bar in ipairs(activityBars) do
            local wave = 0.5 + 0.5 * math.sin(now * (6 + index * 1.4) + index * 1.9)
            bar.Size = UDim2.fromOffset(3, math.floor(4 + wave * 11 + 0.5))
        end
    end))

    -- Same draggable / click-to-toggle behavior as the previous Nemesis pill.
    local dragging, moved = false, false
    local grab = Vector2.zero
    self:_TrackConnection(island.InputBegan:Connect(function(input)
        local kind = input.UserInputType
        if kind == Enum.UserInputType.MouseButton1 or kind == Enum.UserInputType.Touch then
            dragging = true
            moved = false
            local p = input.Position
            grab = Vector2.new(p.X, p.Y) - island.AbsolutePosition
        end
    end))
    self:_TrackConnection(thisInputServiceGoesHard.InputChanged:Connect(function(input)
        if not dragging then return end
        local kind = input.UserInputType
        if kind == Enum.UserInputType.MouseMovement or kind == Enum.UserInputType.Touch then
            local p = input.Position
            local point = Vector2.new(p.X, p.Y) - grab - gui.AbsolutePosition
            if (point - (island.AbsolutePosition - gui.AbsolutePosition)).Magnitude > 3 then
                moved = true
            end
            if moved then
                island.AnchorPoint = Vector2.new(0, 0)
                island.Position = UDim2.fromOffset(
                    math.clamp(point.X, 0, math.max(gui.AbsoluteSize.X - island.AbsoluteSize.X, 0)),
                    math.clamp(point.Y, 0, math.max(gui.AbsoluteSize.Y - island.AbsoluteSize.Y, 0))
                )
            end
        end
    end))
    self:_TrackConnection(thisInputServiceGoesHard.InputEnded:Connect(function(input)
        local kind = input.UserInputType
        if dragging and (kind == Enum.UserInputType.MouseButton1 or kind == Enum.UserInputType.Touch) then
            dragging = false
            if not moved then
                self:ToggleUI()
                islandScale.Scale = 0.96
                smoothMoveGoWoosh(islandScale, {Scale = 1}, 0.4, Enum.EasingStyle.Back)
            end
        end
    end))
end

function superMegaAwesomeLibrary:_ApplyWindowScale()
    local frame, gui = self.mainFrameYay, self.screenGuiYay
    if not (frame and frame.Parent and gui and gui.Parent) then return end
    local sc = frame:FindFirstChild("NemesisUserScale")
    if not sc then return end
    local vp = gui.AbsoluteSize
    if vp.X < 50 or vp.Y < 50 then return end
    local baseW, baseH = 753 * mobileScaleFactor, 493 * mobileScaleFactor
    local margin = isMobileUserSadly and 8 or 24
    -- batas maksimal agar window tidak keluar layar
    local fit = math.min((vp.X - margin) / baseW, (vp.Y - margin) / baseH)
    -- auto: layar besar (PC 1440p/4K) sedikit diperbesar, layar kecil otomatis dikecilkan oleh `fit`
    local auto = 1
    if not isMobileUserSadly then
        auto = math.clamp(math.min(vp.X / 1600, vp.Y / 900), 1, 1.3)
    end
    -- slider "UI scale" (80-120%) bekerja di atas skala otomatis
    sc.Scale = math.clamp(math.min(auto * (self._userScale or 1), fit), 0.3, 2)
end

function superMegaAwesomeLibrary:CreateMainFrameYay()
    local frameWidth = 753 * mobileScaleFactor
    local frameHeight = 493 * mobileScaleFactor
    
    self.mainFrameYay = makeThingExist("Frame", {
        Name = "MainFrameIsAwesome",
        BackgroundColor3 = self.config.BackgroundColor,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        BorderSizePixel = 0,
        Size = UDim2.new(0, frameWidth, 0, frameHeight),
        Parent = self.screenGuiYay
    })

    -- [v7] responsive: satu UIScale yang menggabungkan "UI scale" dari user + auto-fit layar.
    -- Window otomatis mengecil kalau layar lebih kecil (HP kecil, split screen, rotasi, resize) dan
    -- tidak pernah keluar dari layar.
    self._userScale = 1
    makeThingExist("UIScale", {Name = "NemesisUserScale", Scale = 1, Parent = self.mainFrameYay})
    self:_ApplyWindowScale()
    self:_TrackConnection(self.screenGuiYay:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        self:_ApplyWindowScale()
    end))
    
    makeThingExist("UICorner", {CornerRadius = UDim.new(0, 11), Parent = self.mainFrameYay})

    self.mainBackgroundEffectsFrame = makeThingExist("CanvasGroup", {
        Name = "MainBackgroundEffects",
        BackgroundColor3 = Color3.fromRGB(18, 18, 18),
        BackgroundTransparency = 0.45,
        Size = UDim2.new(1, 0, 1, 0),
        ClipsDescendants = true,
        ZIndex = 0,
        Parent = self.mainFrameYay
    })
    makeThingExist("UICorner", {CornerRadius = UDim.new(0, 11), Parent = self.mainBackgroundEffectsFrame})
    self.mainBackgroundGradient = makeThingExist("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 10, 10)),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(18, 18, 18)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(12, 12, 12))
        }),
        Rotation = 210,
        Parent = self.mainBackgroundEffectsFrame
    })
    self.mainBackgroundAccentGlow = makeThingExist("ImageLabel", {
        Name = "AccentGlow",
        BackgroundTransparency = 1,
        Image = "rbxassetid://5028857084",
        ImageColor3 = self.config.AccentColor,
        ImageTransparency = 0.9,
        Size = UDim2.new(1.8, 0, 1.8, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        AnchorPoint = Vector2.new(0.5, 0.5),
        ZIndex = 0,
        Parent = self.mainBackgroundEffectsFrame
    })
    
    self.dragBarThing = makeThingExist("Frame", {
        BackgroundTransparency = 1, Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(1, 0, 0, 65 * mobileScaleFactor), Parent = self.mainFrameYay
    })
    
    makeDraggableCuzWeCan(self.mainFrameYay, self.dragBarThing, self)

self.hubLogoImg = makeThingExist("ImageLabel", {
        Name = "HubLogoImage",
        Image = "rbxassetid://79145122864474",
        BackgroundTransparency = 1,
        -- X digeser dari 18 ke 12 (biar agak ke kiri), Y disesuaikan ke -40
        Position = UDim2.new(0, 12 * mobileScaleFactor, 0, -40 * mobileScaleFactor),
        -- Ukuran dikurangi dari 165 ke 155 biar bawahnya nggak terlalu nekan garis
        Size = UDim2.new(0, 160 * mobileScaleFactor, 0, 160 * mobileScaleFactor),
        ScaleType = Enum.ScaleType.Fit, 
        Parent = self.mainFrameYay
    })
    -- local hubNameWidth = howWideIsThisText(self.config.Name, 17 * mobileScaleFactor, Enum.Font.GothamSemibold)
    
    -- self.hubNameLabel = makeThingExist("TextLabel", {
    --     FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
    --     TextColor3 = Color3.new(1, 1, 1), Text = self.config.Name, BackgroundTransparency = 1,
    --     Position = UDim2.new(0, 10, 0, 14 * mobileScaleFactor), TextSize = 17 * mobileScaleFactor,
    --     Size = UDim2.new(0, hubNameWidth + 10, 0, 20 * mobileScaleFactor),
    --     TextXAlignment = Enum.TextXAlignment.Left, Parent = self.mainFrameYay
    -- })
    -- table.insert(self._gradientLabels, self.hubNameLabel)
    
    -- local playerName = ".gg/nemesishub" -- [TELAH DIUBAH] 
    -- self.userNameLabel = makeThingExist("TextLabel", {
    --     FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
    --     TextColor3 = Color3.fromRGB(46, 46, 46), Text = playerName, BackgroundTransparency = 1,
    --     Position = UDim2.new(0, 10, 0, 34 * mobileScaleFactor), TextSize = 14 * mobileScaleFactor,
    --     Size = UDim2.new(0, 120 * mobileScaleFactor, 0, 18 * mobileScaleFactor),
    --     TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
    --     Parent = self.mainFrameYay
    -- })
    
    -- self.playerAvatarImg = makeThingExist("ImageLabel", {
    --     Image = "rbxassetid://71065073219767",
    --     Position = UDim2.new(0, 145 * mobileScaleFactor, 0, 17 * mobileScaleFactor),
    --     Size = UDim2.new(0, 30 * mobileScaleFactor, 0, 30 * mobileScaleFactor), Parent = self.mainFrameYay
    -- })
    -- makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = self.playerAvatarImg})
    
-- Garis Horizontal (Di bawah Logo)
    self.lineSeperator = makeThingExist("Frame", {
        BackgroundColor3 = Color3.fromRGB(45, 45, 45), 
        -- [DIUBAH]: Naikkan angka ini jadi 0.7 atau 0.8 biar efek visualnya super tipis
        BackgroundTransparency = 0.7, 
        Position = UDim2.new(0, 0, 0, 68 * mobileScaleFactor), 
        Size = UDim2.new(0, 185 * mobileScaleFactor, 0, 1), 
        Parent = self.mainFrameYay
    })
    
    -- Garis Vertikal (Pembatas Tab mentok atas-bawah)
    self.verticalLineSeperator = makeThingExist("Frame", {
        BackgroundColor3 = Color3.fromRGB(45, 45, 45),
        -- [DIUBAH]: Samakan dengan yang atas biar serasi
        BackgroundTransparency = 0.7, 
        Position = UDim2.new(0, 185 * mobileScaleFactor, 0, 0),
        Size = UDim2.new(0, 1, 1, 0), 
        Parent = self.mainFrameYay
    })
    self.tabNameLabel = makeThingExist("TextLabel", {
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
        TextColor3 = Color3.new(1, 1, 1), Text = "tab name", BackgroundTransparency = 1,
        Position = UDim2.new(0, 201 * mobileScaleFactor, 0, 14 * mobileScaleFactor),
        TextSize = 17 * mobileScaleFactor, Size = UDim2.new(0, 305 * mobileScaleFactor, 0, 20 * mobileScaleFactor),
        TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = self.mainFrameYay
    })
    table.insert(self._gradientLabels, self.tabNameLabel)
    
    self.tabDescriptionLabel = makeThingExist("TextLabel", {
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
        TextColor3 = Color3.fromRGB(46, 46, 46), Text = "tab description", BackgroundTransparency = 1,
        Position = UDim2.new(0, 201 * mobileScaleFactor, 0, 34 * mobileScaleFactor),
        TextSize = 14 * mobileScaleFactor, Size = UDim2.new(0, 305 * mobileScaleFactor, 0, 18 * mobileScaleFactor),
        TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = self.mainFrameYay
    })

    self.searchFrame = makeThingExist("Frame", {
        BackgroundColor3 = Color3.fromRGB(22, 22, 22),
        Position = UDim2.new(0, 524 * mobileScaleFactor, 0, 16 * mobileScaleFactor),
        Size = UDim2.new(0, 214 * mobileScaleFactor, 0, 28 * mobileScaleFactor),
        Parent = self.mainFrameYay
    })
    makeThingExist("UICorner", {CornerRadius = UDim.new(0, 8), Parent = self.searchFrame})
    makeThingExist("UIStroke", {Color = Color3.fromRGB(38, 38, 38), Parent = self.searchFrame})
    makeThingExist("ImageLabel", {
        Image = "rbxassetid://10734943674",
        ImageColor3 = Color3.fromRGB(120, 120, 120),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 8, 0.5, -7 * mobileScaleFactor),
        Size = UDim2.new(0, 14 * mobileScaleFactor, 0, 14 * mobileScaleFactor),
        Parent = self.searchFrame
    })
    self.searchBox = makeThingExist("TextBox", {
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
        Text = "",
        PlaceholderText = "Search tabs/groups...",
        PlaceholderColor3 = Color3.fromRGB(80, 80, 80),
        TextColor3 = Color3.fromRGB(210, 210, 210),
        TextSize = 13 * mobileScaleFactor,
        BackgroundTransparency = 1,
        ClearTextOnFocus = false,
        Position = UDim2.new(0, 28 * mobileScaleFactor, 0, 0),
        Size = UDim2.new(1, -34 * mobileScaleFactor, 1, 0),
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = self.searchFrame
    })
    self:_TrackConnection(self.searchBox:GetPropertyChangedSignal("Text"):Connect(function()
        self:ApplySearchFilter(self.searchBox.Text)
    end))
    
    self.sectionHolderScroll = makeThingExist("ScrollingFrame", {
        BackgroundTransparency = 1, Position = UDim2.new(0, 17, 0, 75 * mobileScaleFactor),
        Size = UDim2.new(0, 162 * mobileScaleFactor, 0, 404 * mobileScaleFactor),
        ScrollBarThickness = 0, CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y, ClipsDescendants = true, Parent = self.mainFrameYay
    })
    
    makeThingExist("UIPadding", {PaddingLeft = UDim.new(0, 2), PaddingRight = UDim.new(0, 2), PaddingTop = UDim.new(0, 2), Parent = self.sectionHolderScroll})
    self.sectionLayoutThing = makeThingExist("UIListLayout", {Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder, Parent = self.sectionHolderScroll})
    self:EnableSmoothScrolling(self.sectionHolderScroll, 16)
    
    self.contentHolderFrame = makeThingExist("Frame", {
        BackgroundTransparency = 1, Position = UDim2.new(0, 198 * mobileScaleFactor, 0, 62 * mobileScaleFactor),
        Size = UDim2.new(0, 548 * mobileScaleFactor, 0, 424 * mobileScaleFactor),
        ClipsDescendants = true, Parent = self.mainFrameYay
    })

    local settingsPanelWidth = 250 * mobileScaleFactor
    local settingsPanelHeight = 340 * mobileScaleFactor
    self.uiSettingsOpen = false

    self.uiSettingsButtonFrame = makeThingExist("Frame", {
        BackgroundColor3 = Color3.fromRGB(20, 20, 20),
        Position = UDim2.new(0, 10, 1, -31 * mobileScaleFactor),
        Size = UDim2.new(0, 116 * mobileScaleFactor, 0, 22 * mobileScaleFactor),
        BorderSizePixel = 0,
        Parent = self.mainFrameYay
    })
    makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = self.uiSettingsButtonFrame})
    self.uiSettingsButtonStroke = makeThingExist("UIStroke", {Color = Color3.fromRGB(45, 45, 45), Parent = self.uiSettingsButtonFrame})

    makeThingExist("ImageLabel", {
        Image = "rbxassetid://6031280882",
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 7, 0.5, -6 * mobileScaleFactor),
        Size = UDim2.new(0, 12 * mobileScaleFactor, 0, 12 * mobileScaleFactor),
        ImageColor3 = Color3.fromRGB(165, 165, 165),
        Parent = self.uiSettingsButtonFrame
    })
    makeThingExist("TextLabel", {
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
        Text = "UI Settings",
        TextColor3 = Color3.fromRGB(185, 185, 185),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 24 * mobileScaleFactor, 0, 0),
        Size = UDim2.new(1, -28 * mobileScaleFactor, 1, 0),
        TextXAlignment = Enum.TextXAlignment.Left,
        TextSize = 12 * mobileScaleFactor,
        Parent = self.uiSettingsButtonFrame
    })
    local settingsToggleButton = makeThingExist("TextButton", {
        Text = "",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Parent = self.uiSettingsButtonFrame
    })

    self.uiSettingsPanelFrame = makeThingExist("Frame", {
        BackgroundColor3 = Color3.fromRGB(15, 15, 15),
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.new(0, 10, 1, -36 * mobileScaleFactor),
        Size = UDim2.new(0, settingsPanelWidth, 0, 0),
        ClipsDescendants = true,
        Visible = false,
        Parent = self.mainFrameYay
    })
    makeThingExist("UICorner", {CornerRadius = UDim.new(0, 9), Parent = self.uiSettingsPanelFrame})
    makeThingExist("UIStroke", {Color = Color3.fromRGB(44, 44, 44), Parent = self.uiSettingsPanelFrame})

    makeThingExist("TextLabel", {
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
        Text = "UI Settings",
        TextColor3 = Color3.new(1, 1, 1),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, 8 * mobileScaleFactor),
        Size = UDim2.new(0.7, 0, 0, 16 * mobileScaleFactor),
        TextSize = 13 * mobileScaleFactor,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = self.uiSettingsPanelFrame
    })

    self.uiAccentPreviewFrame = makeThingExist("Frame", {
        BackgroundColor3 = self.config.AccentColor,
        Position = UDim2.new(1, -22 * mobileScaleFactor, 0, 11 * mobileScaleFactor),
        Size = UDim2.new(0, 10 * mobileScaleFactor, 0, 10 * mobileScaleFactor),
        Parent = self.uiSettingsPanelFrame
    })
    makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = self.uiAccentPreviewFrame})

    -- v6: isi popup ada di dalam area scroll (judul tetap di atas)
    self.uiSettingsPanelOuter = self.uiSettingsPanelFrame
    local settingsBody = makeThingExist("ScrollingFrame", {
        Name = "Body", BackgroundTransparency = 1, BorderSizePixel = 0,
        Position = UDim2.new(0, 0, 0, 28 * mobileScaleFactor), Size = UDim2.new(1, 0, 1, -32 * mobileScaleFactor),
        ScrollBarThickness = 3, ScrollBarImageColor3 = self.config.AccentColor, ScrollingDirection = Enum.ScrollingDirection.Y,
        CanvasSize = UDim2.new(0, 0, 0, 600), Parent = self.uiSettingsPanelOuter
    })
    self.uiSettingsPanelFrame = settingsBody

    local rowY = 4 * mobileScaleFactor
    local rowStep = 24 * mobileScaleFactor
    local function createSettingsHeader(text)
        local row = makeThingExist("Frame", {
            BackgroundTransparency = 1, Position = UDim2.new(0, 10, 0, rowY + 2 * mobileScaleFactor),
            Size = UDim2.new(1, -20, 0, 14 * mobileScaleFactor), Parent = self.uiSettingsPanelFrame
        })
        local bar = makeThingExist("Frame", {BackgroundColor3 = self.config.AccentColor, BorderSizePixel = 0, Position = UDim2.new(0, 0, 0.5, -5 * mobileScaleFactor), Size = UDim2.new(0, 2 * mobileScaleFactor, 0, 10 * mobileScaleFactor), Parent = row})
        makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = bar})
        makeThingExist("TextLabel", {
            FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold), Text = string.upper(text),
            TextColor3 = Color3.fromRGB(105, 105, 115), BackgroundTransparency = 1, Position = UDim2.new(0, 8 * mobileScaleFactor, 0, 0),
            Size = UDim2.new(1, -8 * mobileScaleFactor, 1, 0), TextSize = 10 * mobileScaleFactor, TextXAlignment = Enum.TextXAlignment.Left, Parent = row
        })
        rowY = rowY + 22 * mobileScaleFactor
    end
    local function createSettingsToggle(labelText, initial, callback)
        local rowFrame = makeThingExist("Frame", {
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 10, 0, rowY),
            Size = UDim2.new(1, -20, 0, 20 * mobileScaleFactor),
            Parent = self.uiSettingsPanelFrame
        })
        makeThingExist("TextLabel", {
            FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
            Text = labelText,
            TextColor3 = Color3.fromRGB(150, 150, 150),
            BackgroundTransparency = 1,
            Size = UDim2.new(1, -46 * mobileScaleFactor, 1, 0),
            TextSize = 12 * mobileScaleFactor,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = rowFrame
        })
        local switchFrame = makeThingExist("Frame", {
            BackgroundColor3 = initial and self.config.AccentColor or Color3.fromRGB(33, 33, 33),
            Position = UDim2.new(1, -34 * mobileScaleFactor, 0.5, -8 * mobileScaleFactor),
            Size = UDim2.new(0, 34 * mobileScaleFactor, 0, 16 * mobileScaleFactor),
            Parent = rowFrame
        })
        makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = switchFrame})
        local knob = makeThingExist("Frame", {
            BackgroundColor3 = initial and Color3.new(1, 1, 1) or Color3.fromRGB(95, 95, 95),
            Position = initial and UDim2.new(0.5, 0, 0.5, -6 * mobileScaleFactor) or UDim2.new(0, 2 * mobileScaleFactor, 0.5, -6 * mobileScaleFactor),
            Size = UDim2.new(0, 12 * mobileScaleFactor, 0, 12 * mobileScaleFactor),
            Parent = switchFrame
        })
        makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = knob})

        local state = initial == true
        local function setState(nextState, skipCallback)
            state = nextState == true
            smoothMoveGoWoosh(switchFrame, {BackgroundColor3 = state and self.config.AccentColor or Color3.fromRGB(33, 33, 33)}, 0.16)
            smoothMoveGoWoosh(knob, {
                Position = state and UDim2.new(0.5, 0, 0.5, -6 * mobileScaleFactor) or UDim2.new(0, 2 * mobileScaleFactor, 0.5, -6 * mobileScaleFactor),
                BackgroundColor3 = state and Color3.new(1, 1, 1) or Color3.fromRGB(95, 95, 95)
            }, 0.16, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
            if not skipCallback then
                callback(state)
            end
        end

        local toggleButton = makeThingExist("TextButton", {
            Text = "",
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            Parent = rowFrame
        })
        toggleButton.MouseButton1Click:Connect(function()
            setState(not state, false)
        end)

        rowY = rowY + rowStep
        return {
            Set = setState,
            Get = function()
                return state
            end
        }
    end

    createSettingsHeader("Effects")
    local blurToggleRef = createSettingsToggle("Blur Background", self._uiVisualSettings.Blur, function(enabled)
        self._uiVisualSettings.Blur = enabled
        self:_ApplyOpenCloseVisuals(false)
    end)
    local overlayToggleRef = createSettingsToggle("Overlay FX", self._uiVisualSettings.Snow, function(enabled)
        self:_SetSnowEnabled(enabled)
    end)
    local bgFxToggleRef = createSettingsToggle("Background FX", self._uiVisualSettings.BackgroundEffects, function(enabled)
        self:_SetBackgroundEffectsEnabled(enabled)
    end)
    local gradientToggleRef = createSettingsToggle("Text Gradient", self._uiVisualSettings.TextGradient, function(enabled)
        self:_SetTextGradientEnabled(enabled)
    end)
local espPreviewToggleRef = createSettingsToggle("ESP Preview", self._uiVisualSettings.ESPSelfPreview, function(enabled)
        self._uiVisualSettings.ESPSelfPreview = enabled
        self:_UpdateESPPreview(0)
    end)
    
    -- ==========================================
    -- [KODE BARU: FUNGSI MEMBUAT KOLOM INPUT DI SETTINGS]
    -- ==========================================
    local function createSettingsInput(labelText, initial, callback)
        local rowFrame = makeThingExist("Frame", {
            BackgroundTransparency = 1, Position = UDim2.new(0, 10, 0, rowY),
            Size = UDim2.new(1, -20, 0, 20 * mobileScaleFactor), Parent = self.uiSettingsPanelFrame
        })
        makeThingExist("TextLabel", {
            FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
            Text = labelText, TextColor3 = Color3.fromRGB(150, 150, 150), BackgroundTransparency = 1,
            Size = UDim2.new(1, -60 * mobileScaleFactor, 1, 0), TextSize = 12 * mobileScaleFactor,
            TextXAlignment = Enum.TextXAlignment.Left, Parent = rowFrame
        })
        
        -- Background (kotak) tempat ngetik
        local inputBg = makeThingExist("Frame", {
            BackgroundColor3 = Color3.fromRGB(24, 24, 24),
            Position = UDim2.new(1, -44 * mobileScaleFactor, 0.5, -9 * mobileScaleFactor),
            Size = UDim2.new(0, 44 * mobileScaleFactor, 0, 18 * mobileScaleFactor), Parent = rowFrame
        })
        makeThingExist("UICorner", {CornerRadius = UDim.new(0, 6), Parent = inputBg})
        makeThingExist("UIStroke", {Color = Color3.fromRGB(44, 44, 44), Parent = inputBg})

        -- Tempat ngetiknya (TextBox)
        local inputBox = makeThingExist("TextBox", {
            FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
            Text = tostring(initial), TextColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0), TextSize = 11 * mobileScaleFactor, Parent = inputBg
        })

        -- Saat selesai mengetik
        inputBox.FocusLost:Connect(function()
            local val = tonumber(inputBox.Text)
            if val then
                val = math.clamp(val, 0, 1) -- Membatasi angka agar tidak kurang dari 0 atau lebih dari 1
                inputBox.Text = tostring(val)
                callback(val)
            else
                inputBox.Text = tostring(initial) -- Kalau ngetik huruf, kembalikan ke awal
            end
        end)

        rowY = rowY + rowStep
    end

    -- ==========================================
    -- [KODE BARU: MENAMPILKAN MENU TRANSPARANSI]
    -- ==========================================
    createSettingsHeader("Interface")
    createSettingsInput("UI Transparent", 0, function(val)
        -- Ubah transparansi UI secara smooth
        smoothMoveGoWoosh(self.mainFrameYay, {BackgroundTransparency = val}, 0.2)
        if self.mainBackgroundEffectsFrame then
            -- Efek background juga ditransparankan (ditambah 0.45 agar sedikit lebih gelap dari layar utama)
            smoothMoveGoWoosh(self.mainBackgroundEffectsFrame, {BackgroundTransparency = math.clamp(val + 0.45, 0, 1)}, 0.2)
        end
    end)
    -- ==========================================
    -- [KODE BARU: FUNGSI KEYBIND DI SETTINGS (AUTO-SAVE GLOBAL)]
    -- ==========================================
    local function createSettingsKeybind(labelText, initialKey, callback)
        local rowFrame = makeThingExist("Frame", {
            BackgroundTransparency = 1, Position = UDim2.new(0, 10, 0, rowY),
            Size = UDim2.new(1, -20, 0, 20 * mobileScaleFactor), Parent = self.uiSettingsPanelFrame
        })
        makeThingExist("TextLabel", {
            FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
            Text = labelText, TextColor3 = Color3.fromRGB(150, 150, 150), BackgroundTransparency = 1,
            Size = UDim2.new(1, -75 * mobileScaleFactor, 1, 0), TextSize = 12 * mobileScaleFactor,
            TextXAlignment = Enum.TextXAlignment.Left, Parent = rowFrame
        })
        
        local buttonBg = makeThingExist("Frame", {
            BackgroundColor3 = Color3.fromRGB(24, 24, 24),
            Position = UDim2.new(1, -65 * mobileScaleFactor, 0.5, -9 * mobileScaleFactor),
            Size = UDim2.new(0, 65 * mobileScaleFactor, 0, 18 * mobileScaleFactor), Parent = rowFrame
        })
        makeThingExist("UICorner", {CornerRadius = UDim.new(0, 6), Parent = buttonBg})
        makeThingExist("UIStroke", {Color = Color3.fromRGB(44, 44, 44), Parent = buttonBg})

        -- [KODE AUTO-LOAD: BACA FILE SEBELUM UI MUNCUL]
        local currentKey = initialKey
        if isfile and readfile and isfile("NemesisUIConfigs/NemesisKeybind.txt") then
            local success, savedKeyName = pcall(function() return readfile("NemesisUIConfigs/NemesisKeybind.txt") end)
            if success and savedKeyName then
                local successEnum, parsedKey = pcall(function() return Enum.KeyCode[savedKeyName] end)
                if successEnum and parsedKey then
                    currentKey = parsedKey
                    -- Langsung terapkan keybind-nya ke sistem
                    task.spawn(function() callback(currentKey) end)
                end
            end
        end

        local keyTextLabel = makeThingExist("TextLabel", {
            FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
            Text = currentKey == Enum.KeyCode.Unknown and "None" or currentKey.Name, 
            TextColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0), TextSize = 10 * mobileScaleFactor, Parent = buttonBg
        })

        local keyButton = makeThingExist("TextButton", {
            Text = "", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), Parent = buttonBg
        })

        local isListening = false

        keyButton.MouseButton1Click:Connect(function()
            isListening = true
            keyTextLabel.Text = "..."
            smoothMoveGoWoosh(buttonBg, {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}, 0.15)
        end)

        local function setKey(newKey)
            if newKey == Enum.KeyCode.Backspace or newKey == Enum.KeyCode.Delete then
                newKey = Enum.KeyCode.Unknown
            end
            currentKey = newKey
            keyTextLabel.Text = currentKey == Enum.KeyCode.Unknown and "None" or currentKey.Name
            callback(currentKey)
            
            -- [KODE AUTO-SAVE: LANGSUNG SAVE SAAT TOMBOL DIGANTI]
            if writefile then
                pcall(function()
                    if not isfolder("NemesisUIConfigs") then makefolder("NemesisUIConfigs") end
                    writefile("NemesisUIConfigs/NemesisKeybind.txt", currentKey.Name)
                end)
            end
        end

        self:_TrackConnection(thisInputServiceGoesHard.InputBegan:Connect(function(input)
            if isListening and input.UserInputType == Enum.UserInputType.Keyboard then
                isListening = false
                smoothMoveGoWoosh(buttonBg, {BackgroundColor3 = Color3.fromRGB(24, 24, 24)}, 0.15)
                setKey(input.KeyCode)
            end
        end))

        rowY = rowY + rowStep
    end
    -- espPreviewToggleRef < Toggle yg gua disable ESP
    self.uiSettingsToggleRefs = {blurToggleRef, overlayToggleRef, bgFxToggleRef, gradientToggleRef} 

    local overlayRow = makeThingExist("Frame", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, rowY + 2 * mobileScaleFactor),
        Size = UDim2.new(1, -20, 0, 20 * mobileScaleFactor),
        Parent = self.uiSettingsPanelFrame
    })
    makeThingExist("TextLabel", {
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
        Text = "Overlay",
        TextColor3 = Color3.fromRGB(150, 150, 150),
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 52 * mobileScaleFactor, 1, 0),
        TextSize = 12 * mobileScaleFactor,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = overlayRow
    })

    local overlayPickerFrame = makeThingExist("Frame", {
        BackgroundColor3 = Color3.fromRGB(29, 29, 29),
        Position = UDim2.new(1, -84 * mobileScaleFactor, 0, 0),
        Size = UDim2.new(0, 84 * mobileScaleFactor, 1, 0),
        Parent = overlayRow
    })
    makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = overlayPickerFrame})
    makeThingExist("UIStroke", {Color = Color3.fromRGB(44, 44, 44), Parent = overlayPickerFrame})

    self.uiOverlayModeValueLabel = makeThingExist("TextLabel", {
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
        Text = self._overlayMode,
        TextColor3 = Color3.fromRGB(210, 210, 210),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 8 * mobileScaleFactor, 0, 0),
        Size = UDim2.new(1, -24 * mobileScaleFactor, 1, 0),
        TextSize = 11.5 * mobileScaleFactor,
        TextTruncate = Enum.TextTruncate.AtEnd,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = overlayPickerFrame
    })

    local overlayArrowImage = makeThingExist("ImageLabel", {
        Image = "rbxassetid://111626678408582",
        ImageColor3 = Color3.fromRGB(132, 132, 132),
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -18 * mobileScaleFactor, 0.5, -6 * mobileScaleFactor),
        Size = UDim2.new(0, 12 * mobileScaleFactor, 0, 12 * mobileScaleFactor),
        Parent = overlayPickerFrame
    })

    local overlayDropdownWidth = 102 * mobileScaleFactor
    local overlayDropdownRowHeight = 21 * mobileScaleFactor
    local overlayDropdownFrame = makeThingExist("Frame", {
        BackgroundColor3 = Color3.fromRGB(16, 16, 16),
        Size = UDim2.new(0, overlayDropdownWidth, 0, 0),
        ClipsDescendants = true,
        Visible = false,
        ZIndex = 9999,
        Parent = self.dropdownHolderRef
    })
    makeThingExist("UICorner", {CornerRadius = UDim.new(0, 7), Parent = overlayDropdownFrame})
    makeThingExist("UIStroke", {Color = Color3.fromRGB(42, 42, 42), Parent = overlayDropdownFrame})

    local overlayDropdownContainer = makeThingExist("Frame", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 4 * mobileScaleFactor, 0, 4 * mobileScaleFactor),
        Size = UDim2.new(1, -8 * mobileScaleFactor, 0, 0),
        ZIndex = 10000,
        Parent = overlayDropdownFrame
    })

    local overlayDropdownOpen = false
    local overlayDropdownPositionConn = nil
    local overlayDropdownOutsideConn = nil

    local function updateOverlayDropdownPosition()
        local pickerAbsPos = overlayPickerFrame.AbsolutePosition
        local pickerAbsSize = overlayPickerFrame.AbsoluteSize
        overlayDropdownFrame.Position = UDim2.new(0, pickerAbsPos.X + pickerAbsSize.X - overlayDropdownWidth, 0, pickerAbsPos.Y + pickerAbsSize.Y + 5)
    end

    local function closeOverlayDropdown(isInstant)
        overlayDropdownOpen = false
        if overlayDropdownPositionConn then
            overlayDropdownPositionConn:Disconnect()
            overlayDropdownPositionConn = nil
        end
        if overlayDropdownOutsideConn then
            overlayDropdownOutsideConn:Disconnect()
            overlayDropdownOutsideConn = nil
        end
        smoothMoveGoWoosh(overlayArrowImage, {Rotation = 0}, 0.16)
        smoothMoveGoWoosh(overlayPickerFrame, {BackgroundColor3 = Color3.fromRGB(29, 29, 29)}, 0.16)
        if isInstant then
            overlayDropdownFrame.Size = UDim2.new(0, overlayDropdownWidth, 0, 0)
            overlayDropdownFrame.Visible = false
            return
        end
        smoothMoveGoWoosh(overlayDropdownFrame, {Size = UDim2.new(0, overlayDropdownWidth, 0, 0)}, 0.18, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
        task.delay(0.18, function()
            if overlayDropdownFrame and overlayDropdownFrame.Parent and not overlayDropdownOpen then
                overlayDropdownFrame.Visible = false
            end
        end)
    end

    local rebuildOverlayDropdownOptions
    rebuildOverlayDropdownOptions = function()
        for _, child in ipairs(overlayDropdownContainer:GetChildren()) do
            if child:IsA("Frame") or child:IsA("TextButton") then
                child:Destroy()
            end
        end
        local optionY = 0
        for _, modeName in ipairs(self._overlayModes) do
            local isSelected = modeName == self._overlayMode
            local optionFrame = makeThingExist("Frame", {
                BackgroundColor3 = isSelected and Color3.fromRGB(33, 33, 33) or Color3.fromRGB(23, 23, 23),
                Position = UDim2.new(0, 0, 0, optionY),
                Size = UDim2.new(1, 0, 0, overlayDropdownRowHeight - 2 * mobileScaleFactor),
                ZIndex = 10001,
                Parent = overlayDropdownContainer
            })
            makeThingExist("UICorner", {CornerRadius = UDim.new(0, 6), Parent = optionFrame})
            local optionLabel = makeThingExist("TextLabel", {
                FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
                Text = modeName,
                TextColor3 = isSelected and Color3.new(1, 1, 1) or Color3.fromRGB(138, 138, 138),
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -8 * mobileScaleFactor, 1, 0),
                Position = UDim2.new(0, 8 * mobileScaleFactor, 0, 0),
                TextXAlignment = Enum.TextXAlignment.Left,
                TextSize = 11.5 * mobileScaleFactor,
                ZIndex = 10002,
                Parent = optionFrame
            })
            local optionButton = makeThingExist("TextButton", {
                Text = "",
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 1, 0),
                ZIndex = 10003,
                Parent = optionFrame
            })
            optionButton.MouseButton1Click:Connect(function()
                self:_SetOverlayMode(modeName)
                self.uiOverlayModeValueLabel.Text = self._overlayMode
                rebuildOverlayDropdownOptions()
                closeOverlayDropdown(false)
            end)
            optionButton.MouseEnter:Connect(function()
                if self._overlayMode ~= modeName then
                    smoothMoveGoWoosh(optionFrame, {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}, 0.12)
                    smoothMoveGoWoosh(optionLabel, {TextColor3 = Color3.fromRGB(188, 188, 188)}, 0.12)
                end
            end)
            optionButton.MouseLeave:Connect(function()
                if self._overlayMode ~= modeName then
                    smoothMoveGoWoosh(optionFrame, {BackgroundColor3 = Color3.fromRGB(23, 23, 23)}, 0.12)
                    smoothMoveGoWoosh(optionLabel, {TextColor3 = Color3.fromRGB(138, 138, 138)}, 0.12)
                end
            end)
            optionY = optionY + overlayDropdownRowHeight
        end
        overlayDropdownContainer.Size = UDim2.new(1, -8 * mobileScaleFactor, 0, optionY)
    end

    local function openOverlayDropdown()
        overlayDropdownOpen = true
        rebuildOverlayDropdownOptions()
        updateOverlayDropdownPosition()
        overlayDropdownFrame.Visible = true
        smoothMoveGoWoosh(overlayDropdownFrame, {Size = UDim2.new(0, overlayDropdownWidth, 0, #self._overlayModes * overlayDropdownRowHeight + 8 * mobileScaleFactor)}, 0.2)
        smoothMoveGoWoosh(overlayArrowImage, {Rotation = 180}, 0.16)
        smoothMoveGoWoosh(overlayPickerFrame, {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}, 0.16)
        if overlayDropdownPositionConn then
            overlayDropdownPositionConn:Disconnect()
            overlayDropdownPositionConn = nil
        end
        overlayDropdownPositionConn = self:_TrackConnection(runServiceMoreLikeWalkService.RenderStepped:Connect(function()
            if overlayDropdownOpen then
                updateOverlayDropdownPosition()
            end
        end))
        if overlayDropdownOutsideConn then
            overlayDropdownOutsideConn:Disconnect()
            overlayDropdownOutsideConn = nil
        end
        overlayDropdownOutsideConn = self:_TrackConnection(thisInputServiceGoesHard.InputBegan:Connect(function(input)
            if not overlayDropdownOpen then
                return
            end
            local isClick = input.UserInputType == Enum.UserInputType.MouseButton1
                or input.UserInputType == Enum.UserInputType.MouseButton2
                or input.UserInputType == Enum.UserInputType.Touch
            if not isClick then
                return
            end
            local clickPos = input.Position
            local menuPos = overlayDropdownFrame.AbsolutePosition
            local menuSize = overlayDropdownFrame.AbsoluteSize
            local pickerPos = overlayPickerFrame.AbsolutePosition
            local pickerSize = overlayPickerFrame.AbsoluteSize
            local insideMenu = clickPos.X >= menuPos.X and clickPos.X <= menuPos.X + menuSize.X and clickPos.Y >= menuPos.Y and clickPos.Y <= menuPos.Y + menuSize.Y
            local insidePicker = clickPos.X >= pickerPos.X and clickPos.X <= pickerPos.X + pickerSize.X and clickPos.Y >= pickerPos.Y and clickPos.Y <= pickerPos.Y + pickerSize.Y
            if not insideMenu and not insidePicker then
                closeOverlayDropdown(false)
            end
        end))
    end

    local overlayPickerButton = makeThingExist("TextButton", {
        Text = "",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Parent = overlayPickerFrame
    })
    overlayPickerButton.MouseButton1Click:Connect(function()
        if overlayDropdownOpen then
            closeOverlayDropdown(false)
        else
            openOverlayDropdown()
        end
    end)
    overlayPickerButton.MouseEnter:Connect(function()
        if not overlayDropdownOpen then
            smoothMoveGoWoosh(overlayPickerFrame, {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}, 0.12)
        end
    end)
    overlayPickerButton.MouseLeave:Connect(function()
        if not overlayDropdownOpen then
            smoothMoveGoWoosh(overlayPickerFrame, {BackgroundColor3 = Color3.fromRGB(29, 29, 29)}, 0.12)
        end
    end)

    rowY = rowY + rowStep

    local fontRow = makeThingExist("Frame", {
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0, rowY + 2 * mobileScaleFactor),
        Size = UDim2.new(1, -20, 0, 20 * mobileScaleFactor),
        Parent = self.uiSettingsPanelFrame
    })
    makeThingExist("TextLabel", {
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
        Text = "Font",
        TextColor3 = Color3.fromRGB(150, 150, 150),
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 34 * mobileScaleFactor, 1, 0),
        TextSize = 12 * mobileScaleFactor,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = fontRow
    })
    self.uiSettingsFontValueLabel = makeThingExist("TextLabel", {
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
        Text = self._fontPresets[self._fontPresetIndex].Name,
        TextColor3 = Color3.fromRGB(210, 210, 210),
        BackgroundTransparency = 1,
        Position = UDim2.new(0, 36 * mobileScaleFactor, 0, 0),
        Size = UDim2.new(0, 82 * mobileScaleFactor, 1, 0),
        TextSize = 12 * mobileScaleFactor,
        TextTruncate = Enum.TextTruncate.AtEnd,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = fontRow
    })
    local fontCycleFrame = makeThingExist("Frame", {
        BackgroundColor3 = Color3.fromRGB(29, 29, 29),
        Position = UDim2.new(1, -44 * mobileScaleFactor, 0, 0),
        Size = UDim2.new(0, 44 * mobileScaleFactor, 1, 0),
        Parent = fontRow
    })
    makeThingExist("UICorner", {CornerRadius = UDim.new(0, 8), Parent = fontCycleFrame})
    makeThingExist("TextLabel", {
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
        Text = "Next",
        TextColor3 = Color3.fromRGB(190, 190, 190),
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        TextSize = 11 * mobileScaleFactor,
        Parent = fontCycleFrame
    })
    local fontCycleButton = makeThingExist("TextButton", {
        Text = "",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Parent = fontCycleFrame
    })
    fontCycleButton.MouseButton1Click:Connect(function()
        self:ApplyFontPreset(self._fontPresetIndex + 1)
    end)

    local accentRowY = rowY -- [v8] baris Accent dihapus; accent lewat Theme preset / Accent color

    -- ======================================================================
    -- v6: grup Settings + Nickname dipindah ke popup ini
    -- ======================================================================
    local M = mobileScaleFactor
    local PFONT = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold)
    local MUTEDTXT = Color3.fromRGB(150, 150, 150)
    self._trackedControls = self._trackedControls or {}
    rowY = accentRowY + 30 * M

    local function trackPopup(flag, getter, setter)
        self._trackedControls[flag] = {get = getter, set = setter}
    end

    local function createSettingsCycle(labelText, options, initialName, flag, callback)
        local index = 1
        for i, name in ipairs(options) do if name == initialName then index = i end end
        local rowFrame = makeThingExist("Frame", {BackgroundTransparency = 1, Position = UDim2.new(0, 10, 0, rowY), Size = UDim2.new(1, -20, 0, 20 * M), Parent = self.uiSettingsPanelFrame})
        makeThingExist("TextLabel", {FontFace = PFONT, Text = labelText, TextColor3 = MUTEDTXT, BackgroundTransparency = 1, Size = UDim2.new(1, -96 * M, 1, 0), TextSize = 12 * M, TextXAlignment = Enum.TextXAlignment.Left, Parent = rowFrame})
        local pill = makeThingExist("Frame", {BackgroundColor3 = Color3.fromRGB(29, 29, 29), Position = UDim2.new(1, -92 * M, 0, 0), Size = UDim2.new(0, 92 * M, 1, 0), Parent = rowFrame})
        makeThingExist("UICorner", {CornerRadius = UDim.new(0, 6), Parent = pill})
        makeThingExist("UIStroke", {Color = Color3.fromRGB(44, 44, 44), Parent = pill})
        local valueLabel = makeThingExist("TextLabel", {FontFace = PFONT, Text = options[index], TextColor3 = Color3.fromRGB(210, 210, 210), BackgroundTransparency = 1, Position = UDim2.new(0, 8 * M, 0, 0), Size = UDim2.new(1, -24 * M, 1, 0), TextSize = 11 * M, TextTruncate = Enum.TextTruncate.AtEnd, TextXAlignment = Enum.TextXAlignment.Left, Parent = pill})
        makeThingExist("ImageLabel", {Image = pickLucide({"chevrons-up-down", "chevron-down"}, ""), ImageColor3 = Color3.fromRGB(132, 132, 132), BackgroundTransparency = 1, Position = UDim2.new(1, -17 * M, 0.5, -6 * M), Size = UDim2.new(0, 12 * M, 0, 12 * M), Parent = pill})
        local btn = makeThingExist("TextButton", {Text = "", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), Parent = pill})
        local function setIndex(i, skip)
            index = ((i - 1) % #options) + 1
            valueLabel.Text = options[index]
            if not skip then callback(options[index]) end
        end
        btn.MouseButton1Click:Connect(function() setIndex(index + 1) end)
        if flag then
            trackPopup(flag, function() return options[index] end, function(v)
                for i, name in ipairs(options) do
                    if name == v then setIndex(i) break end
                end
            end)
        end
        rowY = rowY + rowStep
    end

    local function createSettingsSlider(labelText, minV, maxV, initial, suffix, flag, callback)
        local value = initial
        local rowFrame = makeThingExist("Frame", {BackgroundTransparency = 1, Position = UDim2.new(0, 10, 0, rowY), Size = UDim2.new(1, -20, 0, 32 * M), Parent = self.uiSettingsPanelFrame})
        makeThingExist("TextLabel", {FontFace = PFONT, Text = labelText, TextColor3 = MUTEDTXT, BackgroundTransparency = 1, Size = UDim2.new(0.6, 0, 0, 16 * M), TextSize = 12 * M, TextXAlignment = Enum.TextXAlignment.Left, Parent = rowFrame})
        local valueLabel = makeThingExist("TextLabel", {FontFace = PFONT, Text = tostring(initial) .. suffix, TextColor3 = self.config.AccentColor, BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, 0, 0, 0), Size = UDim2.new(0.4, 0, 0, 16 * M), TextSize = 11 * M, TextXAlignment = Enum.TextXAlignment.Right, Parent = rowFrame})
        local track = makeThingExist("Frame", {BackgroundColor3 = Color3.fromRGB(33, 33, 33), BorderSizePixel = 0, Position = UDim2.new(0, 0, 0, 23 * M), Size = UDim2.new(1, 0, 0, 5 * M), Parent = rowFrame})
        makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = track})
        local fill = makeThingExist("Frame", {BackgroundColor3 = self.config.AccentColor, BorderSizePixel = 0, Size = UDim2.new((initial - minV) / (maxV - minV), 0, 1, 0), Parent = track})
        makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = fill})
        local hit = makeThingExist("TextButton", {Text = "", BackgroundTransparency = 1, Position = UDim2.new(0, 0, 0, 16 * M), Size = UDim2.new(1, 0, 0, 16 * M), Parent = rowFrame})
        local function setValue(v, skip)
            v = math.clamp(math.floor(v + 0.5), minV, maxV)
            value = v
            fill.Size = UDim2.new((v - minV) / (maxV - minV), 0, 1, 0)
            valueLabel.Text = tostring(v) .. suffix
            if not skip then callback(v) end
        end
        local function fromX(x)
            local a = math.clamp((x - track.AbsolutePosition.X) / math.max(track.AbsoluteSize.X, 1), 0, 1)
            setValue(minV + a * (maxV - minV))
        end
        local dragging = false
        hit.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                fromX(input.Position.X)
            end
        end)
        self:_TrackConnection(thisInputServiceGoesHard.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                fromX(input.Position.X)
            end
        end))
        self:_TrackConnection(thisInputServiceGoesHard.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
        end))
        if flag then trackPopup(flag, function() return value end, function(v) if tonumber(v) then setValue(tonumber(v)) end end) end
        rowY = rowY + 36 * M
    end

    local function createSettingsButton(text, desc, callback)
        local card = makeThingExist("TextButton", {Text = "", AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(24, 24, 24), Position = UDim2.new(0, 10, 0, rowY), Size = UDim2.new(1, -20, 0, 32 * M), Parent = self.uiSettingsPanelFrame})
        makeThingExist("UICorner", {CornerRadius = UDim.new(0, 7), Parent = card})
        makeThingExist("UIStroke", {Color = Color3.fromRGB(44, 44, 44), Parent = card})
        makeThingExist("TextLabel", {FontFace = PFONT, Text = text, TextColor3 = Color3.fromRGB(210, 210, 210), BackgroundTransparency = 1, Position = UDim2.new(0, 10 * M, 0, 3 * M), Size = UDim2.new(1, -20 * M, 0, 14 * M), TextSize = 12 * M, TextXAlignment = Enum.TextXAlignment.Left, Parent = card})
        makeThingExist("TextLabel", {FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium), Text = desc, TextColor3 = Color3.fromRGB(105, 105, 115), BackgroundTransparency = 1, Position = UDim2.new(0, 10 * M, 0, 17 * M), Size = UDim2.new(1, -20 * M, 0, 12 * M), TextSize = 10 * M, TextXAlignment = Enum.TextXAlignment.Left, Parent = card})
        card.MouseButton1Click:Connect(callback)
        card.MouseEnter:Connect(function() smoothMoveGoWoosh(card, {BackgroundColor3 = Color3.fromRGB(32, 32, 32)}, 0.12) end)
        card.MouseLeave:Connect(function() smoothMoveGoWoosh(card, {BackgroundColor3 = Color3.fromRGB(24, 24, 24)}, 0.12) end)
        rowY = rowY + 38 * M
    end

    createSettingsHeader("Settings")
    local themeNames = {"Default", "Midnight", "Moss", "Ember", "Rose", "Mono"}
    createSettingsCycle("Theme preset", themeNames, "Default", "Config_Theme", function(name)
        local theme = superMegaAwesomeLibrary.Themes and superMegaAwesomeLibrary.Themes[name]
        if name == "Default" then self:SetAccentColor(superMegaAwesomeLibrary.AccentColors.Default)
        elseif theme and theme.Accent then self:SetAccentColor(theme.Accent) end
    end)
    createSettingsCycle("Accent color", superMegaAwesomeLibrary.AccentColorOrder, "Royal", "Config_Accent", function(name)
        self:SetAccentPreset(name)
    end)
    local badgeToggleRef = createSettingsToggle("In-game badge", self._badgeEnabled ~= false, function(v) self:SetInGameBadge(v) end)
    trackPopup("Config_InGameBadge", function() return badgeToggleRef.Get() end, function(v) badgeToggleRef.Set(v == true) end)
    local autoSaveToggleRef = createSettingsToggle("Auto save", self._autoSaveEnabled == true, function(v) self:SetAutoSave(v) end)
    trackPopup("Config_AutoSave", function() return autoSaveToggleRef.Get() end, function(v) autoSaveToggleRef.Set(v == true) end)
    createSettingsSlider("UI scale", 80, 120, 100, "%", "Config_UIScale", function(v)
        if not self.mainFrameYay then return end
        self._userScale = v / 100
        self:_ApplyWindowScale()
    end)

    -- ---------------------------------------------------------------------
    -- Nickname card: tombol mata (hide/show) + collapse, semua pakai ikon
    -- ---------------------------------------------------------------------
    createSettingsHeader("Nickname")
    local ICON_EYE = pickLucide({"eye"}, "")
    local ICON_EYE_OFF = pickLucide({"eye-off", "eye-closed"}, "")
    local ICON_IMG = pickLucide({"image", "user"}, "")
    local ICON_IMG_OFF = pickLucide({"image-off", "user-x", "eye-off"}, "")
    local ICON_CHEVRON = pickLucide({"chevron-down"}, "")
    local HEAD_H, ROW_H = 30 * M, 24 * M
    local BADGE_COUNT = 3
    local fullH = HEAD_H + 4 * M + ROW_H * 2 + 18 * M + ROW_H * BADGE_COUNT + 6 * M
    local nickY = rowY
    local nickCard = makeThingExist("Frame", {BackgroundColor3 = Color3.fromRGB(24, 24, 26), BorderSizePixel = 0, ClipsDescendants = true, Position = UDim2.new(0, 10, 0, nickY), Size = UDim2.new(1, -20, 0, fullH), Parent = self.uiSettingsPanelFrame})
    makeThingExist("UICorner", {CornerRadius = UDim.new(0, 8), Parent = nickCard})
    makeThingExist("UIStroke", {Color = Color3.fromRGB(44, 44, 44), Parent = nickCard})

    local function updateCanvas(cardHeight)
        settingsBody.CanvasSize = UDim2.new(0, 0, 0, nickY + cardHeight + 14 * M)
    end
    updateCanvas(fullH)

    -- tombol ikon mata: shown = ikon mata (accent), hidden = mata dicoret (merah redup)
    local SHOWN_COLOR, HIDDEN_COLOR = self.config.AccentColor, Color3.fromRGB(215, 90, 105)
    local function createEyeButton(parent, size, iconOn, iconOff, initialHidden, onChange)
        local hidden = initialHidden == true
        local btn = makeThingExist("TextButton", {Text = "", AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(34, 34, 38), Size = UDim2.new(0, size, 0, size), Parent = parent})
        makeThingExist("UICorner", {CornerRadius = UDim.new(0, 6), Parent = btn})
        local img = makeThingExist("ImageLabel", {BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.new(0, size * 0.58, 0, size * 0.58), Parent = btn})
        local api = {Button = btn}
        local function paint()
            img.Image = hidden and iconOff or iconOn
            img.ImageColor3 = hidden and HIDDEN_COLOR or SHOWN_COLOR
        end
        function api.Set(value, skip)
            hidden = value == true
            paint()
            if not skip and onChange then onChange(hidden) end
        end
        function api.Get() return hidden end
        btn.MouseButton1Click:Connect(function() api.Set(not hidden) end)
        btn.MouseEnter:Connect(function() smoothMoveGoWoosh(btn, {BackgroundColor3 = Color3.fromRGB(46, 46, 52)}, 0.12) end)
        btn.MouseLeave:Connect(function() smoothMoveGoWoosh(btn, {BackgroundColor3 = Color3.fromRGB(34, 34, 38)}, 0.12) end)
        paint()
        return api
    end

    -- header: ikon, judul, tombol mata utama (hide semua), tombol collapse
    local headerIcon = makeThingExist("ImageLabel", {Image = ICON_EYE, ImageColor3 = self.config.AccentColor, BackgroundTransparency = 1, Position = UDim2.new(0, 10 * M, 0, (HEAD_H - 14 * M) / 2), Size = UDim2.new(0, 14 * M, 0, 14 * M), Parent = nickCard})
    makeThingExist("TextLabel", {FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold), Text = "Nickname", TextColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Position = UDim2.new(0, 30 * M, 0, 0), Size = UDim2.new(1, -100 * M, 0, HEAD_H), TextSize = 12.5 * M, TextXAlignment = Enum.TextXAlignment.Left, Parent = nickCard})

    local userBtn, avatarBtn, masterBtn
    local function syncMaster()
        if masterBtn and userBtn and avatarBtn then masterBtn.Set(userBtn.Get() and avatarBtn.Get(), true) end
    end

    local content = makeThingExist("Frame", {BackgroundTransparency = 1, Position = UDim2.new(0, 0, 0, HEAD_H), Size = UDim2.new(1, 0, 1, -HEAD_H), Parent = nickCard})
    makeThingExist("Frame", {BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.93, BorderSizePixel = 0, Position = UDim2.new(0, 10 * M, 0, 0), Size = UDim2.new(1, -20 * M, 0, 1), Parent = content})

    local function createNickRow(y, iconId, text)
        makeThingExist("ImageLabel", {Image = iconId, ImageColor3 = Color3.fromRGB(120, 120, 130), BackgroundTransparency = 1, Position = UDim2.new(0, 12 * M, 0, y + (ROW_H - 13 * M) / 2), Size = UDim2.new(0, 13 * M, 0, 13 * M), Parent = content})
        makeThingExist("TextLabel", {FontFace = PFONT, Text = text, TextColor3 = Color3.fromRGB(190, 190, 195), BackgroundTransparency = 1, Position = UDim2.new(0, 32 * M, 0, y), Size = UDim2.new(1, -74 * M, 0, ROW_H), TextSize = 11.5 * M, TextTruncate = Enum.TextTruncate.AtEnd, TextXAlignment = Enum.TextXAlignment.Left, Parent = content})
    end
    local function placeEye(api, y)
        api.Button.AnchorPoint = Vector2.new(1, 0)
        api.Button.Position = UDim2.new(1, -10 * M, 0, y + (ROW_H - 20 * M) / 2)
    end

    local y1 = 4 * M
    createNickRow(y1, pickLucide({"user", "eye"}, ""), "Username")
    userBtn = createEyeButton(content, 20 * M, ICON_EYE, ICON_EYE_OFF, self._hideUsername == true, function(h) self:SetHideUsername(h) syncMaster() end)
    placeEye(userBtn, y1)
    local y2 = y1 + ROW_H
    createNickRow(y2, ICON_IMG, "Avatar")
    avatarBtn = createEyeButton(content, 20 * M, ICON_IMG, ICON_IMG_OFF, self._hideAvatar == true, function(h) self:SetHideAvatar(h) syncMaster() end)
    placeEye(avatarBtn, y2)
    trackPopup("Config_HideUsername", function() return userBtn.Get() end, function(v) userBtn.Set(v == true) end)
    trackPopup("Config_HideAvatar", function() return avatarBtn.Get() end, function(v) avatarBtn.Set(v == true) end)

    local y3 = y2 + ROW_H + 2 * M
    makeThingExist("TextLabel", {FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold), Text = "BADGES", TextColor3 = Color3.fromRGB(105, 105, 115), BackgroundTransparency = 1, Position = UDim2.new(0, 12 * M, 0, y3), Size = UDim2.new(1, -24 * M, 0, 14 * M), TextSize = 9.5 * M, TextXAlignment = Enum.TextXAlignment.Left, Parent = content})
    local badgeBox = makeThingExist("Frame", {BackgroundTransparency = 1, Position = UDim2.new(0, 0, 0, y3 + 16 * M), Size = UDim2.new(1, 0, 0, ROW_H * BADGE_COUNT), Parent = content})

    local badgeKeys = {"Tier", "Level", "Rank"}
    local function refreshBadges()
        for _, child in ipairs(badgeBox:GetChildren()) do child:Destroy() end
        local owned = {}
        local okBadges, list = pcall(function() return self:GetOwnedBadges() end)
        if okBadges and type(list) == "table" then for _, badge in ipairs(list) do owned[badge.Key] = badge end end
        for index, key in ipairs(badgeKeys) do
            local badge = owned[key] or {Key = key, Name = key .. " badge"}
            local y = (index - 1) * ROW_H
            local hiddenNow = self._hiddenBadges and self._hiddenBadges[key] == true
            makeThingExist("ImageLabel", {Image = ICON_EYE, ImageColor3 = Color3.fromRGB(120, 120, 130), BackgroundTransparency = 1, Position = UDim2.new(0, 12 * M, 0, y + (ROW_H - 13 * M) / 2), Size = UDim2.new(0, 13 * M, 0, 13 * M), Parent = badgeBox})
            makeThingExist("TextLabel", {FontFace = PFONT, Text = badge.Name, TextColor3 = Color3.fromRGB(190, 190, 195), BackgroundTransparency = 1, Position = UDim2.new(0, 32 * M, 0, y), Size = UDim2.new(1, -74 * M, 0, ROW_H), TextSize = 11.5 * M, TextTruncate = Enum.TextTruncate.AtEnd, TextXAlignment = Enum.TextXAlignment.Left, Parent = badgeBox})
            local eye = createEyeButton(badgeBox, 20 * M, ICON_EYE, ICON_EYE_OFF, hiddenNow, function(h) self:SetBadgeVisible(key, not h) end)
            eye.Button.AnchorPoint = Vector2.new(1, 0)
            eye.Button.Position = UDim2.new(1, -10 * M, 0, y + (ROW_H - 20 * M) / 2)
        end
    end
    self._RefreshNicknameBadges = refreshBadges
    refreshBadges()
    for _, key in ipairs(badgeKeys) do
        trackPopup("Config_Badge_" .. key, function() return not (self._hiddenBadges and self._hiddenBadges[key] == true) end, function(v)
            self:SetBadgeVisible(key, v ~= false)
            refreshBadges()
        end)
    end

    -- tombol mata utama + collapse di header
    masterBtn = createEyeButton(nickCard, 20 * M, ICON_EYE, ICON_EYE_OFF, (self._hideUsername == true) and (self._hideAvatar == true), function(h)
        userBtn.Set(h)
        avatarBtn.Set(h)
    end)
    masterBtn.Button.AnchorPoint = Vector2.new(1, 0)
    masterBtn.Button.Position = UDim2.new(1, -38 * M, 0, (HEAD_H - 20 * M) / 2)

    local chevronBtn = makeThingExist("TextButton", {Text = "", AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(34, 34, 38), AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -10 * M, 0, (HEAD_H - 20 * M) / 2), Size = UDim2.new(0, 20 * M, 0, 20 * M), Parent = nickCard})
    makeThingExist("UICorner", {CornerRadius = UDim.new(0, 6), Parent = chevronBtn})
    local chevronImg = makeThingExist("ImageLabel", {Image = ICON_CHEVRON, ImageColor3 = Color3.fromRGB(190, 190, 195), BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.new(0, 12 * M, 0, 12 * M), Parent = chevronBtn})
    local nickExpanded = true
    chevronBtn.MouseButton1Click:Connect(function()
        nickExpanded = not nickExpanded
        local targetH = nickExpanded and fullH or HEAD_H
        smoothMoveGoWoosh(nickCard, {Size = UDim2.new(1, -20, 0, targetH)}, 0.2, Enum.EasingStyle.Quint)
        smoothMoveGoWoosh(chevronImg, {Rotation = nickExpanded and 0 or -90}, 0.2)
        if nickExpanded then updateCanvas(targetH) else task.delay(0.2, function() updateCanvas(HEAD_H) end) end
    end)
    syncMaster()

    rowY = nickY + fullH + 14 * M


    local function setSettingsPanelOpen(openState)
        self.uiSettingsOpen = openState == true
        if self.uiSettingsOpen then
            self.uiSettingsPanelOuter.Visible = true
            if self._RefreshNicknameBadges then pcall(self._RefreshNicknameBadges) end
            smoothMoveGoWoosh(self.uiSettingsPanelOuter, {Size = UDim2.new(0, settingsPanelWidth, 0, settingsPanelHeight)}, 0.22)
            smoothMoveGoWoosh(self.uiSettingsButtonFrame, {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}, 0.2)
            smoothMoveGoWoosh(self.uiSettingsButtonStroke, {Color = self.config.AccentColor:Lerp(Color3.fromRGB(20, 20, 20), 0.45)}, 0.2)
        else
            closeOverlayDropdown(true)
            smoothMoveGoWoosh(self.uiSettingsPanelOuter, {Size = UDim2.new(0, settingsPanelWidth, 0, 0)}, 0.18, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
            smoothMoveGoWoosh(self.uiSettingsButtonFrame, {BackgroundColor3 = Color3.fromRGB(20, 20, 20)}, 0.2)
            smoothMoveGoWoosh(self.uiSettingsButtonStroke, {Color = Color3.fromRGB(45, 45, 45)}, 0.2)
            task.delay(0.18, function()
                if self.uiSettingsPanelOuter and self.uiSettingsPanelOuter.Parent and not self.uiSettingsOpen then
                    self.uiSettingsPanelOuter.Visible = false
                end
            end)
        end
    end

    settingsToggleButton.MouseButton1Click:Connect(function()
        setSettingsPanelOpen(not self.uiSettingsOpen)
    end)
    settingsToggleButton.MouseEnter:Connect(function()
        smoothMoveGoWoosh(self.uiSettingsButtonFrame, {BackgroundColor3 = Color3.fromRGB(28, 28, 28)}, 0.15)
    end)
    settingsToggleButton.MouseLeave:Connect(function()
        if not self.uiSettingsOpen then
            smoothMoveGoWoosh(self.uiSettingsButtonFrame, {BackgroundColor3 = Color3.fromRGB(20, 20, 20)}, 0.15)
        end
    end)
end

-- ==========================================================================
-- Notifications: ported from Airflow (toast with accent bar, CanvasGroup fade, slide in/out, progress line)
-- ==========================================================================
local NOTIFY_THEME = {
    Background = Color3.fromRGB(17, 17, 20),
    Stroke = Color3.fromRGB(40, 40, 46),
    Text = Color3.fromRGB(240, 240, 244),
    Muted = Color3.fromRGB(140, 140, 150),
    Surface3 = Color3.fromRGB(34, 34, 40),
    Success = Color3.fromRGB(150, 220, 170),
    Warning = Color3.fromRGB(240, 176, 108),
    Error = Color3.fromRGB(240, 120, 120),
}

-- [NEMESIS+] Airflow notification icons: type icons + Airflow's sprite-sheet icon resolver
local NOTIFY_ICON_NAMES = {
    Info    = {"info"},
    Success = {"circle-check", "check-circle", "check"},
    Warning = {"triangle-alert", "alert-triangle", "circle-alert", "alert-circle"},
    Error   = {"circle-x", "x-circle", "circle-alert"},
    Default = {"bell"},
}
local airflowIconPack -- Airflow's icon pack (sprite sheets), loaded on demand
local function loadAirflowIcons()
    if airflowIconPack ~= nil then return airflowIconPack end
    local ok, pack = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/Icons/refs/heads/main/lucide/dist/Icons.lua"))()
    end)
    airflowIconPack = (ok and type(pack) == "table") and pack or false
    return airflowIconPack
end
-- returns image, rectOffset, rectSize (same logic as Airflow's icon resolver)
local function resolveAirflowIcon(name)
    local pack = loadAirflowIcons()
    if not pack then return nil end
    local entry = (pack.Icons and pack.Icons[name]) or pack[name]
    if type(entry) == "table" then
        local image = entry.Image
        if type(image) == "number" then image = "rbxassetid://" .. tostring(image) end
        local sheet = (pack.Spritesheets and pack.Spritesheets[tostring(image)]) or image
        return sheet, entry.ImageRectPosition, entry.ImageRectSize
    elseif type(entry) == "string" then
        return entry
    end
    return nil
end
local function resolveNotifyIcon(source, kind)
    if type(source) == "table" and source.Image then return source.Image, source.RectOffset or source.ImageRectPosition, source.RectSize or source.ImageRectSize end
    if type(source) == "string" and source ~= "" then
        if string.find(source, "^rbxasset") or string.find(source, "^http") then return source end
        local name = string.gsub(source, "^lucide:", "")
        local direct = getRealIcon("lucide:" .. name, nil)
        if direct and direct ~= "" then return direct end
        return resolveAirflowIcon(name)
    end
    for _, name in ipairs(NOTIFY_ICON_NAMES[kind or "Default"] or NOTIFY_ICON_NAMES.Default) do
        if lucideIcons[name] then return lucideIcons[name] end
    end
    for _, name in ipairs(NOTIFY_ICON_NAMES[kind or "Default"] or NOTIFY_ICON_NAMES.Default) do
        local image, offset, size = resolveAirflowIcon(name)
        if image then return image, offset, size end
    end
    return nil
end

function superMegaAwesomeLibrary:CreateNotificationHolderForCoolNotifs()
    self.notificationHolderFrame = makeThingExist("Frame", {
        Name = "Notifications", AnchorPoint = Vector2.new(1, 1), Position = UDim2.new(1, -20, 1, -20),
        Size = UDim2.new(0, 280, 1, -40), BackgroundTransparency = 1, Parent = self.screenGuiYay
    })
    makeThingExist("UIListLayout", {
        SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Bottom,
        Padding = UDim.new(0, 4), Parent = self.notificationHolderFrame
    })
    self._notifyOrder = 0
    self._toasts = {}
    self.MaxNotifications = (self.config and self.config.MaxNotifications) or 4
    local function fit()
        if self.notificationHolderFrame and self.screenGuiYay then
            self.notificationHolderFrame.Size = UDim2.new(0, math.min(280, self.screenGuiYay.AbsoluteSize.X - 40), 1, -40)
        end
    end
    fit()
    self:_TrackConnection(self.screenGuiYay:GetPropertyChangedSignal("AbsoluteSize"):Connect(fit))
end

function superMegaAwesomeLibrary:Notify(config)
    if type(config) == "string" then config = {Title = config} end
    config = config or {}
    local content = config.Content or config.Description or config.Text or config.Message
    local iconSource = config.Icon or config.Image
    local duration = tonumber(config.Duration) or 4
    local kind = config.Type and tostring(config.Type) or nil
    local typeColor = kind and NOTIFY_THEME[kind] or nil -- Info (and unknown) use the accent
    local barColor = typeColor or self.config.AccentColor
    local titleColor = typeColor or NOTIFY_THEME.Text
    local theme = NOTIFY_THEME

    self._notifyOrder = (self._notifyOrder or 0) + 1
    local slot = makeThingExist("Frame", {
        Size = UDim2.new(1, 0, 0, 0), BackgroundTransparency = 1, LayoutOrder = self._notifyOrder, Parent = self.notificationHolderFrame
    })
    local mover = makeThingExist("Frame", {
        Position = UDim2.fromOffset(320, 0), Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1, Parent = slot
    })
    local shadow = makeThingExist("ImageLabel", {
        Position = UDim2.fromOffset(-20, -20), Size = UDim2.new(1, 40, 1, 40), BackgroundTransparency = 1,
        Image = "rbxassetid://6014261993", ImageColor3 = Color3.new(0, 0, 0), ImageTransparency = 1,
        ScaleType = Enum.ScaleType.Slice, SliceCenter = Rect.new(49, 49, 450, 450), ZIndex = 0, Parent = mover
    })
    local card = makeThingExist("CanvasGroup", {
        Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundColor3 = theme.Background,
        BorderSizePixel = 0, GroupTransparency = 1, Parent = mover
    })
    makeThingExist("UICorner", {CornerRadius = UDim.new(0, 10), Parent = card})
    local cardStroke = makeThingExist("UIStroke", {Color = theme.Stroke, Parent = card})
    -- soft accent glow in the corner (Airflow's glow)
    local glow = makeThingExist("ImageLabel", {
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(1, -10, 0, -10), Size = UDim2.fromOffset(260, 120),
        BackgroundTransparency = 1, Image = "rbxassetid://8992230677", ImageColor3 = barColor, ImageTransparency = 0.86, ZIndex = 0, Parent = card
    })
    local body = makeThingExist("Frame", {Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, BackgroundTransparency = 1, Parent = card})
    makeThingExist("UIPadding", {PaddingLeft = UDim.new(0, 16), PaddingRight = UDim.new(0, 16), PaddingTop = UDim.new(0, 14), PaddingBottom = UDim.new(0, 24), Parent = body})

    local textOffset = 0
    makeThingExist("Frame", {
        Position = UDim2.fromOffset(0, 14), Size = UDim2.new(0, 2, 1, -28), BackgroundColor3 = barColor, BorderSizePixel = 0, Parent = card
    })
    if config.Icon ~= false then
        local iconImage, iconRectOffset, iconRectSize = resolveNotifyIcon(iconSource, kind)
        if iconImage then
            local iconProps = {
                AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 0, 0, 8), Size = UDim2.fromOffset(16, 16),
                BackgroundTransparency = 1, Image = iconImage, ImageColor3 = (type(iconSource) == "string" and string.find(iconSource, "^rbxasset")) and Color3.new(1, 1, 1) or barColor, ScaleType = Enum.ScaleType.Fit, Parent = body
            }
            if typeof(iconRectOffset) == "Vector2" then iconProps.ImageRectOffset = iconRectOffset end
            if typeof(iconRectSize) == "Vector2" then iconProps.ImageRectSize = iconRectSize end
            makeThingExist("ImageLabel", iconProps)
            textOffset = 24
        end
    end
    makeThingExist("TextLabel", {
        Position = UDim2.fromOffset(textOffset, 0), Size = UDim2.new(1, -28 - textOffset, 0, 16), BackgroundTransparency = 1,
        Text = tostring(config.Title or "Notification"), TextSize = 14, TextColor3 = titleColor,
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
        TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = body
    })
    local closeButton = makeThingExist("TextButton", {
        AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, 6, 0, -5), Size = UDim2.fromOffset(24, 24), BackgroundTransparency = 1,
        Text = "×", TextColor3 = theme.Muted, TextSize = 22, AutoButtonColor = false,
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold), Parent = body
    })
    closeButton.MouseEnter:Connect(function() smoothMoveGoWoosh(closeButton, {TextColor3 = theme.Text}, 0.15) end)
    closeButton.MouseLeave:Connect(function() smoothMoveGoWoosh(closeButton, {TextColor3 = theme.Muted}, 0.2) end)
    if content and tostring(content) ~= "" then
        makeThingExist("TextLabel", {
            Position = UDim2.fromOffset(textOffset, 21), Size = UDim2.new(1, -textOffset, 0, 0), AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1, Text = tostring(content), TextSize = 13, TextColor3 = theme.Muted,
            FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium),
            TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top, TextWrapped = true,
            TextTruncate = Enum.TextTruncate.None, Parent = body
        })
    end
    local track = makeThingExist("Frame", {
        AnchorPoint = Vector2.new(0, 1), Position = UDim2.new(0, 16, 1, -8), Size = UDim2.new(1, -32, 0, 3),
        BackgroundColor3 = theme.Surface3, BorderSizePixel = 0, Parent = card
    })
    makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = track})
    local fill = makeThingExist("Frame", {Size = UDim2.fromScale(1, 1), BackgroundColor3 = barColor, BorderSizePixel = 0, Parent = track})
    makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = fill})

    task.defer(function()
        if slot.Parent then
            smoothMoveGoWoosh(slot, {Size = UDim2.new(1, 0, 0, card.AbsoluteSize.Y)}, 0.3, Enum.EasingStyle.Quint)
        end
    end)
    smoothMoveGoWoosh(mover, {Position = UDim2.fromOffset(0, 0)}, 0.5, Enum.EasingStyle.Back)
    smoothMoveGoWoosh(card, {GroupTransparency = 0}, 0.3)
    smoothMoveGoWoosh(shadow, {ImageTransparency = 0.6}, 0.4)
    smoothMoveGoWoosh(fill, {Size = UDim2.fromScale(0, 1)}, duration, Enum.EasingStyle.Linear)

    local dismissed = false
    local function dismiss()
        if dismissed then return end
        dismissed = true
        for index, fn in ipairs(self._toasts) do
            if fn == dismiss then table.remove(self._toasts, index) break end
        end
        smoothMoveGoWoosh(mover, {Position = UDim2.fromOffset(320, 0)}, 0.3, Enum.EasingStyle.Quint)
        smoothMoveGoWoosh(card, {GroupTransparency = 1}, 0.2)
        smoothMoveGoWoosh(cardStroke, {Transparency = 1}, 0.15)
        smoothMoveGoWoosh(shadow, {ImageTransparency = 1}, 0.2)
        task.delay(0.22, function()
            if not slot.Parent then return end
            slot.ClipsDescendants = true
            smoothMoveGoWoosh(slot, {Size = UDim2.new(1, 0, 0, -4)}, 0.22, Enum.EasingStyle.Quint)
            task.delay(0.24, function() if slot.Parent then slot:Destroy() end end)
        end)
    end
    task.delay(duration, dismiss)
    closeButton.MouseButton1Click:Connect(dismiss)
    table.insert(self._toasts, dismiss)
    while #self._toasts > (self.MaxNotifications or 4) do
        local oldest = table.remove(self._toasts, 1)
        oldest()
    end
    return {Dismiss = dismiss}
end

-- [NEMESIS+] Modal dialog (Airflow style, ported 1:1 from the Airflow source).
-- Buttons = { {Name = / Title =, Style = / Variant = "Primary" | "Danger" | nil, Callback = fn}, ... }
function superMegaAwesomeLibrary:Dialog(config)
    config = config or {}
    local frame = self.mainFrameYay
    if not frame then return end
    local cfg = self.config
    local accent = neonOf(cfg.AccentColor)
    local bg = cfg.BackgroundColor or Color3.fromRGB(16, 16, 16)
    local cardColor = bg:Lerp(Color3.new(1, 1, 1), 0.03)
    local strokeColor, strokeHover = Color3.fromRGB(44, 42, 54), Color3.fromRGB(88, 82, 108)
    local surface2 = bg:Lerp(Color3.new(1, 1, 1), 0.08)
    local textColor, mutedColor = Color3.fromRGB(233, 229, 238), Color3.fromRGB(138, 132, 150)
    local accentDark = Color3.fromRGB(18, 12, 28)
    local FONT = "rbxasset://fonts/families/GothamSSm.json"
    local typeColors = {Info = Color3.fromRGB(96, 165, 250), Success = Color3.fromRGB(150, 220, 170), Warning = Color3.fromRGB(240, 176, 108), Error = Color3.fromRGB(240, 120, 120)}
    if config.Type and typeColors[tostring(config.Type)] then accent = typeColors[tostring(config.Type)] end

    local function text(props)
        local base = {BackgroundTransparency = 1, TextColor3 = textColor, TextSize = 14, FontFace = Font.new(FONT, Enum.FontWeight.Medium),
            TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Center, TextTruncate = Enum.TextTruncate.AtEnd}
        for key, value in pairs(props) do base[key] = value end
        return makeThingExist("TextLabel", base)
    end

    if self._activeDialog then pcall(function() self._activeDialog.Close() end) end

    local title = tostring(config.Title or "Are you sure?")
    local content = config.Content or config.Description or config.Text or config.Message
    local pad = 18
    local TT = "TextTransparency"

    local backdrop = makeThingExist("TextButton", {
        Name = "NemesisDialogBackdrop", Size = UDim2.fromScale(1, 1), BackgroundColor3 = Color3.new(0, 0, 0), BackgroundTransparency = 1,
        Text = "", AutoButtonColor = false, ZIndex = 20000, Parent = frame
    })
    makeThingExist("UICorner", {CornerRadius = UDim.new(0, 11), Parent = backdrop})
    local card = makeThingExist("TextButton", {
        AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 10), Size = UDim2.fromOffset(300, 120),
        BackgroundColor3 = cardColor, BackgroundTransparency = 1, BorderSizePixel = 0, Text = "", AutoButtonColor = false, ZIndex = 20001, Parent = backdrop
    })
    makeThingExist("UICorner", {CornerRadius = UDim.new(0, 10), Parent = card})
    local stroke = makeThingExist("UIStroke", {Color = strokeColor, Transparency = 1, Thickness = 1, Parent = card})
    local scale = makeThingExist("UIScale", {Scale = 0.94, Parent = card})

    local fades, iconShift = {}, 0
    if config.Icon or config.Type then
        local iconId = getRealIcon(config.Icon, pickLucide({"info"}, "rbxassetid://10747361219"))
        local iconImage = makeThingExist("ImageLabel", {
            AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, pad, 0, pad + 9), Size = UDim2.fromOffset(16, 16), BackgroundTransparency = 1,
            Image = iconId, ImageColor3 = accent, ImageTransparency = 1, ScaleType = Enum.ScaleType.Fit, ZIndex = 20002, Parent = card
        })
        table.insert(fades, {iconImage, "ImageTransparency", 0})
        iconShift = 24
    end
    local titleLabel = text({
        Position = UDim2.fromOffset(pad + iconShift, pad), Size = UDim2.new(1, -(pad * 2 + iconShift), 0, 18), Text = title, TextSize = 15,
        FontFace = Font.new(FONT, Enum.FontWeight.SemiBold), TextTransparency = 1, ZIndex = 20002, Parent = card
    })
    table.insert(fades, {titleLabel, TT, 0})

    local contentHeight = 0
    if content and tostring(content) ~= "" then
        local body = text({
            Position = UDim2.fromOffset(pad, pad + 24), Size = UDim2.new(1, -pad * 2, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, Text = tostring(content), TextSize = 13,
            TextColor3 = mutedColor, TextWrapped = true, TextTransparency = 1, TextTruncate = Enum.TextTruncate.None, TextYAlignment = Enum.TextYAlignment.Top, RichText = true,
            ZIndex = 20002, Parent = card
        })
        table.insert(fades, {body, TT, 0})
        contentHeight = math.max(body.TextBounds.Y, 16) + 6
        body:GetPropertyChangedSignal("TextBounds"):Connect(function()
            local newHeight = math.max(body.TextBounds.Y, 16) + 6
            if newHeight ~= contentHeight then
                contentHeight = newHeight
                card.Size = UDim2.fromOffset(300, pad + 24 + contentHeight + 12 + 34 + pad)
                local row = card:FindFirstChild("ButtonRow")
                if row then row.Position = UDim2.fromOffset(pad, pad + 24 + contentHeight + 12) end
            end
        end)
    end

    local buttonRow = makeThingExist("Frame", {
        Name = "ButtonRow", Position = UDim2.fromOffset(pad, pad + 24 + contentHeight + 12), Size = UDim2.new(1, -pad * 2, 0, 34), BackgroundTransparency = 1, ZIndex = 20002, Parent = card
    })
    makeThingExist("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, HorizontalAlignment = Enum.HorizontalAlignment.Right, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 8), Parent = buttonRow})
    card.Size = UDim2.fromOffset(300, pad + 24 + contentHeight + 12 + 34 + pad)

    local dialogObj, closed = {}, false
    function dialogObj.Close()
        if closed then return end
        closed = true
        if self._activeDialog == dialogObj then self._activeDialog = nil end
        if dialogObj._escape then dialogObj._escape:Disconnect(); dialogObj._escape = nil end
        smoothMoveGoWoosh(backdrop, {BackgroundTransparency = 1}, 0.18, Enum.EasingStyle.Quart)
        smoothMoveGoWoosh(card, {BackgroundTransparency = 1, Position = UDim2.new(0.5, 0, 0.5, 8)}, 0.18, Enum.EasingStyle.Quint)
        smoothMoveGoWoosh(scale, {Scale = 0.96}, 0.18, Enum.EasingStyle.Quint)
        smoothMoveGoWoosh(stroke, {Transparency = 1}, 0.12, Enum.EasingStyle.Quart)
        for _, item in ipairs(fades) do smoothMoveGoWoosh(item[1], {[item[2]] = 1}, 0.12, Enum.EasingStyle.Quart) end
        task.delay(0.2, function() backdrop:Destroy() end)
    end

    local buttons = config.Buttons or {{Name = "OK", Style = "Primary"}}
    for order, btn in ipairs(buttons) do
        local variant = btn.Variant or btn.Style
        local primary = variant == "Primary"
        local danger = variant == "Danger"
        local fillColor = primary and accent or (danger and Color3.fromRGB(214, 78, 78) or surface2)
        local fillText = (primary and accentDark) or (danger and Color3.new(1, 1, 1)) or textColor
        local button = makeThingExist("TextButton", {
            Size = UDim2.fromOffset(0, 34), AutomaticSize = Enum.AutomaticSize.X, BackgroundColor3 = fillColor, BackgroundTransparency = 1, BorderSizePixel = 0,
            Text = "", AutoButtonColor = false, ClipsDescendants = true, LayoutOrder = order, ZIndex = 20003, Parent = buttonRow
        })
        makeThingExist("UICorner", {CornerRadius = UDim.new(0, 7), Parent = button})
        local bStroke = makeThingExist("UIStroke", {Color = (primary and accent) or (danger and fillColor) or strokeColor, Transparency = 1, Thickness = 1, Parent = button})
        makeThingExist("UIPadding", {PaddingLeft = UDim.new(0, 14), PaddingRight = UDim.new(0, 14), Parent = button})
        local caption = text({
            Size = UDim2.new(0, 0, 1, 0), AutomaticSize = Enum.AutomaticSize.X, Text = tostring(btn.Title or btn.Name or "OK"), TextSize = 13,
            TextColor3 = fillText, TextXAlignment = Enum.TextXAlignment.Center, TextTransparency = 1, ZIndex = 20004, Parent = button
        })
        local restBg = (primary or danger) and 0.12 or 0
        local restStroke = (primary or danger) and 0.4 or 0
        table.insert(fades, {button, "BackgroundTransparency", restBg})
        table.insert(fades, {bStroke, "Transparency", restStroke})
        table.insert(fades, {caption, TT, 0})
        button.MouseEnter:Connect(function()
            if closed then return end
            if primary or danger then
                smoothMoveGoWoosh(button, {BackgroundTransparency = 0}, 0.12, Enum.EasingStyle.Quart)
                smoothMoveGoWoosh(bStroke, {Transparency = 0}, 0.12, Enum.EasingStyle.Quart)
            else
                smoothMoveGoWoosh(bStroke, {Color = strokeHover}, 0.12, Enum.EasingStyle.Quart)
            end
        end)
        button.MouseLeave:Connect(function()
            if closed then return end
            if primary or danger then
                smoothMoveGoWoosh(button, {BackgroundTransparency = restBg}, 0.2, Enum.EasingStyle.Quart)
                smoothMoveGoWoosh(bStroke, {Transparency = restStroke}, 0.2, Enum.EasingStyle.Quart)
            else
                smoothMoveGoWoosh(bStroke, {Color = strokeColor}, 0.2, Enum.EasingStyle.Quart)
            end
        end)
        button.MouseButton1Click:Connect(function()
            dialogObj.Close()
            if type(btn.Callback) == "function" then task.spawn(btn.Callback) end
        end)
    end

    function dialogObj.Cancel()
        if closed then return end
        dialogObj.Close()
        local handler = config.OnCancel or config.OnDismiss
        if type(handler) == "function" then task.spawn(handler) end
    end
    dialogObj.Dismissable = config.CloseOnBackdrop ~= false and config.Dismissable ~= false
    dialogObj.Destroy = dialogObj.Close
    if dialogObj.Dismissable then
        backdrop.MouseButton1Click:Connect(dialogObj.Cancel)
        dialogObj._escape = thisInputServiceGoesHard.InputBegan:Connect(function(input, processed)
            if processed then return end
            if input.KeyCode == Enum.KeyCode.Escape then dialogObj.Cancel() end
        end)
    end
    self._activeDialog = dialogObj

    smoothMoveGoWoosh(backdrop, {BackgroundTransparency = 0.45}, 0.25, Enum.EasingStyle.Quart)
    smoothMoveGoWoosh(card, {BackgroundTransparency = 0, Position = UDim2.fromScale(0.5, 0.5)}, 0.3, Enum.EasingStyle.Quint)
    smoothMoveGoWoosh(stroke, {Transparency = 0}, 0.25, Enum.EasingStyle.Quart)
    smoothMoveGoWoosh(scale, {Scale = 1}, 0.4, Enum.EasingStyle.Back)
    for _, item in ipairs(fades) do smoothMoveGoWoosh(item[1], {[item[2]] = item[3]}, 0.25, Enum.EasingStyle.Quart) end
    return dialogObj
end

-- [NEMESIS+] Confirm = Dialog with Cancel / Confirm (Airflow style)
function superMegaAwesomeLibrary:Confirm(config)
    config = config or {}
    local confirmCb, cancelCb = config.Callback or config.OnConfirm, config.OnCancel
    return self:Dialog({
        Title = config.Title or "Are you sure?", Content = config.Content or config.Description or "Are you sure?",
        Icon = config.Icon, Type = config.Type, Dismissable = config.Dismissable, OnCancel = cancelCb,
        Buttons = {
            {Title = config.CancelText or "Cancel", Callback = function() if cancelCb then cancelCb() end end},
            {Title = config.ConfirmText or "Confirm", Variant = config.Danger and "Danger" or "Primary", Callback = function() if confirmCb then confirmCb() end end},
        }
    })
end

function superMegaAwesomeLibrary:AddSection(config)
    config = config or {}
    config.Name = config.Name or "Section"
    config.Icon = getRealIcon(config.Icon, "rbxassetid://98092584632154")
    
    local sectionObj = {}
    sectionObj.tabsInSection = {}
    sectionObj.isExpanded = true
    sectionObj.Library = self
    
sectionObj.containerFrame = makeThingExist("Frame", {
        -- [DIUBAH]: Lebar 158 diperkecil jadi 146
        BackgroundTransparency = 1, Size = UDim2.new(0, 146 * mobileScaleFactor, 0, 31 * mobileScaleFactor),
        ClipsDescendants = true, Parent = self.sectionHolderScroll
    })
    
    sectionObj.mainFrame = makeThingExist("Frame", {
        -- [DIUBAH]: Lebar 156 diperkecil jadi 144
        BackgroundColor3 = Color3.fromRGB(18, 18, 18), Position = UDim2.new(0, 1, 0, 2),
        Size = UDim2.new(0, 144 * mobileScaleFactor, 0, 28 * mobileScaleFactor), Parent = sectionObj.containerFrame
    })
    
    -- [v7] outline header section dihapus (tanpa UIStroke)
    makeThingExist("UICorner", {CornerRadius = UDim.new(0, 8), Parent = sectionObj.mainFrame})
    
    makeThingExist("ImageLabel", {
        Image = config.Icon, BackgroundTransparency = 1,
        Position = UDim2.new(0, 10, 0.5, -7 * mobileScaleFactor),
        Size = UDim2.new(0, 14 * mobileScaleFactor, 0, 14 * mobileScaleFactor), Parent = sectionObj.mainFrame
    })
    
    makeThingExist("TextLabel", {
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
        TextColor3 = Color3.new(1, 1, 1), Text = config.Name, BackgroundTransparency = 1,
        Position = UDim2.new(0, 32, 0.5, -8.5 * mobileScaleFactor), TextSize = 15 * mobileScaleFactor,
        Size = UDim2.new(0, 80, 0, 17 * mobileScaleFactor), TextXAlignment = Enum.TextXAlignment.Left,
        Parent = sectionObj.mainFrame
    })
    
    local expandButtonImg = makeThingExist("ImageButton", {
        Image = "rbxassetid://111626678408582", BackgroundTransparency = 1,
        Position = UDim2.new(1, -24, 0.5, -8 * mobileScaleFactor),
        Size = UDim2.new(0, 16 * mobileScaleFactor, 0, 16 * mobileScaleFactor), Parent = sectionObj.mainFrame
    })
    
    sectionObj.tabHolderFrame = makeThingExist("Frame", {
        BackgroundTransparency = 1, Position = UDim2.new(0, 11, 0, 33 * mobileScaleFactor),
        Size = UDim2.new(0, 146 * mobileScaleFactor, 0, 0), ClipsDescendants = true, Parent = sectionObj.containerFrame
    })
    
    sectionObj.tabLayoutThing = makeThingExist("UIListLayout", {Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder, Parent = sectionObj.tabHolderFrame})
    
-- [v7] tinggi dihitung dari ukuran tab itu sendiri (bukan AbsoluteContentSize) supaya
    -- tidak salah ketika UIScale aktif -> tab terakhir tidak lagi "ketiban"/terpotong.
    local TAB_GAP = 3
    local function measureTabsHeight()
        local total, count = 0, 0
        for _, t in ipairs(sectionObj.tabsInSection) do
            local bf = t.buttonFrame
            if bf and bf.Visible then
                total = total + bf.Size.Y.Offset
                count = count + 1
            end
        end
        if count > 1 then total = total + TAB_GAP * (count - 1) end
        return total
    end
    local function fullContainerHeight(tabsHeight)
        return 33 * mobileScaleFactor + tabsHeight + 3
    end
    sectionObj.RecalcHeight = function(instant)
        local tabsHeight = measureTabsHeight()
        sectionObj.tabHolderFrame.Size = UDim2.new(0, 146 * mobileScaleFactor, 0, tabsHeight)
        if sectionObj.isExpanded then
            local goal = UDim2.new(0, 146 * mobileScaleFactor, 0, fullContainerHeight(tabsHeight))
            if instant == true then
                sectionObj.containerFrame.Size = goal
            else
                smoothMoveGoWoosh(sectionObj.containerFrame, {Size = goal}, 0.25)
            end
        end
    end
    local function updateContainerSizeYay() sectionObj.RecalcHeight() end

    self:_TrackConnection(sectionObj.tabLayoutThing:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateContainerSizeYay))

    self:_TrackConnection(expandButtonImg.MouseButton1Click:Connect(function()
        sectionObj.isExpanded = not sectionObj.isExpanded
        smoothMoveGoWoosh(expandButtonImg, {Rotation = sectionObj.isExpanded and 0 or -90}, 0.25)
        if sectionObj.isExpanded then
            smoothMoveGoWoosh(sectionObj.containerFrame, {Size = UDim2.new(0, 146 * mobileScaleFactor, 0, fullContainerHeight(measureTabsHeight()))}, 0.25)
        else
            smoothMoveGoWoosh(sectionObj.containerFrame, {Size = UDim2.new(0, 146 * mobileScaleFactor, 0, 31 * mobileScaleFactor)}, 0.25)
        end
    end))

    function sectionObj:AddTab(tabConfig)
        tabConfig = tabConfig or {}
        tabConfig.Name = tabConfig.Name or "Tab"
        tabConfig.Description = tabConfig.Description or "Tab description"
        tabConfig.Icon = getRealIcon(tabConfig.Icon, "rbxassetid://94219370057308")
        
        local tabObj = {}
        tabObj.tabNameForSearch = tabConfig.Name
        tabObj.searchTerms = {tabConfig.Name, tabConfig.Description}
        tabObj.groupsInTab = {}
        tabObj.groupPositions = {Left = 0, Right = 0}
        tabObj.isActive = false
        tabObj.Library = sectionObj.Library
        -- [DIUBAH]: Lebar 136 diperkecil jadi 124 agar tab punya jarak lega dengan garis
        tabObj.defaultButtonSize = UDim2.new(0, 124 * mobileScaleFactor, 0, 28 * mobileScaleFactor)
        
        tabObj.buttonFrame = makeThingExist("Frame", {
            BackgroundColor3 = sectionObj.Library.config.AccentColor, BackgroundTransparency = 1,
            Size = tabObj.defaultButtonSize, ClipsDescendants = true, Parent = sectionObj.tabHolderFrame
        })
        makeThingExist("UICorner", {CornerRadius = UDim.new(0, 8), Parent = tabObj.buttonFrame})
        
        tabObj.iconImg = makeThingExist("ImageLabel", {
            ImageColor3 = Color3.fromRGB(89, 89, 89), Image = tabConfig.Icon, BackgroundTransparency = 1,
            Position = UDim2.new(0, 9, 0.5, -7 * mobileScaleFactor),
            Size = UDim2.new(0, 14 * mobileScaleFactor, 0, 14 * mobileScaleFactor), Parent = tabObj.buttonFrame
        })
        
        tabObj.nameLabel = makeThingExist("TextLabel", {
            FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
            TextColor3 = Color3.fromRGB(89, 89, 89), Text = tabConfig.Name, BackgroundTransparency = 1,
            Position = UDim2.new(0, 28, 0.5, -8 * mobileScaleFactor), TextSize = 13 * mobileScaleFactor,
            Size = UDim2.new(0, 105 * mobileScaleFactor, 0, 16 * mobileScaleFactor),
            TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
            ClipsDescendants = true, Parent = tabObj.buttonFrame
        })
        
        local tabClickButton = makeThingExist("TextButton", {Text = "", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), Parent = tabObj.buttonFrame})
        
        tabObj.contentScroll = makeThingExist("ScrollingFrame", {
            BackgroundTransparency = 1, Position = UDim2.new(0, 4, 0, 4),
            Size = UDim2.new(1, -8, 1, -8), ScrollBarThickness = 0,
            CanvasSize = UDim2.new(0, 540 * mobileScaleFactor, 0, 0), Visible = false,
            Parent = sectionObj.Library.contentHolderFrame
        })
        sectionObj.Library:EnableSmoothScrolling(tabObj.contentScroll, 18)
        
        tabObj.leftColumnFrame = makeThingExist("Frame", {BackgroundTransparency = 1, Size = UDim2.new(0, 262 * mobileScaleFactor, 0, 1000), Parent = tabObj.contentScroll})
        tabObj.rightColumnFrame = makeThingExist("Frame", {BackgroundTransparency = 1, Position = UDim2.new(0, 272 * mobileScaleFactor, 0, 0), Size = UDim2.new(0, 262 * mobileScaleFactor, 0, 1000), Parent = tabObj.contentScroll})

        tabObj.groupList = {}
        tabObj.subPages = {}
        tabObj._baseY = 4
        tabObj._activePage = nil

        -- ===== page factory: a "page" is a scroll area with 2 columns that can host groups =====
        local function reflowPage(page, animate)
            local leftY, rightY = 0, 0
            local gap = 15 * mobileScaleFactor
            local visibleCount = 0
            for _, g in ipairs(page.groupList) do
                local frame = g.mainFrame
                if frame and frame.Parent and frame.Visible then
                    visibleCount = visibleCount + 1
                    local h = frame.Size.Y.Offset
                    local y
                    if g.fullWidth then
                        y = math.max(leftY, rightY)
                        leftY = y + h + gap
                        rightY = leftY
                    elseif g.side == "Right" then
                        y = rightY
                        rightY = y + h + gap
                    else
                        y = leftY
                        leftY = y + h + gap
                    end
                    local target = UDim2.new(0, 1, 0, y + 1)
                    if animate then
                        smoothMoveGoWoosh(frame, {Position = target}, 0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
                    else
                        frame.Position = target
                    end
                end
            end
            page.contentScroll.CanvasSize = UDim2.new(0, 540 * mobileScaleFactor, 0, math.max(leftY, rightY))
            if page.emptyFrame then
                page.emptyFrame.Visible = visibleCount == 0
            end
        end

        local function buildEmptyState(page, cfgTable)
            cfgTable = cfgTable or {}
            local frame = makeThingExist("Frame", {
                Name = "EmptyState", BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0),
                Position = UDim2.new(0, 270 * mobileScaleFactor, 0, 70 * mobileScaleFactor),
                Size = UDim2.new(0, 300 * mobileScaleFactor, 0, 150 * mobileScaleFactor), Parent = page.contentScroll
            })
            local ring = makeThingExist("Frame", {
                BackgroundColor3 = Color3.fromRGB(22, 22, 22), AnchorPoint = Vector2.new(0.5, 0),
                Position = UDim2.new(0.5, 0, 0, 0), Size = UDim2.new(0, 56 * mobileScaleFactor, 0, 56 * mobileScaleFactor), Parent = frame
            })
            makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = ring})
            makeThingExist("UIStroke", {Color = Color3.fromRGB(40, 40, 40), Thickness = 1.2, Parent = ring})
            page.emptyIcon = makeThingExist("ImageLabel", {
                Image = getRealIcon(cfgTable.Icon, pickLucide({"inbox", "package-open", "folder-open"}, "rbxassetid://10723427199")),
                ImageColor3 = Color3.fromRGB(110, 110, 110), BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.new(0, 26 * mobileScaleFactor, 0, 26 * mobileScaleFactor), Parent = ring
            })
            page.emptyTitle = makeThingExist("TextLabel", {
                FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold),
                Text = tostring(cfgTable.Title or "Nothing here yet"), TextColor3 = Color3.fromRGB(190, 190, 190),
                TextSize = 15 * mobileScaleFactor, BackgroundTransparency = 1,
                Position = UDim2.new(0, 0, 0, 68 * mobileScaleFactor), Size = UDim2.new(1, 0, 0, 20 * mobileScaleFactor), Parent = frame
            })
            page.emptyDesc = makeThingExist("TextLabel", {
                FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium),
                Text = tostring(cfgTable.Description or "There is no content in this tab yet."), TextColor3 = Color3.fromRGB(105, 105, 105),
                TextSize = 12 * mobileScaleFactor, TextWrapped = true, BackgroundTransparency = 1,
                Position = UDim2.new(0, 10, 0, 92 * mobileScaleFactor), Size = UDim2.new(1, -20, 0, 40 * mobileScaleFactor),
                TextYAlignment = Enum.TextYAlignment.Top, Parent = frame
            })
            page.emptyFrame = frame
        end

        tabObj._Reflow = function(self, animate)
            reflowPage(self, animate)
            for _, page in ipairs(self.subPages) do reflowPage(page, animate) end
        end
        buildEmptyState(tabObj, tabConfig.Empty or {Title = tabConfig.EmptyTitle, Description = tabConfig.EmptyDescription, Icon = tabConfig.EmptyIcon})
        tabObj.contentScroll.CanvasSize = UDim2.new(0, 540 * mobileScaleFactor, 0, 300)

        function tabObj:SetEmpty(emptyCfg)
            emptyCfg = emptyCfg or {}
            if emptyCfg.Title then tabObj.emptyTitle.Text = tostring(emptyCfg.Title) end
            if emptyCfg.Description then tabObj.emptyDesc.Text = tostring(emptyCfg.Description) end
            if emptyCfg.Icon then tabObj.emptyIcon.Image = getRealIcon(emptyCfg.Icon, tabObj.emptyIcon.Image) end
        end
        tabObj.AddEmpty = tabObj.SetEmpty

        function tabObj:_ActiveScroll()
            if tabObj._activePage then return tabObj._activePage.contentScroll end
            return tabObj.contentScroll
        end
        function tabObj:_HideAll()
            tabObj.contentScroll.Visible = false
            tabObj.contentScroll.Position = UDim2.new(0, 4, 0, tabObj._baseY)
            for _, page in ipairs(tabObj.subPages) do
                page.contentScroll.Visible = false
                page.contentScroll.Position = UDim2.new(0, 4, 0, tabObj._baseY)
            end
            if tabObj.subBar then tabObj.subBar.Visible = false end
        end

        -- ===== sub tabs (pill bar on top of the tab; usable in every tab) =====
        function tabObj:AddSubTab(subConfig)
            if type(subConfig) == "string" then subConfig = {Name = subConfig} end
            subConfig = subConfig or {}
            subConfig.Name = tostring(subConfig.Name or ("Page " .. (#tabObj.subPages + 1)))
            local library = sectionObj.Library
            if not tabObj.subBar then
                tabObj.hasSubTabs = true
                tabObj._baseY = 40 * mobileScaleFactor
                tabObj.subBar = makeThingExist("ScrollingFrame", {
                    Name = "SubTabBar", BackgroundTransparency = 1, Position = UDim2.new(0, 4, 0, 4),
                    Size = UDim2.new(1, -8, 0, 30 * mobileScaleFactor), ScrollBarThickness = 0,
                    ScrollingDirection = Enum.ScrollingDirection.X, AutomaticCanvasSize = Enum.AutomaticSize.X,
                    CanvasSize = UDim2.new(0, 0, 0, 0), Visible = tabObj.isActive, Parent = library.contentHolderFrame
                })
                makeThingExist("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder, VerticalAlignment = Enum.VerticalAlignment.Center, Parent = tabObj.subBar})
                tabObj.contentScroll.Visible = false
            end

            local page = {}
            page.Name = subConfig.Name
            page.tabNameForSearch = tabConfig.Name .. "/" .. subConfig.Name
            page.Library = library
            page.groupsInTab = tabObj.groupsInTab
            page.groupList = {}
            page.ownerTab = tabObj
            page.contentScroll = makeThingExist("ScrollingFrame", {
                BackgroundTransparency = 1, Position = UDim2.new(0, 4, 0, tabObj._baseY),
                Size = UDim2.new(1, -8, 1, -(tabObj._baseY + 4)), ScrollBarThickness = 0,
                CanvasSize = UDim2.new(0, 540 * mobileScaleFactor, 0, 0), Visible = false, Parent = library.contentHolderFrame
            })
            library:EnableSmoothScrolling(page.contentScroll, 18)
            page.leftColumnFrame = makeThingExist("Frame", {BackgroundTransparency = 1, Size = UDim2.new(0, 262 * mobileScaleFactor, 0, 1000), Parent = page.contentScroll})
            page.rightColumnFrame = makeThingExist("Frame", {BackgroundTransparency = 1, Position = UDim2.new(0, 272 * mobileScaleFactor, 0, 0), Size = UDim2.new(0, 262 * mobileScaleFactor, 0, 1000), Parent = page.contentScroll})
            page._Reflow = function(self, animate) reflowPage(self, animate) end
            buildEmptyState(page, subConfig.Empty or {Title = subConfig.EmptyTitle, Description = subConfig.EmptyDescription, Icon = subConfig.EmptyIcon})
            page.contentScroll.CanvasSize = UDim2.new(0, 540 * mobileScaleFactor, 0, 300)

            -- pill button
            local iconImage = subConfig.Icon and getRealIcon(subConfig.Icon, nil) or nil
            local textBounds = textServiceBeLikeText:GetTextSize(page.Name, 13 * mobileScaleFactor, Enum.Font.GothamSemibold, Vector2.new(400, 30))
            local pillWidth = textBounds.X + 24 + (iconImage and 20 or 0)
            page.pill = makeThingExist("TextButton", {
                Text = "", AutoButtonColor = false, BackgroundColor3 = Color3.fromRGB(24, 24, 24),
                Size = UDim2.new(0, pillWidth, 0, 26 * mobileScaleFactor), LayoutOrder = #tabObj.subPages + 1, Parent = tabObj.subBar
            })
            makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = page.pill})
            page.pillStroke = makeThingExist("UIStroke", {Color = Color3.fromRGB(38, 38, 38), Parent = page.pill})
            local textX = 12
            if iconImage then
                page.pillIcon = makeThingExist("ImageLabel", {
                    Image = iconImage, ImageColor3 = Color3.fromRGB(110, 110, 110), BackgroundTransparency = 1,
                    Position = UDim2.new(0, 9, 0.5, -7 * mobileScaleFactor), Size = UDim2.new(0, 14 * mobileScaleFactor, 0, 14 * mobileScaleFactor), Parent = page.pill
                })
                textX = 28
            end
            page.pillLabel = makeThingExist("TextLabel", {
                FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold), Text = page.Name,
                TextColor3 = Color3.fromRGB(110, 110, 110), TextSize = 13 * mobileScaleFactor, BackgroundTransparency = 1,
                Position = UDim2.new(0, textX, 0, 0), Size = UDim2.new(1, -textX - 8, 1, 0), TextXAlignment = Enum.TextXAlignment.Left, Parent = page.pill
            })

            function page:Select(skipAnim)
                local previous = tabObj._activePage
                if previous and previous ~= page then
                    previous.contentScroll.Visible = false
                    smoothMoveGoWoosh(previous.pill, {BackgroundColor3 = Color3.fromRGB(24, 24, 24)}, 0.18)
                    smoothMoveGoWoosh(previous.pillLabel, {TextColor3 = Color3.fromRGB(110, 110, 110)}, 0.18)
                    if previous.pillIcon then smoothMoveGoWoosh(previous.pillIcon, {ImageColor3 = Color3.fromRGB(110, 110, 110)}, 0.18) end
                    smoothMoveGoWoosh(previous.pillStroke, {Color = Color3.fromRGB(38, 38, 38)}, 0.18)
                end
                tabObj._activePage = page
                smoothMoveGoWoosh(page.pill, {BackgroundColor3 = library.config.AccentColor:Lerp(Color3.fromRGB(24, 24, 24), 0.55)}, 0.18)
                smoothMoveGoWoosh(page.pillLabel, {TextColor3 = Color3.new(1, 1, 1)}, 0.18)
                if page.pillIcon then smoothMoveGoWoosh(page.pillIcon, {ImageColor3 = Color3.new(1, 1, 1)}, 0.18) end
                smoothMoveGoWoosh(page.pillStroke, {Color = library.config.AccentColor}, 0.18)
                if tabObj.isActive then
                    page.contentScroll.Visible = true
                    if not skipAnim then
                        page.contentScroll.Position = UDim2.new(0, 14 * mobileScaleFactor, 0, tabObj._baseY)
                        smoothMoveGoWoosh(page.contentScroll, {Position = UDim2.new(0, 4, 0, tabObj._baseY)}, 0.24, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
                    end
                end
            end
            page.pill.MouseButton1Click:Connect(function() page:Select() end)

            -- same group API as a normal tab
            function page:AddGroup(groupConfig) return tabObj._pageAddGroup(page, groupConfig) end

            table.insert(tabObj.subPages, page)
            tabObj.subPages[page.Name] = page
            if #tabObj.subPages == 1 then page:Select(true) end
            return page
        end

        function tabObj:AddSubTabs(list)
            local result = {}
            for _, cfg in ipairs(list or {}) do table.insert(result, tabObj:AddSubTab(cfg)) end
            return result
        end
        function tabObj:SelectSubTab(nameOrIndex)
            local page = tabObj.subPages[nameOrIndex]
            if page then page:Select() end
        end
        
        function tabObj:Activate()
            if tabObj.isActive then
                return
            end
            local previousTab = sectionObj.Library.currentTabYay
            if previousTab and previousTab ~= tabObj then
                previousTab:Deactivate(true)
            end
            sectionObj.Library.currentTabYay = tabObj
            tabObj.isActive = true
            local activeScroll = tabObj:_ActiveScroll()
            activeScroll.Position = UDim2.new(0, 14 * mobileScaleFactor, 0, tabObj._baseY)
            activeScroll.Visible = true
            if tabObj.subBar then tabObj.subBar.Visible = true end
            smoothMoveGoWoosh(activeScroll, {Position = UDim2.new(0, 4, 0, tabObj._baseY)}, 0.26, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
            smoothMoveGoWoosh(tabObj.buttonFrame, {BackgroundTransparency = 0}, 0.22)
            smoothMoveGoWoosh(tabObj.iconImg, {ImageColor3 = Color3.new(1, 1, 1)}, 0.22)
            smoothMoveGoWoosh(tabObj.nameLabel, {TextColor3 = Color3.new(1, 1, 1)}, 0.22)
            sectionObj.Library.tabNameLabel.Text = tabConfig.Name
            sectionObj.Library.tabDescriptionLabel.Text = tabConfig.Description
        end
        
        function tabObj:Deactivate(skipAnimation)
            tabObj.isActive = false
            for _, group in ipairs(tabObj.groupsInTab) do
                for _, element in ipairs(group.elementsInGroup) do
                    if type(element) == "table" and type(element.Close) == "function" then
                        pcall(function()
                            element:Close()
                        end)
                    end
                end
            end
            if skipAnimation then
                tabObj:_HideAll()
            else
                smoothMoveGoWoosh(tabObj:_ActiveScroll(), {Position = UDim2.new(0, -8 * mobileScaleFactor, 0, tabObj._baseY)}, 0.18, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
                task.delay(0.18, function()
                    if not tabObj.isActive and tabObj.contentScroll and tabObj.contentScroll.Parent then
                        tabObj:_HideAll()
                    end
                end)
            end
            smoothMoveGoWoosh(tabObj.buttonFrame, {BackgroundTransparency = 1}, 0.18)
            smoothMoveGoWoosh(tabObj.iconImg, {ImageColor3 = Color3.fromRGB(89, 89, 89)}, 0.18)
            smoothMoveGoWoosh(tabObj.nameLabel, {TextColor3 = Color3.fromRGB(89, 89, 89)}, 0.18)
        end
        
        tabClickButton.MouseButton1Click:Connect(function() if not tabObj.isActive then tabObj:Activate() end end)
        tabClickButton.MouseEnter:Connect(function()
            if not tabObj.isActive then
                smoothMoveGoWoosh(tabObj.nameLabel, {TextColor3 = Color3.fromRGB(150, 150, 150)}, 0.2)
                smoothMoveGoWoosh(tabObj.iconImg, {ImageColor3 = Color3.fromRGB(150, 150, 150)}, 0.2)
            end
        end)
        tabClickButton.MouseLeave:Connect(function()
            if not tabObj.isActive then
                smoothMoveGoWoosh(tabObj.nameLabel, {TextColor3 = Color3.fromRGB(89, 89, 89)}, 0.2)
                smoothMoveGoWoosh(tabObj.iconImg, {ImageColor3 = Color3.fromRGB(89, 89, 89)}, 0.2)
            end
        end)

        local function pageAddGroup(tabObj, groupConfig)
            groupConfig = groupConfig or {}
            groupConfig.Name = groupConfig.Name or "Group"
            groupConfig.Side = groupConfig.Side or "Left"
            groupConfig.Icon = getRealIcon(groupConfig.Icon, "rbxassetid://10723427199")
            
            local groupObj = {}
            groupObj.groupNameForSearch = groupConfig.Name
            groupObj.searchTerms = {groupConfig.Name}
            groupObj.elementsInGroup = {}
            groupObj.Library = tabObj.Library
            groupObj.elementYPos = groupConfig.Bare and 0 or (35 * mobileScaleFactor)
            
            local function createAutoFlag(elementName)
                return tostring(tabObj.tabNameForSearch) .. "." .. tostring(groupObj.groupNameForSearch) .. "." .. tostring(elementName or "Value")
            end
            local function addSearchTerm(term)
                local normalized = normalizeSearchText(term)
                if normalized ~= "" then
                    table.insert(groupObj.searchTerms, tostring(term))
                end
            end
            
            -- [NEMESIS+] group layout engine: groups are positioned by the page reflow, so
            -- AddGroup -> AddGroup -> (add elements later) never overlaps.
            local isFullWidth = (groupConfig.Side == "Full" or groupConfig.Side == "Standalone")
            local groupWidth = isFullWidth and (534 * mobileScaleFactor) or (260 * mobileScaleFactor)
            local parentColumn = (groupConfig.Side == "Right") and tabObj.rightColumnFrame or tabObj.leftColumnFrame
            groupObj.elementWidth = groupConfig.Bare and groupWidth or (groupWidth - 22 * mobileScaleFactor)
            groupObj.fullWidth = isFullWidth
            groupObj.side = isFullWidth and "Full" or ((groupConfig.Side == "Right") and "Right" or "Left")
            groupObj.collapsible = groupConfig.Collapsible ~= false
            groupObj.collapsed = groupConfig.Collapsed == true
            local COLLAPSED_HEIGHT = 34 * mobileScaleFactor

            groupObj.mainFrame = makeThingExist("Frame", {
                BackgroundColor3 = Color3.new(1, 1, 1), Position = UDim2.new(0, 1, 0, 1),
                Size = UDim2.new(0, groupWidth, 0, 50 * mobileScaleFactor),
                ClipsDescendants = true, Parent = parentColumn
            })

            local groupStrokeThing = makeThingExist("UIStroke", {Color = Color3.fromRGB(33, 33, 33), Parent = groupObj.mainFrame})
            makeThingExist("UIGradient", {
                Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(1,1,1)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150,150,150)), ColorSequenceKeypoint.new(1, Color3.new(1,1,1))}),
                Rotation = 260, Parent = groupStrokeThing
            })
            makeThingExist("UICorner", {CornerRadius = UDim.new(0, 10), Parent = groupObj.mainFrame})
            -- [NEMESIS+] purple gradient only for Dashboard groups (Gradient = true); every other tab stays flat
            if groupConfig.Bare then
                groupObj.mainFrame.BackgroundTransparency = 1
                groupStrokeThing.Enabled = false
            elseif groupConfig.Gradient then
                makeThingExist("UIGradient", {
                    Color = ColorSequence.new(Color3.fromRGB(18, 18, 20):Lerp(sectionObj.Library.config.AccentColor, 0.2), Color3.fromRGB(17, 17, 19)),
                    Rotation = 35, Parent = groupObj.mainFrame
                })
            else
                groupObj.mainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
            end

            makeThingExist("ImageLabel", {
                Image = groupConfig.Icon, BackgroundTransparency = 1, Position = UDim2.new(0, 10, 0, 10 * mobileScaleFactor),
                Size = UDim2.new(0, 16 * mobileScaleFactor, 0, 16 * mobileScaleFactor), Parent = groupObj.mainFrame
            })

            makeThingExist("TextLabel", {
                FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
                TextColor3 = Color3.new(1, 1, 1), Text = groupConfig.Name, BackgroundTransparency = 1,
                Position = UDim2.new(0, 32, 0, 8 * mobileScaleFactor), TextSize = 15 * mobileScaleFactor,
                Size = UDim2.new(1, -64 * mobileScaleFactor, 0, 16 * mobileScaleFactor), TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd, Parent = groupObj.mainFrame
            })

            -- collapse arrow + clickable header strip
            groupObj.arrow = makeThingExist("ImageLabel", {
                Image = pickLucide({"chevron-down"}, "rbxassetid://111626678408582"), ImageColor3 = Color3.fromRGB(120, 120, 120),
                BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 0),
                Position = UDim2.new(1, -10, 0, 9 * mobileScaleFactor), Size = UDim2.new(0, 16 * mobileScaleFactor, 0, 16 * mobileScaleFactor),
                Rotation = groupObj.collapsed and -90 or 0, Visible = groupObj.collapsible, Parent = groupObj.mainFrame
            })
            local headerButton = makeThingExist("TextButton", {
                Text = "", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 32 * mobileScaleFactor),
                Active = groupObj.collapsible, Visible = groupObj.collapsible, Parent = groupObj.mainFrame
            })
            if groupConfig.Bare then
                -- borderless group: no icon / title / arrow header
                for _, child in ipairs(groupObj.mainFrame:GetChildren()) do
                    if child:IsA("ImageLabel") or child:IsA("TextLabel") then child.Visible = false end
                end
                headerButton.Visible = false
                headerButton.Active = false
            end

            local function currentTargetHeight()
                if groupObj.collapsed then return COLLAPSED_HEIGHT end
                if groupConfig.Bare then return math.max(groupObj.elementYPos - 8 * mobileScaleFactor, 1) end
                return groupObj.elementYPos + 10 * mobileScaleFactor
            end

            local function updateGroupSizeYay()
                groupObj.mainFrame.Size = UDim2.new(0, groupWidth, 0, currentTargetHeight())
                tabObj:_Reflow()
            end
            groupObj._UpdateSize = updateGroupSizeYay

            function groupObj:SetCollapsed(state, instant)
                state = state == true
                if not groupObj.collapsible and state then return end
                groupObj.collapsed = state
                smoothMoveGoWoosh(groupObj.arrow, {Rotation = state and -90 or 0}, 0.2)
                if state then
                    for _, element in ipairs(groupObj.elementsInGroup) do
                        if type(element) == "table" and type(element.Close) == "function" then pcall(function() element:Close() end) end
                    end
                end
                local target = currentTargetHeight()
                if instant then
                    groupObj.mainFrame.Size = UDim2.new(0, groupWidth, 0, target)
                    tabObj:_Reflow()
                    return
                end
                local startHeight = groupObj.mainFrame.Size.Y.Offset
                local startTime = os.clock()
                groupObj._collapseToken = (groupObj._collapseToken or 0) + 1
                local token = groupObj._collapseToken
                task.spawn(function()
                    while groupObj.mainFrame and groupObj.mainFrame.Parent and groupObj._collapseToken == token do
                        local alpha = math.min((os.clock() - startTime) / 0.22, 1)
                        alpha = 1 - (1 - alpha) ^ 3
                        groupObj.mainFrame.Size = UDim2.new(0, groupWidth, 0, startHeight + (currentTargetHeight() - startHeight) * alpha)
                        tabObj:_Reflow()
                        if alpha >= 1 then break end
                        task.wait()
                    end
                end)
            end
            function groupObj:Toggle() groupObj:SetCollapsed(not groupObj.collapsed) end
            function groupObj:IsCollapsed() return groupObj.collapsed end
            headerButton.MouseButton1Click:Connect(function() groupObj:Toggle() end)
            headerButton.MouseEnter:Connect(function() if groupObj.collapsible then smoothMoveGoWoosh(groupObj.arrow, {ImageColor3 = Color3.new(1, 1, 1)}, 0.15) end end)
            headerButton.MouseLeave:Connect(function() smoothMoveGoWoosh(groupObj.arrow, {ImageColor3 = Color3.fromRGB(120, 120, 120)}, 0.15) end)

            -- shift every element that sits below `thresholdY` (used when an element changes height later, e.g. a paragraph)
            function groupObj:_ShiftBelow(thresholdY, delta)
                for _, child in ipairs(groupObj.mainFrame:GetChildren()) do
                    if child:IsA("GuiObject") and child ~= headerButton and child.Position.Y.Scale == 0 and child.Position.Y.Offset > thresholdY + 1 then
                        child.Position = UDim2.new(child.Position.X.Scale, child.Position.X.Offset, 0, child.Position.Y.Offset + delta)
                    end
                end
                groupObj.elementYPos = groupObj.elementYPos + delta
                updateGroupSizeYay()
            end

            -- ======================================================================
            -- [NEMESIS+] shared helpers for elements
            -- ======================================================================
            local function gothamFont(weight)
                return Font.new("rbxasset://fonts/families/GothamSSm.json", weight or Enum.FontWeight.SemiBold)
            end
            -- dotted / segmented bar (reference design). SetFraction(0..1)
            local function buildSegmentBar(parent, xOffset, yOffset, width, height, colorOverride)
                local count = math.max(12, math.floor(width / 9))
                local holder = makeThingExist("Frame", {
                    BackgroundTransparency = 1, Position = UDim2.new(0, xOffset, 0, yOffset), Size = UDim2.new(0, width, 0, height), Parent = parent
                })
                local bar = {Holder = holder, Segments = {}, Count = count, Color = colorOverride or neonOf(groupObj.Library.config.AccentColor), Fraction = 0}
                local offColor = Color3.fromRGB(40, 40, 46)
                for index = 1, count do
                    local segment = makeThingExist("Frame", {
                        BackgroundColor3 = offColor, BorderSizePixel = 0,
                        Position = UDim2.new((index - 1) / count, 1, 0, 0), Size = UDim2.new(1 / count, -4, 1, 0), Parent = holder
                    })
                    makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = segment})
                    bar.Segments[index] = segment
                end
                function bar:Render()
                    local filled = math.floor(bar.Fraction * count + 0.5)
                    local dim = bar.Color:Lerp(Color3.fromRGB(30, 30, 36), 0.55)
                    for index, segment in ipairs(bar.Segments) do
                        if index <= filled then
                            segment.BackgroundColor3 = dim:Lerp(bar.Color, 0.25 + 0.75 * (index / count))
                        else
                            segment.BackgroundColor3 = offColor
                        end
                    end
                end
                function bar:SetFraction(fraction) bar.Fraction = math.clamp(fraction, 0, 1); bar:Render() end
                function bar:SetColor(color) bar.Color = color; bar:Render() end
                return bar
            end

            -- smooth rounded bar with a pink -> violet gradient fill (used by AddSlider). SetFraction(0..1, instant)
            local function buildSmoothBar(parent, xOffset, yOffset, width, height)
                local base = neonOf(groupObj.Library.config.AccentColor)
                local hotColor = base:Lerp(Color3.fromRGB(255, 84, 232), 0.6)
                local holder = makeThingExist("Frame", {
                    BackgroundTransparency = 1, Position = UDim2.new(0, xOffset, 0, yOffset), Size = UDim2.new(0, width, 0, height), Parent = parent
                })
                local track = makeThingExist("Frame", {BackgroundColor3 = Color3.fromRGB(30, 30, 36), BorderSizePixel = 0, Size = UDim2.new(1, 0, 1, 0), Parent = holder})
                makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = track})
                makeThingExist("UIStroke", {Color = Color3.fromRGB(44, 44, 52), Transparency = 0.3, Parent = track})
                local fill = makeThingExist("Frame", {BackgroundColor3 = Color3.new(1, 1, 1), BorderSizePixel = 0, Size = UDim2.new(0, 0, 1, 0), Parent = track})
                makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = fill})
                local fillGradient = makeThingExist("UIGradient", {Color = ColorSequence.new(base:Lerp(Color3.fromRGB(40, 10, 70), 0.15), hotColor), Parent = fill})
                local glow = makeThingExist("UIStroke", {Color = hotColor, Transparency = 0.6, Thickness = 1, Parent = fill})
                local knob = makeThingExist("Frame", {
                    BackgroundColor3 = Color3.new(1, 1, 1), AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0, 0, 0.5, 0),
                    Size = UDim2.new(0, 11 * mobileScaleFactor, 0, 11 * mobileScaleFactor), ZIndex = 3, Parent = holder
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = knob})
                makeThingExist("UIStroke", {Color = hotColor, Thickness = 2, Transparency = 0.3, Parent = knob})
                local bar = {Holder = holder, Fraction = 0}
                local shown, goal, glideConn = 0, 0, nil
                local function draw()
                    fill.Size = UDim2.new(shown, 0, 1, 0)
                    fill.Visible = shown > 0.001
                    knob.Position = UDim2.new(shown, 0, 0.5, 0)
                end
                function bar:SetFraction(fraction, instant)
                    goal = math.clamp(fraction, 0, 1)
                    bar.Fraction = goal
                    if instant then
                        if glideConn then glideConn:Disconnect(); glideConn = nil end
                        shown = goal
                        draw()
                        return
                    end
                    if glideConn then return end
                    -- exponential glide towards the target: the fill follows the cursor smoothly instead of snapping between steps
                    glideConn = runServiceMoreLikeWalkService.RenderStepped:Connect(function(dt)
                        shown = shown + (goal - shown) * (1 - math.exp(-dt * 16))
                        if math.abs(goal - shown) < 0.0005 then
                            shown = goal
                            if glideConn then glideConn:Disconnect(); glideConn = nil end
                        end
                        draw()
                    end)
                end
                function bar:SetColor(color)
                    fillGradient.Color = ColorSequence.new(color:Lerp(Color3.fromRGB(40, 10, 70), 0.15), color:Lerp(Color3.fromRGB(255, 84, 232), 0.5))
                    glow.Color = color
                end
                return bar
            end

            local function notifyBlocked(stateKey, customMessage)
                local info = NEMESIS_STATE[stateKey]
                if not info then return end
                local now = os.clock()
                if groupObj._lastBlockedNotify and now - groupObj._lastBlockedNotify < 1.5 then return end
                groupObj._lastBlockedNotify = now
                local titles = {Locked = "Locked", Premium = "Premium only", Fixing = "Perbaikan (Fixing)"}
                pcall(function()
                    groupObj.Library:Notify({
                        Title = titles[stateKey], Description = customMessage or info.Msg, Type = "Warning", Duration = 2.5,
                    })
                end)
            end
            local function formatNumber(value, decimals)
                local text = string.format("%." .. tostring(decimals) .. "f", value)
                if decimals > 0 then
                    text = string.gsub(text, "0+$", "")
                    text = string.gsub(text, "%.$", "")
                end
                return text
            end
            local function countDecimals(number)
                local str = string.format("%.6f", number)
                str = string.gsub(str, "0+$", "")
                local frac = string.match(str, "%.(%d*)$")
                return frac and #frac or 0
            end

            function groupObj:AddToggle(toggleConfig)
                toggleConfig = toggleConfig or {}
                toggleConfig.Name = toggleConfig.Name or "Toggle"
                if toggleConfig.Default == nil then toggleConfig.Default = toggleConfig.CurrentValue end
                toggleConfig.Default = toggleConfig.Default or false
                toggleConfig.Callback = toggleConfig.Callback or function() end
                toggleConfig.Flag = toggleConfig.Flag or createAutoFlag(toggleConfig.Name)
                addSearchTerm(toggleConfig.Name)
                local hasDesc = type(toggleConfig.Desc) == "string" and toggleConfig.Desc ~= ""
                if hasDesc then addSearchTerm(toggleConfig.Desc) end

                local toggleObj = {}
                local accentColor = groupObj.Library.config.AccentColor
                toggleObj.stateKey = resolveElementState(toggleConfig, groupObj.Library)
                if toggleConfig.Premium and groupObj.Library._stateElements then table.insert(groupObj.Library._stateElements, {Obj = toggleObj, Cfg = toggleConfig}) end
                toggleObj.isLocked = toggleObj.stateKey ~= nil
                toggleObj.value = toggleObj.isLocked and false or toggleConfig.Default
                local yPosition = groupObj.elementYPos

                toggleObj.labelText = makeThingExist("TextLabel", {
                    FontFace = gothamFont(), TextColor3 = Color3.fromRGB(124, 124, 124), Text = toggleConfig.Name,
                    BackgroundTransparency = 1, Position = UDim2.new(0, 10, 0, yPosition), TextSize = 14 * mobileScaleFactor,
                    Size = UDim2.new(0, groupObj.elementWidth - 44 * mobileScaleFactor, 0, 20 * mobileScaleFactor),
                    TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = groupObj.mainFrame
                })
                if hasDesc then
                    toggleObj.descText = makeThingExist("TextLabel", {
                        FontFace = gothamFont(Enum.FontWeight.Medium), TextColor3 = Color3.fromRGB(88, 88, 88), Text = toggleConfig.Desc,
                        BackgroundTransparency = 1, Position = UDim2.new(0, 10, 0, yPosition + 17 * mobileScaleFactor), TextSize = 11.5 * mobileScaleFactor,
                        Size = UDim2.new(0, groupObj.elementWidth - 44 * mobileScaleFactor, 0, 14 * mobileScaleFactor),
                        TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = groupObj.mainFrame
                    })
                end

                toggleObj.switchFrame = makeThingExist("Frame", {
                    BackgroundColor3 = Color3.fromRGB(32, 32, 32), Position = UDim2.new(1, -44 * mobileScaleFactor, 0, yPosition),
                    Size = UDim2.new(0, 34 * mobileScaleFactor, 0, 21 * mobileScaleFactor), Parent = groupObj.mainFrame
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = toggleObj.switchFrame})
                local premiumStroke = makeThingExist("UIStroke", {Color = GOLD_COLOR, Thickness = 1.3, Enabled = false, Parent = toggleObj.switchFrame})
                toggleObj.circleFrame = makeThingExist("Frame", {
                    BackgroundColor3 = Color3.fromRGB(75, 75, 75), Position = UDim2.new(0.0104, 0, 0.143, 0),
                    Size = UDim2.new(0, 15 * mobileScaleFactor, 0, 15 * mobileScaleFactor), Parent = toggleObj.switchFrame
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = toggleObj.circleFrame})
                local toggleClickButton = makeThingExist("TextButton", {Text = "", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), Parent = toggleObj.switchFrame})

                local function applyVisuals(animated)
                    local info = toggleObj.stateKey and NEMESIS_STATE[toggleObj.stateKey] or nil
                    setPremiumMark(toggleObj.labelText, toggleObj.stateKey == "Premium")
                    toggleObj.labelText.Text = ((toggleObj.stateKey == "Premium") and PREMIUM_PREFIX or "") .. toggleConfig.Name .. (info and info.Suffix or "")
                    toggleObj.labelText.TextColor3 = info and info.Text or Color3.fromRGB(124, 124, 124)
                    setPremiumOutline(toggleObj.switchFrame, toggleObj.stateKey == "Premium")
                    premiumStroke.Enabled = false
                    accentColor = groupObj.Library.config.AccentColor -- [v3.1] follows SetAccentColor
                    local on = toggleObj.value
                    local dur = animated and 0.2 or 0
                    local switchColor = info and Color3.fromRGB(20, 20, 20) or (on and accentColor or Color3.fromRGB(32, 32, 32))
                    local circleColor = info and Color3.fromRGB(45, 45, 45) or (on and Color3.new(1, 1, 1) or Color3.fromRGB(75, 75, 75))
                    local circlePos = on and UDim2.new(0.462, 0, 0.143, 0) or UDim2.new(0.0104, 0, 0.143, 0)
                    if animated then
                        smoothMoveGoWoosh(toggleObj.switchFrame, {BackgroundColor3 = switchColor}, dur)
                        smoothMoveGoWoosh(toggleObj.circleFrame, {Position = circlePos, BackgroundColor3 = circleColor}, dur, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
                    else
                        toggleObj.switchFrame.BackgroundColor3 = switchColor
                        toggleObj.circleFrame.BackgroundColor3 = circleColor
                        toggleObj.circleFrame.Position = circlePos
                    end
                end
                applyVisuals(false)
                toggleObj._RefreshAccent = function() applyVisuals(false) end

                function toggleObj:Set(value)
                    if toggleObj.isLocked then return end
                    toggleObj.value = value == true
                    applyVisuals(true)
                    toggleConfig.Callback(toggleObj.value)
                end
                function toggleObj:Get() return toggleObj.value end
                function toggleObj:SetState(stateKey, forceOff)
                    toggleObj.stateKey = stateKey
                    toggleObj.isLocked = stateKey ~= nil
                    if toggleObj.isLocked and forceOff ~= false then toggleObj.value = false end
                    applyVisuals(true)
                end
                function toggleObj:SetLocked(state, reason)
                    toggleConfig.LockedMessage = reason or toggleConfig.LockedMessage
                    toggleObj:SetState(state and "Locked" or nil)
                end
                function toggleObj:SetPremium(state) toggleObj:SetState(state and "Premium" or nil) end
                function toggleObj:SetFixing(state) toggleObj:SetState(state and "Fixing" or nil) end

                toggleClickButton.MouseButton1Click:Connect(function()
                    if toggleObj.isLocked then
                        notifyBlocked(toggleObj.stateKey, toggleConfig.LockedMessage)
                    else
                        toggleObj:Set(not toggleObj.value)
                    end
                end)

                if toggleConfig.Default and not toggleObj.isLocked then toggleConfig.Callback(true) end
                groupObj.Library:RegisterControl(toggleConfig.Flag, function()
                    return toggleObj:Get()
                end, function(value)
                    if not toggleObj.isLocked then toggleObj:Set(value == true) end
                end)
                -- Ouroboros compact indicator counts enabled toggles (not FPS).
                groupObj.Library._miniToggleRefs = groupObj.Library._miniToggleRefs or {}
                table.insert(groupObj.Library._miniToggleRefs, toggleObj)

                groupObj.elementYPos = groupObj.elementYPos + (28 + (hasDesc and 14 or 0)) * mobileScaleFactor
                updateGroupSizeYay()
                table.insert(groupObj.elementsInGroup, toggleObj)
                return toggleObj
            end

            function groupObj:AddSlider(sliderConfig)
                sliderConfig = sliderConfig or {}
                sliderConfig.Name = sliderConfig.Name or "Slider"
                if type(sliderConfig.Range) == "table" then
                    sliderConfig.Min = sliderConfig.Min or sliderConfig.Range[1]
                    sliderConfig.Max = sliderConfig.Max or sliderConfig.Range[2]
                end
                sliderConfig.Min = sliderConfig.Min or 0
                sliderConfig.Max = sliderConfig.Max or 100
                if sliderConfig.Default == nil then sliderConfig.Default = sliderConfig.CurrentValue end
                sliderConfig.Default = sliderConfig.Default or sliderConfig.Min
                sliderConfig.Increment = sliderConfig.Increment or 1
                sliderConfig.Suffix = sliderConfig.Suffix or ""
                sliderConfig.Callback = sliderConfig.Callback or function() end
                sliderConfig.Flag = sliderConfig.Flag or createAutoFlag(sliderConfig.Name)
                addSearchTerm(sliderConfig.Name)
                local hasDesc = type(sliderConfig.Desc) == "string" and sliderConfig.Desc ~= ""
                if hasDesc then addSearchTerm(sliderConfig.Desc) end
                local decimals = countDecimals(sliderConfig.Increment)
                local accentColor = groupObj.Library.config.AccentColor
                local minV, maxV = sliderConfig.Min, sliderConfig.Max
                local range = math.max(maxV - minV, 1e-9)

                local sliderObj = {}
                sliderObj.value = math.clamp(sliderConfig.Default, minV, maxV)
                local yPosition = groupObj.elementYPos
                local trackY = yPosition + (26 + (hasDesc and 14 or 0)) * mobileScaleFactor

                sliderObj.labelText = makeThingExist("TextLabel", {
                    FontFace = gothamFont(), TextColor3 = Color3.fromRGB(124, 124, 124), Text = sliderConfig.Name, BackgroundTransparency = 1,
                    Position = UDim2.new(0, 10, 0, yPosition), TextSize = 14 * mobileScaleFactor,
                    Size = UDim2.new(0, groupObj.elementWidth - 74 * mobileScaleFactor, 0, 20 * mobileScaleFactor),
                    TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = groupObj.mainFrame
                })
                if hasDesc then
                    sliderObj.descText = makeThingExist("TextLabel", {
                        FontFace = gothamFont(Enum.FontWeight.Medium), TextColor3 = Color3.fromRGB(88, 88, 88), Text = sliderConfig.Desc,
                        BackgroundTransparency = 1, Position = UDim2.new(0, 10, 0, yPosition + 17 * mobileScaleFactor), TextSize = 11.5 * mobileScaleFactor,
                        Size = UDim2.new(0, groupObj.elementWidth, 0, 14 * mobileScaleFactor), TextXAlignment = Enum.TextXAlignment.Left,
                        TextTruncate = Enum.TextTruncate.AtEnd, Parent = groupObj.mainFrame
                    })
                end

                -- typeable value box ("click the value to type a number")
                sliderObj.valueBox = makeThingExist("TextBox", {
                    FontFace = gothamFont(), TextColor3 = neonOf(accentColor), TextSize = 12.5 * mobileScaleFactor,
                    Text = formatNumber(sliderObj.value, decimals) .. sliderConfig.Suffix, ClearTextOnFocus = false,
                    BackgroundColor3 = Color3.fromRGB(26, 26, 26), AnchorPoint = Vector2.new(1, 0),
                    Position = UDim2.new(1, -10, 0, yPosition - 1), Size = UDim2.new(0, 62 * mobileScaleFactor, 0, 21 * mobileScaleFactor),
                    PlaceholderText = "...", Parent = groupObj.mainFrame
                })
                sliderObj.valueLabelText = sliderObj.valueBox
                local hasInput = sliderConfig.Input == true
                if not hasInput then
                    -- [v3.1] AddSlider: no input, only the value / percent on the right
                    sliderObj.valueBox.TextEditable = false
                    sliderObj.valueBox.Active = false
                    sliderObj.valueBox.Selectable = false
                    sliderObj.valueBox.BackgroundTransparency = 1
                    sliderObj.valueBox.TextXAlignment = Enum.TextXAlignment.Right
                end
                local function displayText(value)
                    if not hasInput and sliderConfig.ShowPercent then
                        return string.format("%d%%", math.floor((value - minV) / range * 100 + 0.5))
                    elseif not hasInput and sliderConfig.ShowMax then
                        return formatNumber(value, decimals) .. "/" .. formatNumber(maxV, decimals)
                    end
                    return formatNumber(value, decimals) .. sliderConfig.Suffix
                end
                sliderObj.valueBox.Text = displayText(sliderObj.value)
                makeThingExist("UICorner", {CornerRadius = UDim.new(0, 6), Parent = sliderObj.valueBox})
                local boxStroke = makeThingExist("UIStroke", {Color = Color3.fromRGB(42, 42, 42), Enabled = sliderConfig.Input == true, Parent = sliderObj.valueBox})

                local neon = neonOf(accentColor)
                sliderObj.backgroundFrame = makeThingExist("Frame", {
                    BackgroundTransparency = 1, Position = UDim2.new(0, 10, 0, trackY),
                    Size = UDim2.new(0, groupObj.elementWidth, 0, 9 * mobileScaleFactor), Parent = groupObj.mainFrame
                })
                sliderObj.segments = buildSmoothBar(sliderObj.backgroundFrame, 0, 0, groupObj.elementWidth, 8 * mobileScaleFactor)
                sliderObj.segments:SetFraction((sliderObj.value - minV) / range, true)
                local sliderClickButton = makeThingExist("TextButton", {
                    Text = "", BackgroundTransparency = 1, Position = UDim2.new(0, 0, 0.5, -11 * mobileScaleFactor),
                    Size = UDim2.new(1, 0, 0, 22 * mobileScaleFactor), Parent = sliderObj.backgroundFrame
                })
                local isDraggingSlider = false

                local function snap(value)
                    value = math.clamp(value, minV, maxV)
                    value = math.floor((value - minV) / sliderConfig.Increment + 0.5) * sliderConfig.Increment + minV
                    value = tonumber(string.format("%." .. (decimals + 2) .. "f", value)) or value
                    return math.clamp(value, minV, maxV)
                end

                function sliderObj:Set(value, skipAnim)
                    value = snap(tonumber(value) or minV)
                    sliderObj.value = value
                    local newPercentage = (value - minV) / range
                    sliderObj.segments:SetFraction(newPercentage, skipAnim == true)
                    if not sliderObj.valueBox:IsFocused() then
                        sliderObj.valueBox.Text = displayText(value)
                    end
                    sliderConfig.Callback(value)
                end
                function sliderObj:Get() return sliderObj.value end

                local function setFromInput(input)
                    local pct = math.clamp((input.Position.X - sliderObj.backgroundFrame.AbsolutePosition.X) / math.max(sliderObj.backgroundFrame.AbsoluteSize.X, 1), 0, 1)
                    sliderObj:Set(minV + range * pct, false)
                end
                sliderClickButton.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        isDraggingSlider = true
                        setFromInput(input)
                    end
                end)
                groupObj.Library:_TrackConnection(thisInputServiceGoesHard.InputEnded:Connect(function(input)
                    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and isDraggingSlider then
                        isDraggingSlider = false
                    end
                end))
                groupObj.Library:_TrackConnection(thisInputServiceGoesHard.InputChanged:Connect(function(input)
                    if isDraggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                        setFromInput(input)
                    end
                end))
                sliderObj.valueBox.Focused:Connect(function()
                    if not hasInput then sliderObj.valueBox:ReleaseFocus(); return end
                    sliderObj.valueBox.Text = formatNumber(sliderObj.value, decimals)
                    smoothMoveGoWoosh(boxStroke, {Color = neon}, 0.15)
                end)
                sliderObj.valueBox.FocusLost:Connect(function()
                    if not hasInput then return end
                    smoothMoveGoWoosh(boxStroke, {Color = Color3.fromRGB(42, 42, 42)}, 0.15)
                    local typed = tonumber(string.match(sliderObj.valueBox.Text, "-?%d+%.?%d*"))
                    if typed then sliderObj:Set(typed, false) else sliderObj.valueBox.Text = formatNumber(sliderObj.value, decimals) .. sliderConfig.Suffix end
                end)

                if sliderObj.value ~= minV then sliderConfig.Callback(sliderObj.value) end
                groupObj.Library:RegisterControl(sliderConfig.Flag, function()
                    return sliderObj:Get()
                end, function(value)
                    sliderObj:Set(tonumber(value) or minV, false)
                end)

                groupObj.elementYPos = groupObj.elementYPos + (40 + (hasDesc and 14 or 0)) * mobileScaleFactor
                updateGroupSizeYay()
                sliderObj._RefreshAccent = function()
                    local n = neonOf(groupObj.Library.config.AccentColor)
                    neon = n
                    sliderObj.valueBox.TextColor3 = n
                    sliderObj.segments:SetColor(n)
                end
                table.insert(groupObj.elementsInGroup, sliderObj)
                return sliderObj
            end
            -- [v3.1] slider with a typeable number box on the right
            function groupObj:AddInputSlider(sliderConfig)
                sliderConfig = sliderConfig or {}
                sliderConfig.Input = true
                return groupObj:AddSlider(sliderConfig)
            end

            function groupObj:AddStepper(stepConfig)
                stepConfig = stepConfig or {}
                stepConfig.Name = stepConfig.Name or "Stepper"
                if type(stepConfig.Range) == "table" then
                    stepConfig.Min = stepConfig.Min or stepConfig.Range[1]
                    stepConfig.Max = stepConfig.Max or stepConfig.Range[2]
                end
                stepConfig.Min = stepConfig.Min or 0
                stepConfig.Max = stepConfig.Max or 100
                if stepConfig.Default == nil then stepConfig.Default = stepConfig.CurrentValue end
                stepConfig.Default = stepConfig.Default or stepConfig.Min
                stepConfig.Increment = stepConfig.Increment or 1
                stepConfig.Suffix = stepConfig.Suffix or ""
                stepConfig.Callback = stepConfig.Callback or function() end
                stepConfig.Flag = stepConfig.Flag or createAutoFlag(stepConfig.Name)
                addSearchTerm(stepConfig.Name)
                local hasDesc = type(stepConfig.Desc) == "string" and stepConfig.Desc ~= ""
                if hasDesc then addSearchTerm(stepConfig.Desc) end
                local decimals = countDecimals(stepConfig.Increment)
                local accentColor = groupObj.Library.config.AccentColor
                local yPosition = groupObj.elementYPos
                local stepObj = {}
                stepObj.value = math.clamp(stepConfig.Default, stepConfig.Min, stepConfig.Max)

                stepObj.labelText = makeThingExist("TextLabel", {
                    FontFace = gothamFont(), TextColor3 = Color3.fromRGB(124, 124, 124), Text = stepConfig.Name, BackgroundTransparency = 1,
                    Position = UDim2.new(0, 10, 0, yPosition + 1), TextSize = 14 * mobileScaleFactor,
                    Size = UDim2.new(0, groupObj.elementWidth - 118 * mobileScaleFactor, 0, 20 * mobileScaleFactor),
                    TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = groupObj.mainFrame
                })
                if hasDesc then
                    makeThingExist("TextLabel", {
                        FontFace = gothamFont(Enum.FontWeight.Medium), TextColor3 = Color3.fromRGB(88, 88, 88), Text = stepConfig.Desc,
                        BackgroundTransparency = 1, Position = UDim2.new(0, 10, 0, yPosition + 18 * mobileScaleFactor), TextSize = 11.5 * mobileScaleFactor,
                        Size = UDim2.new(0, groupObj.elementWidth - 118 * mobileScaleFactor, 0, 14 * mobileScaleFactor), TextXAlignment = Enum.TextXAlignment.Left,
                        TextTruncate = Enum.TextTruncate.AtEnd, Parent = groupObj.mainFrame
                    })
                end

                local controls = makeThingExist("Frame", {
                    BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -10, 0, yPosition),
                    Size = UDim2.new(0, 108 * mobileScaleFactor, 0, 22 * mobileScaleFactor), Parent = groupObj.mainFrame
                })
                local function makeStepButton(symbol, xPos)
                    local btn = makeThingExist("TextButton", {
                        Text = symbol, AutoButtonColor = false, FontFace = gothamFont(Enum.FontWeight.Bold), TextSize = 16 * mobileScaleFactor,
                        TextColor3 = Color3.fromRGB(190, 190, 190), BackgroundColor3 = Color3.fromRGB(32, 32, 32),
                        Position = UDim2.new(0, xPos, 0, 0), Size = UDim2.new(0, 24 * mobileScaleFactor, 1, 0), Parent = controls
                    })
                    makeThingExist("UICorner", {CornerRadius = UDim.new(0, 6), Parent = btn})
                    makeThingExist("UIStroke", {Color = Color3.fromRGB(46, 46, 46), Parent = btn})
                    btn.MouseEnter:Connect(function() smoothMoveGoWoosh(btn, {BackgroundColor3 = Color3.fromRGB(44, 44, 44)}, 0.12) end)
                    btn.MouseLeave:Connect(function() smoothMoveGoWoosh(btn, {BackgroundColor3 = Color3.fromRGB(32, 32, 32)}, 0.12) end)
                    return btn
                end
                local minusButton = makeStepButton("−", 0)
                local plusButton = makeStepButton("+", 84 * mobileScaleFactor)
                stepObj.valueBox = makeThingExist("TextBox", {
                    FontFace = gothamFont(), TextColor3 = accentColor:Lerp(Color3.new(1, 1, 1), 0.35), TextSize = 12.5 * mobileScaleFactor,
                    Text = formatNumber(stepObj.value, decimals) .. stepConfig.Suffix, ClearTextOnFocus = false, BackgroundColor3 = Color3.fromRGB(26, 26, 26),
                    Position = UDim2.new(0, 28 * mobileScaleFactor, 0, 0), Size = UDim2.new(0, 52 * mobileScaleFactor, 1, 0), Parent = controls
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(0, 6), Parent = stepObj.valueBox})
                makeThingExist("UIStroke", {Color = Color3.fromRGB(42, 42, 42), Parent = stepObj.valueBox})

                local function snap(value)
                    value = math.clamp(value, stepConfig.Min, stepConfig.Max)
                    value = math.floor((value - stepConfig.Min) / stepConfig.Increment + 0.5) * stepConfig.Increment + stepConfig.Min
                    value = tonumber(string.format("%." .. (decimals + 2) .. "f", value)) or value
                    return math.clamp(value, stepConfig.Min, stepConfig.Max)
                end
                function stepObj:Set(value)
                    value = snap(tonumber(value) or stepConfig.Min)
                    local changed = value ~= stepObj.value
                    stepObj.value = value
                    stepObj.valueBox.Text = formatNumber(value, decimals) .. stepConfig.Suffix
                    if changed then stepConfig.Callback(value) end
                end
                function stepObj:Get() return stepObj.value end

                local function bindHold(button, direction)
                    local token = 0
                    button.MouseButton1Down:Connect(function()
                        token = token + 1
                        local myToken = token
                        stepObj:Set(stepObj.value + direction * stepConfig.Increment)
                        task.spawn(function()
                            task.wait(0.4)
                            local interval = 0.1
                            while token == myToken and button.Parent do
                                stepObj:Set(stepObj.value + direction * stepConfig.Increment)
                                task.wait(interval)
                                interval = math.max(0.03, interval * 0.92)
                            end
                        end)
                    end)
                    local function release() token = token + 1 end
                    button.MouseButton1Up:Connect(release)
                    button.MouseLeave:Connect(release)
                end
                bindHold(minusButton, -1)
                bindHold(plusButton, 1)
                stepObj.valueBox.FocusLost:Connect(function()
                    local typed = tonumber(string.match(stepObj.valueBox.Text, "-?%d+%.?%d*"))
                    if typed then stepObj:Set(typed) else stepObj.valueBox.Text = formatNumber(stepObj.value, decimals) .. stepConfig.Suffix end
                end)

                if stepObj.value ~= stepConfig.Min then stepConfig.Callback(stepObj.value) end
                groupObj.Library:RegisterControl(stepConfig.Flag, function() return stepObj:Get() end, function(value) stepObj:Set(tonumber(value) or stepConfig.Min) end)

                groupObj.elementYPos = groupObj.elementYPos + (30 + (hasDesc and 14 or 0)) * mobileScaleFactor
                updateGroupSizeYay()
                table.insert(groupObj.elementsInGroup, stepObj)
                return stepObj
            end

            function groupObj:AddProgress(progressConfig)
                progressConfig = progressConfig or {}
                progressConfig.Name = progressConfig.Name or "Progress"
                if type(progressConfig.Range) == "table" then
                    progressConfig.Min = progressConfig.Min or progressConfig.Range[1]
                    progressConfig.Max = progressConfig.Max or progressConfig.Range[2]
                end
                progressConfig.Min = progressConfig.Min or 0
                progressConfig.Max = progressConfig.Max or 1
                local initial = progressConfig.CurrentValue
                if initial == nil then initial = progressConfig.Value end
                if initial == nil then initial = progressConfig.Default end
                initial = initial or progressConfig.Min
                addSearchTerm(progressConfig.Name)
                local hasDesc = type(progressConfig.Desc) == "string" and progressConfig.Desc ~= ""
                local accentColor = progressConfig.Color or groupObj.Library.config.AccentColor
                local yPosition = groupObj.elementYPos
                local progressObj = {value = initial}
                local range = math.max(progressConfig.Max - progressConfig.Min, 1e-9)

                progressObj.labelText = makeThingExist("TextLabel", {
                    FontFace = gothamFont(), TextColor3 = Color3.fromRGB(124, 124, 124), Text = progressConfig.Name, BackgroundTransparency = 1,
                    Position = UDim2.new(0, 10, 0, yPosition), TextSize = 14 * mobileScaleFactor,
                    Size = UDim2.new(0, groupObj.elementWidth - 70 * mobileScaleFactor, 0, 20 * mobileScaleFactor),
                    TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = groupObj.mainFrame
                })
                progressObj.valueText = makeThingExist("TextLabel", {
                    FontFace = gothamFont(), TextColor3 = neonOf(accentColor), Text = "", BackgroundTransparency = 1,
                    AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -10, 0, yPosition), TextSize = 13 * mobileScaleFactor,
                    Size = UDim2.new(0, 64 * mobileScaleFactor, 0, 20 * mobileScaleFactor), TextXAlignment = Enum.TextXAlignment.Right, Parent = groupObj.mainFrame
                })
                if hasDesc then
                    makeThingExist("TextLabel", {
                        FontFace = gothamFont(Enum.FontWeight.Medium), TextColor3 = Color3.fromRGB(88, 88, 88), Text = progressConfig.Desc,
                        BackgroundTransparency = 1, Position = UDim2.new(0, 10, 0, yPosition + 17 * mobileScaleFactor), TextSize = 11.5 * mobileScaleFactor,
                        Size = UDim2.new(0, groupObj.elementWidth, 0, 14 * mobileScaleFactor), TextXAlignment = Enum.TextXAlignment.Left,
                        TextTruncate = Enum.TextTruncate.AtEnd, Parent = groupObj.mainFrame
                    })
                end
                local trackY = yPosition + (25 + (hasDesc and 14 or 0)) * mobileScaleFactor
                progressObj.track = makeThingExist("Frame", {
                    BackgroundTransparency = 1, Position = UDim2.new(0, 10, 0, trackY),
                    Size = UDim2.new(0, groupObj.elementWidth, 0, 8 * mobileScaleFactor), Parent = groupObj.mainFrame
                })
                progressObj.segments = buildSegmentBar(progressObj.track, 0, 0, groupObj.elementWidth, 8 * mobileScaleFactor, progressConfig.Color and accentColor or nil)

                -- [v3.1] soft glow behind the bar, pulses while the progress is above 80%
                local glowFrame = makeThingExist("Frame", {
                    BackgroundColor3 = neonOf(accentColor), BackgroundTransparency = 1, BorderSizePixel = 0, ZIndex = 0,
                    Position = UDim2.new(0, -3, 0, -3), Size = UDim2.new(1, 6, 1, 6), Parent = progressObj.track
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = glowFrame})
                local pulseTween
                local function setPulse(on)
                    if on and not pulseTween then
                        glowFrame.BackgroundTransparency = 0.9
                        pulseTween = oMgThisTweenServiceIsSoCool:Create(glowFrame, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {BackgroundTransparency = 0.65})
                        pulseTween:Play()
                    elseif not on and pulseTween then
                        pulseTween:Cancel(); pulseTween = nil
                        glowFrame.BackgroundTransparency = 1
                    end
                end
                local function render(animate)
                    local pct = math.clamp((progressObj.value - progressConfig.Min) / range, 0, 1)
                    progressObj.segments:SetFraction(pct)
                    setPulse(pct >= 0.8)
                    progressObj.valueText.FontFace = gothamFont(pct >= 1 and Enum.FontWeight.Bold or Enum.FontWeight.SemiBold)
                    if progressObj._customText then
                        progressObj.valueText.Text = progressObj._customText
                    elseif type(progressConfig.Format) == "function" then
                        progressObj.valueText.Text = tostring(progressConfig.Format(progressObj.value, pct))
                    elseif progressConfig.Suffix and progressConfig.Max > 1 then
                        progressObj.valueText.Text = formatNumber(progressObj.value, 1) .. progressConfig.Suffix
                    else
                        progressObj.valueText.Text = string.format("%d%%", math.floor(pct * 100 + 0.5))
                    end
                end
                render(false)
                function progressObj:Set(value) progressObj.value = tonumber(value) or progressObj.value; render(true) end
                function progressObj:Get() return progressObj.value end
                function progressObj:SetText(text) progressObj._customText = text and tostring(text) or nil; render(false) end
                function progressObj:SetName(text) progressObj.labelText.Text = tostring(text) end
                function progressObj:SetColor(color)
                    progressObj.segments:SetColor(color)
                    progressObj.valueText.TextColor3 = color
                    glowFrame.BackgroundColor3 = color
                end
                if not progressConfig.Color then
                    progressObj._RefreshAccent = function() progressObj:SetColor(neonOf(groupObj.Library.config.AccentColor)) end
                end

                groupObj.elementYPos = groupObj.elementYPos + (38 + (hasDesc and 14 or 0)) * mobileScaleFactor
                updateGroupSizeYay()
                table.insert(groupObj.elementsInGroup, progressObj)
                return progressObj
            end

            function groupObj:AddButton(buttonConfig)
                if type(buttonConfig) == "string" then buttonConfig = {Name = buttonConfig} end
                buttonConfig = buttonConfig or {}
                buttonConfig.Name = buttonConfig.Name or "Button"
                buttonConfig.Icon = getRealIcon(buttonConfig.Icon, nil)
                buttonConfig.Callback = buttonConfig.Callback or function() end
                buttonConfig.Style = buttonConfig.Style or "Default"
                addSearchTerm(buttonConfig.Name)
                local hasDesc = type(buttonConfig.Desc) == "string" and buttonConfig.Desc ~= ""
                if hasDesc then addSearchTerm(buttonConfig.Desc) end
                local accentColor = groupObj.Library.config.AccentColor

                local buttonObj = {}
                buttonObj.stateKey = resolveElementState(buttonConfig, groupObj.Library)
                if buttonConfig.Premium and groupObj.Library._stateElements then table.insert(groupObj.Library._stateElements, {Obj = buttonObj, Cfg = buttonConfig}) end
                buttonObj.isLocked = buttonObj.stateKey ~= nil
                local yPosition = groupObj.elementYPos
                local buttonHeight = (hasDesc and 40 or 26) * mobileScaleFactor
                local baseColor, hoverColor, textColor, strokeColor = Color3.fromRGB(32, 32, 32), Color3.fromRGB(40, 40, 40), Color3.fromRGB(120, 120, 120), Color3.fromRGB(48, 48, 48)
                if buttonConfig.Style == "Primary" then
                    baseColor = accentColor:Lerp(Color3.fromRGB(20, 20, 20), 0.35); hoverColor = accentColor:Lerp(Color3.fromRGB(20, 20, 20), 0.15)
                    textColor = Color3.new(1, 1, 1); strokeColor = accentColor
                elseif buttonConfig.Style == "Danger" then
                    baseColor = Color3.fromRGB(70, 28, 28); hoverColor = Color3.fromRGB(95, 36, 36)
                    textColor = Color3.fromRGB(255, 140, 140); strokeColor = Color3.fromRGB(130, 50, 50)
                end

                buttonObj.mainFrame = makeThingExist("Frame", {
                    BackgroundColor3 = baseColor, Position = UDim2.new(0, 10, 0, yPosition),
                    Size = UDim2.new(0, groupObj.elementWidth, 0, buttonHeight), Parent = groupObj.mainFrame
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(0, 6), Parent = buttonObj.mainFrame})
                local buttonStrokeThing = makeThingExist("UIStroke", {Color = strokeColor, Parent = buttonObj.mainFrame})
                makeThingExist("UIGradient", {
                    Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(1,1,1)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150,150,150)), ColorSequenceKeypoint.new(1, Color3.new(1,1,1))}),
                    Rotation = 260, Parent = buttonStrokeThing
                })

                local textXPos = 10
                if buttonConfig.Icon then
                    buttonObj.iconImage = makeThingExist("ImageLabel", {
                        ImageColor3 = textColor, Image = buttonConfig.Icon, BackgroundTransparency = 1,
                        Position = UDim2.new(0, 9, 0.5, -8 * mobileScaleFactor),
                        Size = UDim2.new(0, 16 * mobileScaleFactor, 0, 16 * mobileScaleFactor), Parent = buttonObj.mainFrame
                    })
                    textXPos = 32
                end
                buttonObj.labelText = makeThingExist("TextLabel", {
                    FontFace = gothamFont(), TextColor3 = textColor, Text = buttonConfig.Name, BackgroundTransparency = 1,
                    Position = UDim2.new(0, textXPos * mobileScaleFactor, 0, hasDesc and 5 * mobileScaleFactor or 0), TextSize = 14 * mobileScaleFactor,
                    Size = UDim2.new(1, -textXPos * mobileScaleFactor - 10, 0, hasDesc and 17 * mobileScaleFactor or buttonHeight),
                    TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = buttonObj.mainFrame
                })
                if hasDesc then
                    buttonObj.descText = makeThingExist("TextLabel", {
                        FontFace = gothamFont(Enum.FontWeight.Medium), TextColor3 = textColor:Lerp(Color3.fromRGB(20, 20, 20), 0.35), Text = buttonConfig.Desc,
                        BackgroundTransparency = 1, Position = UDim2.new(0, textXPos * mobileScaleFactor, 0, 22 * mobileScaleFactor), TextSize = 11.5 * mobileScaleFactor,
                        Size = UDim2.new(1, -textXPos * mobileScaleFactor - 10, 0, 14 * mobileScaleFactor), TextXAlignment = Enum.TextXAlignment.Left,
                        TextTruncate = Enum.TextTruncate.AtEnd, Parent = buttonObj.mainFrame
                    })
                end

                local function applyVisuals()
                    local info = buttonObj.stateKey and NEMESIS_STATE[buttonObj.stateKey] or nil
                    if info then
                        buttonObj.mainFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
                        buttonStrokeThing.Color = (buttonObj.stateKey == "Premium") and GOLD_COLOR:Lerp(Color3.fromRGB(24, 24, 24), 0.45) or Color3.fromRGB(32, 32, 32)
                    buttonObj.labelText.TextColor3 = info.Text
                    setPremiumOutline(buttonObj.mainFrame, buttonObj.stateKey == "Premium")
                    setPremiumMark(buttonObj.labelText, buttonObj.stateKey == "Premium")
                        buttonObj.labelText.Text = ((buttonObj.stateKey == "Premium") and PREMIUM_PREFIX or "") .. buttonConfig.Name .. info.Suffix
                        if buttonObj.iconImage then buttonObj.iconImage.ImageColor3 = info.Text:Lerp(Color3.fromRGB(0, 0, 0), 0.2) end
                        if buttonObj.descText then buttonObj.descText.TextColor3 = info.Text:Lerp(Color3.fromRGB(20, 20, 20), 0.35) end
                    else
                    setPremiumMark(buttonObj.labelText, false)
                    setPremiumOutline(buttonObj.mainFrame, false)
                    buttonObj.mainFrame.BackgroundColor3 = baseColor
                        buttonStrokeThing.Color = strokeColor
                        buttonObj.labelText.TextColor3 = textColor
                        buttonObj.labelText.Text = buttonConfig.Name
                        if buttonObj.iconImage then buttonObj.iconImage.ImageColor3 = textColor end
                        if buttonObj.descText then buttonObj.descText.TextColor3 = textColor:Lerp(Color3.fromRGB(20, 20, 20), 0.35) end
                    end
                end
                applyVisuals()
                buttonObj._RefreshAccent = function()
                    if buttonConfig.Style ~= "Primary" then return end
                    local a = groupObj.Library.config.AccentColor
                    baseColor = a:Lerp(Color3.fromRGB(20, 20, 20), 0.35); hoverColor = a:Lerp(Color3.fromRGB(20, 20, 20), 0.15); strokeColor = a
                    if not buttonObj.isLocked then applyVisuals() end
                end

                local armed = false
                local buttonClickButton = makeThingExist("TextButton", {Text = "", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), Parent = buttonObj.mainFrame})
                local function fire()
                    if buttonConfig.Confirm and not armed then
                        armed = true
                        buttonObj.labelText.Text = "Click again to confirm"
                        task.delay(2, function()
                            if armed then armed = false; if not buttonObj.isLocked then applyVisuals() end end
                        end)
                        return
                    end
                    if armed then armed = false; applyVisuals() end
                    task.spawn(buttonConfig.Callback)
                end
                buttonClickButton.MouseButton1Click:Connect(function()
                    if buttonObj.isLocked then notifyBlocked(buttonObj.stateKey, buttonConfig.LockedMessage) else fire() end
                end)
                buttonClickButton.MouseEnter:Connect(function() if not buttonObj.isLocked then smoothMoveGoWoosh(buttonObj.mainFrame, {BackgroundColor3 = hoverColor}, 0.2) end end)
                buttonClickButton.MouseLeave:Connect(function() if not buttonObj.isLocked then smoothMoveGoWoosh(buttonObj.mainFrame, {BackgroundColor3 = baseColor}, 0.2) end end)

                function buttonObj:SetState(stateKey) buttonObj.stateKey = stateKey; buttonObj.isLocked = stateKey ~= nil; applyVisuals() end
                function buttonObj:SetLocked(state, reason) buttonConfig.LockedMessage = reason or buttonConfig.LockedMessage; buttonObj:SetState(state and "Locked" or nil) end
                function buttonObj:SetPremium(state) buttonObj:SetState(state and "Premium" or nil) end
                function buttonObj:SetFixing(state) buttonObj:SetState(state and "Fixing" or nil) end
                function buttonObj:SetText(text) buttonConfig.Name = tostring(text); applyVisuals() end
                function buttonObj:SetDesc(text) if buttonObj.descText then buttonObj.descText.Text = tostring(text) end end
                function buttonObj:Click() if not buttonObj.isLocked then fire() end end

                groupObj.elementYPos = groupObj.elementYPos + buttonHeight + 6 * mobileScaleFactor
                updateGroupSizeYay()
                table.insert(groupObj.elementsInGroup, buttonObj)
                return buttonObj
            end

            -- ==========================================
            -- [KODE BARU: DOUBLE BUTTONS (2 TOMBOL SEJAJAR)]
            -- ==========================================
            function groupObj:AddDoubleButton(doubleConfig)
                doubleConfig = doubleConfig or {}
                local btn1Config = doubleConfig.Button1 or {Name = "Button 1", Callback = function() end}
                local btn2Config = doubleConfig.Button2 or {Name = "Button 2", Callback = function() end}
                
                local doubleBtnObj = {}
                local yPosition = groupObj.elementYPos
                
                -- Lebar masing-masing tombol adalah setengah dari lebar elemen grup dikurangi jarak tengah (8px)
                local halfWidth = (groupObj.elementWidth / 2) - (4 * mobileScaleFactor)
                
                local function createHalfBtn(config, xOffset)
                    local isRed = config.IsRed == true
                    
                    local btnFrame = makeThingExist("Frame", {
                        BackgroundColor3 = Color3.fromRGB(22, 22, 22),
                        Position = UDim2.new(0, xOffset, 0, yPosition),
                        Size = UDim2.new(0, halfWidth, 0, 26 * mobileScaleFactor), 
                        Parent = groupObj.mainFrame
                    })
                    makeThingExist("UICorner", {CornerRadius = UDim.new(0, 6), Parent = btnFrame})
                    
                    -- Warna garis pinggir: Merah jika IsRed = true, kalau tidak abu-abu gelap
                    local strokeColor = isRed and Color3.fromRGB(180, 50, 50) or Color3.fromRGB(40, 40, 40)
                    makeThingExist("UIStroke", {Color = strokeColor, Parent = btnFrame})
                    
                    local textColor = isRed and Color3.fromRGB(220, 80, 80) or Color3.fromRGB(210, 210, 210)
                    makeThingExist("TextLabel", {
                        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
                        TextColor3 = textColor, Text = config.Name,
                        BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0),
                        TextSize = 13 * mobileScaleFactor, Parent = btnFrame
                    })
                    
                    local click = makeThingExist("TextButton", {
                        Text = "", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), Parent = btnFrame
                    })
                    
                    click.MouseButton1Click:Connect(function()
                        if config.Callback then config.Callback() end
                    end)
                    
                    -- Efek nyala saat mouse masuk (Hover)
                    click.MouseEnter:Connect(function() 
                        smoothMoveGoWoosh(btnFrame, {BackgroundColor3 = isRed and Color3.fromRGB(40, 20, 20) or Color3.fromRGB(30, 30, 30)}, 0.15) 
                    end)
                    click.MouseLeave:Connect(function() 
                        smoothMoveGoWoosh(btnFrame, {BackgroundColor3 = Color3.fromRGB(22, 22, 22)}, 0.15) 
                    end)
                    
                    return btnFrame
                end
                
                -- Gambar Tombol Kiri (Mulai dari X = 10)
                local btn1 = createHalfBtn(btn1Config, 10)
                -- Gambar Tombol Kanan (Mulai dari X = 10 + lebar tombol kiri + jarak tengah)
                local btn2 = createHalfBtn(btn2Config, 10 + halfWidth + (8 * mobileScaleFactor))
                
                groupObj.elementYPos = groupObj.elementYPos + 32 * mobileScaleFactor
                updateGroupSizeYay()
                table.insert(groupObj.elementsInGroup, doubleBtnObj)
                
                return doubleBtnObj
            end
            -- ==========================================
            -- [KODE BARU: FITUR PARAGRAPH (SUPPORT SETCONTENT & RICHTEXT)]
            -- ==========================================
            function groupObj:AddParagraph(paraConfig)
                if type(paraConfig) == "string" then paraConfig = {Content = paraConfig} end
                paraConfig = paraConfig or {}
                paraConfig.Title = paraConfig.Title or ""
                paraConfig.Content = paraConfig.Content or paraConfig.Text or ""

                local paraObj = {}
                local yPosition = groupObj.elementYPos
                local width = groupObj.elementWidth
                local titleHeight = (paraConfig.Title ~= "") and (20 * mobileScaleFactor) or 0

                -- auto layout: the label sizes itself (AutomaticSize) and the group follows, no "Lines" needed
                local _, newlineCount = string.gsub(paraConfig.Content, "\n", "")
                local initialLines = paraConfig.Lines or (newlineCount + 1)
                paraObj.height = initialLines * 15 * mobileScaleFactor + titleHeight

                paraObj.frame = makeThingExist("Frame", {
                    BackgroundTransparency = 1, Position = UDim2.new(0, 10, 0, yPosition),
                    Size = UDim2.new(0, width, 0, paraObj.height), Parent = groupObj.mainFrame
                })
                if paraConfig.Title ~= "" then
                    paraObj.titleLabel = makeThingExist("TextLabel", {
                        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold),
                        Text = paraConfig.Title, TextColor3 = Color3.fromRGB(230, 230, 230), BackgroundTransparency = 1,
                        Position = UDim2.new(0, 0, 0, 0), Size = UDim2.new(1, 0, 0, 16 * mobileScaleFactor), TextSize = 13 * mobileScaleFactor,
                        TextXAlignment = Enum.TextXAlignment.Left, RichText = true, Parent = paraObj.frame
                    })
                end
                paraObj.contentLabel = makeThingExist("TextLabel", {
                    FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium),
                    Text = paraConfig.Content, TextColor3 = Color3.fromRGB(160, 160, 160), BackgroundTransparency = 1,
                    Position = UDim2.new(0, 0, 0, titleHeight), Size = UDim2.new(1, 0, 0, 14 * mobileScaleFactor),
                    AutomaticSize = Enum.AutomaticSize.Y, TextSize = 12 * mobileScaleFactor,
                    TextXAlignment = Enum.TextXAlignment.Left, TextYAlignment = Enum.TextYAlignment.Top,
                    RichText = true, TextWrapped = true, Parent = paraObj.frame
                })

                local function resync()
                    if not paraObj.contentLabel or not paraObj.contentLabel.Parent then return end
                    local newHeight = titleHeight + math.max(paraObj.contentLabel.AbsoluteSize.Y / math.max(1, 1), 12)
                    -- AbsoluteSize is in pixels; the layout is in offsets, they match unless a UIScale is applied
                    local delta = newHeight - paraObj.height
                    if math.abs(delta) >= 1 then
                        paraObj.height = newHeight
                        paraObj.frame.Size = UDim2.new(0, width, 0, newHeight)
                        groupObj:_ShiftBelow(yPosition + 1, delta)
                    end
                end
                paraObj.contentLabel:GetPropertyChangedSignal("AbsoluteSize"):Connect(resync)
                task.defer(resync)

                function paraObj:SetContent(newContent)
                    if newContent == nil then return end
                    paraObj.contentLabel.Text = tostring(newContent)
                    task.defer(resync)
                end
                function paraObj:SetTitle(newTitle)
                    if paraObj.titleLabel and newTitle then paraObj.titleLabel.Text = tostring(newTitle) end
                end

                groupObj.elementYPos = groupObj.elementYPos + paraObj.height + 8 * mobileScaleFactor
                updateGroupSizeYay()
                table.insert(groupObj.elementsInGroup, paraObj)
                return paraObj
            end

            -- Airflow-style section heading (label + line) used to split a group into parts
            function groupObj:AddSection(sectionConfig)
                if type(sectionConfig) == "string" then sectionConfig = {Name = sectionConfig} end
                sectionConfig = sectionConfig or {}
                local name = tostring(sectionConfig.Name or sectionConfig.Title or "Section")
                addSearchTerm(name)
                local accentColor = groupObj.Library.config.AccentColor
                local yPosition = groupObj.elementYPos + 2 * mobileScaleFactor
                local textBounds = textServiceBeLikeText:GetTextSize(name, 11.5 * mobileScaleFactor, Enum.Font.GothamBold, Vector2.new(400, 20))
                local iconImage = sectionConfig.Icon and getRealIcon(sectionConfig.Icon, nil) or nil
                local labelX = 10
                local sectionObj2 = {}
                makeThingExist("Frame", {
                    BackgroundColor3 = accentColor, Position = UDim2.new(0, 10, 0, yPosition + 3 * mobileScaleFactor),
                    Size = UDim2.new(0, 3, 0, 11 * mobileScaleFactor), BorderSizePixel = 0, Parent = groupObj.mainFrame
                })
                labelX = 20
                if iconImage then
                    makeThingExist("ImageLabel", {
                        Image = iconImage, ImageColor3 = accentColor:Lerp(Color3.new(1, 1, 1), 0.3), BackgroundTransparency = 1,
                        Position = UDim2.new(0, labelX, 0, yPosition + 1 * mobileScaleFactor), Size = UDim2.new(0, 14 * mobileScaleFactor, 0, 14 * mobileScaleFactor), Parent = groupObj.mainFrame
                    })
                    labelX = labelX + 20
                end
                sectionObj2.label = makeThingExist("TextLabel", {
                    FontFace = gothamFont(Enum.FontWeight.Bold), Text = string.upper(name), TextColor3 = Color3.fromRGB(150, 150, 150),
                    TextSize = 11.5 * mobileScaleFactor, BackgroundTransparency = 1, Position = UDim2.new(0, labelX, 0, yPosition),
                    Size = UDim2.new(0, textBounds.X + 14, 0, 17 * mobileScaleFactor), TextXAlignment = Enum.TextXAlignment.Left, Parent = groupObj.mainFrame
                })
                local lineStart = labelX + textBounds.X + 18
                sectionObj2.line = makeThingExist("Frame", {
                    BackgroundColor3 = Color3.fromRGB(38, 38, 38), Position = UDim2.new(0, lineStart, 0, yPosition + 8 * mobileScaleFactor),
                    Size = UDim2.new(0, math.max(10, groupObj.elementWidth + 10 - lineStart), 0, 1), BorderSizePixel = 0, Parent = groupObj.mainFrame
                })
                function sectionObj2:SetName(text) sectionObj2.label.Text = string.upper(tostring(text)) end
                groupObj.elementYPos = groupObj.elementYPos + 24 * mobileScaleFactor
                updateGroupSizeYay()
                table.insert(groupObj.elementsInGroup, sectionObj2)
                return sectionObj2
            end

            -- empty placeholder inside a group
            function groupObj:AddEmpty(emptyConfig)
                if type(emptyConfig) == "string" then emptyConfig = {Title = emptyConfig} end
                emptyConfig = emptyConfig or {}
                local height = (emptyConfig.Height or 96) * mobileScaleFactor
                local yPosition = groupObj.elementYPos
                local emptyObj = {}
                emptyObj.frame = makeThingExist("Frame", {BackgroundTransparency = 1, Position = UDim2.new(0, 10, 0, yPosition), Size = UDim2.new(0, groupObj.elementWidth, 0, height), Parent = groupObj.mainFrame})
                local ring = makeThingExist("Frame", {
                    BackgroundColor3 = Color3.fromRGB(24, 24, 24), AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, 4),
                    Size = UDim2.new(0, 38 * mobileScaleFactor, 0, 38 * mobileScaleFactor), Parent = emptyObj.frame
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = ring})
                makeThingExist("UIStroke", {Color = Color3.fromRGB(40, 40, 40), Parent = ring})
                makeThingExist("ImageLabel", {
                    Image = getRealIcon(emptyConfig.Icon, pickLucide({"inbox", "package-open"}, "rbxassetid://10723427199")), ImageColor3 = Color3.fromRGB(110, 110, 110),
                    BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0),
                    Size = UDim2.new(0, 18 * mobileScaleFactor, 0, 18 * mobileScaleFactor), Parent = ring
                })
                emptyObj.title = makeThingExist("TextLabel", {
                    FontFace = gothamFont(Enum.FontWeight.Bold), Text = tostring(emptyConfig.Title or "Nothing here yet"), TextColor3 = Color3.fromRGB(180, 180, 180),
                    TextSize = 13 * mobileScaleFactor, BackgroundTransparency = 1, Position = UDim2.new(0, 0, 0, 48 * mobileScaleFactor), Size = UDim2.new(1, 0, 0, 16 * mobileScaleFactor), Parent = emptyObj.frame
                })
                emptyObj.desc = makeThingExist("TextLabel", {
                    FontFace = gothamFont(Enum.FontWeight.Medium), Text = tostring(emptyConfig.Description or ""), TextColor3 = Color3.fromRGB(100, 100, 100),
                    TextSize = 11.5 * mobileScaleFactor, TextWrapped = true, BackgroundTransparency = 1, TextYAlignment = Enum.TextYAlignment.Top,
                    Position = UDim2.new(0, 6, 0, 66 * mobileScaleFactor), Size = UDim2.new(1, -12, 1, -66 * mobileScaleFactor), Parent = emptyObj.frame
                })
                function emptyObj:Set(title, description) if title then emptyObj.title.Text = tostring(title) end if description then emptyObj.desc.Text = tostring(description) end end
                groupObj.elementYPos = groupObj.elementYPos + height + 6 * mobileScaleFactor
                updateGroupSizeYay()
                table.insert(groupObj.elementsInGroup, emptyObj)
                return emptyObj
            end

            -- image card (asset id / rbxassetid / rbxthumb / web link / "Avatar" / gradient preset)
            function groupObj:AddImage(imageConfig)
                if type(imageConfig) == "string" then imageConfig = {Image = imageConfig} end
                imageConfig = imageConfig or {}
                local hasName = type(imageConfig.Name) == "string" and imageConfig.Name ~= ""
                local hasCaption = type(imageConfig.Caption) == "string" and imageConfig.Caption ~= ""
                if hasName then addSearchTerm(imageConfig.Name) end
                local imageHeight = (imageConfig.Height or 140) * mobileScaleFactor
                local yPosition = groupObj.elementYPos
                local imageObj = {}
                local currentY = 0
                local PRESETS = {
                    ["Deep Violet"] = {Color3.fromRGB(28, 10, 70), Color3.fromRGB(125, 45, 205)},
                    Ocean   = {Color3.fromRGB(8, 32, 78),  Color3.fromRGB(35, 160, 205)},
                    Sunset  = {Color3.fromRGB(90, 22, 60), Color3.fromRGB(255, 150, 70)},
                    Forest  = {Color3.fromRGB(10, 40, 26), Color3.fromRGB(100, 190, 110)},
                    Mono    = {Color3.fromRGB(18, 18, 18), Color3.fromRGB(90, 90, 90)},
                }
                local totalHeight = imageHeight + (hasName and 20 * mobileScaleFactor or 0) + (hasCaption and 18 * mobileScaleFactor or 0)
                imageObj.frame = makeThingExist("Frame", {BackgroundTransparency = 1, Position = UDim2.new(0, 10, 0, yPosition), Size = UDim2.new(0, groupObj.elementWidth, 0, totalHeight), Parent = groupObj.mainFrame})
                if hasName then
                    makeThingExist("TextLabel", {
                        FontFace = gothamFont(), Text = imageConfig.Name, TextColor3 = Color3.fromRGB(124, 124, 124), TextSize = 14 * mobileScaleFactor, BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, 18 * mobileScaleFactor), TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = imageObj.frame
                    })
                    currentY = 20 * mobileScaleFactor
                end
                imageObj.holder = makeThingExist("Frame", {
                    BackgroundColor3 = Color3.fromRGB(22, 22, 22), ClipsDescendants = true, Position = UDim2.new(0, 0, 0, currentY),
                    Size = UDim2.new(1, 0, 0, imageHeight), Parent = imageObj.frame
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(0, imageConfig.Corner or 8), Parent = imageObj.holder})
                makeThingExist("UIStroke", {Color = Color3.fromRGB(38, 38, 38), Parent = imageObj.holder})
                imageObj.picture = makeThingExist("ImageLabel", {
                    BackgroundTransparency = 1, ImageTransparency = 1, Size = UDim2.new(1, 0, 1, 0),
                    ScaleType = (imageConfig.ScaleType == "Fit") and Enum.ScaleType.Fit or Enum.ScaleType.Crop, Parent = imageObj.holder
                })
                local presetGradient

                local function showPreset(colors)
                    imageObj.picture.Visible = false
                    if not presetGradient then
                        presetGradient = makeThingExist("Frame", {BackgroundColor3 = Color3.new(1, 1, 1), Size = UDim2.new(1, 0, 1, 0), Parent = imageObj.holder})
                        makeThingExist("UIGradient", {Rotation = 35, Color = ColorSequence.new(colors[1], colors[2]), Parent = presetGradient})
                    else
                        presetGradient.UIGradient.Color = ColorSequence.new(colors[1], colors[2])
                    end
                end
                local function showImage(contentId)
                    if presetGradient then presetGradient:Destroy(); presetGradient = nil end
                    imageObj.picture.Visible = true
                    imageObj.picture.Image = contentId
                    smoothMoveGoWoosh(imageObj.picture, {ImageTransparency = 0}, 0.4)
                end

                function imageObj:SetImage(source)
                    source = source or "Deep Violet"
                    if type(source) == "number" then source = "rbxassetid://" .. tostring(source) end
                    if PRESETS[source] then showPreset(PRESETS[source]); return end
                    if source == "Avatar" then
                        showImage("rbxthumb://type=AvatarBust&id=" .. tostring(theOneAndOnlyPlayer.UserId) .. "&w=420&h=420"); return
                    end
                    if string.match(source, "^%d+$") then showImage("rbxassetid://" .. source); return end
                    if string.match(source, "^rbxasset") then showImage(source); return end
                    if string.match(source, "^https?://") then
                        showPreset(PRESETS["Mono"])
                        task.spawn(function()
                            local requestFn = (syn and syn.request) or request or http_request or (http and http.request)
                            if not (requestFn and writefile and getcustomasset) then return end
                            local okReq, res = pcall(requestFn, {Url = source, Method = "GET"})
                            if not okReq or type(res) ~= "table" or not res.Body or res.StatusCode ~= 200 then return end
                            local folder = (groupObj.Library._cfgFolder or "NemesisUIConfigs") .. "_Images"
                            pcall(function() if not isfolder(folder) then makefolder(folder) end end)
                            local hash = 5381
                            for index = 1, #source do hash = (hash * 33 + string.byte(source, index)) % 4294967296 end
                            local path = folder .. "/img_" .. tostring(hash) .. ".png"
                            local okWrite = pcall(writefile, path, res.Body)
                            if not okWrite then return end
                            local okAsset, asset = pcall(getcustomasset, path)
                            if okAsset and imageObj.frame and imageObj.frame.Parent then showImage(asset) end
                        end)
                        return
                    end
                    showPreset(PRESETS["Deep Violet"])
                end
                imageObj:SetImage(imageConfig.Image)

                if hasCaption then
                    imageObj.caption = makeThingExist("TextLabel", {
                        FontFace = gothamFont(Enum.FontWeight.Medium), Text = imageConfig.Caption, TextColor3 = Color3.fromRGB(95, 95, 95), TextSize = 11.5 * mobileScaleFactor,
                        BackgroundTransparency = 1, Position = UDim2.new(0, 0, 0, currentY + imageHeight + 3 * mobileScaleFactor), Size = UDim2.new(1, 0, 0, 14 * mobileScaleFactor),
                        TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = imageObj.frame
                    })
                end
                function imageObj:SetCaption(text) if imageObj.caption then imageObj.caption.Text = tostring(text) end end

                groupObj.elementYPos = groupObj.elementYPos + totalHeight + 8 * mobileScaleFactor
                updateGroupSizeYay()
                table.insert(groupObj.elementsInGroup, imageObj)
                return imageObj
            end

            -- table / leaderboard (sortable headers, rank medals, highlighted rows, live row updates)
            function groupObj:AddTable(tableConfig)
                tableConfig = tableConfig or {}
                local accentColor = groupObj.Library.config.AccentColor
                local hasName = type(tableConfig.Name) == "string" and tableConfig.Name ~= ""
                local hasDesc = type(tableConfig.Desc) == "string" and tableConfig.Desc ~= ""
                if hasName then addSearchTerm(tableConfig.Name) end
                local columns = {}
                for index, column in ipairs(tableConfig.Columns or {"Column"}) do
                    if type(column) == "string" then column = {Name = column} end
                    columns[index] = {Name = tostring(column.Name or ("Column " .. index)), Align = column.Align or "Left", Width = column.Width, Format = column.Format}
                end
                local tableObj = {Columns = columns, Rows = {}}
                local rowHeight = 24 * mobileScaleFactor
                local headerHeight = 24 * mobileScaleFactor
                local maxRows = tableConfig.MaxRows or 6
                local yPosition = groupObj.elementYPos
                local totalWidth = groupObj.elementWidth
                local rankWidth = tableConfig.Rank and (30 * mobileScaleFactor) or 0
                local topOffset = (hasName and 20 * mobileScaleFactor or 0) + (hasDesc and 15 * mobileScaleFactor or 0)

                -- column geometry
                local available = totalWidth - rankWidth
                local specifiedFraction, unspecified = 0, 0
                for _, column in ipairs(columns) do
                    if column.Width then specifiedFraction = specifiedFraction + column.Width else unspecified = unspecified + 1 end
                end
                local leftover = math.max(0.05, 1 - specifiedFraction)
                local cursor = rankWidth
                for _, column in ipairs(columns) do
                    local fraction = column.Width or (leftover / math.max(unspecified, 1))
                    column.x = cursor
                    column.w = available * fraction
                    cursor = cursor + column.w
                end
                local function alignOf(column)
                    if column.Align == "Right" then return Enum.TextXAlignment.Right elseif column.Align == "Center" then return Enum.TextXAlignment.Center end
                    return Enum.TextXAlignment.Left
                end

                tableObj.frame = makeThingExist("Frame", {BackgroundTransparency = 1, Position = UDim2.new(0, 10, 0, yPosition), Size = UDim2.new(0, totalWidth, 0, 100), Parent = groupObj.mainFrame})
                if hasName then
                    makeThingExist("TextLabel", {
                        FontFace = gothamFont(), Text = tableConfig.Name, TextColor3 = Color3.fromRGB(124, 124, 124), TextSize = 14 * mobileScaleFactor, BackgroundTransparency = 1,
                        Size = UDim2.new(1, 0, 0, 18 * mobileScaleFactor), TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = tableObj.frame
                    })
                end
                if hasDesc then
                    makeThingExist("TextLabel", {
                        FontFace = gothamFont(Enum.FontWeight.Medium), Text = tableConfig.Desc, TextColor3 = Color3.fromRGB(88, 88, 88), TextSize = 11.5 * mobileScaleFactor, BackgroundTransparency = 1,
                        Position = UDim2.new(0, 0, 0, 17 * mobileScaleFactor), Size = UDim2.new(1, 0, 0, 14 * mobileScaleFactor), TextXAlignment = Enum.TextXAlignment.Left, Parent = tableObj.frame
                    })
                end
                local box = makeThingExist("Frame", {
                    BackgroundColor3 = Color3.fromRGB(20, 20, 20), ClipsDescendants = true, Position = UDim2.new(0, 0, 0, topOffset),
                    Size = UDim2.new(1, 0, 0, headerHeight + rowHeight), Parent = tableObj.frame
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(0, 7), Parent = box})
                makeThingExist("UIStroke", {Color = Color3.fromRGB(38, 38, 38), Parent = box})
                local headerFrame = makeThingExist("Frame", {BackgroundColor3 = Color3.fromRGB(26, 26, 26), Size = UDim2.new(1, 0, 0, headerHeight), Parent = box})
                if tableConfig.Rank then
                    makeThingExist("TextLabel", {
                        FontFace = gothamFont(Enum.FontWeight.Bold), Text = "#", TextColor3 = Color3.fromRGB(120, 120, 120), TextSize = 11.5 * mobileScaleFactor, BackgroundTransparency = 1,
                        Size = UDim2.new(0, rankWidth, 1, 0), Parent = headerFrame
                    })
                end
                local sortColumn, sortDirection = nil, nil
                if tableConfig.SortBy then
                    for index, column in ipairs(columns) do if column.Name == tableConfig.SortBy then sortColumn = index; sortDirection = "desc" end end
                end
                local rowsScroll = makeThingExist("ScrollingFrame", {
                    BackgroundTransparency = 1, Position = UDim2.new(0, 0, 0, headerHeight), Size = UDim2.new(1, 0, 0, rowHeight),
                    CanvasSize = UDim2.new(0, 0, 0, 0), ScrollBarThickness = 0, ScrollBarImageColor3 = accentColor,
                    ScrollingDirection = Enum.ScrollingDirection.Y, BorderSizePixel = 0, Parent = box
                })
                groupObj.Library:EnableSmoothScrolling(rowsScroll, 20)
                local headerLabels = {}
                local renderRows

                for index, column in ipairs(columns) do
                    local headerButton = makeThingExist("TextButton", {
                        FontFace = gothamFont(Enum.FontWeight.Bold), Text = column.Name, TextColor3 = Color3.fromRGB(150, 150, 150), TextSize = 11.5 * mobileScaleFactor,
                        BackgroundTransparency = 1, AutoButtonColor = false, TextXAlignment = alignOf(column),
                        Position = UDim2.new(0, column.x + 6, 0, 0), Size = UDim2.new(0, column.w - 12, 1, 0), TextTruncate = Enum.TextTruncate.AtEnd, Parent = headerFrame
                    })
                    headerLabels[index] = headerButton
                    headerButton.MouseButton1Click:Connect(function()
                        if sortColumn ~= index then sortColumn = index; sortDirection = "asc"
                        elseif sortDirection == "asc" then sortDirection = "desc"
                        else sortColumn = nil; sortDirection = nil end
                        renderRows()
                    end)
                end

                local function medalColor(rank)
                    if rank == 1 then return Color3.fromRGB(255, 200, 66) elseif rank == 2 then return Color3.fromRGB(196, 202, 214) elseif rank == 3 then return Color3.fromRGB(205, 127, 80) end
                    return Color3.fromRGB(110, 110, 110)
                end

                local rowFrames = {}
                local function updateHeight(animate)
                    local visibleRows = math.min(math.max(#tableObj.Rows, 1), maxRows)
                    local boxHeight = headerHeight + rowHeight * visibleRows
                    box.Size = UDim2.new(1, 0, 0, boxHeight)
                    rowsScroll.Size = UDim2.new(1, 0, 0, rowHeight * visibleRows)
                    rowsScroll.CanvasSize = UDim2.new(0, 0, 0, rowHeight * #tableObj.Rows)
                    local newTotal = topOffset + boxHeight
                    local oldTotal = tableObj._totalHeight
                    tableObj.frame.Size = UDim2.new(0, totalWidth, 0, newTotal)
                    if oldTotal and oldTotal ~= newTotal then
                        groupObj:_ShiftBelow(yPosition + oldTotal - 2, newTotal - oldTotal)
                    end
                    tableObj._totalHeight = newTotal
                end

                renderRows = function()
                    for _, frame in ipairs(rowFrames) do frame:Destroy() end
                    rowFrames = {}
                    local order = {}
                    for index = 1, #tableObj.Rows do order[index] = index end
                    if sortColumn then
                        table.sort(order, function(a, b)
                            local va, vb = tableObj.Rows[a][sortColumn], tableObj.Rows[b][sortColumn]
                            local result
                            if type(va) == "number" and type(vb) == "number" then result = va < vb else result = string.lower(tostring(va)) < string.lower(tostring(vb)) end
                            if va == vb then return a < b end
                            if sortDirection == "desc" then return not result end
                            return result
                        end)
                    end
                    for index, column in ipairs(columns) do
                        local arrow = (sortColumn == index) and (sortDirection == "asc" and "  ▲" or "  ▼") or ""
                        headerLabels[index].Text = column.Name .. arrow
                        headerLabels[index].TextColor3 = (sortColumn == index) and accentColor:Lerp(Color3.new(1, 1, 1), 0.4) or Color3.fromRGB(150, 150, 150)
                    end
                    for displayIndex, rowIndex in ipairs(order) do
                        local row = tableObj.Rows[rowIndex]
                        local rowFrame = makeThingExist("TextButton", {
                            Text = "", AutoButtonColor = false,
                            BackgroundColor3 = row.Highlight and accentColor:Lerp(Color3.fromRGB(20, 20, 20), 0.7) or ((displayIndex % 2 == 0) and Color3.fromRGB(23, 23, 23) or Color3.fromRGB(20, 20, 20)),
                            BorderSizePixel = 0, Position = UDim2.new(0, 0, 0, (displayIndex - 1) * rowHeight), Size = UDim2.new(1, 0, 0, rowHeight), Parent = rowsScroll
                        })
                        if tableConfig.Rank then
                            makeThingExist("TextLabel", {
                                FontFace = gothamFont(Enum.FontWeight.Bold), Text = tostring(displayIndex), TextColor3 = medalColor(displayIndex), TextSize = 12 * mobileScaleFactor,
                                BackgroundTransparency = 1, Size = UDim2.new(0, rankWidth, 1, 0), Parent = rowFrame
                            })
                        end
                        for columnIndex, column in ipairs(columns) do
                            local value = row[columnIndex]
                            local text = value == nil and "" or tostring(value)
                            if column.Format and value ~= nil then local okFmt, formatted = pcall(column.Format, value); if okFmt then text = tostring(formatted) end end
                            makeThingExist("TextLabel", {
                                FontFace = gothamFont(row.Highlight and Enum.FontWeight.Bold or Enum.FontWeight.Medium), Text = text,
                                TextColor3 = row.Highlight and Color3.new(1, 1, 1) or Color3.fromRGB(170, 170, 170), TextSize = 12 * mobileScaleFactor, BackgroundTransparency = 1,
                                TextXAlignment = alignOf(column), TextTruncate = Enum.TextTruncate.AtEnd,
                                Position = UDim2.new(0, column.x + 6, 0, 0), Size = UDim2.new(0, column.w - 12, 1, 0), Parent = rowFrame
                            })
                        end
                        rowFrame.MouseEnter:Connect(function() smoothMoveGoWoosh(rowFrame, {BackgroundColor3 = Color3.fromRGB(34, 34, 34)}, 0.12) end)
                        rowFrame.MouseLeave:Connect(function()
                            smoothMoveGoWoosh(rowFrame, {BackgroundColor3 = row.Highlight and accentColor:Lerp(Color3.fromRGB(20, 20, 20), 0.7) or ((displayIndex % 2 == 0) and Color3.fromRGB(23, 23, 23) or Color3.fromRGB(20, 20, 20))}, 0.12)
                        end)
                        rowFrame.MouseButton1Click:Connect(function()
                            if type(tableConfig.Callback) == "function" then task.spawn(tableConfig.Callback, row, rowIndex) end
                        end)
                        table.insert(rowFrames, rowFrame)
                    end
                    updateHeight()
                end

                function tableObj:SetRows(rows) tableObj.Rows = rows or {}; renderRows() end
                function tableObj:AddRow(row) table.insert(tableObj.Rows, row); renderRows() end
                function tableObj:UpdateRow(index, row) if tableObj.Rows[index] then tableObj.Rows[index] = row; renderRows() end end
                function tableObj:RemoveRow(index) if tableObj.Rows[index] then table.remove(tableObj.Rows, index); renderRows() end end
                function tableObj:Clear() tableObj.Rows = {}; renderRows() end
                function tableObj:Sort(columnName, direction)
                    sortColumn, sortDirection = nil, nil
                    for index, column in ipairs(columns) do if column.Name == columnName then sortColumn = index; sortDirection = direction or "desc" end end
                    renderRows()
                end

                tableObj.Rows = tableConfig.Rows or {}
                renderRows()
                groupObj.elementYPos = groupObj.elementYPos + tableObj._totalHeight + 8 * mobileScaleFactor
                updateGroupSizeYay()
                table.insert(groupObj.elementsInGroup, tableObj)
                return tableObj
            end

            function groupObj:AddKeybind(keybindConfig)
                keybindConfig = keybindConfig or {}
                keybindConfig.Name = keybindConfig.Name or "Keybind"
                keybindConfig.Default = keybindConfig.Default or Enum.KeyCode.Unknown
                keybindConfig.Callback = keybindConfig.Callback or function() end
                keybindConfig.ChangedCallback = keybindConfig.ChangedCallback or function() end
                keybindConfig.ModeChangedCallback = keybindConfig.ModeChangedCallback or function() end
                keybindConfig.Mode = tostring(keybindConfig.Mode or "Toggle")
                keybindConfig.Flag = keybindConfig.Flag or createAutoFlag(keybindConfig.Name)
                keybindConfig.ModeFlag = keybindConfig.ModeFlag or createAutoFlag(keybindConfig.Name .. ".Mode")
                addSearchTerm(keybindConfig.Name)
                addSearchTerm("hold")
                addSearchTerm("toggle")
                
                local keybindObj = {}
                keybindObj.value = keybindConfig.Default
                keybindObj.mode = string.lower(keybindConfig.Mode) == "hold" and "Hold" or "Toggle"
                keybindObj.isListening = false
                keybindObj.holdActive = false
                local yPosition = groupObj.elementYPos
                
                keybindObj.labelText = makeThingExist("TextLabel", {
                    FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
                    TextColor3 = Color3.fromRGB(124, 124, 124), Text = keybindConfig.Name, BackgroundTransparency = 1,
                    Position = UDim2.new(0, 10, 0, yPosition), TextSize = 14 * mobileScaleFactor,
                    Size = UDim2.new(0, 145 * mobileScaleFactor, 0, 20 * mobileScaleFactor),
                    TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
                    Parent = groupObj.mainFrame
                })
                
                local function normalizeMode(modeValue)
                    return string.lower(tostring(modeValue or "toggle")) == "hold" and "Hold" or "Toggle"
                end
                
                local function getKeyText()
                    return keybindObj.value == Enum.KeyCode.Unknown and "None" or keybindObj.value.Name
                end
                
                local keyText = getKeyText()
                local keyWidth = math.max(48 * mobileScaleFactor, howWideIsThisText(keyText, 12 * mobileScaleFactor) + 30 * mobileScaleFactor)
                
                keybindObj.buttonFrame = makeThingExist("Frame", {
                    BackgroundColor3 = Color3.fromRGB(32, 32, 32), Position = UDim2.new(1, -keyWidth - 10, 0, yPosition),
                    Size = UDim2.new(0, keyWidth, 0, 21 * mobileScaleFactor), Active = true, Parent = groupObj.mainFrame
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(0, 8), Parent = keybindObj.buttonFrame})
                
                local keybindStrokeThing = makeThingExist("UIStroke", {Color = Color3.fromRGB(40, 40, 40), Parent = keybindObj.buttonFrame})
                makeThingExist("UIGradient", {
                    Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.new(1,1,1)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(150,150,150)), ColorSequenceKeypoint.new(1, Color3.new(1,1,1))}),
                    Rotation = 260, Parent = keybindStrokeThing
                })
                
                keybindObj.keyLabelText = makeThingExist("TextLabel", {
                    FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
                    TextColor3 = Color3.fromRGB(113, 113, 113), Text = keyText, BackgroundTransparency = 1,
                    Position = UDim2.new(0, 2, 0, 0), TextSize = 12 * mobileScaleFactor,
                    Size = UDim2.new(1, -24 * mobileScaleFactor, 1, 0), TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = keybindObj.buttonFrame
                })
                makeThingExist("UIPadding", {PaddingLeft = UDim.new(0, 2), Parent = keybindObj.keyLabelText})
                
                keybindObj.keyboardIconImg = makeThingExist("ImageLabel", {
                    ImageColor3 = Color3.fromRGB(76, 76, 76), Image = "rbxassetid://10723416765", BackgroundTransparency = 1,
                    Position = UDim2.new(1, -18 * mobileScaleFactor, 0.5, -7 * mobileScaleFactor),
                    Size = UDim2.new(0, 14 * mobileScaleFactor, 0, 14 * mobileScaleFactor), Parent = keybindObj.buttonFrame
                })
                
                local keybindClickButton = makeThingExist("TextButton", {Text = "", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), Active = true, Parent = keybindObj.buttonFrame})
                
                local modeMenuWidth = 120 * mobileScaleFactor
                local modeMenuHeight = 78 * mobileScaleFactor
                local modeMenuPositionConn = nil
                local modeMenuOutsideConn = nil
                keybindObj.isModeMenuOpen = false
                
                keybindObj.modeMenuFrame = makeThingExist("Frame", {
                    BackgroundColor3 = Color3.fromRGB(16, 16, 16),
                    Size = UDim2.new(0, modeMenuWidth, 0, 0),
                    ClipsDescendants = true,
                    Visible = false,
                    ZIndex = 9999,
                    Parent = groupObj.Library.dropdownHolderRef
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(0, 7), Parent = keybindObj.modeMenuFrame})
                makeThingExist("UIStroke", {Color = Color3.fromRGB(40, 40, 40), Parent = keybindObj.modeMenuFrame})
                
                makeThingExist("TextLabel", {
                    FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
                    Text = "Keybind Mode",
                    TextColor3 = Color3.new(1, 1, 1),
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 8, 0, 5 * mobileScaleFactor),
                    Size = UDim2.new(1, -16, 0, 16 * mobileScaleFactor),
                    TextSize = 12 * mobileScaleFactor,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 10000,
                    Parent = keybindObj.modeMenuFrame
                })
                
                local toggleModeFrame = makeThingExist("Frame", {
                    BackgroundColor3 = Color3.fromRGB(28, 28, 28),
                    Position = UDim2.new(0, 8, 0, 26 * mobileScaleFactor),
                    Size = UDim2.new(1, -16, 0, 20 * mobileScaleFactor),
                    ZIndex = 10000,
                    Parent = keybindObj.modeMenuFrame
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(0, 5), Parent = toggleModeFrame})
                
                local toggleModeLabel = makeThingExist("TextLabel", {
                    FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
                    Text = "Toggle",
                    TextColor3 = Color3.fromRGB(124, 124, 124),
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    TextSize = 12 * mobileScaleFactor,
                    ZIndex = 10001,
                    Parent = toggleModeFrame
                })
                
                local holdModeFrame = makeThingExist("Frame", {
                    BackgroundColor3 = Color3.fromRGB(28, 28, 28),
                    Position = UDim2.new(0, 8, 0, 50 * mobileScaleFactor),
                    Size = UDim2.new(1, -16, 0, 20 * mobileScaleFactor),
                    ZIndex = 10000,
                    Parent = keybindObj.modeMenuFrame
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(0, 5), Parent = holdModeFrame})
                
                local holdModeLabel = makeThingExist("TextLabel", {
                    FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
                    Text = "Hold",
                    TextColor3 = Color3.fromRGB(124, 124, 124),
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    TextSize = 12 * mobileScaleFactor,
                    ZIndex = 10001,
                    Parent = holdModeFrame
                })
                
                local toggleModeClickButton = makeThingExist("TextButton", {
                    Text = "",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    ZIndex = 10002,
                    Parent = toggleModeFrame
                })
                
                local holdModeClickButton = makeThingExist("TextButton", {
                    Text = "",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 1, 0),
                    ZIndex = 10002,
                    Parent = holdModeFrame
                })
                
                local function updateKeybindSizeYay(text)
                    local newWidth = math.max(48 * mobileScaleFactor, howWideIsThisText(text, 12 * mobileScaleFactor) + 30 * mobileScaleFactor)
                    smoothMoveGoWoosh(keybindObj.buttonFrame, {Size = UDim2.new(0, newWidth, 0, 21 * mobileScaleFactor), Position = UDim2.new(1, -newWidth - 10, 0, yPosition)}, 0.15)
                end
                
                local function updateModeVisuals()
                    local selectedBg = groupObj.Library.config.AccentColor:Lerp(Color3.fromRGB(16, 16, 16), 0.45)
                    local idleBg = Color3.fromRGB(28, 28, 28)
                    local selectedText = Color3.new(1, 1, 1)
                    local idleText = Color3.fromRGB(124, 124, 124)
                    local isToggleSelected = keybindObj.mode == "Toggle"
                    
                    smoothMoveGoWoosh(toggleModeFrame, {BackgroundColor3 = isToggleSelected and selectedBg or idleBg}, 0.12)
                    smoothMoveGoWoosh(toggleModeLabel, {TextColor3 = isToggleSelected and selectedText or idleText}, 0.12)
                    smoothMoveGoWoosh(holdModeFrame, {BackgroundColor3 = isToggleSelected and idleBg or selectedBg}, 0.12)
                    smoothMoveGoWoosh(holdModeLabel, {TextColor3 = isToggleSelected and idleText or selectedText}, 0.12)
                end
                
                local function updateModeMenuPositionYay()
                    local buttonAbsPos = keybindObj.buttonFrame.AbsolutePosition
                    local buttonAbsSize = keybindObj.buttonFrame.AbsoluteSize
                    keybindObj.modeMenuFrame.Position = UDim2.new(0, buttonAbsPos.X + buttonAbsSize.X - modeMenuWidth, 0, buttonAbsPos.Y + buttonAbsSize.Y + 5)
                end
                
                local function closeModeMenu(isInstant)
                    keybindObj.isModeMenuOpen = false
                    if modeMenuPositionConn then
                        modeMenuPositionConn:Disconnect()
                        modeMenuPositionConn = nil
                    end
                    if modeMenuOutsideConn then
                        modeMenuOutsideConn:Disconnect()
                        modeMenuOutsideConn = nil
                    end
                    if isInstant then
                        keybindObj.modeMenuFrame.Size = UDim2.new(0, modeMenuWidth, 0, 0)
                        keybindObj.modeMenuFrame.Visible = false
                        return
                    end
                    smoothMoveGoWoosh(keybindObj.modeMenuFrame, {Size = UDim2.new(0, modeMenuWidth, 0, 0)}, 0.18, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
                    task.delay(0.18, function()
                        if keybindObj.modeMenuFrame and keybindObj.modeMenuFrame.Parent and not keybindObj.isModeMenuOpen then
                            keybindObj.modeMenuFrame.Visible = false
                        end
                    end)
                end
                
                local function openModeMenu()
                    if keybindObj.isListening then return end
                    keybindObj.isModeMenuOpen = true
                    updateModeVisuals()
                    updateModeMenuPositionYay()
                    keybindObj.modeMenuFrame.Visible = true
                    smoothMoveGoWoosh(keybindObj.modeMenuFrame, {Size = UDim2.new(0, modeMenuWidth, 0, modeMenuHeight)}, 0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
                    
                    if modeMenuPositionConn then modeMenuPositionConn:Disconnect() end
                    modeMenuPositionConn = groupObj.Library:_TrackConnection(runServiceMoreLikeWalkService.RenderStepped:Connect(function()
                        if keybindObj.isModeMenuOpen then
                            updateModeMenuPositionYay()
                        elseif modeMenuPositionConn then
                            modeMenuPositionConn:Disconnect()
                            modeMenuPositionConn = nil
                        end
                    end))
                    
                    if modeMenuOutsideConn then modeMenuOutsideConn:Disconnect() end
                    modeMenuOutsideConn = groupObj.Library:_TrackConnection(thisInputServiceGoesHard.InputBegan:Connect(function(input)
                        if not keybindObj.isModeMenuOpen then return end
                        local isPress = input.UserInputType == Enum.UserInputType.MouseButton1
                            or input.UserInputType == Enum.UserInputType.MouseButton2
                            or input.UserInputType == Enum.UserInputType.Touch
                        if not isPress then return end
                        
                        local mousePos = input.Position
                        local menuPos = keybindObj.modeMenuFrame.AbsolutePosition
                        local menuSize = keybindObj.modeMenuFrame.AbsoluteSize
                        local buttonPos = keybindObj.buttonFrame.AbsolutePosition
                        local buttonSize = keybindObj.buttonFrame.AbsoluteSize
                        
                        local insideMenu = mousePos.X >= menuPos.X and mousePos.X <= (menuPos.X + menuSize.X)
                            and mousePos.Y >= menuPos.Y and mousePos.Y <= (menuPos.Y + menuSize.Y)
                        local insideButton = mousePos.X >= buttonPos.X and mousePos.X <= (buttonPos.X + buttonSize.X)
                            and mousePos.Y >= buttonPos.Y and mousePos.Y <= (buttonPos.Y + buttonSize.Y)
                        
                        if not insideMenu and not insideButton then
                            closeModeMenu(false)
                        end
                    end))
                end
                
                local function toggleModeMenu()
                    if keybindObj.isModeMenuOpen then
                        closeModeMenu(false)
                    else
                        openModeMenu()
                    end
                end
                
                local function setMode(modeValue, silent)
                    local newMode = normalizeMode(modeValue)
                    if newMode == keybindObj.mode then
                        updateModeVisuals()
                        return
                    end
                    if keybindObj.holdActive then
                        keybindObj.holdActive = false
                        keybindConfig.Callback(false)
                    end
                    keybindObj.mode = newMode
                    updateModeVisuals()
                    keybindConfig.ModeChangedCallback(newMode)
                    if not silent then
                        groupObj.Library:Notify({
                            Title = keybindConfig.Name .. " mode updated",
                            Description = "Now using " .. newMode .. " input",
                            Duration = 2.2,
                            Icon = "rbxassetid://6031075938"
                        })
                    end
                end
                
                function keybindObj:Set(key)
                    if keybindObj.holdActive then
                        keybindObj.holdActive = false
                        keybindConfig.Callback(false)
                    end
                    keybindObj.value = key
                    local newKeyText = getKeyText()
                    keybindObj.keyLabelText.Text = newKeyText
                    updateKeybindSizeYay(newKeyText)
                    keybindConfig.ChangedCallback(key)
                end

                function keybindObj:Get()
                    return keybindObj.value
                end
                
                function keybindObj:SetMode(modeValue, silent)
                    setMode(modeValue, silent)
                end
                
                function keybindObj:GetMode()
                    return keybindObj.mode
                end
                
                function keybindObj:Close()
                    keybindObj.isListening = false
                    if keybindObj.holdActive then
                        keybindObj.holdActive = false
                        keybindConfig.Callback(false)
                    end
                    closeModeMenu(true)
                end
                
                keybindClickButton.MouseButton1Click:Connect(function()
                    closeModeMenu(true)
                    keybindObj.isListening = true
                    keybindObj.keyLabelText.Text = "..."
                    updateKeybindSizeYay("...")
                    smoothMoveGoWoosh(keybindObj.buttonFrame, {BackgroundColor3 = Color3.fromRGB(48, 48, 48)}, 0.2)
                end)
                
                local modeMenuToggleDebounceAt = 0
                local function toggleModeMenuFromRightClick()
                    if keybindObj.isListening then
                        return
                    end
                    local now = os.clock()
                    if now - modeMenuToggleDebounceAt < 0.12 then
                        return
                    end
                    modeMenuToggleDebounceAt = now
                    toggleModeMenu()
                end
                
                keybindClickButton.MouseButton2Click:Connect(toggleModeMenuFromRightClick)
                keybindClickButton.InputBegan:Connect(function(input)
                    if input.UserInputType ~= Enum.UserInputType.MouseButton2 then
                        return
                    end
                    toggleModeMenuFromRightClick()
                end)
                
                toggleModeClickButton.MouseButton1Click:Connect(function()
                    setMode("Toggle", false)
                    closeModeMenu(false)
                end)
                
                holdModeClickButton.MouseButton1Click:Connect(function()
                    setMode("Hold", false)
                    closeModeMenu(false)
                end)
                
                groupObj.Library:_TrackConnection(thisInputServiceGoesHard.InputBegan:Connect(function(input, gameProcessed)
                    if keybindObj.isListening then
                        if input.UserInputType == Enum.UserInputType.Keyboard then
                            keybindObj.isListening = false
                            local pickedKey = input.KeyCode
                            if pickedKey == Enum.KeyCode.Backspace or pickedKey == Enum.KeyCode.Delete then
                                pickedKey = Enum.KeyCode.Unknown
                            end
                            keybindObj:Set(pickedKey)
                            smoothMoveGoWoosh(keybindObj.buttonFrame, {BackgroundColor3 = Color3.fromRGB(32, 32, 32)}, 0.2)
                        end
                    elseif not gameProcessed and input.UserInputType == Enum.UserInputType.Keyboard then
                        if input.KeyCode == keybindObj.value and keybindObj.value ~= Enum.KeyCode.Unknown then
                            if keybindObj.mode == "Hold" then
                                if not keybindObj.holdActive then
                                    keybindObj.holdActive = true
                                    keybindConfig.Callback(true)
                                end
                            else
                                keybindConfig.Callback()
                            end
                        end
                    end
                end))
                
                groupObj.Library:_TrackConnection(thisInputServiceGoesHard.InputEnded:Connect(function(input)
                    if keybindObj.mode == "Hold" and keybindObj.holdActive and input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == keybindObj.value then
                        keybindObj.holdActive = false
                        keybindConfig.Callback(false)
                    end
                end))
                
                keybindClickButton.MouseEnter:Connect(function()
                    if not keybindObj.isListening then smoothMoveGoWoosh(keybindObj.buttonFrame, {BackgroundColor3 = Color3.fromRGB(48, 48, 48)}, 0.2) end
                end)
                keybindClickButton.MouseLeave:Connect(function()
                    if not keybindObj.isListening then smoothMoveGoWoosh(keybindObj.buttonFrame, {BackgroundColor3 = Color3.fromRGB(32, 32, 32)}, 0.2) end
                end)
                
                toggleModeClickButton.MouseEnter:Connect(function()
                    if keybindObj.mode ~= "Toggle" then
                        smoothMoveGoWoosh(toggleModeFrame, {BackgroundColor3 = Color3.fromRGB(42, 42, 42)}, 0.12)
                    end
                end)
                toggleModeClickButton.MouseLeave:Connect(function()
                    updateModeVisuals()
                end)
                holdModeClickButton.MouseEnter:Connect(function()
                    if keybindObj.mode ~= "Hold" then
                        smoothMoveGoWoosh(holdModeFrame, {BackgroundColor3 = Color3.fromRGB(42, 42, 42)}, 0.12)
                    end
                end)
                holdModeClickButton.MouseLeave:Connect(function()
                    updateModeVisuals()
                end)
                
                groupObj.Library:RegisterControl(keybindConfig.Flag, function()
                    return keybindObj:Get()
                end, function(value)
                    if typeof(value) == "EnumItem" and value.EnumType == Enum.KeyCode then
                        keybindObj:Set(value)
                    end
                end)
                groupObj.Library:RegisterControl(keybindConfig.ModeFlag, function()
                    return keybindObj:GetMode()
                end, function(value)
                    keybindObj:SetMode(value, true)
                end)
                
                groupObj.elementYPos = groupObj.elementYPos + 28 * mobileScaleFactor
                updateGroupSizeYay()
                table.insert(groupObj.elementsInGroup, keybindObj)
                return keybindObj
            end

            function groupObj:AddKeybindToggle(keybindToggleConfig)
                keybindToggleConfig = keybindToggleConfig or {}
                keybindToggleConfig.Name = keybindToggleConfig.Name or "Keybind Toggle"
                keybindToggleConfig.Default = keybindToggleConfig.Default or Enum.KeyCode.Unknown
                keybindToggleConfig.ToggleDefault = keybindToggleConfig.ToggleDefault or false
                keybindToggleConfig.Callback = keybindToggleConfig.Callback or function() end
                keybindToggleConfig.ToggleCallback = keybindToggleConfig.ToggleCallback or function() end
                keybindToggleConfig.ChangedCallback = keybindToggleConfig.ChangedCallback or function() end
                keybindToggleConfig.Flag = keybindToggleConfig.Flag or createAutoFlag(keybindToggleConfig.Name .. ".Key")
                keybindToggleConfig.ToggleFlag = keybindToggleConfig.ToggleFlag or createAutoFlag(keybindToggleConfig.Name .. ".Enabled")
                addSearchTerm(keybindToggleConfig.Name)
                
                local keybindToggleObj = {}
                keybindToggleObj.keyValue = keybindToggleConfig.Default
                keybindToggleObj.toggleValue = keybindToggleConfig.ToggleDefault
                keybindToggleObj.isListening = false
                local yPosition = groupObj.elementYPos
                
                keybindToggleObj.labelText = makeThingExist("TextLabel", {
                    FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
                    TextColor3 = Color3.fromRGB(124, 124, 124), Text = keybindToggleConfig.Name, BackgroundTransparency = 1,
                    Position = UDim2.new(0, 10, 0, yPosition), TextSize = 14 * mobileScaleFactor,
                    Size = UDim2.new(0, 115 * mobileScaleFactor, 0, 20 * mobileScaleFactor),
                    TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
                    Parent = groupObj.mainFrame
                })
                
                local keyText = keybindToggleObj.keyValue == Enum.KeyCode.Unknown and "None" or keybindToggleObj.keyValue.Name
                local keyWidth = math.max(48 * mobileScaleFactor, howWideIsThisText(keyText, 12 * mobileScaleFactor) + 30 * mobileScaleFactor)
                
                keybindToggleObj.keybindButtonFrame = makeThingExist("Frame", {
                    BackgroundColor3 = Color3.fromRGB(32, 32, 32), Position = UDim2.new(1, -keyWidth - 10, 0, yPosition),
                    Size = UDim2.new(0, keyWidth, 0, 21 * mobileScaleFactor), Parent = groupObj.mainFrame
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(0, 8), Parent = keybindToggleObj.keybindButtonFrame})
                
                local keybindStrokeThing = makeThingExist("UIStroke", {Color = Color3.fromRGB(40, 40, 40), Parent = keybindToggleObj.keybindButtonFrame})
                
                keybindToggleObj.keyLabelText = makeThingExist("TextLabel", {
                    FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
                    TextColor3 = Color3.fromRGB(113, 113, 113), Text = keyText, BackgroundTransparency = 1,
                    Position = UDim2.new(0, 6, 0, 0), TextSize = 12 * mobileScaleFactor,
                    Size = UDim2.new(1, -24 * mobileScaleFactor, 1, 0), TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = keybindToggleObj.keybindButtonFrame
                })
                
                keybindToggleObj.keyboardIconImg = makeThingExist("ImageLabel", {
                    ImageColor3 = Color3.fromRGB(76, 76, 76), Image = "rbxassetid://10723416765", BackgroundTransparency = 1,
                    Position = UDim2.new(1, -18 * mobileScaleFactor, 0.5, -7 * mobileScaleFactor),
                    Size = UDim2.new(0, 14 * mobileScaleFactor, 0, 14 * mobileScaleFactor), Parent = keybindToggleObj.keybindButtonFrame
                })
                
                keybindToggleObj.toggleSwitchFrame = makeThingExist("Frame", {
                    BackgroundColor3 = keybindToggleObj.toggleValue and groupObj.Library.config.AccentColor or Color3.fromRGB(32, 32, 32),
                    Position = UDim2.new(1, -keyWidth - 48 * mobileScaleFactor, 0, yPosition),
                    Size = UDim2.new(0, 34 * mobileScaleFactor, 0, 21 * mobileScaleFactor), Parent = groupObj.mainFrame
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = keybindToggleObj.toggleSwitchFrame})
                
                keybindToggleObj.toggleCircleFrame = makeThingExist("Frame", {
                    BackgroundColor3 = keybindToggleObj.toggleValue and Color3.new(1, 1, 1) or Color3.fromRGB(75, 75, 75),
                    Position = keybindToggleObj.toggleValue and UDim2.new(0.462, 0, 0.143, 0) or UDim2.new(0.0104, 0, 0.143, 0),
                    Size = UDim2.new(0, 15 * mobileScaleFactor, 0, 15 * mobileScaleFactor), Parent = keybindToggleObj.toggleSwitchFrame
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = keybindToggleObj.toggleCircleFrame})
                
                local toggleClickButton = makeThingExist("TextButton", {Text = "", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), Parent = keybindToggleObj.toggleSwitchFrame})
                local keybindClickButton = makeThingExist("TextButton", {Text = "", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), Parent = keybindToggleObj.keybindButtonFrame})
                
                function keybindToggleObj:SetToggle(value)
                    keybindToggleObj.toggleValue = value
                    if value then
                        smoothMoveGoWoosh(keybindToggleObj.toggleSwitchFrame, {BackgroundColor3 = groupObj.Library.config.AccentColor}, 0.2)
                        smoothMoveGoWoosh(keybindToggleObj.toggleCircleFrame, {Position = UDim2.new(0.462, 0, 0.143, 0), BackgroundColor3 = Color3.new(1, 1, 1)}, 0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
                    else
                        smoothMoveGoWoosh(keybindToggleObj.toggleSwitchFrame, {BackgroundColor3 = Color3.fromRGB(32, 32, 32)}, 0.2)
                        smoothMoveGoWoosh(keybindToggleObj.toggleCircleFrame, {Position = UDim2.new(0.0104, 0, 0.143, 0), BackgroundColor3 = Color3.fromRGB(75, 75, 75)}, 0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
                    end
                    keybindToggleConfig.ToggleCallback(value)
                end
                
                local function updateKeybindSizeYay(text)
                    local newWidth = math.max(48 * mobileScaleFactor, howWideIsThisText(text, 12 * mobileScaleFactor) + 30 * mobileScaleFactor)
                    smoothMoveGoWoosh(keybindToggleObj.keybindButtonFrame, {Size = UDim2.new(0, newWidth, 0, 21 * mobileScaleFactor), Position = UDim2.new(1, -newWidth - 10, 0, yPosition)}, 0.15)
                    smoothMoveGoWoosh(keybindToggleObj.toggleSwitchFrame, {Position = UDim2.new(1, -newWidth - 48 * mobileScaleFactor, 0, yPosition)}, 0.15)
                end
                
                function keybindToggleObj:SetKey(key)
                    keybindToggleObj.keyValue = key
                    local keyText = key == Enum.KeyCode.Unknown and "None" or key.Name
                    keybindToggleObj.keyLabelText.Text = keyText
                    updateKeybindSizeYay(keyText)
                    keybindToggleConfig.ChangedCallback(key)
                end

                function keybindToggleObj:GetKey()
                    return keybindToggleObj.keyValue
                end

                function keybindToggleObj:GetToggle()
                    return keybindToggleObj.toggleValue
                end
                
                toggleClickButton.MouseButton1Click:Connect(function() keybindToggleObj:SetToggle(not keybindToggleObj.toggleValue) end)
                keybindClickButton.MouseButton1Click:Connect(function()
                    keybindToggleObj.isListening = true
                    keybindToggleObj.keyLabelText.Text = "..."
                    updateKeybindSizeYay("...")
                    smoothMoveGoWoosh(keybindToggleObj.keybindButtonFrame, {BackgroundColor3 = Color3.fromRGB(48, 48, 48)}, 0.2)
                end)
                
                groupObj.Library:_TrackConnection(thisInputServiceGoesHard.InputBegan:Connect(function(input, gameProcessed)
                    if keybindToggleObj.isListening then
                        if input.UserInputType == Enum.UserInputType.Keyboard then
                            keybindToggleObj.isListening = false
                            keybindToggleObj:SetKey(input.KeyCode)
                            smoothMoveGoWoosh(keybindToggleObj.keybindButtonFrame, {BackgroundColor3 = Color3.fromRGB(32, 32, 32)}, 0.2)
                        end
                    elseif not gameProcessed and input.UserInputType == Enum.UserInputType.Keyboard then
                        if input.KeyCode == keybindToggleObj.keyValue and keybindToggleObj.toggleValue then
                            keybindToggleConfig.Callback()
                        end
                    end
                end))
                
                keybindClickButton.MouseEnter:Connect(function() if not keybindToggleObj.isListening then smoothMoveGoWoosh(keybindToggleObj.keybindButtonFrame, {BackgroundColor3 = Color3.fromRGB(48, 48, 48)}, 0.2) end end)
                keybindClickButton.MouseLeave:Connect(function() if not keybindToggleObj.isListening then smoothMoveGoWoosh(keybindToggleObj.keybindButtonFrame, {BackgroundColor3 = Color3.fromRGB(32, 32, 32)}, 0.2) end end)
                
                if keybindToggleConfig.ToggleDefault then keybindToggleConfig.ToggleCallback(true) end
                groupObj.Library:RegisterControl(keybindToggleConfig.Flag, function()
                    return keybindToggleObj:GetKey()
                end, function(value)
                    if typeof(value) == "EnumItem" and value.EnumType == Enum.KeyCode then
                        keybindToggleObj:SetKey(value)
                    end
                end)
                groupObj.Library:RegisterControl(keybindToggleConfig.ToggleFlag, function()
                    return keybindToggleObj:GetToggle()
                end, function(value)
                    keybindToggleObj:SetToggle(value == true)
                end)
                groupObj.elementYPos = groupObj.elementYPos + 28 * mobileScaleFactor
                updateGroupSizeYay()
                table.insert(groupObj.elementsInGroup, keybindToggleObj)
                return keybindToggleObj
            end
            -- ==========================================
            -- [KODE BARU: DROPDOWN DENGAN FITUR SEARCH & NO RESULT]
            -- ==========================================
            function groupObj:AddDropdown(dropdownConfig)
                dropdownConfig = dropdownConfig or {}
                dropdownConfig.Name = dropdownConfig.Name or "Dropdown"
                dropdownConfig.Options = dropdownConfig.Options or {"Option 1", "Option 2", "Option 3"}
                dropdownConfig.Default = dropdownConfig.Default or dropdownConfig.Options[1]
                dropdownConfig.Callback = dropdownConfig.Callback or function() end
                dropdownConfig.Flag = dropdownConfig.Flag or createAutoFlag(dropdownConfig.Name)
                addSearchTerm(dropdownConfig.Name)
                for _, option in ipairs(dropdownConfig.Options) do
                    addSearchTerm(option)
                end
                
                local dropdownObj = {}
                dropdownObj.value = dropdownConfig.Default
                dropdownObj.isOpen = false
                local yPosition = groupObj.elementYPos
                
                dropdownObj.labelText = makeThingExist("TextLabel", {
                    FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
                    TextColor3 = Color3.fromRGB(124, 124, 124), Text = dropdownConfig.Name, BackgroundTransparency = 1,
                    Position = UDim2.new(0, 10, 0, yPosition), TextSize = 13 * mobileScaleFactor,
                    Size = UDim2.new(0, 130 * mobileScaleFactor, 0, 20 * mobileScaleFactor),
                    TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = groupObj.mainFrame
                })
                
                local displayText = dropdownObj.value or "None"
                local buttonWidth = math.max(70 * mobileScaleFactor, howWideIsThisText(displayText, 12 * mobileScaleFactor) + 30 * mobileScaleFactor)
                
                dropdownObj.buttonFrame = makeThingExist("Frame", {
                    BackgroundColor3 = Color3.fromRGB(32, 32, 32), Position = UDim2.new(1, -buttonWidth - 10, 0, yPosition),
                    Size = UDim2.new(0, buttonWidth, 0, 21 * mobileScaleFactor), Parent = groupObj.mainFrame
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(0, 8), Parent = dropdownObj.buttonFrame})
                
                local dropdownStrokeThing = makeThingExist("UIStroke", {Color = Color3.fromRGB(44, 44, 44), Parent = dropdownObj.buttonFrame})
                
                dropdownObj.selectedLabelText = makeThingExist("TextLabel", {
                    FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
                    TextColor3 = Color3.fromRGB(84, 84, 84), Text = displayText, BackgroundTransparency = 1,
                    Position = UDim2.new(0, 8, 0, 0), TextSize = 12 * mobileScaleFactor,
                    Size = UDim2.new(1, -28 * mobileScaleFactor, 1, 0), TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd, Parent = dropdownObj.buttonFrame
                })
                
                dropdownObj.arrowImg = makeThingExist("ImageLabel", {
                    ImageColor3 = Color3.fromRGB(80, 80, 80), Image = "rbxassetid://111626678408582", BackgroundTransparency = 1,
                    Position = UDim2.new(1, -20 * mobileScaleFactor, 0.5, -7 * mobileScaleFactor),
                    Size = UDim2.new(0, 14 * mobileScaleFactor, 0, 14 * mobileScaleFactor), Parent = dropdownObj.buttonFrame
                })
                
                dropdownObj.optionHolderFrame = makeThingExist("Frame", {
                    BackgroundColor3 = Color3.fromRGB(16, 16, 16), Size = UDim2.new(0, 140 * mobileScaleFactor, 0, 0),
                    ClipsDescendants = true, Visible = false, ZIndex = 9999, Parent = groupObj.Library.dropdownHolderRef
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(0, 6), Parent = dropdownObj.optionHolderFrame})
                makeThingExist("UIStroke", {Color = Color3.fromRGB(40, 40, 40), Parent = dropdownObj.optionHolderFrame})
                
                makeThingExist("TextLabel", {
                    FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
                    TextColor3 = Color3.new(1, 1, 1), Text = dropdownConfig.Name, BackgroundTransparency = 1,
                    Position = UDim2.new(0, 12, 0, 8 * mobileScaleFactor), TextSize = 14 * mobileScaleFactor,
                    Size = UDim2.new(1, -44 * mobileScaleFactor, 0, 20 * mobileScaleFactor), TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 10000, Parent = dropdownObj.optionHolderFrame
                })

                local dropdownCloseButton = makeThingExist("TextButton", {
                    FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold),
                    Text = "X", TextColor3 = Color3.fromRGB(170, 170, 170), TextSize = 14 * mobileScaleFactor,
                    BackgroundColor3 = Color3.fromRGB(24, 24, 24), AutoButtonColor = false,
                    Position = UDim2.new(1, -25 * mobileScaleFactor, 0, 5 * mobileScaleFactor),
                    Size = UDim2.new(0, 18 * mobileScaleFactor, 0, 18 * mobileScaleFactor),
                    ZIndex = 10002, Parent = dropdownObj.optionHolderFrame
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = dropdownCloseButton})
                
                -- KOTAK SEARCH UNTUK DROPDOWN BIASA
                dropdownObj.searchFrame = makeThingExist("Frame", {
                    BackgroundColor3 = Color3.fromRGB(22, 22, 22), Position = UDim2.new(0, 10, 0, 32 * mobileScaleFactor),
                    Size = UDim2.new(1, -20, 0, 22 * mobileScaleFactor), ZIndex = 10001, Parent = dropdownObj.optionHolderFrame
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(0, 6), Parent = dropdownObj.searchFrame})
                makeThingExist("UIStroke", {Color = Color3.fromRGB(44, 44, 44), Parent = dropdownObj.searchFrame})
                
                makeThingExist("ImageLabel", {
                    Image = "rbxassetid://10734943674", ImageColor3 = Color3.fromRGB(120, 120, 120),
                    BackgroundTransparency = 1, Position = UDim2.new(0, 6, 0.5, -6 * mobileScaleFactor),
                    Size = UDim2.new(0, 12 * mobileScaleFactor, 0, 12 * mobileScaleFactor), ZIndex = 10002, Parent = dropdownObj.searchFrame
                })
                
                dropdownObj.searchBox = makeThingExist("TextBox", {
                    FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
                    Text = "", PlaceholderText = "Search...", PlaceholderColor3 = Color3.fromRGB(100, 100, 100),
                    TextColor3 = Color3.fromRGB(210, 210, 210), TextSize = 11.5 * mobileScaleFactor,
                    BackgroundTransparency = 1, ClearTextOnFocus = false,
                    Position = UDim2.new(0, 22 * mobileScaleFactor, 0, 0), Size = UDim2.new(1, -24 * mobileScaleFactor, 1, 0),
                    TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 10002, Parent = dropdownObj.searchFrame
                })
                
                dropdownObj.optionScrollFrame = makeThingExist("ScrollingFrame", {
                    BackgroundTransparency = 1, Position = UDim2.new(0, 0, 0, 62 * mobileScaleFactor),
                    Size = UDim2.new(1, 0, 1, -67 * mobileScaleFactor), ScrollBarThickness = 0,
                    ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80), CanvasSize = UDim2.new(0, 0, 0, 0),
                    ZIndex = 10000, Parent = dropdownObj.optionHolderFrame
                })
                groupObj.Library:EnableSmoothScrolling(dropdownObj.optionScrollFrame, 22)
                
                dropdownObj.optionContainerFrame = makeThingExist("Frame", {
                    BackgroundTransparency = 1, Size = UDim2.new(1, -6, 0, 0),
                    ZIndex = 10000, Parent = dropdownObj.optionScrollFrame
                })

                local dropdownListLayout = makeThingExist("UIListLayout", {
                    Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder,
                    Parent = dropdownObj.optionContainerFrame
                })
                groupObj.Library:_TrackConnection(dropdownListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    local contentHeight = dropdownListLayout.AbsoluteContentSize.Y
                    dropdownObj.optionContainerFrame.Size = UDim2.new(1, -6, 0, contentHeight)
                    dropdownObj.optionScrollFrame.CanvasSize = UDim2.new(0, 0, 0, contentHeight)
                end))

                -- [KODE BARU] Teks "Tidak ada" (No Results Found)
                dropdownObj.noResultLabel = makeThingExist("TextLabel", {
                    FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium),
                    TextColor3 = Color3.fromRGB(150, 80, 80), Text = "🚫 No Results", BackgroundTransparency = 1,
                    Position = UDim2.new(0, 0, 0, 65 * mobileScaleFactor), Size = UDim2.new(1, 0, 0, 20 * mobileScaleFactor),
                    TextSize = 12 * mobileScaleFactor, Visible = false, ZIndex = 10001, Parent = dropdownObj.optionHolderFrame
                })
                
                local maxDropdownHeight = 240 * mobileScaleFactor
                local dropdownPositionUpdateConn = nil

                local function closeDropdown(isInstant)
                    dropdownObj.isOpen = false
                    if dropdownPositionUpdateConn then
                        dropdownPositionUpdateConn:Disconnect()
                        dropdownPositionUpdateConn = nil
                    end
                    if isInstant then
                        dropdownObj.optionHolderFrame.Size = UDim2.new(0, 140 * mobileScaleFactor, 0, 0)
                        dropdownObj.optionHolderFrame.Visible = false
                        dropdownObj.arrowImg.Rotation = 0
                        dropdownObj.buttonFrame.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
                        dropdownStrokeThing.Color = Color3.fromRGB(44, 44, 44)
                        return
                    end
                    smoothMoveGoWoosh(dropdownObj.optionHolderFrame, {Size = UDim2.new(0, 140 * mobileScaleFactor, 0, 0)}, 0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
                    smoothMoveGoWoosh(dropdownObj.arrowImg, {Rotation = 0}, 0.2)
                    smoothMoveGoWoosh(dropdownObj.buttonFrame, {BackgroundColor3 = Color3.fromRGB(32, 32, 32)}, 0.18)
                    smoothMoveGoWoosh(dropdownStrokeThing, {Color = Color3.fromRGB(44, 44, 44)}, 0.18)
                    task.delay(0.22, function()
                        if dropdownObj.optionHolderFrame.Parent and not dropdownObj.isOpen then
                            dropdownObj.optionHolderFrame.Visible = false
                        end
                    end)
                end

                dropdownCloseButton.MouseButton1Click:Connect(function() closeDropdown(false) end)
                dropdownCloseButton.MouseEnter:Connect(function() smoothMoveGoWoosh(dropdownCloseButton, {BackgroundColor3 = Color3.fromRGB(44, 44, 44), TextColor3 = Color3.fromRGB(220, 220, 220)}, 0.12) end)
                dropdownCloseButton.MouseLeave:Connect(function() smoothMoveGoWoosh(dropdownCloseButton, {BackgroundColor3 = Color3.fromRGB(24, 24, 24), TextColor3 = Color3.fromRGB(138, 138, 138)}, 0.12) end)
                
                local optionInstances = {}
                local function createOptionsYay()
                    for _, child in pairs(dropdownObj.optionContainerFrame:GetChildren()) do
                        if child:IsA("Frame") then child:Destroy() end
                    end
                    optionInstances = {}
                    
                    for _, option in ipairs(dropdownConfig.Options) do
                        local isSelected = dropdownObj.value == option
                        
                        local optFrame = makeThingExist("Frame", {
                            BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 18 * mobileScaleFactor),
                            ZIndex = 10001, Parent = dropdownObj.optionContainerFrame
                        })

                        local optionLabelText = makeThingExist("TextLabel", {
                            FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
                            TextColor3 = isSelected and groupObj.Library.config.AccentColor or Color3.fromRGB(124, 124, 124),
                            Text = option, BackgroundTransparency = 1, Position = UDim2.new(0, 12, 0, 0),
                            TextSize = 14 * mobileScaleFactor, Size = UDim2.new(1, -24, 1, 0),
                            TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd,
                            ZIndex = 10001, Parent = optFrame
                        })
                        local optionClickButton = makeThingExist("TextButton", {
                            Text = "", BackgroundTransparency = 1, Position = UDim2.new(0, 0, 0, 0),
                            Size = UDim2.new(1, 0, 1, 0), ZIndex = 10002, Parent = optFrame
                        })
                        optionClickButton.MouseButton1Click:Connect(function()
                            dropdownObj.value = option
                            dropdownObj.searchBox.Text = "" 
                            closeDropdown(false)
                            dropdownObj.selectedLabelText.Text = option
                            local newWidth = math.max(70 * mobileScaleFactor, howWideIsThisText(option, 12 * mobileScaleFactor) + 30 * mobileScaleFactor)
                            smoothMoveGoWoosh(dropdownObj.buttonFrame, {Size = UDim2.new(0, newWidth, 0, 21 * mobileScaleFactor), Position = UDim2.new(1, -newWidth - 10, 0, yPosition)}, 0.15)
                            createOptionsYay()
                            dropdownConfig.Callback(option)
                        end)
                        optionClickButton.MouseEnter:Connect(function() if dropdownObj.value ~= option then smoothMoveGoWoosh(optionLabelText, {TextColor3 = Color3.fromRGB(180, 180, 180)}, 0.2) end end)
                        optionClickButton.MouseLeave:Connect(function() if dropdownObj.value ~= option then smoothMoveGoWoosh(optionLabelText, {TextColor3 = Color3.fromRGB(124, 124, 124)}, 0.2) end end)
                        
                        table.insert(optionInstances, {frame = optFrame, text = string.lower(tostring(option))})
                    end
                end
                createOptionsYay()
                
                -- Logika Filter Pencarian
                dropdownObj.searchBox:GetPropertyChangedSignal("Text"):Connect(function()
                    local query = string.lower(dropdownObj.searchBox.Text)
                    local visibleCount = 0
                    for _, opt in ipairs(optionInstances) do
                        if query == "" or string.find(opt.text, query, 1, true) then
                            opt.frame.Visible = true
                            visibleCount = visibleCount + 1
                        else
                            opt.frame.Visible = false
                        end
                    end
                    
                    dropdownObj.noResultLabel.Visible = (visibleCount == 0)

                    -- Animasi menyusut saat pencarian dilakukan
                    if dropdownObj.isOpen then
                        local contentHeight = 0
                        if visibleCount == 0 then
                            contentHeight = 94 * mobileScaleFactor -- Ruang khusus agar teks "Tidak ada" muat
                        else
                            contentHeight = (68 + (visibleCount * 22)) * mobileScaleFactor
                        end
                        local height = math.min(contentHeight, maxDropdownHeight)
                        smoothMoveGoWoosh(dropdownObj.optionHolderFrame, {Size = UDim2.new(0, 140 * mobileScaleFactor, 0, height)}, 0.15)
                    end
                end)
                
                local dropdownClickButton = makeThingExist("TextButton", {Text = "", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), Parent = dropdownObj.buttonFrame})
                
                local function updateDropdownPositionYay()
                    local buttonAbsPos = dropdownObj.buttonFrame.AbsolutePosition
                    local buttonAbsSize = dropdownObj.buttonFrame.AbsoluteSize
                    dropdownObj.optionHolderFrame.Position = UDim2.new(0, buttonAbsPos.X, 0, buttonAbsPos.Y + buttonAbsSize.Y + 5)
                end
                
                dropdownClickButton.MouseButton1Click:Connect(function()
                    dropdownObj.isOpen = not dropdownObj.isOpen
                    if dropdownObj.isOpen then
                        updateDropdownPositionYay()
                        dropdownObj.optionHolderFrame.Visible = true
                        
                        local visibleCount = 0
                        for _, opt in ipairs(optionInstances) do
                            if opt.frame.Visible then visibleCount = visibleCount + 1 end
                        end
                        
                        dropdownObj.noResultLabel.Visible = (visibleCount == 0)

                        local contentHeight = 0
                        if visibleCount == 0 then
                            contentHeight = 94 * mobileScaleFactor
                        else
                            contentHeight = (68 + (visibleCount * 22)) * mobileScaleFactor
                        end
                        
                        local height = math.min(contentHeight, maxDropdownHeight)
                        smoothMoveGoWoosh(dropdownObj.optionHolderFrame, {Size = UDim2.new(0, 140 * mobileScaleFactor, 0, height)}, 0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
                        smoothMoveGoWoosh(dropdownObj.arrowImg, {Rotation = 180}, 0.24, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
                        
                        if dropdownPositionUpdateConn then dropdownPositionUpdateConn:Disconnect() end
                        dropdownPositionUpdateConn = groupObj.Library:_TrackConnection(runServiceMoreLikeWalkService.RenderStepped:Connect(function()
                            if dropdownObj.isOpen then
                                updateDropdownPositionYay()
                            else
                                dropdownPositionUpdateConn:Disconnect()
                                dropdownPositionUpdateConn = nil
                            end
                        end))
                    else
                        closeDropdown(false)
                    end
                end)
                
                dropdownClickButton.MouseEnter:Connect(function()
                    smoothMoveGoWoosh(dropdownObj.buttonFrame, {BackgroundColor3 = Color3.fromRGB(48, 48, 48)}, 0.2)
                    smoothMoveGoWoosh(dropdownStrokeThing, {Color = Color3.fromRGB(83, 83, 83)}, 0.2)
                end)
                dropdownClickButton.MouseLeave:Connect(function()
                    if not dropdownObj.isOpen then
                        smoothMoveGoWoosh(dropdownObj.buttonFrame, {BackgroundColor3 = Color3.fromRGB(32, 32, 32)}, 0.2)
                        smoothMoveGoWoosh(dropdownStrokeThing, {Color = Color3.fromRGB(44, 44, 44)}, 0.2)
                    end
                end)
                
                function dropdownObj:Set(value)
                    if value == nil then return end
                    value = tostring(value)
                    dropdownObj.value = value
                    dropdownObj.selectedLabelText.Text = value
                    local newWidth = math.max(70 * mobileScaleFactor, howWideIsThisText(value, 12 * mobileScaleFactor) + 30 * mobileScaleFactor)
                    dropdownObj.buttonFrame.Size = UDim2.new(0, newWidth, 0, 21 * mobileScaleFactor)
                    dropdownObj.buttonFrame.Position = UDim2.new(1, -newWidth - 10, 0, yPosition)
                    createOptionsYay()
                    dropdownConfig.Callback(value)
                end

                function dropdownObj:Get() return dropdownObj.value end
                
                function dropdownObj:UpdateOptions(newOptions)
                    dropdownConfig.Options = newOptions
                    for _, option in ipairs(dropdownConfig.Options) do addSearchTerm(option) end
                    createOptionsYay()
                    if groupObj.Library._searchQuery ~= "" then groupObj.Library:ApplySearchFilter(groupObj.Library._searchQuery) end
                    
                    if dropdownObj.searchBox.Text ~= "" then
                        local query = string.lower(dropdownObj.searchBox.Text)
                        local visibleCount = 0
                        for _, opt in ipairs(optionInstances) do
                            opt.frame.Visible = (query == "" or string.find(opt.text, query, 1, true))
                            if opt.frame.Visible then visibleCount = visibleCount + 1 end
                        end
                        dropdownObj.noResultLabel.Visible = (visibleCount == 0)
                    end
                end

                function dropdownObj:Close() closeDropdown(true) end
                groupObj.Library:RegisterControl(dropdownConfig.Flag, function() return dropdownObj:Get() end, function(value) if value ~= nil then dropdownObj:Set(value) end end)
                
                groupObj.elementYPos = groupObj.elementYPos + 28 * mobileScaleFactor
                updateGroupSizeYay()
                table.insert(groupObj.elementsInGroup, dropdownObj)
                return dropdownObj
            end

            -- ==========================================
            -- [KODE BARU: MULTI-DROPDOWN DENGAN FITUR SEARCH & NO RESULT]
            -- ==========================================
            function groupObj:AddMultiDropdown(multiDropdownConfig)
                multiDropdownConfig = multiDropdownConfig or {}
                multiDropdownConfig.Name = multiDropdownConfig.Name or "Multi Dropdown"
                multiDropdownConfig.Options = multiDropdownConfig.Options or {"Option 1", "Option 2", "Option 3"}
                multiDropdownConfig.Default = multiDropdownConfig.Default or {}
                multiDropdownConfig.Callback = multiDropdownConfig.Callback or function() end
                multiDropdownConfig.Flag = multiDropdownConfig.Flag or createAutoFlag(multiDropdownConfig.Name)
                addSearchTerm(multiDropdownConfig.Name)
                for _, option in ipairs(multiDropdownConfig.Options) do
                    addSearchTerm(option)
                end
                
                local multiDropdownObj = {}
                multiDropdownObj.selectedValues = {}
                for _, v in ipairs(multiDropdownConfig.Default) do multiDropdownObj.selectedValues[v] = true end
                multiDropdownObj.isOpen = false
                local yPosition = groupObj.elementYPos
                
                multiDropdownObj.labelText = makeThingExist("TextLabel", {
                    FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
                    TextColor3 = Color3.fromRGB(124, 124, 124), Text = multiDropdownConfig.Name, BackgroundTransparency = 1,
                    Position = UDim2.new(0, 10, 0, yPosition), TextSize = 14 * mobileScaleFactor,
                    Size = UDim2.new(0, 100 * mobileScaleFactor, 0, 20 * mobileScaleFactor),
                    TextXAlignment = Enum.TextXAlignment.Left, Parent = groupObj.mainFrame
                })
                
                local function getDisplayText()
                    local selected = {}
                    for option, isSelected in pairs(multiDropdownObj.selectedValues) do
                        if isSelected then table.insert(selected, option) end
                    end
                    table.sort(selected, function(a, b) return tostring(a) < tostring(b) end)
                    if #selected == 0 then return "None"
                    elseif #selected == 1 then return selected[1]
                    elseif #selected <= 2 then return table.concat(selected, ", ")
                    else return #selected .. " selected" end
                end
                
                local function getSelectedArray()
                    local arr = {}
                    for option, isSelected in pairs(multiDropdownObj.selectedValues) do
                        if isSelected then table.insert(arr, option) end
                    end
                    table.sort(arr, function(a, b) return tostring(a) < tostring(b) end)
                    return arr
                end
                
                local displayText = getDisplayText()
                local buttonWidth = math.max(85 * mobileScaleFactor, howWideIsThisText(displayText, 12 * mobileScaleFactor) + 35 * mobileScaleFactor)
                
                multiDropdownObj.buttonFrame = makeThingExist("Frame", {
                    BackgroundColor3 = Color3.fromRGB(32, 32, 32), Position = UDim2.new(1, -buttonWidth - 10, 0, yPosition),
                    Size = UDim2.new(0, buttonWidth, 0, 21 * mobileScaleFactor), Parent = groupObj.mainFrame
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(0, 8), Parent = multiDropdownObj.buttonFrame})
                
                local dropdownStrokeThing = makeThingExist("UIStroke", {Color = Color3.fromRGB(44, 44, 44), Parent = multiDropdownObj.buttonFrame})
                
                multiDropdownObj.selectedLabelText = makeThingExist("TextLabel", {
                    FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
                    TextColor3 = Color3.fromRGB(84, 84, 84), Text = displayText, BackgroundTransparency = 1,
                    Position = UDim2.new(0, 8, 0, 0), TextSize = 12 * mobileScaleFactor,
                    Size = UDim2.new(1, -28 * mobileScaleFactor, 1, 0), TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd, Parent = multiDropdownObj.buttonFrame
                })
                
                multiDropdownObj.arrowImg = makeThingExist("ImageLabel", {
                    ImageColor3 = Color3.fromRGB(80, 80, 80), Image = "rbxassetid://111626678408582", BackgroundTransparency = 1,
                    Position = UDim2.new(1, -20 * mobileScaleFactor, 0.5, -7 * mobileScaleFactor),
                    Size = UDim2.new(0, 14 * mobileScaleFactor, 0, 14 * mobileScaleFactor), Parent = multiDropdownObj.buttonFrame
                })
                
                multiDropdownObj.optionHolderFrame = makeThingExist("Frame", {
                    BackgroundColor3 = Color3.fromRGB(16, 16, 16), Size = UDim2.new(0, 160 * mobileScaleFactor, 0, 0),
                    ClipsDescendants = true, Visible = false, ZIndex = 9999, Parent = groupObj.Library.dropdownHolderRef
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(0, 6), Parent = multiDropdownObj.optionHolderFrame})
                makeThingExist("UIStroke", {Color = Color3.fromRGB(40, 40, 40), Parent = multiDropdownObj.optionHolderFrame})
                
                makeThingExist("TextLabel", {
                    FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
                    TextColor3 = Color3.new(1, 1, 1), Text = multiDropdownConfig.Name, BackgroundTransparency = 1,
                    Position = UDim2.new(0, 12, 0, 8 * mobileScaleFactor), TextSize = 14 * mobileScaleFactor,
                    Size = UDim2.new(1, -44 * mobileScaleFactor, 0, 20 * mobileScaleFactor), TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd, ZIndex = 10000, Parent = multiDropdownObj.optionHolderFrame
                })

                local multiDropdownCloseButton = makeThingExist("TextButton", {
                    FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold),
                    Text = "X", TextColor3 = Color3.fromRGB(170, 170, 170), TextSize = 14 * mobileScaleFactor,
                    BackgroundColor3 = Color3.fromRGB(24, 24, 24), AutoButtonColor = false,
                    Position = UDim2.new(1, -25 * mobileScaleFactor, 0, 5 * mobileScaleFactor),
                    Size = UDim2.new(0, 18 * mobileScaleFactor, 0, 18 * mobileScaleFactor),
                    ZIndex = 10002, Parent = multiDropdownObj.optionHolderFrame
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = multiDropdownCloseButton})

                -- KOTAK SEARCH UNTUK MULTI DROPDOWN
                multiDropdownObj.searchFrame = makeThingExist("Frame", {
                    BackgroundColor3 = Color3.fromRGB(22, 22, 22), Position = UDim2.new(0, 10, 0, 32 * mobileScaleFactor),
                    Size = UDim2.new(1, -20, 0, 22 * mobileScaleFactor), ZIndex = 10001, Parent = multiDropdownObj.optionHolderFrame
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(0, 6), Parent = multiDropdownObj.searchFrame})
                makeThingExist("UIStroke", {Color = Color3.fromRGB(44, 44, 44), Parent = multiDropdownObj.searchFrame})
                
                makeThingExist("ImageLabel", {
                    Image = "rbxassetid://10734943674", ImageColor3 = Color3.fromRGB(120, 120, 120),
                    BackgroundTransparency = 1, Position = UDim2.new(0, 6, 0.5, -6 * mobileScaleFactor),
                    Size = UDim2.new(0, 12 * mobileScaleFactor, 0, 12 * mobileScaleFactor), ZIndex = 10002, Parent = multiDropdownObj.searchFrame
                })
                
                multiDropdownObj.searchBox = makeThingExist("TextBox", {
                    FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
                    Text = "", PlaceholderText = "Search...", PlaceholderColor3 = Color3.fromRGB(100, 100, 100),
                    TextColor3 = Color3.fromRGB(210, 210, 210), TextSize = 11.5 * mobileScaleFactor,
                    BackgroundTransparency = 1, ClearTextOnFocus = false,
                    Position = UDim2.new(0, 22 * mobileScaleFactor, 0, 0), Size = UDim2.new(1, -24 * mobileScaleFactor, 1, 0),
                    TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 10002, Parent = multiDropdownObj.searchFrame
                })
                
                multiDropdownObj.optionScrollFrame = makeThingExist("ScrollingFrame", {
                    BackgroundTransparency = 1, Position = UDim2.new(0, 0, 0, 62 * mobileScaleFactor),
                    Size = UDim2.new(1, 0, 1, -67 * mobileScaleFactor), ScrollBarThickness = 0,
                    ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80), CanvasSize = UDim2.new(0, 0, 0, 0),
                    ZIndex = 10000, Parent = multiDropdownObj.optionHolderFrame
                })
                groupObj.Library:EnableSmoothScrolling(multiDropdownObj.optionScrollFrame, 22)
                
                multiDropdownObj.optionContainerFrame = makeThingExist("Frame", {
                    BackgroundTransparency = 1, Size = UDim2.new(1, -6, 0, 0),
                    ZIndex = 10000, Parent = multiDropdownObj.optionScrollFrame
                })

                local multiDropdownListLayout = makeThingExist("UIListLayout", {
                    Padding = UDim.new(0, 4), SortOrder = Enum.SortOrder.LayoutOrder,
                    Parent = multiDropdownObj.optionContainerFrame
                })
                groupObj.Library:_TrackConnection(multiDropdownListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    local contentHeight = multiDropdownListLayout.AbsoluteContentSize.Y
                    multiDropdownObj.optionContainerFrame.Size = UDim2.new(1, -6, 0, contentHeight)
                    multiDropdownObj.optionScrollFrame.CanvasSize = UDim2.new(0, 0, 0, contentHeight)
                end))

                -- [KODE BARU] Teks "Tidak ada" (No Results Found)
                multiDropdownObj.noResultLabel = makeThingExist("TextLabel", {
                    FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium),
                    TextColor3 = Color3.fromRGB(150, 80, 80), Text = "🚫 No Results", BackgroundTransparency = 1,
                    Position = UDim2.new(0, 0, 0, 65 * mobileScaleFactor), Size = UDim2.new(1, 0, 0, 20 * mobileScaleFactor),
                    TextSize = 12 * mobileScaleFactor, Visible = false, ZIndex = 10001, Parent = multiDropdownObj.optionHolderFrame
                })
                
                local maxMultiDropdownHeight = 260 * mobileScaleFactor
                local multiDropdownPositionConn = nil

                local function closeMultiDropdown(isInstant)
                    multiDropdownObj.isOpen = false
                    if multiDropdownPositionConn then
                        multiDropdownPositionConn:Disconnect()
                        multiDropdownPositionConn = nil
                    end
                    if isInstant then
                        multiDropdownObj.optionHolderFrame.Size = UDim2.new(0, 160 * mobileScaleFactor, 0, 0)
                        multiDropdownObj.optionHolderFrame.Visible = false
                        multiDropdownObj.arrowImg.Rotation = 0
                        multiDropdownObj.buttonFrame.BackgroundColor3 = Color3.fromRGB(32, 32, 32)
                        dropdownStrokeThing.Color = Color3.fromRGB(44, 44, 44)
                        return
                    end
                    smoothMoveGoWoosh(multiDropdownObj.optionHolderFrame, {Size = UDim2.new(0, 160 * mobileScaleFactor, 0, 0)}, 0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
                    smoothMoveGoWoosh(multiDropdownObj.arrowImg, {Rotation = 0}, 0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
                    smoothMoveGoWoosh(multiDropdownObj.buttonFrame, {BackgroundColor3 = Color3.fromRGB(32, 32, 32)}, 0.18)
                    smoothMoveGoWoosh(dropdownStrokeThing, {Color = Color3.fromRGB(44, 44, 44)}, 0.18)
                    task.delay(0.22, function()
                        if multiDropdownObj.optionHolderFrame.Parent and not multiDropdownObj.isOpen then
                            multiDropdownObj.optionHolderFrame.Visible = false
                        end
                    end)
                end

                multiDropdownCloseButton.MouseButton1Click:Connect(function() closeMultiDropdown(false) end)
                multiDropdownCloseButton.MouseEnter:Connect(function() smoothMoveGoWoosh(multiDropdownCloseButton, {BackgroundColor3 = Color3.fromRGB(44, 44, 44), TextColor3 = Color3.fromRGB(220, 220, 220)}, 0.12) end)
                multiDropdownCloseButton.MouseLeave:Connect(function() smoothMoveGoWoosh(multiDropdownCloseButton, {BackgroundColor3 = Color3.fromRGB(24, 24, 24), TextColor3 = Color3.fromRGB(138, 138, 138)}, 0.12) end)

                local multiOptionInstances = {}
                local function createMultiOptionsYay()
                    for _, child in pairs(multiDropdownObj.optionContainerFrame:GetChildren()) do
                        if child:IsA("Frame") then child:Destroy() end
                    end
                    multiOptionInstances = {}
                    
                    for _, option in ipairs(multiDropdownConfig.Options) do
                        local isSelected = multiDropdownObj.selectedValues[option] == true
                        
                        local optFrame = makeThingExist("Frame", {
                            BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, 22 * mobileScaleFactor),
                            ZIndex = 10001, Parent = multiDropdownObj.optionContainerFrame
                        })
                        
                        local checkboxFrame = makeThingExist("Frame", {
                            BackgroundColor3 = isSelected and groupObj.Library.config.AccentColor or Color3.fromRGB(32, 32, 32),
                            Position = UDim2.new(0, 12, 0.5, -8 * mobileScaleFactor),
                            Size = UDim2.new(0, 16 * mobileScaleFactor, 0, 16 * mobileScaleFactor),
                            ZIndex = 10002, Parent = optFrame
                        })
                        makeThingExist("UICorner", {CornerRadius = UDim.new(0, 4), Parent = checkboxFrame})
                        
                        local checkmarkImg = makeThingExist("ImageLabel", {
                            Image = "rbxassetid://10709790644", ImageColor3 = Color3.new(1, 1, 1),
                            ImageTransparency = isSelected and 0 or 1, BackgroundTransparency = 1,
                            Position = UDim2.new(0.5, 0, 0.5, 0), AnchorPoint = Vector2.new(0.5, 0.5),
                            Size = UDim2.new(0, 12 * mobileScaleFactor, 0, 12 * mobileScaleFactor),
                            ZIndex = 10003, Parent = checkboxFrame
                        })
                        
                        local optionLabelText = makeThingExist("TextLabel", {
                            FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
                            TextColor3 = isSelected and groupObj.Library.config.AccentColor or Color3.fromRGB(124, 124, 124),
                            Text = option, BackgroundTransparency = 1, Position = UDim2.new(0, 34, 0, 0),
                            TextSize = 14 * mobileScaleFactor, Size = UDim2.new(1, -46, 1, 0),
                            TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 10002, Parent = optFrame
                        })
                        
                        local optionClickButton = makeThingExist("TextButton", {
                            Text = "", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0),
                            ZIndex = 10004, Parent = optFrame
                        })
                        
                        optionClickButton.MouseButton1Click:Connect(function()
                            multiDropdownObj.selectedValues[option] = not multiDropdownObj.selectedValues[option]
                            local nowSelected = multiDropdownObj.selectedValues[option]
                            
                            smoothMoveGoWoosh(checkboxFrame, {BackgroundColor3 = nowSelected and groupObj.Library.config.AccentColor or Color3.fromRGB(32, 32, 32)}, 0.15)
                            smoothMoveGoWoosh(checkmarkImg, {ImageTransparency = nowSelected and 0 or 1}, 0.15)
                            smoothMoveGoWoosh(optionLabelText, {TextColor3 = nowSelected and groupObj.Library.config.AccentColor or Color3.fromRGB(124, 124, 124)}, 0.15)
                            
                            local newDisplayText = getDisplayText()
                            multiDropdownObj.selectedLabelText.Text = newDisplayText
                            local newWidth = math.max(85 * mobileScaleFactor, howWideIsThisText(newDisplayText, 12 * mobileScaleFactor) + 35 * mobileScaleFactor)
                            smoothMoveGoWoosh(multiDropdownObj.buttonFrame, {Size = UDim2.new(0, newWidth, 0, 21 * mobileScaleFactor), Position = UDim2.new(1, -newWidth - 10, 0, yPosition)}, 0.15)
                            
                            multiDropdownConfig.Callback(getSelectedArray())
                        end)
                        
                        optionClickButton.MouseEnter:Connect(function()
                            if not multiDropdownObj.selectedValues[option] then
                                smoothMoveGoWoosh(optionLabelText, {TextColor3 = Color3.fromRGB(180, 180, 180)}, 0.15)
                                smoothMoveGoWoosh(checkboxFrame, {BackgroundColor3 = Color3.fromRGB(48, 48, 48)}, 0.15)
                            end
                        end)
                        optionClickButton.MouseLeave:Connect(function()
                            if not multiDropdownObj.selectedValues[option] then
                                smoothMoveGoWoosh(optionLabelText, {TextColor3 = Color3.fromRGB(124, 124, 124)}, 0.15)
                                smoothMoveGoWoosh(checkboxFrame, {BackgroundColor3 = Color3.fromRGB(32, 32, 32)}, 0.15)
                            end
                        end)
                        
                        table.insert(multiOptionInstances, {frame = optFrame, text = string.lower(tostring(option))})
                    end
                end
                createMultiOptionsYay()
                
                -- Logika Filter Pencarian
                multiDropdownObj.searchBox:GetPropertyChangedSignal("Text"):Connect(function()
                    local query = string.lower(multiDropdownObj.searchBox.Text)
                    local visibleCount = 0
                    for _, opt in ipairs(multiOptionInstances) do
                        if query == "" or string.find(opt.text, query, 1, true) then
                            opt.frame.Visible = true
                            visibleCount = visibleCount + 1
                        else
                            opt.frame.Visible = false
                        end
                    end
                    
                    multiDropdownObj.noResultLabel.Visible = (visibleCount == 0)

                    if multiDropdownObj.isOpen then
                        local contentHeight = 0
                        if visibleCount == 0 then
                            contentHeight = 94 * mobileScaleFactor -- Ruang khusus agar teks "Tidak ada" muat
                        else
                            contentHeight = (68 + (visibleCount * 26)) * mobileScaleFactor
                        end
                        local height = math.min(contentHeight, maxMultiDropdownHeight)
                        smoothMoveGoWoosh(multiDropdownObj.optionHolderFrame, {Size = UDim2.new(0, 160 * mobileScaleFactor, 0, height)}, 0.15)
                    end
                end)
                
                local dropdownClickButton = makeThingExist("TextButton", {Text = "", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), Parent = multiDropdownObj.buttonFrame})
                
                local function updateDropdownPositionYay()
                    local buttonAbsPos = multiDropdownObj.buttonFrame.AbsolutePosition
                    local buttonAbsSize = multiDropdownObj.buttonFrame.AbsoluteSize
                    multiDropdownObj.optionHolderFrame.Position = UDim2.new(0, buttonAbsPos.X, 0, buttonAbsPos.Y + buttonAbsSize.Y + 5)
                end
                
                dropdownClickButton.MouseButton1Click:Connect(function()
                    multiDropdownObj.isOpen = not multiDropdownObj.isOpen
                    if multiDropdownObj.isOpen then
                        updateDropdownPositionYay()
                        multiDropdownObj.optionHolderFrame.Visible = true
                        
                        local visibleCount = 0
                        for _, opt in ipairs(multiOptionInstances) do
                            if opt.frame.Visible then visibleCount = visibleCount + 1 end
                        end
                        
                        multiDropdownObj.noResultLabel.Visible = (visibleCount == 0)

                        local contentHeight = 0
                        if visibleCount == 0 then
                            contentHeight = 94 * mobileScaleFactor
                        else
                            contentHeight = (68 + (visibleCount * 26)) * mobileScaleFactor
                        end
                        
                        local height = math.min(contentHeight, maxMultiDropdownHeight)
                        smoothMoveGoWoosh(multiDropdownObj.optionHolderFrame, {Size = UDim2.new(0, 160 * mobileScaleFactor, 0, height)}, 0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
                        smoothMoveGoWoosh(multiDropdownObj.arrowImg, {Rotation = 180}, 0.24, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
                        
                        if multiDropdownPositionConn then multiDropdownPositionConn:Disconnect() end
                        multiDropdownPositionConn = groupObj.Library:_TrackConnection(runServiceMoreLikeWalkService.RenderStepped:Connect(function()
                            if multiDropdownObj.isOpen then
                                updateDropdownPositionYay()
                            else
                                multiDropdownPositionConn:Disconnect()
                                multiDropdownPositionConn = nil
                            end
                        end))
                    else
                        closeMultiDropdown(false)
                    end
                end)
                
                dropdownClickButton.MouseEnter:Connect(function()
                    smoothMoveGoWoosh(multiDropdownObj.buttonFrame, {BackgroundColor3 = Color3.fromRGB(48, 48, 48)}, 0.2)
                    smoothMoveGoWoosh(dropdownStrokeThing, {Color = Color3.fromRGB(83, 83, 83)}, 0.2)
                end)
                dropdownClickButton.MouseLeave:Connect(function()
                    if not multiDropdownObj.isOpen then
                        smoothMoveGoWoosh(multiDropdownObj.buttonFrame, {BackgroundColor3 = Color3.fromRGB(32, 32, 32)}, 0.2)
                        smoothMoveGoWoosh(dropdownStrokeThing, {Color = Color3.fromRGB(44, 44, 44)}, 0.2)
                    end
                end)
                
                function multiDropdownObj:Set(values)
                    multiDropdownObj.selectedValues = {}
                    for _, v in ipairs(values) do multiDropdownObj.selectedValues[v] = true end
                    local newDisplayText = getDisplayText()
                    multiDropdownObj.selectedLabelText.Text = newDisplayText
                    local newWidth = math.max(85 * mobileScaleFactor, howWideIsThisText(newDisplayText, 12 * mobileScaleFactor) + 35 * mobileScaleFactor)
                    multiDropdownObj.buttonFrame.Size = UDim2.new(0, newWidth, 0, 21 * mobileScaleFactor)
                    multiDropdownObj.buttonFrame.Position = UDim2.new(1, -newWidth - 10, 0, yPosition)
                    createMultiOptionsYay()
                    multiDropdownConfig.Callback(getSelectedArray())
                end
                
                function multiDropdownObj:UpdateOptions(newOptions)
                    multiDropdownConfig.Options = newOptions
                    for _, option in ipairs(multiDropdownConfig.Options) do addSearchTerm(option) end
                    createMultiOptionsYay()
                    if groupObj.Library._searchQuery ~= "" then groupObj.Library:ApplySearchFilter(groupObj.Library._searchQuery) end
                    
                    if multiDropdownObj.searchBox.Text ~= "" then
                        local query = string.lower(multiDropdownObj.searchBox.Text)
                        local visibleCount = 0
                        for _, opt in ipairs(multiOptionInstances) do
                            opt.frame.Visible = (query == "" or string.find(opt.text, query, 1, true))
                            if opt.frame.Visible then visibleCount = visibleCount + 1 end
                        end
                        multiDropdownObj.noResultLabel.Visible = (visibleCount == 0)
                    end
                end
                
                function multiDropdownObj:Get() return getSelectedArray() end

                function multiDropdownObj:Close() closeMultiDropdown(true) end
                groupObj.Library:RegisterControl(multiDropdownConfig.Flag, function() return multiDropdownObj:Get() end, function(value) if type(value) == "table" then multiDropdownObj:Set(value) end end)
                
                if #multiDropdownConfig.Default > 0 then multiDropdownConfig.Callback(getSelectedArray()) end
                groupObj.elementYPos = groupObj.elementYPos + 28 * mobileScaleFactor
                updateGroupSizeYay()
                table.insert(groupObj.elementsInGroup, multiDropdownObj)
                return multiDropdownObj
            end
            function groupObj:AddDivider()
                local yPosition = groupObj.elementYPos
                local dividerFrame = makeThingExist("Frame", {
                    BackgroundColor3 = Color3.fromRGB(36, 36, 36),
                    Position = UDim2.new(0, 10, 0, yPosition + 4 * mobileScaleFactor),
                    Size = UDim2.new(0.92, 0, 0, 1), Parent = groupObj.mainFrame
                })
                makeThingExist("UIGradient", {
                    Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(108, 108, 108)), ColorSequenceKeypoint.new(0.514, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.fromRGB(108, 108, 108))}),
                    Parent = dividerFrame
                })
                groupObj.elementYPos = groupObj.elementYPos + 12 * mobileScaleFactor
                updateGroupSizeYay()
                return dividerFrame
            end
            
            function groupObj:AddLabel(labelConfig)
                labelConfig = labelConfig or {}
                labelConfig.Text = labelConfig.Text or "Label"
                labelConfig.Wrap = labelConfig.Wrap == true
                addSearchTerm(labelConfig.Text)
                local yPosition = groupObj.elementYPos
                local labelMaxWidth = groupObj.elementWidth
                local labelTextSize = 14 * mobileScaleFactor
                local measuredBounds = textServiceBeLikeText:GetTextSize(
                    tostring(labelConfig.Text),
                    labelTextSize,
                    Enum.Font.GothamSemibold,
                    Vector2.new(labelMaxWidth, labelConfig.Wrap and math.huge or (labelTextSize + 4))
                )
                local labelHeight = labelConfig.Wrap and math.max(20 * mobileScaleFactor, measuredBounds.Y) or (20 * mobileScaleFactor)
                local labelText = makeThingExist("TextLabel", {
                    FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
                    TextColor3 = Color3.fromRGB(124, 124, 124), Text = labelConfig.Text, BackgroundTransparency = 1,
                    Position = UDim2.new(0, 10, 0, yPosition), TextSize = labelTextSize,
                    Size = UDim2.new(0, labelMaxWidth, 0, labelHeight), TextXAlignment = Enum.TextXAlignment.Left,
                    TextYAlignment = Enum.TextYAlignment.Top, TextWrapped = labelConfig.Wrap,
                    TextTruncate = labelConfig.Wrap and Enum.TextTruncate.None or Enum.TextTruncate.AtEnd,
                    ClipsDescendants = true,
                    Parent = groupObj.mainFrame
                })
                groupObj.elementYPos = groupObj.elementYPos + labelHeight + 6 * mobileScaleFactor
                updateGroupSizeYay()
                return labelText
            end
            
            -- generic custom area: returns a Frame inside the group (used by Dashboard banner / Chat)
            function groupObj:AddFrame(frameConfig)
                frameConfig = frameConfig or {}
                local height = (frameConfig.Height or 100) * mobileScaleFactor
                local yPosition = groupObj.elementYPos
                local frameObj = {Height = height}
                frameObj.Frame = makeThingExist("Frame", {
                    BackgroundColor3 = frameConfig.Color or Color3.fromRGB(20, 20, 20),
                    BackgroundTransparency = frameConfig.Color and 0 or (frameConfig.Transparent and 1 or 0),
                    Position = UDim2.new(0, groupConfig.Bare and 0 or 10, 0, yPosition), Size = UDim2.new(0, groupObj.elementWidth, 0, height),
                    ClipsDescendants = frameConfig.Clip ~= false, Parent = groupObj.mainFrame
                })
                if frameConfig.Corner ~= false then makeThingExist("UICorner", {CornerRadius = UDim.new(0, 8), Parent = frameObj.Frame}) end
                if frameConfig.Stroke ~= false and not frameConfig.Transparent then makeThingExist("UIStroke", {Color = Color3.fromRGB(38, 38, 38), Parent = frameObj.Frame}) end
                frameObj.Width = groupObj.elementWidth
                function frameObj:SetHeight(newHeight)
                    newHeight = newHeight * mobileScaleFactor
                    local delta = newHeight - frameObj.Height
                    if math.abs(delta) < 1 then return end
                    frameObj.Height = newHeight
                    frameObj.Frame.Size = UDim2.new(0, groupObj.elementWidth, 0, newHeight)
                    groupObj:_ShiftBelow(yPosition + newHeight - delta - 2, delta)
                end
                groupObj.elementYPos = groupObj.elementYPos + height + 8 * mobileScaleFactor
                updateGroupSizeYay()
                table.insert(groupObj.elementsInGroup, frameObj)
                return frameObj
            end

            function groupObj:AddTextInput(textInputConfig)
                textInputConfig = textInputConfig or {}
                textInputConfig.Name = textInputConfig.Name or "Input"
                textInputConfig.Placeholder = textInputConfig.Placeholder or "Enter text..."
                textInputConfig.Default = textInputConfig.Default or ""
                textInputConfig.Callback = textInputConfig.Callback or function() end
                textInputConfig.Flag = textInputConfig.Flag or createAutoFlag(textInputConfig.Name)
                addSearchTerm(textInputConfig.Name)
                addSearchTerm(textInputConfig.Placeholder)
                
                local textInputObj = {}
                textInputObj.value = textInputConfig.Default
                local yPosition = groupObj.elementYPos
                
                textInputObj.labelText = makeThingExist("TextLabel", {
                    FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
                    TextColor3 = Color3.fromRGB(124, 124, 124), Text = textInputConfig.Name, BackgroundTransparency = 1,
                    Position = UDim2.new(0, 10, 0, yPosition), TextSize = 14 * mobileScaleFactor,
                    Size = UDim2.new(0, 80 * mobileScaleFactor, 0, 20 * mobileScaleFactor),
                    TextXAlignment = Enum.TextXAlignment.Left, Parent = groupObj.mainFrame
                })
                
                textInputObj.inputFrame = makeThingExist("Frame", {
                    BackgroundColor3 = Color3.fromRGB(32, 32, 32),
                    Position = UDim2.new(0, 10, 0, yPosition + 22 * mobileScaleFactor),
                    Size = UDim2.new(0, groupObj.elementWidth, 0, 26 * mobileScaleFactor),
                    Parent = groupObj.mainFrame
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(0, 6), Parent = textInputObj.inputFrame})
                makeThingExist("UIStroke", {Color = Color3.fromRGB(44, 44, 44), Parent = textInputObj.inputFrame})
                
                textInputObj.textBox = makeThingExist("TextBox", {
                    FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
                    PlaceholderText = textInputConfig.Placeholder,
                    PlaceholderColor3 = Color3.fromRGB(80, 80, 80),
                    Text = textInputConfig.Default,
                    TextColor3 = Color3.fromRGB(200, 200, 200),
                    TextSize = 13 * mobileScaleFactor,
                    BackgroundTransparency = 1,
                    ClearTextOnFocus = false,
                    Position = UDim2.new(0, 8, 0, 0),
                    Size = UDim2.new(1, -16, 1, 0),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = textInputObj.inputFrame
                })
                
                textInputObj.textBox.Focused:Connect(function()
                    smoothMoveGoWoosh(textInputObj.inputFrame, {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}, 0.2)
                end)
                
                textInputObj.textBox.FocusLost:Connect(function(enterPressed)
                    smoothMoveGoWoosh(textInputObj.inputFrame, {BackgroundColor3 = Color3.fromRGB(32, 32, 32)}, 0.2)
                    textInputObj.value = textInputObj.textBox.Text
                    textInputConfig.Callback(textInputObj.value, enterPressed)
                end)
                
                function textInputObj:Set(text)
                    textInputObj.value = text
                    textInputObj.textBox.Text = text
                end
                
                function textInputObj:Get()
                    return textInputObj.value
                end
                groupObj.Library:RegisterControl(textInputConfig.Flag, function()
                    return textInputObj:Get()
                end, function(value)
                    textInputObj:Set(tostring(value or ""))
                    textInputConfig.Callback(textInputObj.value, false)
                end)
                
                groupObj.elementYPos = groupObj.elementYPos + 54 * mobileScaleFactor
                updateGroupSizeYay()
                table.insert(groupObj.elementsInGroup, textInputObj)
                return textInputObj
            end
            function groupObj:AddColorPicker(colorPickerConfig)
                colorPickerConfig = colorPickerConfig or {}
                colorPickerConfig.Name = colorPickerConfig.Name or "Color"
                colorPickerConfig.Default = colorPickerConfig.Default or Color3.fromRGB(230, 79, 49)
                colorPickerConfig.Callback = colorPickerConfig.Callback or function() end
                colorPickerConfig.Flag = colorPickerConfig.Flag or createAutoFlag(colorPickerConfig.Name)
                addSearchTerm(colorPickerConfig.Name)
                
                local colorPickerObj = {}
                colorPickerObj.value = colorPickerConfig.Default
                colorPickerObj.alpha = 1 -- 100%
                colorPickerObj.isOpen = false
                colorPickerObj.isRainbow = false -- [FITUR BARU]: Status Rainbow
                local yPosition = groupObj.elementYPos
                
                if not groupObj.Library._lastUsedColors then
                    groupObj.Library._lastUsedColors = {
                        Color3.fromRGB(0, 255, 170), Color3.fromRGB(170, 0, 255), Color3.fromRGB(255, 170, 255),
                        Color3.fromRGB(170, 255, 0), Color3.fromRGB(85, 170, 255), Color3.fromRGB(255, 255, 85)
                    }
                end
                
                local function rgbToHsv(color)
                    local r, g, b = color.R, color.G, color.B
                    local max, min = math.max(r, g, b), math.min(r, g, b)
                    local h, s, v = 0, 0, max
                    local d = max - min
                    s = max == 0 and 0 or d / max
                    if max ~= min then
                        if max == r then h = (g - b) / d + (g < b and 6 or 0)
                        elseif max == g then h = (b - r) / d + 2
                        elseif max == b then h = (r - g) / d + 4 end
                        h = h / 6
                    end
                    return h, s, v
                end
                
                local currentH, currentS, currentV = rgbToHsv(colorPickerConfig.Default)
                local currentFormat = "Hex" 
                
                colorPickerObj.labelText = makeThingExist("TextLabel", {
                    FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
                    TextColor3 = Color3.fromRGB(124, 124, 124), Text = colorPickerConfig.Name, BackgroundTransparency = 1,
                    Position = UDim2.new(0, 10, 0, yPosition), TextSize = 14 * mobileScaleFactor,
                    Size = UDim2.new(0, 100 * mobileScaleFactor, 0, 20 * mobileScaleFactor),
                    TextXAlignment = Enum.TextXAlignment.Left, Parent = groupObj.mainFrame
                })
                
                colorPickerObj.colorPreview = makeThingExist("Frame", {
                    BackgroundColor3 = colorPickerObj.value, Position = UDim2.new(1, -40 * mobileScaleFactor, 0, yPosition),
                    Size = UDim2.new(0, 30 * mobileScaleFactor, 0, 20 * mobileScaleFactor), Parent = groupObj.mainFrame
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(0, 6), Parent = colorPickerObj.colorPreview})
                makeThingExist("UIStroke", {Color = Color3.fromRGB(60, 60, 60), Parent = colorPickerObj.colorPreview})
                local pickerClickBtn = makeThingExist("TextButton", {Text = "", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), Parent = colorPickerObj.colorPreview})
                
                -- [DIUBAH]: Tinggi holder diperbesar dari 440 menjadi 480 agar muat tombol Rainbow
                local holderWidth = 270 * mobileScaleFactor
                local holderHeight = 480 * mobileScaleFactor
                
                colorPickerObj.pickerHolder = makeThingExist("Frame", {
                    BackgroundColor3 = Color3.fromRGB(22, 22, 22), Size = UDim2.new(0, holderWidth, 0, 0),
                    ClipsDescendants = true, Visible = false, ZIndex = 9999, Parent = groupObj.Library.dropdownHolderRef
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(0, 12), Parent = colorPickerObj.pickerHolder})
                makeThingExist("UIStroke", {Color = Color3.fromRGB(45, 45, 45), Parent = colorPickerObj.pickerHolder})
                
                makeThingExist("ImageLabel", {
                    Image = "rbxassetid://10734898355", ImageColor3 = Color3.new(1,1,1), BackgroundTransparency = 1,
                    Position = UDim2.new(0, 14 * mobileScaleFactor, 0, 14 * mobileScaleFactor), Size = UDim2.new(0, 16 * mobileScaleFactor, 0, 16 * mobileScaleFactor),
                    ZIndex = 10000, Parent = colorPickerObj.pickerHolder
                })
                makeThingExist("TextLabel", {
                    FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold),
                    Text = ".gg/nemesishub", TextColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1,
                    Position = UDim2.new(0, 36 * mobileScaleFactor, 0, 12 * mobileScaleFactor), Size = UDim2.new(0, 100, 0, 20 * mobileScaleFactor),
                    TextSize = 13 * mobileScaleFactor, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 10000, Parent = colorPickerObj.pickerHolder
                })
                
                local closeBtn = makeThingExist("TextButton", {
                    Text = "X", FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold),
                    TextColor3 = Color3.fromRGB(150, 150, 150), TextSize = 12 * mobileScaleFactor,
                    BackgroundColor3 = Color3.fromRGB(40, 40, 40), AnchorPoint = Vector2.new(1, 0),
                    Position = UDim2.new(1, -12 * mobileScaleFactor, 0, 12 * mobileScaleFactor), Size = UDim2.new(0, 20 * mobileScaleFactor, 0, 20 * mobileScaleFactor),
                    ZIndex = 10000, Parent = colorPickerObj.pickerHolder
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = closeBtn})
                
                local areaY = 45 * mobileScaleFactor
                local areaH = 150 * mobileScaleFactor
                
                colorPickerObj.hueSlider = makeThingExist("Frame", {
                    BackgroundColor3 = Color3.new(1, 1, 1), Position = UDim2.new(0, 14 * mobileScaleFactor, 0, areaY),
                    Size = UDim2.new(0, 12 * mobileScaleFactor, 0, areaH), ZIndex = 10000, Parent = colorPickerObj.pickerHolder
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = colorPickerObj.hueSlider})
                makeThingExist("UIGradient", {
                    Rotation = 90, Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Color3.fromHSV(0, 1, 1)), ColorSequenceKeypoint.new(0.167, Color3.fromHSV(0.167, 1, 1)),
                        ColorSequenceKeypoint.new(0.333, Color3.fromHSV(0.333, 1, 1)), ColorSequenceKeypoint.new(0.5, Color3.fromHSV(0.5, 1, 1)),
                        ColorSequenceKeypoint.new(0.667, Color3.fromHSV(0.667, 1, 1)), ColorSequenceKeypoint.new(0.833, Color3.fromHSV(0.833, 1, 1)),
                        ColorSequenceKeypoint.new(1, Color3.fromHSV(1, 1, 1))
                    }), Parent = colorPickerObj.hueSlider
                })
                colorPickerObj.hueCursor = makeThingExist("Frame", {
                    BackgroundColor3 = Color3.new(1, 1, 1), Position = UDim2.new(0.5, 0, currentH, 0), AnchorPoint = Vector2.new(0.5, 0.5),
                    Size = UDim2.new(0, 20 * mobileScaleFactor, 0, 6 * mobileScaleFactor), ZIndex = 10001, Parent = colorPickerObj.hueSlider
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = colorPickerObj.hueCursor})
                
                local alphaBg = makeThingExist("ImageLabel", {
                    Image = "rbxassetid://3887014957", ScaleType = Enum.ScaleType.Tile, TileSize = UDim2.new(0, 10, 0, 10),
                    Position = UDim2.new(0, 36 * mobileScaleFactor, 0, areaY), Size = UDim2.new(0, 12 * mobileScaleFactor, 0, areaH),
                    ZIndex = 10000, Parent = colorPickerObj.pickerHolder
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = alphaBg})
                colorPickerObj.alphaSlider = makeThingExist("Frame", {
                    BackgroundColor3 = Color3.fromHSV(currentH, currentS, currentV), Size = UDim2.new(1, 0, 1, 0), ZIndex = 10001, Parent = alphaBg
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = colorPickerObj.alphaSlider})
                makeThingExist("UIGradient", {Rotation = 90, Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,0), NumberSequenceKeypoint.new(1,1)}), Parent = colorPickerObj.alphaSlider})
                colorPickerObj.alphaCursor = makeThingExist("Frame", {
                    BackgroundColor3 = Color3.new(1, 1, 1), Position = UDim2.new(0.5, 0, 1 - colorPickerObj.alpha, 0), AnchorPoint = Vector2.new(0.5, 0.5),
                    Size = UDim2.new(0, 20 * mobileScaleFactor, 0, 6 * mobileScaleFactor), ZIndex = 10002, Parent = colorPickerObj.alphaSlider
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = colorPickerObj.alphaCursor})

                local svBoxW = 194 * mobileScaleFactor
                colorPickerObj.svBase = makeThingExist("Frame", {
                    BackgroundColor3 = Color3.new(1, 1, 1), Position = UDim2.new(0, 60 * mobileScaleFactor, 0, areaY),
                    Size = UDim2.new(0, svBoxW, 0, areaH), ZIndex = 10000, Parent = colorPickerObj.pickerHolder
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(0, 8), Parent = colorPickerObj.svBase})
                
                colorPickerObj.svHue = makeThingExist("Frame", {
                    BackgroundColor3 = Color3.fromHSV(currentH, 1, 1), Size = UDim2.new(1, 0, 1, 0), ZIndex = 10001, Parent = colorPickerObj.svBase
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(0, 8), Parent = colorPickerObj.svHue})
                makeThingExist("UIGradient", {Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,1), NumberSequenceKeypoint.new(1,0)}), Parent = colorPickerObj.svHue})
                
                local svBlack = makeThingExist("Frame", {
                    BackgroundColor3 = Color3.new(0, 0, 0), Size = UDim2.new(1, 0, 1, 0), ZIndex = 10002, Parent = colorPickerObj.svBase
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(0, 8), Parent = svBlack})
                makeThingExist("UIGradient", {Rotation = 90, Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0,1), NumberSequenceKeypoint.new(1,0)}), Parent = svBlack})
                
                colorPickerObj.svCursor = makeThingExist("Frame", {
                    BackgroundColor3 = Color3.new(1,1,1), BackgroundTransparency = 1,
                    Position = UDim2.new(currentS, 0, 1 - currentV, 0), AnchorPoint = Vector2.new(0.5, 0.5),
                    Size = UDim2.new(0, 12 * mobileScaleFactor, 0, 12 * mobileScaleFactor), ZIndex = 10004, Parent = colorPickerObj.svBase
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = colorPickerObj.svCursor})
                makeThingExist("UIStroke", {Color = Color3.new(1, 1, 1), Thickness = 2, Parent = colorPickerObj.svCursor})

                -- ==========================================
                -- FORMAT TABS
                -- ==========================================
                local tabsY = areaY + areaH + 14 * mobileScaleFactor
                local formats = {"Hex", "RGB", "HSL", "HSB"}
                local tabData = {}
                
                for i, fmt in ipairs(formats) do
                    local isHex = (fmt == "Hex")
                    local tab = makeThingExist("Frame", {
                        BackgroundTransparency = 1, Position = UDim2.new(0, 14 + (i-1)*60 * mobileScaleFactor, 0, tabsY),
                        Size = UDim2.new(0, 50 * mobileScaleFactor, 0, 22 * mobileScaleFactor), ZIndex = 10000, Parent = colorPickerObj.pickerHolder
                    })
                    local stroke
                    if isHex then
                        makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = tab})
                        stroke = makeThingExist("UIStroke", {Color = Color3.fromRGB(80, 80, 80), Parent = tab})
                    end
                    local label = makeThingExist("TextLabel", {
                        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
                        Text = fmt, TextColor3 = isHex and Color3.new(1,1,1) or Color3.fromRGB(100, 100, 100),
                        BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), TextSize = 13 * mobileScaleFactor,
                        ZIndex = 10001, Parent = tab
                    })
                    local btn = makeThingExist("TextButton", {Text = "", BackgroundTransparency = 1, Size = UDim2.new(1,0,1,0), ZIndex = 10002, Parent = tab})
                    
                    table.insert(tabData, {name = fmt, frame = tab, label = label, stroke = stroke})
                    
                    btn.MouseButton1Click:Connect(function()
                        currentFormat = fmt
                        for _, td in ipairs(tabData) do
                            if td.name == fmt then
                                td.label.TextColor3 = Color3.new(1, 1, 1)
                                makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = td.frame})
                                if not td.frame:FindFirstChildOfClass("UIStroke") then
                                    makeThingExist("UIStroke", {Color = Color3.fromRGB(80, 80, 80), Parent = td.frame})
                                end
                            else
                                td.label.TextColor3 = Color3.fromRGB(100, 100, 100)
                                local oldStroke = td.frame:FindFirstChildOfClass("UIStroke")
                                if oldStroke then oldStroke:Destroy() end
                            end
                        end
                        updateHarmoniesAndTexts() 
                    end)
                end

                -- ==========================================
                -- INPUTS & EYEDROPPER
                -- ==========================================
                local inputY = tabsY + 30 * mobileScaleFactor
                
                local dropperBtn = makeThingExist("Frame", {
                    BackgroundColor3 = Color3.fromRGB(30, 30, 30), Position = UDim2.new(0, 14 * mobileScaleFactor, 0, inputY),
                    Size = UDim2.new(0, 34 * mobileScaleFactor, 0, 28 * mobileScaleFactor), ZIndex = 10000, Parent = colorPickerObj.pickerHolder
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = dropperBtn})
                local dropperImg = makeThingExist("ImageLabel", {
                    Image = "rbxassetid://10723405649", ImageColor3 = Color3.fromRGB(150, 150, 150), BackgroundTransparency = 1,
                    Position = UDim2.new(0.5, 0, 0.5, 0), AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.new(0, 16 * mobileScaleFactor, 0, 16 * mobileScaleFactor),
                    ZIndex = 10001, Parent = dropperBtn
                })
                local dropperClick = makeThingExist("TextButton", {Text = "", BackgroundTransparency = 1, Size = UDim2.new(1,0,1,0), ZIndex = 10002, Parent = dropperBtn})

                local isDropperActive = false
                dropperClick.MouseButton1Click:Connect(function()
                    isDropperActive = not isDropperActive
                    smoothMoveGoWoosh(dropperBtn, {BackgroundColor3 = isDropperActive and Color3.fromRGB(60, 60, 60) or Color3.fromRGB(30, 30, 30)}, 0.2)
                    smoothMoveGoWoosh(dropperImg, {ImageColor3 = isDropperActive and Color3.new(1, 1, 1) or Color3.fromRGB(150, 150, 150)}, 0.2)
                end)

                groupObj.Library:_TrackConnection(thisInputServiceGoesHard.InputBegan:Connect(function(input)
                    if isDropperActive and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
                        isDropperActive = false
                        smoothMoveGoWoosh(dropperBtn, {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}, 0.2)
                        smoothMoveGoWoosh(dropperImg, {ImageColor3 = Color3.fromRGB(150, 150, 150)}, 0.2)

                        local cam = workspace.CurrentCamera
                        if cam then
                            local ray = cam:ScreenPointToRay(input.Position.X, input.Position.Y)
                            local raycastResult = workspace:Raycast(ray.Origin, ray.Direction * 1000)
                            if raycastResult and raycastResult.Instance and raycastResult.Instance:IsA("BasePart") then
                                colorPickerObj:Set(raycastResult.Instance.Color)
                                colorPickerObj:SetRainbow(false) -- Matikan rainbow jika ambil warna manual
                                return
                            end
                        end

                        local guis = {}
                        pcall(function() guis = theOneAndOnlyPlayer:WaitForChild("PlayerGui"):GetGuiObjectsAtPosition(input.Position.X, input.Position.Y) end)
                        for _, gui in ipairs(guis) do
                            if (gui:IsA("Frame") or gui:IsA("TextButton") or gui:IsA("TextBox")) and gui.BackgroundTransparency < 1 then
                                colorPickerObj:Set(gui.BackgroundColor3)
                                colorPickerObj:SetRainbow(false)
                                break
                            elseif gui:IsA("TextLabel") then
                                colorPickerObj:Set(gui.BackgroundTransparency < 1 and gui.BackgroundColor3 or gui.TextColor3)
                                colorPickerObj:SetRainbow(false)
                                break
                            elseif gui:IsA("ImageLabel") and gui.ImageTransparency < 1 then
                                colorPickerObj:Set(gui.ImageColor3)
                                colorPickerObj:SetRainbow(false)
                                break
                            end
                        end
                    end
                end))

                local hexBg = makeThingExist("Frame", {
                    BackgroundColor3 = Color3.fromRGB(30, 30, 30), Position = UDim2.new(0, 56 * mobileScaleFactor, 0, inputY),
                    Size = UDim2.new(0, 130 * mobileScaleFactor, 0, 28 * mobileScaleFactor), ZIndex = 10000, Parent = colorPickerObj.pickerHolder
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(0, 8), Parent = hexBg})
                local hashLabel = makeThingExist("TextLabel", {
                    FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium), Text = "#",
                    TextColor3 = Color3.fromRGB(120, 120, 120), BackgroundTransparency = 1, Position = UDim2.new(0, 14 * mobileScaleFactor, 0, 0),
                    Size = UDim2.new(0, 20, 1, 0), TextSize = 14 * mobileScaleFactor, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 10001, Parent = hexBg
                })
                colorPickerObj.hexInput = makeThingExist("TextBox", {
                    FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold), Text = "",
                    TextColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Position = UDim2.new(0, 40 * mobileScaleFactor, 0, 0),
                    Size = UDim2.new(1, -45 * mobileScaleFactor, 1, 0), TextSize = 13 * mobileScaleFactor, TextXAlignment = Enum.TextXAlignment.Left,
                    ClearTextOnFocus = false, ZIndex = 10001, Parent = hexBg
                })
                colorPickerObj.hexInput.Focused:Connect(function() colorPickerObj:SetRainbow(false) end) -- Disable Rainbow on manual type

                local alphaInputBg = makeThingExist("Frame", {
                    BackgroundColor3 = Color3.fromRGB(30, 30, 30), Position = UDim2.new(0, 194 * mobileScaleFactor, 0, inputY),
                    Size = UDim2.new(0, 60 * mobileScaleFactor, 0, 28 * mobileScaleFactor), ZIndex = 10000, Parent = colorPickerObj.pickerHolder
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(0, 8), Parent = alphaInputBg})
                colorPickerObj.alphaInput = makeThingExist("TextBox", {
                    FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold), Text = "100",
                    TextColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 1, Position = UDim2.new(0, 8 * mobileScaleFactor, 0, 0),
                    Size = UDim2.new(0, 30 * mobileScaleFactor, 1, 0), TextSize = 13 * mobileScaleFactor, TextXAlignment = Enum.TextXAlignment.Left,
                    ClearTextOnFocus = false, ZIndex = 10001, Parent = alphaInputBg
                })
                makeThingExist("TextLabel", {
                    FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium), Text = "%",
                    TextColor3 = Color3.fromRGB(120, 120, 120), BackgroundTransparency = 1, Position = UDim2.new(1, -20 * mobileScaleFactor, 0, 0),
                    Size = UDim2.new(0, 16, 1, 0), TextSize = 13 * mobileScaleFactor, TextXAlignment = Enum.TextXAlignment.Right, ZIndex = 10001, Parent = alphaInputBg
                })

                -- ==========================================
                -- HARMONIES (Y: 284)
                -- ==========================================
                local harmY = inputY + 45 * mobileScaleFactor
                local harmBoxes = {}
                local function createHarmonyBox(title, xPos, colorCount)
                    local box = makeThingExist("Frame", {
                        BackgroundColor3 = Color3.fromRGB(16, 16, 16), Position = UDim2.new(0, xPos, 0, harmY),
                        Size = UDim2.new(0, 75 * mobileScaleFactor, 0, 85 * mobileScaleFactor), ZIndex = 10000, Parent = colorPickerObj.pickerHolder
                    })
                    makeThingExist("UICorner", {CornerRadius = UDim.new(0, 8), Parent = box})
                    makeThingExist("TextLabel", {
                        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium), Text = title,
                        TextColor3 = Color3.new(1,1,1), BackgroundTransparency = 1, Position = UDim2.new(0, 0, 0, 6 * mobileScaleFactor),
                        Size = UDim2.new(1, 0, 0, 12 * mobileScaleFactor), TextSize = 9 * mobileScaleFactor, ZIndex = 10001, Parent = box
                    })
                    
                    local colors = {}
                    if colorCount == 1 then
                        local diamond = makeThingExist("Frame", {
                            BackgroundColor3 = Color3.new(1,1,1), Position = UDim2.new(0.5, 0, 0.45, 0), AnchorPoint = Vector2.new(0.5, 0.5),
                            Size = UDim2.new(0, 18 * mobileScaleFactor, 0, 18 * mobileScaleFactor), Rotation = 45, ZIndex = 10001, Parent = box
                        })
                        makeThingExist("UICorner", {CornerRadius = UDim.new(0, 3), Parent = diamond})
                        table.insert(colors, diamond)
                    else
                        local d1 = makeThingExist("Frame", {
                            BackgroundColor3 = Color3.new(1,1,1), Position = UDim2.new(0.32, 0, 0.45, 0), AnchorPoint = Vector2.new(0.5, 0.5),
                            Size = UDim2.new(0, 15 * mobileScaleFactor, 0, 15 * mobileScaleFactor), Rotation = 45, ZIndex = 10001, Parent = box
                        })
                        makeThingExist("UICorner", {CornerRadius = UDim.new(0, 3), Parent = d1})
                        local d2 = makeThingExist("Frame", {
                            BackgroundColor3 = Color3.new(1,1,1), Position = UDim2.new(0.68, 0, 0.45, 0), AnchorPoint = Vector2.new(0.5, 0.5),
                            Size = UDim2.new(0, 15 * mobileScaleFactor, 0, 15 * mobileScaleFactor), Rotation = 45, ZIndex = 10001, Parent = box
                        })
                        makeThingExist("UICorner", {CornerRadius = UDim.new(0, 3), Parent = d2})
                        table.insert(colors, d1)
                        table.insert(colors, d2)
                    end
                    
                    local getBtn = makeThingExist("Frame", {
                        BackgroundColor3 = Color3.fromRGB(26, 26, 26), Position = UDim2.new(0.5, 0, 0.82, 0), AnchorPoint = Vector2.new(0.5, 0.5),
                        Size = UDim2.new(0, 50 * mobileScaleFactor, 0, 16 * mobileScaleFactor), ZIndex = 10001, Parent = box
                    })
                    makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = getBtn})
                    local getStroke = makeThingExist("UIStroke", {Color = Color3.new(1,1,1), Thickness = 1, Parent = getBtn})
                    makeThingExist("TextLabel", {
                        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold), Text = "Get",
                        TextColor3 = Color3.new(1,1,1), BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), TextSize = 10 * mobileScaleFactor, ZIndex = 10002, Parent = getBtn
                    })
                    local clicker = makeThingExist("TextButton", {Text = "", BackgroundTransparency = 1, Size = UDim2.new(1,0,1,0), ZIndex = 10003, Parent = getBtn})
                    
                    return {box = box, colors = colors, getStroke = getStroke, clicker = clicker}
                end
                
                local compBox = createHarmonyBox("Complementary", 14 * mobileScaleFactor, 1)
                local triadBox = createHarmonyBox("Triadic", 97 * mobileScaleFactor, 2)
                local analBox = createHarmonyBox("Analogous", 180 * mobileScaleFactor, 2)

                -- ==========================================
                -- [FITUR BARU]: RAINBOW TOGGLE (Y: 380)
                -- ==========================================
                local rainbowY = harmY + 95 * mobileScaleFactor
                
                local rainbowFrame = makeThingExist("Frame", {
                    BackgroundColor3 = Color3.fromRGB(20, 20, 20),
                    Position = UDim2.new(0, 14 * mobileScaleFactor, 0, rainbowY),
                    Size = UDim2.new(1, -28 * mobileScaleFactor, 0, 30 * mobileScaleFactor),
                    ZIndex = 10000, Parent = colorPickerObj.pickerHolder
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(0, 6), Parent = rainbowFrame})
                makeThingExist("UIStroke", {Color = Color3.fromRGB(36, 36, 36), Parent = rainbowFrame})
                
                makeThingExist("TextLabel", {
                    FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold),
                    Text = "Rainbow Mode (RGB)", TextColor3 = Color3.fromRGB(200, 200, 200),
                    BackgroundTransparency = 1, Position = UDim2.new(0, 12 * mobileScaleFactor, 0, 0),
                    Size = UDim2.new(0.6, 0, 1, 0), TextSize = 12 * mobileScaleFactor, TextXAlignment = Enum.TextXAlignment.Left,
                    ZIndex = 10001, Parent = rainbowFrame
                })
                
                local rainbowSwitch = makeThingExist("Frame", {
                    BackgroundColor3 = Color3.fromRGB(35, 35, 35),
                    Position = UDim2.new(1, -38 * mobileScaleFactor, 0.5, -8 * mobileScaleFactor),
                    Size = UDim2.new(0, 28 * mobileScaleFactor, 0, 16 * mobileScaleFactor),
                    ZIndex = 10001, Parent = rainbowFrame
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = rainbowSwitch})
                
                local rainbowCircle = makeThingExist("Frame", {
                    BackgroundColor3 = Color3.fromRGB(100, 100, 100),
                    Position = UDim2.new(0, 2 * mobileScaleFactor, 0.5, -6 * mobileScaleFactor),
                    Size = UDim2.new(0, 12 * mobileScaleFactor, 0, 12 * mobileScaleFactor),
                    ZIndex = 10002, Parent = rainbowSwitch
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = rainbowCircle})
                
                local rainbowBtn = makeThingExist("TextButton", {Text="", Size=UDim2.new(1,0,1,0), BackgroundTransparency=1, ZIndex=10003, Parent=rainbowFrame})
                
                function colorPickerObj:SetRainbow(state)
                    colorPickerObj.isRainbow = state
                    if state then
                        smoothMoveGoWoosh(rainbowSwitch, {BackgroundColor3 = groupObj.Library.config.AccentColor}, 0.2)
                        smoothMoveGoWoosh(rainbowCircle, {Position = UDim2.new(1, -14 * mobileScaleFactor, 0.5, -6 * mobileScaleFactor), BackgroundColor3 = Color3.new(1,1,1)}, 0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
                    else
                        smoothMoveGoWoosh(rainbowSwitch, {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}, 0.2)
                        smoothMoveGoWoosh(rainbowCircle, {Position = UDim2.new(0, 2 * mobileScaleFactor, 0.5, -6 * mobileScaleFactor), BackgroundColor3 = Color3.fromRGB(100, 100, 100)}, 0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
                    end
                end
                
                rainbowBtn.MouseButton1Click:Connect(function()
                    colorPickerObj:SetRainbow(not colorPickerObj.isRainbow)
                end)

                -- ==========================================
                -- LAST USED (Y: 420)
                -- ==========================================
                local lastY = rainbowY + 40 * mobileScaleFactor
                makeThingExist("TextLabel", {
                    FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium), Text = "Last used",
                    TextColor3 = Color3.fromRGB(180, 180, 180), BackgroundTransparency = 1, Position = UDim2.new(0, 14 * mobileScaleFactor, 0, lastY),
                    Size = UDim2.new(0, 100, 0, 12 * mobileScaleFactor), TextSize = 10 * mobileScaleFactor, TextXAlignment = Enum.TextXAlignment.Left, ZIndex = 10000, Parent = colorPickerObj.pickerHolder
                })
                
                local lastUsedDots = {}
                for i = 1, 6 do
                    local dot = makeThingExist("Frame", {
                        BackgroundColor3 = groupObj.Library._lastUsedColors[i] or Color3.new(1,1,1),
                        Position = UDim2.new(0, 14 + (i-1)*24 * mobileScaleFactor, 0, lastY + 18 * mobileScaleFactor),
                        Size = UDim2.new(0, 14 * mobileScaleFactor, 0, 14 * mobileScaleFactor), ZIndex = 10000, Parent = colorPickerObj.pickerHolder
                    })
                    makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = dot})
                    local dotClick = makeThingExist("TextButton", {Text = "", BackgroundTransparency = 1, Size = UDim2.new(1,0,1,0), ZIndex = 10001, Parent = dot})
                    
                    dotClick.MouseButton1Click:Connect(function() 
                        colorPickerObj:Set(dot.BackgroundColor3) 
                        colorPickerObj:SetRainbow(false) -- Disable rainbow jika load last used
                    end)
                    table.insert(lastUsedDots, dot)
                end

                -- ==========================================
                -- LOGIKA UPDATE GLOBAL
                -- ==========================================
                function updateHarmoniesAndTexts()
                    local c = Color3.fromHSV(currentH, currentS, currentV)
                    colorPickerObj.value = c
                    colorPickerObj.colorPreview.BackgroundColor3 = c
                    
                    local r, g, b = math.floor(c.R*255), math.floor(c.G*255), math.floor(c.B*255)
                    if currentFormat == "Hex" then
                        colorPickerObj.hexInput.Text = string.format("%02X%02X%02X", r, g, b)
                        hashLabel.Visible = true
                        colorPickerObj.hexInput.Position = UDim2.new(0, 40 * mobileScaleFactor, 0, 0)
                        colorPickerObj.hexInput.Size = UDim2.new(1, -45 * mobileScaleFactor, 1, 0)
                    elseif currentFormat == "RGB" then
                        colorPickerObj.hexInput.Text = string.format("%d, %d, %d", r, g, b)
                        hashLabel.Visible = false
                        colorPickerObj.hexInput.Position = UDim2.new(0, 10 * mobileScaleFactor, 0, 0)
                        colorPickerObj.hexInput.Size = UDim2.new(1, -20 * mobileScaleFactor, 1, 0)
                    elseif currentFormat == "HSB" then
                        colorPickerObj.hexInput.Text = string.format("%.0f, %.0f%%, %.0f%%", currentH * 360, currentS * 100, currentV * 100)
                        hashLabel.Visible = false
                        colorPickerObj.hexInput.Position = UDim2.new(0, 10 * mobileScaleFactor, 0, 0)
                        colorPickerObj.hexInput.Size = UDim2.new(1, -20 * mobileScaleFactor, 1, 0)
                    elseif currentFormat == "HSL" then
                        local l = currentV * (1 - currentS / 2)
                        local sl = (l == 0 or l == 1) and 0 or (currentV - l) / math.min(l, 1 - l)
                        colorPickerObj.hexInput.Text = string.format("%.0f, %.0f%%, %.0f%%", currentH * 360, sl * 100, l * 100)
                        hashLabel.Visible = false
                        colorPickerObj.hexInput.Position = UDim2.new(0, 10 * mobileScaleFactor, 0, 0)
                        colorPickerObj.hexInput.Size = UDim2.new(1, -20 * mobileScaleFactor, 1, 0)
                    end
                    
                    colorPickerObj.alphaInput.Text = tostring(math.floor(colorPickerObj.alpha * 100))
                    colorPickerObj.alphaSlider.BackgroundColor3 = Color3.fromHSV(currentH, currentS, currentV)
                    
                    local compColor = Color3.fromHSV((currentH + 0.5) % 1, currentS, currentV)
                    compBox.colors[1].BackgroundColor3 = compColor
                    compBox.getStroke.Color = compColor
                    
                    local tri1 = Color3.fromHSV((currentH + 0.333) % 1, currentS, currentV)
                    local tri2 = Color3.fromHSV((currentH + 0.667) % 1, currentS, currentV)
                    triadBox.colors[1].BackgroundColor3 = tri1
                    triadBox.colors[2].BackgroundColor3 = tri2
                    triadBox.getStroke.Color = tri1
                    
                    local ana1 = Color3.fromHSV((currentH + 0.083) % 1, currentS, currentV)
                    local ana2 = Color3.fromHSV((currentH - 0.083) % 1, currentS, currentV)
                    analBox.colors[1].BackgroundColor3 = ana1
                    analBox.colors[2].BackgroundColor3 = ana2
                    analBox.getStroke.Color = ana1
                    
                    colorPickerConfig.Callback(c)
                end
                
                compBox.clicker.MouseButton1Click:Connect(function() colorPickerObj:Set(compBox.colors[1].BackgroundColor3) colorPickerObj:SetRainbow(false) end)
                triadBox.clicker.MouseButton1Click:Connect(function() colorPickerObj:Set(triadBox.colors[1].BackgroundColor3) colorPickerObj:SetRainbow(false) end)
                analBox.clicker.MouseButton1Click:Connect(function() colorPickerObj:Set(analBox.colors[1].BackgroundColor3) colorPickerObj:SetRainbow(false) end)
                
                colorPickerObj.hexInput.FocusLost:Connect(function()
                    local txt = colorPickerObj.hexInput.Text
                    if currentFormat == "Hex" then
                        txt = txt:gsub("#", "")
                        if #txt == 6 then
                            local r, g, b = tonumber(txt:sub(1,2), 16), tonumber(txt:sub(3,4), 16), tonumber(txt:sub(5,6), 16)
                            if r and g and b then colorPickerObj:Set(Color3.fromRGB(r, g, b)) return end
                        end
                    elseif currentFormat == "RGB" then
                        local r, g, b = txt:match("(%d+)%D+(%d+)%D+(%d+)")
                        if r and g and b then colorPickerObj:Set(Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b))) return end
                    elseif currentFormat == "HSB" then
                        local h, s, b = txt:match("(%d+)%D+(%d+)%D+(%d+)")
                        if h and s and b then colorPickerObj:Set(Color3.fromHSV(tonumber(h)/360, tonumber(s)/100, tonumber(b)/100)) return end
                    elseif currentFormat == "HSL" then
                        local h, s, l = txt:match("(%d+)%D+(%d+)%D+(%d+)")
                        if h and s and l then 
                            h, s, l = tonumber(h)/360, tonumber(s)/100, tonumber(l)/100
                            local v = l + s * math.min(l, 1 - l)
                            local sv = v == 0 and 0 or 2 * (1 - l / v)
                            colorPickerObj:Set(Color3.fromHSV(h, sv, v)) return 
                        end
                    end
                    updateHarmoniesAndTexts()
                end)
                
                colorPickerObj.alphaInput.FocusLost:Connect(function()
                    local val = tonumber(colorPickerObj.alphaInput.Text)
                    if val then
                        colorPickerObj.alpha = math.clamp(val, 0, 100) / 100
                        colorPickerObj.alphaCursor.Position = UDim2.new(0.5, 0, 1 - colorPickerObj.alpha, 0)
                    end
                    updateHarmoniesAndTexts()
                end)

                local svClickBtn = makeThingExist("TextButton", {Text = "", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), ZIndex = 10005, Parent = colorPickerObj.svBase})
                local svDragging = false
                svClickBtn.MouseButton1Down:Connect(function() svDragging = true colorPickerObj:SetRainbow(false) end)
                groupObj.Library:_TrackConnection(thisInputServiceGoesHard.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then svDragging = false end
                end))
                groupObj.Library:_TrackConnection(thisInputServiceGoesHard.InputChanged:Connect(function(input)
                    if svDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                        local absPos, absSize = colorPickerObj.svBase.AbsolutePosition, colorPickerObj.svBase.AbsoluteSize
                        currentS = math.clamp((input.Position.X - absPos.X) / absSize.X, 0, 1)
                        currentV = math.clamp(1 - (input.Position.Y - absPos.Y) / absSize.Y, 0, 1)
                        colorPickerObj.svCursor.Position = UDim2.new(currentS, 0, 1 - currentV, 0)
                        updateHarmoniesAndTexts()
                    end
                end))
                
                local hueClickBtn = makeThingExist("TextButton", {Text = "", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), ZIndex = 10005, Parent = colorPickerObj.hueSlider})
                local hueDragging = false
                hueClickBtn.MouseButton1Down:Connect(function() hueDragging = true colorPickerObj:SetRainbow(false) end)
                groupObj.Library:_TrackConnection(thisInputServiceGoesHard.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then hueDragging = false end
                end))
                groupObj.Library:_TrackConnection(thisInputServiceGoesHard.InputChanged:Connect(function(input)
                    if hueDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                        local absPos, absSize = colorPickerObj.hueSlider.AbsolutePosition, colorPickerObj.hueSlider.AbsoluteSize
                        currentH = math.clamp((input.Position.Y - absPos.Y) / absSize.Y, 0, 1)
                        colorPickerObj.hueCursor.Position = UDim2.new(0.5, 0, currentH, 0)
                        colorPickerObj.svHue.BackgroundColor3 = Color3.fromHSV(currentH, 1, 1)
                        updateHarmoniesAndTexts()
                    end
                end))

                local alphaClickBtn = makeThingExist("TextButton", {Text = "", BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), ZIndex = 10005, Parent = alphaBg})
                local alphaDragging = false
                alphaClickBtn.MouseButton1Down:Connect(function() alphaDragging = true end)
                groupObj.Library:_TrackConnection(thisInputServiceGoesHard.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then alphaDragging = false end
                end))
                groupObj.Library:_TrackConnection(thisInputServiceGoesHard.InputChanged:Connect(function(input)
                    if alphaDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                        local absPos, absSize = alphaBg.AbsolutePosition, alphaBg.AbsoluteSize
                        colorPickerObj.alpha = 1 - math.clamp((input.Position.Y - absPos.Y) / absSize.Y, 0, 1)
                        colorPickerObj.alphaCursor.Position = UDim2.new(0.5, 0, 1 - colorPickerObj.alpha, 0)
                        updateHarmoniesAndTexts()
                    end
                end))

                -- ==========================================
                -- [FITUR BARU]: LOOP RAINBOW REAL-TIME
                -- ==========================================
                groupObj.Library:_TrackConnection(runServiceMoreLikeWalkService.RenderStepped:Connect(function(dt)
                    if colorPickerObj.isRainbow then
                        currentH = (currentH + (dt * 0.15)) % 1 -- Kecepatan berputar warna pelangi
                        colorPickerObj.svHue.BackgroundColor3 = Color3.fromHSV(currentH, 1, 1)
                        colorPickerObj.hueCursor.Position = UDim2.new(0.5, 0, currentH, 0)
                        
                        if colorPickerObj.isOpen then
                            -- Jika menu terbuka, update seluruh textbox & UI
                            updateHarmoniesAndTexts()
                        else
                            -- Jika menu tertutup, cukup update preview warna & fire callback secara konstan
                            local c = Color3.fromHSV(currentH, currentS, currentV)
                            colorPickerObj.value = c
                            colorPickerObj.colorPreview.BackgroundColor3 = c
                            colorPickerConfig.Callback(c)
                        end
                    end
                end))

                local colorPickerPositionConn = nil
                local function closeColorPicker(isInstant)
                    colorPickerObj.isOpen = false
                    isDropperActive = false 
                    smoothMoveGoWoosh(dropperBtn, {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}, 0.2)
                    smoothMoveGoWoosh(dropperImg, {ImageColor3 = Color3.fromRGB(150, 150, 150)}, 0.2)
                    
                    if colorPickerPositionConn then colorPickerPositionConn:Disconnect() colorPickerPositionConn = nil end
                    
                    table.insert(groupObj.Library._lastUsedColors, 1, colorPickerObj.value)
                    table.remove(groupObj.Library._lastUsedColors, 7)
                    for i, dot in ipairs(lastUsedDots) do dot.BackgroundColor3 = groupObj.Library._lastUsedColors[i] or Color3.new(1,1,1) end
                    
                    if isInstant then
                        colorPickerObj.pickerHolder.Size = UDim2.new(0, holderWidth, 0, 0)
                        colorPickerObj.pickerHolder.Visible = false
                        return
                    end
                    smoothMoveGoWoosh(colorPickerObj.pickerHolder, {Size = UDim2.new(0, holderWidth, 0, 0)}, 0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
                    task.delay(0.2, function()
                        if colorPickerObj.pickerHolder.Parent and not colorPickerObj.isOpen then colorPickerObj.pickerHolder.Visible = false end
                    end)
                end

                local function updatePickerPosition()
                    local absPos = colorPickerObj.colorPreview.AbsolutePosition
                    local absSize = colorPickerObj.colorPreview.AbsoluteSize
                    colorPickerObj.pickerHolder.Position = UDim2.new(0, absPos.X - (holderWidth - 40 * mobileScaleFactor), 0, absPos.Y + absSize.Y + 5)
                end
                
                closeBtn.MouseButton1Click:Connect(function() closeColorPicker(false) end)
                
                pickerClickBtn.MouseButton1Click:Connect(function()
                    colorPickerObj.isOpen = not colorPickerObj.isOpen
                    if colorPickerObj.isOpen then
                        updatePickerPosition()
                        colorPickerObj.pickerHolder.Visible = true
                        smoothMoveGoWoosh(colorPickerObj.pickerHolder, {Size = UDim2.new(0, holderWidth, 0, holderHeight)}, 0.26, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
                        if colorPickerPositionConn then colorPickerPositionConn:Disconnect() end
                        colorPickerPositionConn = groupObj.Library:_TrackConnection(runServiceMoreLikeWalkService.RenderStepped:Connect(function()
                            if colorPickerObj.isOpen then updatePickerPosition()
                            else colorPickerPositionConn:Disconnect() colorPickerPositionConn = nil end
                        end))
                    else
                        closeColorPicker(false)
                    end
                end)
                
                function colorPickerObj:Set(color)
                    currentH, currentS, currentV = rgbToHsv(color)
                    colorPickerObj.svHue.BackgroundColor3 = Color3.fromHSV(currentH, 1, 1)
                    colorPickerObj.svCursor.Position = UDim2.new(currentS, 0, 1 - currentV, 0)
                    colorPickerObj.hueCursor.Position = UDim2.new(0.5, 0, currentH, 0)
                    updateHarmoniesAndTexts()
                end
                
                function colorPickerObj:Get() return colorPickerObj.value end
                function colorPickerObj:Close() closeColorPicker(true) end
                
                groupObj.Library:RegisterControl(colorPickerConfig.Flag, function() return colorPickerObj:Get() end, function(value) if typeof(value) == "Color3" then colorPickerObj:Set(value) end end)
                
                updateHarmoniesAndTexts()
                
                groupObj.elementYPos = groupObj.elementYPos + 28 * mobileScaleFactor
                updateGroupSizeYay()
                table.insert(groupObj.elementsInGroup, colorPickerObj)
                return colorPickerObj
            end
            -- [v3.1] dropdown variants + lowercase aliases (createSection/addToggle style)
            function groupObj:AddSearchDropdown(cfg)
                cfg = cfg or {}
                cfg.Search = true
                return groupObj:AddDropdown(cfg)
            end
            local function positional(fn, kind)
                return function(_, a, ...)
                    if type(a) == "table" then return fn(groupObj, a) end
                    local desc, x1, x2, x3, x4 = ...
                    if kind == "slider" then
                        return fn(groupObj, {Name = a, Desc = desc, Min = x1, Max = x2, Default = x3, Callback = x4})
                    elseif kind == "dropdown" then
                        return fn(groupObj, {Name = a, Desc = desc, Options = x1, Default = x2, Callback = x3})
                    elseif kind == "multi" then
                        return fn(groupObj, {Name = a, Desc = desc, Options = x1, Default = x2, Callback = x3})
                    elseif kind == "toggle" then
                        return fn(groupObj, {Name = a, Desc = desc, Default = x1, Callback = x2})
                    elseif kind == "button" then
                        return fn(groupObj, {Name = a, Desc = (type(desc) == "string") and desc or nil, Callback = (type(desc) == "function") and desc or x1})
                    end
                    return fn(groupObj, {Name = a})
                end
            end
            groupObj.addSlider = positional(groupObj.AddSlider, "slider")
            groupObj.addInputSlider = positional(groupObj.AddInputSlider, "slider")
            groupObj.addDropdown = positional(groupObj.AddDropdown, "dropdown")
            groupObj.addMultiDropdown = positional(groupObj.AddMultiDropdown, "multi")
            groupObj.addSearchDropdown = positional(groupObj.AddSearchDropdown, "dropdown")
            groupObj.addToggle = positional(groupObj.AddToggle, "toggle")
            groupObj.addButton = positional(groupObj.AddButton, "button")
            groupObj.addProgress = function(_, cfg) return groupObj:AddProgress(cfg) end
            groupObj.addStepper = function(_, cfg) return groupObj:AddStepper(cfg) end
            updateGroupSizeYay()
            table.insert(tabObj.groupsInTab, groupObj)
            table.insert(tabObj.groupList, groupObj)
            if groupObj.collapsed then groupObj:SetCollapsed(true, true) end
            tabObj:_Reflow()
            return groupObj
        end
        tabObj._pageAddGroup = pageAddGroup
        function tabObj:AddGroup(groupConfig) return pageAddGroup(tabObj, groupConfig) end
        
        table.insert(sectionObj.tabsInSection, tabObj)
        table.insert(sectionObj.Library.tabsGoWoosh, tabObj)
        
        if #sectionObj.Library.tabsGoWoosh == 1 then tabObj:Activate() end
        
        sectionObj.RecalcHeight(true)
        task.defer(function() sectionObj.RecalcHeight(true) end)
        
        if sectionObj.Library._searchQuery ~= "" then
            sectionObj.Library:ApplySearchFilter(sectionObj.Library._searchQuery)
        end
        
        return tabObj
    end
    
    table.insert(self.sectionsAreAwesome, sectionObj)
    return sectionObj
end

-- ==========================================================================
-- [NEMESIS+] Dashboard / usage stats / chat / leaderboard / config saving / splash
-- ==========================================================================
local function formatDuration(totalSeconds)
    totalSeconds = math.max(0, math.floor(tonumber(totalSeconds) or 0))
    local hours = math.floor(totalSeconds / 3600)
    local minutes = math.floor((totalSeconds % 3600) / 60)
    local seconds = totalSeconds % 60
    if hours > 0 then return string.format("%dh %02dm", hours, minutes) end
    if minutes > 0 then return string.format("%dm %02ds", minutes, seconds) end
    return string.format("%ds", seconds)
end

local function escapeRichText(text)
    text = tostring(text)
    text = string.gsub(text, "&", "&amp;")
    text = string.gsub(text, "<", "&lt;")
    text = string.gsub(text, ">", "&gt;")
    return text
end

function superMegaAwesomeLibrary:_InitUsageStats()
    local folder = self._cfgFolder or "NemesisUIConfigs"
    self._usagePath = folder .. "/UsageStats.json"
    self._usage = {executions = 0, totalSeconds = 0}
    pcall(function()
        if isfile and readfile and isfile(self._usagePath) then
            local data = httpServiceNoCap:JSONDecode(readfile(self._usagePath))
            if type(data) == "table" then
                self._usage.executions = tonumber(data.executions) or 0
                self._usage.totalSeconds = tonumber(data.totalSeconds) or 0
            end
        end
    end)
    self._usage.executions = self._usage.executions + 1
    self._usageStart = os.clock()
    self._usageBaseSeconds = self._usage.totalSeconds

    local function persist()
        self._usage.totalSeconds = self._usageBaseSeconds + (os.clock() - self._usageStart)
        pcall(function()
            if writefile and isfolder and makefolder then
                if not isfolder(folder) then makefolder(folder) end
                writefile(self._usagePath, httpServiceNoCap:JSONEncode({executions = self._usage.executions, totalSeconds = math.floor(self._usage.totalSeconds)}))
            end
        end)
    end
    persist()
    task.spawn(function()
        while not self._destroyed do
            task.wait(20)
            persist()
        end
        persist()
    end)
    function self:GetUsage()
        return {Executions = self._usage.executions, Seconds = math.floor(self._usageBaseSeconds + (os.clock() - self._usageStart)), SessionSeconds = math.floor(os.clock() - self._usageStart)}
    end
end

-- ---- Chat (local prototype with adapter) --------------------------------
function superMegaAwesomeLibrary:SetChatAdapter(adapter)
    self._chatAdapter = adapter
    if self._chatStatus then
        self._chatStatus.Text = adapter and "Connected" or "Offline • local prototype"
        self._chatStatusDot.BackgroundColor3 = adapter and Color3.fromRGB(110, 220, 130) or Color3.fromRGB(240, 176, 108)
    end
end

function superMegaAwesomeLibrary:AddChatMessage(name, text, options)
    options = options or {}
    local push = self._chatPush
    if push then push(tostring(name or "?"), tostring(text or ""), options) end
end
superMegaAwesomeLibrary.ReceiveChat = superMegaAwesomeLibrary.AddChatMessage

function superMegaAwesomeLibrary:ClearChat()
    if self._chatClear then self._chatClear() end
end

-- ---- Leaderboard ------------------------------------------------------
function superMegaAwesomeLibrary:SetLeaderboardAdapter(adapter)
    self._leaderboardAdapter = adapter
    if self._refreshLeaderboard then task.spawn(self._refreshLeaderboard) end
end
function superMegaAwesomeLibrary:SetLeaderboardRows(rows)
    self._leaderboardExternalRows = rows
    if self._refreshLeaderboard then task.spawn(self._refreshLeaderboard) end
end

function superMegaAwesomeLibrary:_BuildDashboard(dash)
    local accent = self.config.AccentColor
    local neon = neonOf(accent)
    local localPlayer = theOneAndOnlyPlayer
    local statsList = dash.Stats or {"FPS", "Ping", "Executor", "Game", "Region", "Time"}
    local statSet = {}
    for _, key in ipairs(statsList) do statSet[string.lower(key)] = true end
    local M = mobileScaleFactor
    local function S(n) return n * M end
    local FONT = "rbxasset://fonts/families/GothamSSm.json"
    local function font(weight) return Font.new(FONT, weight or Enum.FontWeight.SemiBold) end

    -- palette (all synced with the accent)
    local hot = neon:Lerp(Color3.fromRGB(232, 98, 255), 0.5)
    local lav = neon:Lerp(Color3.fromRGB(140, 150, 255), 0.55)
    local greyLine = Color3.fromRGB(128, 128, 144)
    local MUTED = Color3.fromRGB(135, 130, 150)
    local DIM = Color3.fromRGB(100, 96, 116)
    local GLASS = Color3.fromRGB(24, 24, 26)
    local RADIUS = 10
    local HISTORY = 40
    local fpsHist, pingHist = {}, {}
    for index = 1, HISTORY do fpsHist[index] = 0; pingHist[index] = 0 end

    ----------------------------------------------------------------------
    -- helpers
    ----------------------------------------------------------------------
    -- text label. Fit = max text size -> the text shrinks to fit its box instead of being cut off
    local function label(parent, props)
        local fit = props.Fit
        local base = {
            FontFace = font(), TextColor3 = Color3.fromRGB(215, 212, 225), TextSize = 12 * M, BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, Parent = parent,
        }
        for key, value in pairs(props) do if key ~= "Fit" then base[key] = value end end
        local lbl = makeThingExist("TextLabel", base)
        if fit then
            lbl.TextScaled = true
            makeThingExist("UITextSizeConstraint", {MaxTextSize = fit * M, MinTextSize = 6, Parent = lbl})
        end
        return lbl
    end

    -- glass card: translucent body, soft light sheen, hairline border, optional colored glow
    local function glass(parent, x, y, w, h, opts)
        opts = opts or {}
        -- v5: dark solid card (no glass/blur), subtle hairline border
        local frame = makeThingExist("Frame", {
            BackgroundColor3 = Color3.fromRGB(24, 24, 26), BackgroundTransparency = 0, BorderSizePixel = 0,
            Position = UDim2.new(0, x, 0, y), Size = UDim2.new(0, w, 0, h), ClipsDescendants = true, Parent = parent
        })
        makeThingExist("UICorner", {CornerRadius = UDim.new(0, opts.Radius or RADIUS), Parent = frame})
        local stroke = makeThingExist("UIStroke", {Enabled = false, Color = Color3.new(1, 1, 1), Transparency = 0.92, Parent = frame})
        if false then
            makeThingExist("ImageLabel", {
                BackgroundTransparency = 1, Image = "rbxassetid://5028857084", ImageColor3 = opts.Glow, ImageTransparency = math.min(0.97, (opts.GlowAlpha or 0.82) + 0.1),
                AnchorPoint = Vector2.new(0.5, 0.5), Position = opts.GlowPos or UDim2.new(1, 0, 0, 0), Size = opts.GlowSize or UDim2.new(1.2, 0, 1.8, 0), Parent = frame
            })
        end
        return frame, stroke
    end

    local function iconBox(parent, iconName, x, y, size)
        local box = makeThingExist("Frame", {BackgroundColor3 = neon, BackgroundTransparency = 0.84, Position = UDim2.new(0, x, 0, y), Size = UDim2.new(0, size, 0, size), Parent = parent})
        makeThingExist("UICorner", {CornerRadius = UDim.new(0, 7), Parent = box})
        makeThingExist("ImageLabel", {
            Image = getRealIcon(iconName, ""), ImageColor3 = neon, BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.new(0, size * 0.56, 0, size * 0.56), Parent = box
        })
        return box
    end

    local function arrowChip(parent, right, top)
        local size = S(22)
        local holder = makeThingExist("Frame", {
            BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.92, AnchorPoint = Vector2.new(1, 0),
            Position = UDim2.new(1, -right, 0, top), Size = UDim2.new(0, size, 0, size), Parent = parent
        })
        makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = holder})
        makeThingExist("ImageLabel", {
            Image = pickLucide({"arrow-up-right", "move-up-right", "chevron-right"}, ""), ImageColor3 = Color3.fromRGB(200, 195, 220), BackgroundTransparency = 1,
            AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.new(0, size * 0.5, 0, size * 0.5), Parent = holder
        })
        return holder
    end

    local function chip(parent, str, color, layoutOrder)
        local bounds = textServiceBeLikeText:GetTextSize(str, 11 * M, Enum.Font.GothamSemibold, Vector2.new(300, 20))
        local holder = makeThingExist("Frame", {
            BackgroundColor3 = color, BackgroundTransparency = 0.85, Size = UDim2.new(0, bounds.X + S(18), 0, S(20)), LayoutOrder = layoutOrder or 0, Parent = parent
        })
        makeThingExist("UICorner", {CornerRadius = UDim.new(0, 6), Parent = holder})
        makeThingExist("UIStroke", {Enabled = false, Color = color, Transparency = 0.6, Parent = holder})
        label(holder, {Text = str, TextColor3 = color, TextSize = 11 * M, TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.new(1, 0, 1, 0)})
        return holder
    end

    local function fixedChip(parent, width, color)
        local holder = makeThingExist("Frame", {
            BackgroundColor3 = color, BackgroundTransparency = 0.85, Size = UDim2.new(0, width, 0, S(20)), Parent = parent
        })
        makeThingExist("UICorner", {CornerRadius = UDim.new(0, 6), Parent = holder})
        makeThingExist("UIStroke", {Enabled = false, Color = color, Transparency = 0.6, Parent = holder})
        local lbl = label(holder, {Text = "", TextColor3 = color, TextSize = 11 * M, TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.new(1, 0, 1, 0)})
        return holder, lbl
    end

    -- badge image (falls back to a lucide glyph if the asset is not loaded / not approved yet)
    local function badgeImage(parent, asset, size, fallbackNames, tint)
        local img = makeThingExist("ImageLabel", {
            BackgroundTransparency = 1, Image = asset, Size = UDim2.new(0, size, 0, size), ScaleType = Enum.ScaleType.Fit, Parent = parent
        })
        task.delay(5, function()
            if img.Parent and not img.IsLoaded and fallbackNames then
                local glyph = pickLucide(fallbackNames, "")
                if glyph ~= "" then img.Image = glyph; img.ImageColor3 = tint or Color3.new(1, 1, 1) end
            end
        end)
        return img
    end

    local lastText = setmetatable({}, {__mode = "k"})
    local function setText(lbl, text)
        if lastText[lbl] ~= text then lastText[lbl] = text; lbl.Text = text end
    end

    ----------------------------------------------------------------------
    -- line chart (FPS = bright line, Ping = grey line, glowing cursor)
    ----------------------------------------------------------------------
    local function lineChart(parent, x, y, w, h)
        local area = makeThingExist("Frame", {BackgroundTransparency = 1, Position = UDim2.new(0, x, 0, y), Size = UDim2.new(0, w, 0, h), ClipsDescendants = true, Parent = parent})
        local chart = {fy = {}}
        local step = w / (HISTORY - 1)
        local cols, segF, segP = {}, {}, {}
        for index = 1, HISTORY do
            local col = makeThingExist("Frame", {
                BackgroundColor3 = hot, BorderSizePixel = 0, AnchorPoint = Vector2.new(0.5, 1),
                Position = UDim2.new(0, (index - 1) * step, 1, 0), Size = UDim2.new(0, step + 1, 0, 0), Parent = area
            })
            makeThingExist("UIGradient", {Rotation = 90, Transparency = NumberSequence.new(0.82, 1), Parent = col})
            cols[index] = col
        end
        local function newSeg(color, thickness)
            local frame = makeThingExist("Frame", {BackgroundColor3 = color, BorderSizePixel = 0, AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.new(0, 0, 0, thickness), Parent = area})
            makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = frame})
            return frame
        end
        for index = 1, HISTORY - 1 do segP[index] = newSeg(greyLine, 2 * M) end
        for index = 1, HISTORY - 1 do segF[index] = newSeg(hot, 2.4 * M) end

        local glow = makeThingExist("Frame", {BackgroundColor3 = hot, BackgroundTransparency = 0.86, BorderSizePixel = 0, AnchorPoint = Vector2.new(0.5, 0), Size = UDim2.new(0, 12 * M, 1, 0), Parent = area})
        makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = glow})
        local line = makeThingExist("Frame", {BackgroundColor3 = hot, BorderSizePixel = 0, AnchorPoint = Vector2.new(0.5, 0), Size = UDim2.new(0, 2, 1, 0), Parent = area})
        makeThingExist("UIGradient", {Rotation = 90, Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5, 0), NumberSequenceKeypoint.new(1, 1)}), Parent = line})
        local dot = makeThingExist("Frame", {BackgroundColor3 = Color3.new(1, 1, 1), AnchorPoint = Vector2.new(0.5, 0.5), Size = UDim2.new(0, 8 * M, 0, 8 * M), ZIndex = 3, Parent = area})
        makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = dot})
        makeThingExist("UIStroke", {Enabled = false, Color = hot, Thickness = 2, Parent = dot})
        local tipW = S(108)
        local tip = makeThingExist("Frame", {BackgroundColor3 = Color3.fromRGB(14, 14, 15), AnchorPoint = Vector2.new(0.5, 0), Size = UDim2.new(0, tipW, 0, S(18)), Visible = false, ZIndex = 4, Parent = area})
        makeThingExist("UICorner", {CornerRadius = UDim.new(0, 6), Parent = tip})
        makeThingExist("UIStroke", {Enabled = false, Color = hot, Transparency = 0.5, Parent = tip})
        local tipText = label(tip, {Text = "", TextSize = 10.5 * M, TextColor3 = Color3.new(1, 1, 1), TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.new(1, 0, 1, 0), ZIndex = 5})

        local function yOf(value, vmax) return h - 6 * M - math.clamp(value / vmax, 0, 1) * (h - 16 * M) end
        local function place(frame, x1, y1, x2, y2)
            local dx, dy = x2 - x1, y2 - y1
            frame.Size = UDim2.new(0, math.sqrt(dx * dx + dy * dy) + 1.5, 0, frame.Size.Y.Offset)
            frame.Position = UDim2.new(0, (x1 + x2) / 2, 0, (y1 + y2) / 2)
            frame.Rotation = math.deg(math.atan2(dy, dx))
        end
        function chart:UpdateCursor()
            local index = chart.hover or HISTORY
            local px = (index - 1) * step
            glow.Position = UDim2.new(0, px, 0, 0)
            line.Position = UDim2.new(0, px, 0, 0)
            dot.Position = UDim2.new(0, px, 0, chart.fy[index] or h)
            tip.Visible = chart.hover ~= nil
            if chart.hover then
                tip.Position = UDim2.new(0, math.clamp(px, tipW / 2, w - tipW / 2), 0, 2)
                tipText.Text = string.format("%d fps  ·  %d ms", fpsHist[index], pingHist[index])
            end
        end
        function chart:Render()
            local fMax, pMax = 90, 100
            for index = 1, HISTORY do fMax = math.max(fMax, fpsHist[index]); pMax = math.max(pMax, pingHist[index]) end
            fMax, pMax = fMax * 1.12, pMax * 1.25
            local prevX, prevFY, prevPY
            for index = 1, HISTORY do
                local px = (index - 1) * step
                local fy, py = yOf(fpsHist[index], fMax), yOf(pingHist[index], pMax)
                chart.fy[index] = fy
                cols[index].Size = UDim2.new(0, step + 1, 0, math.max(0, h - fy))
                if index > 1 then
                    place(segF[index - 1], prevX, prevFY, px, fy)
                    place(segP[index - 1], prevX, prevPY, px, py)
                end
                prevX, prevFY, prevPY = px, fy, py
            end
            chart:UpdateCursor()
        end
        local hit = makeThingExist("Frame", {BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), Active = false, ZIndex = 6, Parent = area})
        hit.MouseMoved:Connect(function(mouseX)
            local rel = (mouseX - area.AbsolutePosition.X) / math.max(area.AbsoluteSize.X, 1)
            chart.hover = math.clamp(math.floor(rel * (HISTORY - 1) + 0.5) + 1, 1, HISTORY)
            chart:UpdateCursor()
        end)
        hit.MouseLeave:Connect(function() chart.hover = nil; chart:UpdateCursor() end)
        return chart
    end

    ----------------------------------------------------------------------
    -- tab + one borderless group; every row is a frame, cards are placed on an exact pixel grid
    ----------------------------------------------------------------------
    local section = self:AddSection({Name = dash.SectionName or "Dashboard", Icon = dash.SectionIcon or "lucide:layout-dashboard"})
    local tab = section:AddTab({
        Name = dash.Name or "Dashboard",
        Description = dash.Description or "Overview, leaderboard and changelogs",
        Icon = dash.Icon or "lucide:layout-dashboard",
    })
    self.Dashboard = {Section = section, Tab = tab}
    local board = tab:AddGroup({Name = "Dashboard", Side = "Full", Icon = "lucide:layout-dashboard", Collapsible = false, Bare = true})
    pcall(function() -- v6: latar gelap menyeluruh untuk tab Dashboard
        local sc = tab.contentScroll
        if sc then
            -- [v7] border bawaan Roblox dibuat membulat mengikuti corner group
            makeThingExist("UICorner", {CornerRadius = UDim.new(0, RADIUS), Parent = sc})
        end
        if sc then sc.BorderSizePixel = 0; sc.BackgroundColor3 = Color3.fromRGB(12, 12, 13); sc.BackgroundTransparency = 0 end
    end)

    local execName = "Unknown"
    pcall(function() execName = (identifyexecutor and identifyexecutor()) or (getexecutorname and getexecutorname()) or "Unknown" end)

    local GAP = S(8)
    local dashActive -- [v3.1] forward declared (used by the realtime mini cards)
    local executionsText, playersText, perfChart, fpsValueText, pingChipLabel, memValueText, signalIcon, updateLevel
    local timeBoxes = {}
    local valueLabels = {}
    local gameName, gameIcon

    ----------------------------------------------------------------------
    -- ROW 1: Welcome (hero) | Level          ROW 2: Executions | Time spent          ROW 3: Performance
    -- One grid: full-width rows, same gap, same inner padding, same card header, same stroke.
    ----------------------------------------------------------------------
    local PAD = S(14)

    -- card header used by every card (icon box + title, always at the same position)
    local function cardHeader(card, iconName, title)
        iconBox(card, iconName, PAD, PAD, S(22))
        label(card, {
            Text = title, TextColor3 = Color3.fromRGB(225, 222, 235), TextSize = 12.5 * M, FontFace = font(Enum.FontWeight.SemiBold),
            Position = UDim2.new(0, PAD + S(30), 0, PAD), Size = UDim2.new(1, -(PAD * 2 + S(30)), 0, S(22))
        })
    end

    -- chip with 3D text inside (role, version)
    local function pill3D(parent, order)
        local pill = makeThingExist("Frame", {BackgroundTransparency = 0.88, BorderSizePixel = 0, Size = UDim2.new(0, S(60), 0, S(22)), LayoutOrder = order or 0, Parent = parent})
        makeThingExist("UICorner", {CornerRadius = UDim.new(0, 6), Parent = pill})
        local stroke = makeThingExist("UIStroke", {Enabled = false, Color = Color3.new(1, 1, 1), Transparency = 0.6, Parent = pill})
        local content = makeThingExist("Frame", {BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), Parent = pill})
        local obj = {Frame = pill}
        function obj:Set(str, pal)
            content:ClearAllChildren()
            pill.BackgroundColor3 = pal.Mid
            stroke.Color = pal.Mid
            local holder, width, height = text3D(content, str, math.floor(S(12)), S(8), 0, pal)
            holder.Position = UDim2.new(0, S(8), 0.5, -height / 2)
            pill.Size = UDim2.new(0, width + S(16), 0, S(22))
        end
        return obj
    end

    do
        local row = board:AddFrame({Height = 118, Transparent = true, Corner = false})
        local root, W, H = row.Frame, row.Width, row.Height
        local heroW = math.floor((W - GAP) * 0.58)
        local levelW = W - GAP - heroW

        -- hero ------------------------------------------------------------
        local hero = glass(root, 0, 0, heroW, H, {Glow = neon, GlowAlpha = 0.78, GlowPos = UDim2.new(1, 0, 0, 0), GlowSize = UDim2.new(0.9, 0, 1.9, 0)})
        local avatarSize = S(46)
        local avatar = makeThingExist("ImageLabel", {
            BackgroundColor3 = Color3.fromRGB(30, 30, 32), Position = UDim2.new(0, PAD, 0, PAD), Size = UDim2.new(0, avatarSize, 0, avatarSize),
            Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(localPlayer.UserId) .. "&w=150&h=150", Parent = hero
        })
        makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = avatar})
        makeThingExist("UIStroke", {Color = neon, Transparency = 0.4, Parent = avatar})
        local tx = PAD + avatarSize + S(12)
        local tw = heroW - tx - PAD
        label(hero, {Text = string.upper(dash.Welcome or "Welcome back"), TextColor3 = MUTED, TextSize = 9.5 * M, Position = UDim2.new(0, tx, 0, PAD + S(1)), Size = UDim2.new(0, tw, 0, S(12))})

        -- name + ONE role icon (+ rank icon for the leaderboard top 3)
        local badgeSize = S(18)
        local nameMax = tw - badgeSize * 2 - S(8)
        local nameW = textServiceBeLikeText:GetTextSize(localPlayer.DisplayName, 18 * M, Enum.Font.GothamBold, Vector2.new(400, 30)).X
        self._heroAvatar = avatar
        self._heroNameLabel = label(hero, {Text = localPlayer.DisplayName, TextColor3 = Color3.new(1, 1, 1), Fit = 18, FontFace = font(Enum.FontWeight.Bold), Position = UDim2.new(0, tx, 0, PAD + S(14)), Size = UDim2.new(0, nameMax, 0, S(22))})
        local badgeX = tx + math.min(nameW, nameMax) + S(6)
        local startTier = TIER_INFO[self._tier or "Member"] or TIER_INFO.Member
        local heroTierIcon = badgeImage(hero, startTier.Asset, badgeSize, startTier.Fallback, startTier.Color)
        heroTierIcon.Position = UDim2.new(0, badgeX, 0, PAD + S(16))
        local heroRankIcon = badgeImage(hero, BADGE_ASSETS.Rank1, badgeSize, {"trophy", "award"})
        heroRankIcon.Position = UDim2.new(0, badgeX + badgeSize + S(4), 0, PAD + S(16))
        heroRankIcon.Visible = false
        self._heroTierIcon, self._heroRankIcon = heroTierIcon, heroRankIcon
        self._heroUserLabel = label(hero, {Text = "@" .. localPlayer.Name, TextColor3 = MUTED, TextSize = 11 * M, FontFace = font(Enum.FontWeight.Medium), Position = UDim2.new(0, tx, 0, PAD + S(38)), Size = UDim2.new(0, tw, 0, S(14))})

        -- [v7] responsive: nickname + badge saling menyesuaikan.
        -- Muat satu baris -> badge tepat di kanan nickname. Tidak muat -> badge pindah ke baris username
        -- (rata kanan) dan username memendek, jadi tidak pernah menumpuk.
        local function layoutHeroIdentity()
            local nameLbl, userLbl = self._heroNameLabel, self._heroUserLabel
            if not (nameLbl and nameLbl.Parent and userLbl and userLbl.Parent) then return end
            local nW = textServiceBeLikeText:GetTextSize(nameLbl.Text, 18 * M, Enum.Font.GothamBold, Vector2.new(400, 30)).X + S(3)
            local icons = {}
            if heroTierIcon.Visible then table.insert(icons, heroTierIcon) end
            if heroRankIcon.Visible then table.insert(icons, heroRankIcon) end
            local gapB = S(4)
            local badgesW = #icons > 0 and (#icons * badgeSize + (#icons - 1) * gapB) or 0
            if badgesW == 0 or nW + S(6) + badgesW <= tw then
                local w = math.min(nW, tw)
                nameLbl.Size = UDim2.new(0, w, 0, S(22))
                for i, icon in ipairs(icons) do
                    icon.Position = UDim2.new(0, tx + w + S(6) + (i - 1) * (badgeSize + gapB), 0, PAD + S(16))
                end
                userLbl.Size = UDim2.new(0, tw, 0, S(14))
            else
                nameLbl.Size = UDim2.new(0, tw, 0, S(22))
                for i, icon in ipairs(icons) do
                    icon.Position = UDim2.new(0, tx + tw - badgesW + (i - 1) * (badgeSize + gapB), 0, PAD + S(36))
                end
                userLbl.Size = UDim2.new(0, math.max(tw - badgesW - S(6), S(24)), 0, S(14))
            end
        end
        self._LayoutHeroIdentity = layoutHeroIdentity
        layoutHeroIdentity()

        -- chips: role (3D text) | version (3D text) | time left
        local chips = makeThingExist("Frame", {BackgroundTransparency = 1, Position = UDim2.new(0, PAD, 1, -(PAD + S(22))), Size = UDim2.new(1, -PAD * 2, 0, S(22)), Parent = hero})
        makeThingExist("UIListLayout", {FillDirection = Enum.FillDirection.Horizontal, Padding = UDim.new(0, S(6)), VerticalAlignment = Enum.VerticalAlignment.Center, SortOrder = Enum.SortOrder.LayoutOrder, Parent = chips})
        local tierPill = pill3D(chips, 1)
        local versionPill = pill3D(chips, 2)
        versionPill:Set("v" .. tostring(dash.Version or (self._luarmorInfo and self._luarmorInfo.ScriptVersion) or "1.0"), palette3D(lav))
        local expiryHolder, expiryLabel = fixedChip(chips, S(66), lav)
        expiryHolder.Size = UDim2.new(0, S(66), 0, S(22))
        expiryHolder.LayoutOrder = 3
        expiryHolder.Visible = false

        local shownTier
        local function renderTierChip(tier)
            if shownTier == tier then return end
            shownTier = tier
            local info = TIER_INFO[tier] or TIER_INFO.Member
            tierPill:Set(info.Label, TEXT3D_PALETTES[tier] or TEXT3D_PALETTES.Member)
            heroTierIcon.Image = info.Asset
            layoutHeroIdentity()
        end
        local function setExpiry(tier, info)
            local left = (tier == "VIP") and formatTimeLeft(info and info.SecondsLeft) or nil
            expiryHolder.Visible = left ~= nil
            if left then expiryLabel.Text = left end
        end
        local function setRankBadge(rank)
            local asset = rank == 1 and BADGE_ASSETS.Rank1 or rank == 2 and BADGE_ASSETS.Rank2 or rank == 3 and BADGE_ASSETS.Rank3 or nil
            if asset then heroRankIcon.Image = asset end
            heroRankIcon.Visible = asset ~= nil and not (self._hiddenBadges and self._hiddenBadges.Rank)
            layoutHeroIdentity()
            if self._rank ~= rank then
                self._rank = rank
                if self._RefreshInGameBadge then self:_RefreshInGameBadge() end
            end
        end
        self._onRankChanged = setRankBadge
        table.insert(self._tierListeners, function(tier, info)
            renderTierChip(tier)
            setExpiry(tier, info)
        end)
        renderTierChip(self._tier or "Member")
        setExpiry(self._tier, self._luarmorInfo)

        -- level (only the CURRENT level icon is shown: level up => the old icon is replaced) -------------
        local lv = glass(root, heroW + GAP, 0, levelW, H, {Glow = lav, GlowAlpha = 0.84, GlowPos = UDim2.new(1, 0, 0, 0), GlowSize = UDim2.new(0.9, 0, 1.9, 0)})
        local iconS = S(48)
        local levelIcon = makeThingExist("ImageLabel", {
            BackgroundTransparency = 1, ScaleType = Enum.ScaleType.Fit, Image = LEVELS[1].Asset, AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0, PAD + iconS / 2, 0, PAD + iconS / 2), Size = UDim2.new(0, iconS, 0, iconS), Parent = lv
        })
        local lx = PAD + iconS + S(10)
        local lvw = levelW - lx - PAD
        local levelTop = label(lv, {Text = "LEVEL 1", TextColor3 = MUTED, TextSize = 9.5 * M, Position = UDim2.new(0, lx, 0, PAD + S(2)), Size = UDim2.new(0, lvw, 0, S(12))})
        local levelName = label(lv, {Text = LEVELS[1].Name, TextColor3 = Color3.new(1, 1, 1), Fit = 16, FontFace = font(Enum.FontWeight.Bold), Position = UDim2.new(0, lx, 0, PAD + S(16)), Size = UDim2.new(0, lvw, 0, S(20))})
        local levelSub = label(lv, {Text = "", TextColor3 = DIM, TextSize = 10 * M, FontFace = font(Enum.FontWeight.Medium), Position = UDim2.new(0, lx, 0, PAD + S(37)), Size = UDim2.new(0, lvw, 0, S(12))})
        local track = makeThingExist("Frame", {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.9, BorderSizePixel = 0, Position = UDim2.new(0, PAD, 1, -(PAD + S(24))), Size = UDim2.new(1, -PAD * 2, 0, S(6)), Parent = lv})
        makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = track})
        local fill = makeThingExist("Frame", {BackgroundColor3 = neon, BorderSizePixel = 0, Size = UDim2.new(0, 0, 1, 0), Parent = track})
        makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = fill})
        makeThingExist("UIGradient", {Color = ColorSequence.new(neon:Lerp(Color3.fromRGB(32, 32, 34), 0.5), hot), Parent = fill})
        local xpLeft = label(lv, {Text = "0 XP", TextColor3 = Color3.fromRGB(190, 186, 205), TextSize = 10.5 * M, Position = UDim2.new(0, PAD, 1, -(PAD + S(14))), Size = UDim2.new(0.5, -PAD, 0, S(14))})
        local xpRight = label(lv, {Text = "", TextColor3 = DIM, TextSize = 10.5 * M, TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -PAD, 1, -(PAD + S(14))), Size = UDim2.new(0.5, -PAD, 0, S(14))})

        local shownLevel
        updateLevel = function(xp, silent)
            local idx, cur, nxt = levelOf(xp)
            if idx ~= shownLevel then
                local leveledUp = shownLevel ~= nil and idx > shownLevel
                shownLevel = idx
                levelIcon.Image = cur.Asset
                setText(levelTop, "LEVEL " .. idx)
                setText(levelName, cur.Name)
                if leveledUp and not silent then
                    levelIcon.Size = UDim2.new(0, iconS * 0.6, 0, iconS * 0.6)
                    smoothMoveGoWoosh(levelIcon, {Size = UDim2.new(0, iconS, 0, iconS)}, 0.45, Enum.EasingStyle.Back)
                    pcall(function()
                        self:Notify({Title = "Level up!", Content = "You reached Level " .. idx .. "  ·  " .. cur.Name, Type = "Success", Icon = cur.Asset, Duration = 5})
                    end)
                end
                self._level = idx
                if self._RefreshInGameBadge then self:_RefreshInGameBadge() end
            end
            fill.Size = UDim2.new(nxt and math.clamp((xp - cur.XP) / (nxt.XP - cur.XP), 0, 1) or 1, 0, 1, 0)
            setText(levelSub, nxt and ("Next: " .. nxt.Name) or "Max level reached")
            setText(xpLeft, tostring(xp) .. " XP")
            setText(xpRight, nxt and (tostring(nxt.XP) .. " XP  ·  Lv " .. nxt.Level) or "MAX")
        end
        do
            local usage = self:GetUsage()
            local lrm = self._luarmorInfo
            updateLevel(calcXP((lrm and lrm.Executions) or usage.Executions, usage.Seconds), true)
        end
    end

    -- ROW 2: Executions | Time spent --------------------------------------
    do
        local row = board:AddFrame({Height = 84, Transparent = true, Corner = false})
        local root, W, H = row.Frame, row.Width, row.Height
        local execW = math.floor((W - GAP) * 0.3)
        local timeW = W - GAP - execW

        local ex = glass(root, 0, 0, execW, H, {Glow = neon, GlowAlpha = 0.84, GlowPos = UDim2.new(1, 0, 0, 0), GlowSize = UDim2.new(0.9, 0, 1.9, 0)})
        cardHeader(ex, "lucide:play", "Executions")
        executionsText = label(ex, {Text = "0", TextColor3 = Color3.new(1, 1, 1), Fit = 24, FontFace = font(Enum.FontWeight.Bold), Position = UDim2.new(0, PAD, 0, PAD + S(28)), Size = UDim2.new(1, -PAD * 2, 0, S(28))})

        local tm = glass(root, execW + GAP, 0, timeW, H, {Glow = lav, GlowAlpha = 0.86, GlowPos = UDim2.new(1, 0, 0, 0), GlowSize = UDim2.new(0.9, 0, 1.9, 0)})
        local leftW = S(112)
        iconBox(tm, "lucide:clock", PAD, PAD, S(22))
        label(tm, {Text = "Time spent", TextColor3 = Color3.fromRGB(225, 222, 235), TextSize = 12.5 * M, FontFace = font(Enum.FontWeight.SemiBold), Position = UDim2.new(0, PAD + S(30), 0, PAD), Size = UDim2.new(0, leftW - S(30), 0, S(22))})
        label(tm, {Text = "Total usage", TextColor3 = DIM, TextSize = 10 * M, FontFace = font(Enum.FontWeight.Medium), Position = UDim2.new(0, PAD, 0, PAD + S(30)), Size = UDim2.new(0, leftW, 0, S(14))})

        -- one unified digital strip:  DD | HH | MM | SS   (the live seconds cell is accented)
        local stripX = PAD + leftW + S(6)
        local stripW, stripH = timeW - stripX - PAD, H - PAD * 2
        local strip = makeThingExist("Frame", {
            BackgroundColor3 = Color3.fromRGB(8, 6, 14), BackgroundTransparency = 0.5, BorderSizePixel = 0,
            Position = UDim2.new(0, stripX, 0, PAD), Size = UDim2.new(0, stripW, 0, stripH), Parent = tm
        })
        makeThingExist("UICorner", {CornerRadius = UDim.new(0, 8), Parent = strip})
        makeThingExist("UIStroke", {Enabled = false, Color = Color3.fromRGB(190, 170, 235), Transparency = 0.86, Parent = strip})
        local cellW = stripW / 4
        for index, unit in ipairs({"Day", "Hour", "Min", "Sec"}) do
            local live = unit == "Sec"
            local cell = makeThingExist("Frame", {BackgroundTransparency = 1, Position = UDim2.new(0, (index - 1) * cellW, 0, 0), Size = UDim2.new(0, cellW, 1, 0), Parent = strip})
            if index > 1 then
                makeThingExist("Frame", {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.9, BorderSizePixel = 0, Position = UDim2.new(0, (index - 1) * cellW, 0.2, 0), Size = UDim2.new(0, 1, 0.6, 0), Parent = strip})
            end
            timeBoxes[unit] = label(cell, {Text = "00", TextColor3 = live and hot or Color3.new(1, 1, 1), Fit = 18, FontFace = font(Enum.FontWeight.Bold), TextXAlignment = Enum.TextXAlignment.Center, Position = UDim2.new(0, S(2), 0, S(9)), Size = UDim2.new(1, -S(4), 0, S(24))})
            label(cell, {Text = string.upper(unit), TextColor3 = live and hot or DIM, TextSize = 9 * M, FontFace = font(Enum.FontWeight.Medium), TextXAlignment = Enum.TextXAlignment.Center, Position = UDim2.new(0, 0, 0, S(36)), Size = UDim2.new(1, 0, 0, S(12))})
            if live then
                local bar = makeThingExist("Frame", {BackgroundColor3 = hot, BorderSizePixel = 0, AnchorPoint = Vector2.new(0.5, 1), Position = UDim2.new(0.5, 0, 1, -S(3)), Size = UDim2.new(0, S(16), 0, 2), Parent = cell})
                makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = bar})
            end
        end
    end

    -- ROW 3: Performance ---------------------------------------------------
    do
        local row = board:AddFrame({Height = 172, Transparent = true, Corner = false})
        local root, W, H = row.Frame, row.Width, row.Height
        local card = glass(root, 0, 0, W, H, {Glow = lav, GlowAlpha = 0.86, GlowPos = UDim2.new(1, 0, 0, 0), GlowSize = UDim2.new(0.8, 0, 1.8, 0)})
        cardHeader(card, "lucide:activity", "Performance")
        label(card, {Text = "Current FPS", TextColor3 = MUTED, TextSize = 10.5 * M, FontFace = font(Enum.FontWeight.Medium), Position = UDim2.new(0, PAD, 0, PAD + S(32)), Size = UDim2.new(0, S(140), 0, S(14))})
        fpsValueText = label(card, {Text = "0 fps", TextColor3 = Color3.new(1, 1, 1), Fit = 30, FontFace = font(Enum.FontWeight.Bold), Position = UDim2.new(0, PAD, 0, PAD + S(46)), Size = UDim2.new(0, S(140), 0, S(34))})

        -- one status strip:  [signal icon  42 ms | ● LIVE]
        local statW, statH = S(140), S(24)
        local stat = makeThingExist("Frame", {
            BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.94, BorderSizePixel = 0,
            Position = UDim2.new(0, PAD, 0, PAD + S(88)), Size = UDim2.new(0, statW, 0, statH), Parent = card
        })
        makeThingExist("UICorner", {CornerRadius = UDim.new(0, 7), Parent = stat})
        makeThingExist("UIStroke", {Enabled = false, Color = Color3.fromRGB(190, 170, 235), Transparency = 0.86, Parent = stat})
        signalIcon = badgeImage(stat, BADGE_ASSETS.SignalGood, S(16), {"wifi"}, Color3.fromRGB(150, 220, 170))
        signalIcon.Position = UDim2.new(0, S(7), 0.5, -S(8))
        pingChipLabel = label(stat, {Text = "0 ms", TextColor3 = Color3.new(1, 1, 1), TextSize = 11 * M, FontFace = font(Enum.FontWeight.Bold), Position = UDim2.new(0, S(29), 0, 0), Size = UDim2.new(0, S(52), 1, 0)})
        makeThingExist("Frame", {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.88, BorderSizePixel = 0, Position = UDim2.new(0, S(84), 0.5, -S(7)), Size = UDim2.new(0, 1, 0, S(14)), Parent = stat})
        label(stat, {Text = "LIVE", TextColor3 = Color3.fromRGB(150, 220, 170), TextSize = 10 * M, FontFace = font(Enum.FontWeight.Bold), TextXAlignment = Enum.TextXAlignment.Center, Position = UDim2.new(0, S(88), 0, 0), Size = UDim2.new(0, S(48), 1, 0)})

        -- v6: memory info lives inside Performance (no separate Memory card)
        local memStrip = makeThingExist("Frame", {
            BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.94, BorderSizePixel = 0,
            Position = UDim2.new(0, PAD, 0, PAD + S(88) + statH + S(6)), Size = UDim2.new(0, statW, 0, statH), Parent = card
        })
        makeThingExist("UICorner", {CornerRadius = UDim.new(0, 7), Parent = memStrip})
        makeThingExist("UIStroke", {Enabled = false, Color = Color3.fromRGB(190, 170, 235), Transparency = 0.86, Parent = memStrip})
        makeThingExist("ImageLabel", {
            Image = getRealIcon("lucide:cpu", ""), ImageColor3 = lav, BackgroundTransparency = 1,
            Position = UDim2.new(0, S(8), 0.5, -S(7)), Size = UDim2.new(0, S(14), 0, S(14)), Parent = memStrip
        })
        memValueText = label(memStrip, {Text = "0 MB", TextColor3 = Color3.new(1, 1, 1), TextSize = 11 * M, FontFace = font(Enum.FontWeight.Bold), Position = UDim2.new(0, S(29), 0, 0), Size = UDim2.new(0, S(52), 1, 0)})
        makeThingExist("Frame", {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.88, BorderSizePixel = 0, Position = UDim2.new(0, S(84), 0.5, -S(7)), Size = UDim2.new(0, 1, 0, S(14)), Parent = memStrip})
        label(memStrip, {Text = "MEM", TextColor3 = lav, TextSize = 10 * M, FontFace = font(Enum.FontWeight.Bold), TextXAlignment = Enum.TextXAlignment.Center, Position = UDim2.new(0, S(88), 0, 0), Size = UDim2.new(0, S(48), 1, 0)})

        local chartX = PAD + statW + S(18)
        local chartW = W - chartX - PAD
        perfChart = lineChart(card, chartX, PAD, chartW, S(122))
        local ticks = {"20s", "15s", "10s", "5s", "Now"}
        for index, text in ipairs(ticks) do
            local isNow = index == #ticks
            local anchor = (index == 1) and 0 or (isNow and 1 or 0.5)
            label(card, {
                Text = text, TextColor3 = isNow and hot or DIM, TextSize = 10 * M, FontFace = font(isNow and Enum.FontWeight.Bold or Enum.FontWeight.Medium),
                TextXAlignment = (index == 1) and Enum.TextXAlignment.Left or (isNow and Enum.TextXAlignment.Right or Enum.TextXAlignment.Center),
                AnchorPoint = Vector2.new(anchor, 0),
                Position = UDim2.new(0, chartX + chartW * (index - 1) / (#ticks - 1), 0, PAD + S(128)), Size = UDim2.new(0, S(36), 0, S(14))
            })
        end
    end

    ----
    -- ROW 3: Game card | Executor / Region / Time
    ----------------------------------------------------------------------
    do
        local row = board:AddFrame({Height = 118, Transparent = true, Corner = false})
        local root, W, H = row.Frame, row.Width, row.Height
        local gameW = math.floor((W - GAP) * 0.52)
        local stackW = W - gameW - GAP

        local gameCard = glass(root, 0, 0, gameW, H, {Glow = lav, GlowAlpha = 0.86, GlowPos = UDim2.new(1, 0, 0, 0), GlowSize = UDim2.new(0.9, 0, 1.8, 0)})
        arrowChip(gameCard, S(12), S(13))
        local iconSize = S(56)
        gameIcon = makeThingExist("ImageLabel", {
            BackgroundColor3 = Color3.fromRGB(32, 32, 34), Position = UDim2.new(0, S(14), 0, S(14)), Size = UDim2.new(0, iconSize, 0, iconSize), ScaleType = Enum.ScaleType.Crop,
            Image = "rbxthumb://type=GameIcon&id=" .. tostring(game.GameId) .. "&w=150&h=150", Parent = gameCard
        })
        makeThingExist("UICorner", {CornerRadius = UDim.new(0, 8), Parent = gameIcon})
        makeThingExist("UIStroke", {Enabled = false, Color = Color3.fromRGB(190, 170, 235), Transparency = 0.7, Parent = gameIcon})
        local gx = S(14) + iconSize + S(12)
        local gw = gameW - gx - S(40)
        label(gameCard, {Text = "NOW PLAYING", TextColor3 = MUTED, TextSize = 9.5 * M, Position = UDim2.new(0, gx, 0, S(16)), Size = UDim2.new(0, gw, 0, S(12))})
        gameName = label(gameCard, {
            Text = "Loading...", TextColor3 = Color3.new(1, 1, 1), TextSize = 12.5 * M, FontFace = font(Enum.FontWeight.Bold), TextWrapped = true,
            TextYAlignment = Enum.TextYAlignment.Top, Position = UDim2.new(0, gx, 0, S(31)), Size = UDim2.new(0, gw + S(4), 0, S(36))
        })
        makeThingExist("Frame", {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.92, BorderSizePixel = 0, Position = UDim2.new(0, S(14), 0, S(80)), Size = UDim2.new(1, -S(28), 0, 1), Parent = gameCard})
        iconBox(gameCard, "lucide:users", S(14), S(88), S(20))
        label(gameCard, {Text = "Players online", TextColor3 = MUTED, TextSize = 11 * M, Position = UDim2.new(0, S(42), 0, S(88)), Size = UDim2.new(0, S(130), 0, S(20))})
        playersText = label(gameCard, {Text = tostring(#playersAreNoobs:GetPlayers()), TextColor3 = Color3.new(1, 1, 1), Fit = 14, FontFace = font(Enum.FontWeight.Bold), TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -S(14), 0, S(88)), Size = UDim2.new(0, S(70), 0, S(20))})

        local rowDefs = {}
        if statSet["executor"] then table.insert(rowDefs, {Key = "executor", Icon = "lucide:terminal", Label = "Executor", Value = tostring(execName)}) end
        if statSet["region"] then table.insert(rowDefs, {Key = "region", Icon = "lucide:globe", Label = "Region", Value = "..."}) end
        if statSet["time"] then table.insert(rowDefs, {Key = "time", Icon = "lucide:clock", Label = "Time", Value = "--:--:--"}) end
        local count = math.max(#rowDefs, 1)
        local rowH = (H - GAP * (count - 1)) / count
        for index, def in ipairs(rowDefs) do
            local mini = glass(root, gameW + GAP, (index - 1) * (rowH + GAP), stackW, rowH, {Radius = 9})
            local ib = math.min(S(22), rowH - S(10))
            iconBox(mini, def.Icon, S(10), (rowH - ib) / 2, ib)
            label(mini, {Text = def.Label, TextColor3 = MUTED, TextSize = 11.5 * M, FontFace = font(Enum.FontWeight.Medium), Position = UDim2.new(0, S(10) + ib + S(8), 0, 0), Size = UDim2.new(0, S(66), 1, 0)})
            local vx = S(10) + ib + S(8) + S(66)
            valueLabels[def.Key] = label(mini, {
                Text = def.Value, TextColor3 = Color3.fromRGB(230, 228, 238), Fit = 12, TextXAlignment = Enum.TextXAlignment.Right,
                AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -S(12), 0, 0), Size = UDim2.new(0, stackW - vx - S(12), 1, 0)
            })
        end
    end

    task.spawn(function()
        local ok, productInfo = pcall(function() return game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId) end)
        if gameName then gameName.Text = (ok and productInfo and productInfo.Name) or game.Name end
        if gameIcon then
            task.wait(4)
            if gameIcon.Parent and not gameIcon.IsLoaded and ok and productInfo and tonumber(productInfo.IconImageAssetId) and tonumber(productInfo.IconImageAssetId) > 0 then
                gameIcon.Image = "rbxassetid://" .. tostring(productInfo.IconImageAssetId)
            end
        end
    end)
    task.spawn(function()
        if valueLabels.region then
            local ok, region = pcall(function() return game:GetService("LocalizationService"):GetCountryRegionForPlayerAsync(localPlayer) end)
            valueLabels.region.Text = (ok and region) or "N/A"
        end
    end)

    ----------------------------------------------------------------------
    -- live data
    ----------------------------------------------------------------------
    -- nothing below runs while the Dashboard tab is hidden or the window is closed (keeps other tabs light)
    dashActive = function()
        if self._destroyed or self.isToggledOn == false then return false end
        local sc = tab.contentScroll
        return not sc or sc.Visible
    end
    task.spawn(function()
        while not self._destroyed do
            if dashActive() then
                local usage = self:GetUsage()
                local lrm = self._luarmorInfo
                setText(executionsText, tostring((lrm and lrm.Executions) or usage.Executions))
                local secs = usage.Seconds
                setText(timeBoxes.Day, string.format("%02d", math.floor(secs / 86400)))
                setText(timeBoxes.Hour, string.format("%02d", math.floor((secs % 86400) / 3600)))
                setText(timeBoxes.Min, string.format("%02d", math.floor((secs % 3600) / 60)))
                setText(timeBoxes.Sec, string.format("%02d", secs % 60))
                setText(playersText, tostring(#playersAreNoobs:GetPlayers()))
                if updateLevel then updateLevel(calcXP((lrm and lrm.Executions) or usage.Executions, usage.Seconds)) end
            end
            task.wait(1)
        end
    end)
    task.spawn(function()
        local seeded = false
        local shownSignal
        while not self._destroyed do
            if not dashActive() then
                task.wait(0.5)
                continue
            end
            local fps = self._latestFPSValue or 0
            local ping = 0
            pcall(function() ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue() end)
            fps, ping = math.floor(fps + 0.5), math.floor(ping + 0.5)
            if not seeded and fps > 0 then
                for index = 1, HISTORY do fpsHist[index] = fps; pingHist[index] = ping end
                seeded = true
            else
                table.remove(fpsHist, 1); table.insert(fpsHist, fps)
                table.remove(pingHist, 1); table.insert(pingHist, ping)
            end
            setText(fpsValueText, string.format("%d fps", fps))
            setText(pingChipLabel, string.format("%d ms", ping))
            if memValueText then
                local mem = 0
                pcall(function() mem = game:GetService("Stats"):GetTotalMemoryUsageMb() end)
                setText(memValueText, string.format("%d MB", math.floor(mem + 0.5)))
            end
            local signalKey = (ping <= 90) and "SignalGood" or (ping <= 200 and "SignalMid" or "SignalBad")
            if signalKey ~= shownSignal and signalIcon then
                shownSignal = signalKey
                signalIcon.Image = BADGE_ASSETS[signalKey]
            end
            perfChart:Render()
            if valueLabels.time then setText(valueLabels.time, os.date("%H:%M:%S")) end
            task.wait(0.5)
        end
    end)

    ----------------------------------------------------------------------
    -- ROW 4: Community (glass) -> Leaderboard / Changelogs
    ----------------------------------------------------------------------
    local COMMUNITY_H = 380
    local commRow = board:AddFrame({Height = COMMUNITY_H, Transparent = true, Corner = false})
    local commRoot, CW, CH = commRow.Frame, commRow.Width, commRow.Height
    local comm = glass(commRoot, 0, 0, CW, CH, {Alpha = 0.5, Glow = lav, GlowAlpha = 0.9, GlowPos = UDim2.new(1, 0, 0, 0), GlowSize = UDim2.new(0.8, 0, 1.6, 0)})
    iconBox(comm, "lucide:users", S(14), S(13), S(24))
    label(comm, {Text = dash.CommunityTitle or "Community", TextColor3 = Color3.new(1, 1, 1), TextSize = 14 * M, FontFace = font(Enum.FontWeight.Bold), Position = UDim2.new(0, S(46), 0, S(13)), Size = UDim2.new(0, S(150), 0, S(24))})

    local pageNames = {}
    if dash.Leaderboard ~= false then table.insert(pageNames, "Leaderboard") end
    table.insert(pageNames, "Changelogs")

    local pillW = S(104)
    local switchW = pillW * #pageNames + S(8)
    local switcher = makeThingExist("Frame", {
        BackgroundColor3 = Color3.fromRGB(10, 10, 11), BackgroundTransparency = 0.35, BorderSizePixel = 0, AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, -S(14), 0, S(11)), Size = UDim2.new(0, switchW, 0, S(30)), Parent = comm
    })
    makeThingExist("UICorner", {CornerRadius = UDim.new(0, 8), Parent = switcher})
    makeThingExist("UIStroke", {Enabled = false, Color = Color3.fromRGB(190, 170, 235), Transparency = 0.85, Parent = switcher})
    local indicator = makeThingExist("Frame", {
        BackgroundColor3 = neon, BackgroundTransparency = 0.8, BorderSizePixel = 0,
        Position = UDim2.new(0, S(4), 0, S(4)), Size = UDim2.new(0, pillW, 1, -S(8)), Parent = switcher
    })
    makeThingExist("UICorner", {CornerRadius = UDim.new(0, 6), Parent = indicator})
    makeThingExist("UIStroke", {Color = neon, Transparency = 0.45, Parent = indicator})

    makeThingExist("Frame", {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.92, BorderSizePixel = 0, Position = UDim2.new(0, S(14), 0, S(50)), Size = UDim2.new(1, -S(28), 0, 1), Parent = comm})
    local panelArea = makeThingExist("Frame", {BackgroundTransparency = 1, ClipsDescendants = true, Position = UDim2.new(0, S(12), 0, S(58)), Size = UDim2.new(1, -S(24), 1, -S(68)), Parent = comm})

    local panels, pills = {}, {}
    local function selectPanel(name)
        local pageIndex = 1
        for index, pageName in ipairs(pageNames) do if pageName == name then pageIndex = index end end
        for key, panel in pairs(panels) do
            local on = key == name
            if on and not panel.Visible then
                panel.Position = UDim2.new(0, 0, 0, S(8))
                panel.Visible = true
                smoothMoveGoWoosh(panel, {Position = UDim2.new(0, 0, 0, 0)}, 0.28, Enum.EasingStyle.Quint)
            elseif not on then
                panel.Visible = false
            end
        end
        for key, pill in pairs(pills) do
            smoothMoveGoWoosh(pill, {TextColor3 = key == name and Color3.new(1, 1, 1) or MUTED}, 0.2)
        end
        smoothMoveGoWoosh(indicator, {Position = UDim2.new(0, S(4) + (pageIndex - 1) * pillW, 0, S(4))}, 0.32, Enum.EasingStyle.Quint)
    end
    local function newPanel(name)
        local index = #pageNames
        for i, pageName in ipairs(pageNames) do if pageName == name then index = i end end
        local button = makeThingExist("TextButton", {
            Text = name, AutoButtonColor = false, BackgroundTransparency = 1, FontFace = font(), TextSize = 12 * M, TextColor3 = MUTED,
            Position = UDim2.new(0, S(4) + (index - 1) * pillW, 0, 0), Size = UDim2.new(0, pillW, 1, 0), ZIndex = 3, Parent = switcher
        })
        makeThingExist("UITextSizeConstraint", {MaxTextSize = 12 * M, MinTextSize = 6, Parent = button})
        button.TextScaled = true
        pills[name] = button
        local panel = makeThingExist("ScrollingFrame", {
            BackgroundTransparency = 1, Size = UDim2.new(1, 0, 1, 0), CanvasSize = UDim2.new(0, 0, 0, 0), AutomaticCanvasSize = Enum.AutomaticSize.Y,
            ScrollBarThickness = 0, ScrollingDirection = Enum.ScrollingDirection.Y, BorderSizePixel = 0, Visible = false, Parent = panelArea
        })
        makeThingExist("UIListLayout", {Padding = UDim.new(0, S(6)), SortOrder = Enum.SortOrder.LayoutOrder, Parent = panel})
        self:EnableSmoothScrolling(panel, 18)
        panels[name] = panel
        button.MouseButton1Click:Connect(function() selectPanel(name) end)
        return panel
    end
    local function emptyState(parent, title, description)
        local holder = makeThingExist("Frame", {BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, S(180)), Parent = parent})
        local ring = makeThingExist("Frame", {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.93, AnchorPoint = Vector2.new(0.5, 0), Position = UDim2.new(0.5, 0, 0, S(30)), Size = UDim2.new(0, S(52), 0, S(52)), Parent = holder})
        makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = ring})
        makeThingExist("ImageLabel", {Image = pickLucide({"inbox", "package-open"}, ""), ImageColor3 = MUTED, BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5), Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.new(0, S(24), 0, S(24)), Parent = ring})
        label(holder, {Text = title, TextColor3 = Color3.fromRGB(200, 196, 214), FontFace = font(Enum.FontWeight.Bold), TextSize = 14 * M, TextXAlignment = Enum.TextXAlignment.Center, Position = UDim2.new(0, 0, 0, S(92)), Size = UDim2.new(1, 0, 0, S(20))})
        label(holder, {Text = description, TextColor3 = DIM, FontFace = font(Enum.FontWeight.Medium), TextXAlignment = Enum.TextXAlignment.Center, TextWrapped = true, TextYAlignment = Enum.TextYAlignment.Top, Position = UDim2.new(0, S(20), 0, S(114)), Size = UDim2.new(1, -S(40), 0, S(36))})
        return holder
    end

    -- row surface used by leaderboard + changelog entries
    local function rowSurface(parent, order, highlight)
        local frame = makeThingExist("Frame", {
            BackgroundColor3 = highlight and neon or Color3.new(1, 1, 1), BackgroundTransparency = highlight and 0.9 or 0.95, BorderSizePixel = 0, LayoutOrder = order, Parent = parent
        })
        makeThingExist("UICorner", {CornerRadius = UDim.new(0, 9), Parent = frame})
        makeThingExist("UIStroke", {Enabled = false, Color = highlight and neon or Color3.fromRGB(190, 170, 235), Transparency = highlight and 0.5 or 0.86, Parent = frame})
        return frame
    end

    ----------------------------------------------------------------------
    -- Leaderboard
    ----------------------------------------------------------------------
    if dash.Leaderboard ~= false then
        local lbCfg = type(dash.Leaderboard) == "table" and dash.Leaderboard or {}
        local panel = newPanel("Leaderboard")
        local PAGE_SIZE = math.max(1, tonumber(lbCfg.PageSize) or 10)
        local lb = {Rows = {}}
        local rendered = {}
        local page, query = 1, ""
        local medal = {Color3.fromRGB(255, 200, 66), Color3.fromRGB(196, 202, 214), Color3.fromRGB(214, 140, 90)}
        local rankAssets = {BADGE_ASSETS.Rank1, BADGE_ASSETS.Rank2, BADGE_ASSETS.Rank3}
        local function avatarColor(name)
            local hash = 0
            for index = 1, #name do hash = (hash * 31 + string.byte(name, index)) % 360 end
            return Color3.fromHSV(hash / 360, 0.5, 0.75)
        end
        local ROW_W = CW - S(24)
        local barX, execX, timeW = S(244), S(372), S(72)

        local function tierOfRow(row)
            local userId = row.UserId
            local name = row.Name or (type(row[1]) == "string" and row[1]) or nil
            local t = row.Tier and string.lower(tostring(row.Tier)) or ""
            return tierOfUser(userId, name, row.Premium == true or t == "vip" or t == "premium")
        end

        -- toolbar: search box (left) + pager "<  1 / 3  >" (right); built once, rows are rebuilt below it
        local toolbar = makeThingExist("Frame", {BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, S(28)), LayoutOrder = -1, Parent = panel})
        local pagerW = S(24) * 2 + S(56) + S(8)
        local searchFrame = makeThingExist("Frame", {
            BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.94, BorderSizePixel = 0,
            Size = UDim2.new(1, -(pagerW + S(8)), 1, 0), Parent = toolbar
        })
        makeThingExist("UICorner", {CornerRadius = UDim.new(0, 8), Parent = searchFrame})
        makeThingExist("UIStroke", {Enabled = false, Color = Color3.fromRGB(190, 170, 235), Transparency = 0.86, Parent = searchFrame})
        makeThingExist("ImageLabel", {
            Image = pickLucide({"search"}, ""), ImageColor3 = MUTED, BackgroundTransparency = 1, AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.new(0, S(9), 0.5, 0), Size = UDim2.new(0, S(14), 0, S(14)), Parent = searchFrame
        })
        local searchBox = makeThingExist("TextBox", {
            BackgroundTransparency = 1, ClearTextOnFocus = false, Text = "", PlaceholderText = "Search player...", PlaceholderColor3 = DIM,
            TextColor3 = Color3.new(1, 1, 1), FontFace = font(Enum.FontWeight.Medium), TextSize = 12 * M, TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd, Position = UDim2.new(0, S(30), 0, 0), Size = UDim2.new(1, -S(38), 1, 0), Parent = searchFrame
        })
        local pager = makeThingExist("Frame", {BackgroundTransparency = 1, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, 0, 0, 0), Size = UDim2.new(0, pagerW, 1, 0), Parent = toolbar})
        local function pagerButton(iconNames, fallbackText, xOffset)
            local btn = makeThingExist("TextButton", {
                Text = "", AutoButtonColor = false, BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.92, BorderSizePixel = 0,
                Position = UDim2.new(0, xOffset, 0, 0), Size = UDim2.new(0, S(24), 1, 0), Parent = pager
            })
            makeThingExist("UICorner", {CornerRadius = UDim.new(0, 7), Parent = btn})
            makeThingExist("UIStroke", {Enabled = false, Color = Color3.fromRGB(190, 170, 235), Transparency = 0.86, Parent = btn})
            local glyph = pickLucide(iconNames, "")
            local img = makeThingExist("ImageLabel", {
                Image = glyph, ImageColor3 = Color3.fromRGB(215, 212, 225), BackgroundTransparency = 1, AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.new(0, S(14), 0, S(14)), Parent = btn
            })
            if glyph == "" then
                label(btn, {Text = fallbackText, TextColor3 = Color3.fromRGB(215, 212, 225), TextSize = 14 * M, TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.new(1, 0, 1, 0)})
            end
            return btn, img
        end
        local prevBtn, prevImg = pagerButton({"chevron-left"}, "<", 0)
        local nextBtn, nextImg = pagerButton({"chevron-right"}, ">", S(24) + S(56) + S(8))
        local pageLabel = label(pager, {
            Text = "1 / 1", TextColor3 = Color3.fromRGB(215, 212, 225), TextSize = 11.5 * M, FontFace = font(Enum.FontWeight.SemiBold),
            TextXAlignment = Enum.TextXAlignment.Center, Position = UDim2.new(0, S(28), 0, 0), Size = UDim2.new(0, S(56), 1, 0)
        })

        local function render()
            for _, frame in ipairs(rendered) do frame:Destroy() end
            rendered = {}
            local rows = {}
            for index, row in ipairs(lb.Rows) do rows[index] = row end
            table.sort(rows, function(a, b)
                local av, bv = tonumber(a[2]) or 0, tonumber(b[2]) or 0
                if av ~= bv then return av > bv end
                return tostring(a[1]) < tostring(b[1])
            end)
            local maxValue = 1
            for _, row in ipairs(rows) do maxValue = math.max(maxValue, tonumber(row[2]) or 0) end

            -- global ranks are fixed before filtering, so a searched player keeps his real rank
            local filtered, needle = {}, string.lower(query)
            for rank, row in ipairs(rows) do
                if row.Highlight and self._onRankChanged then self._onRankChanged(rank) end
                local match = needle == ""
                if not match then
                    local display = string.lower(tostring(row[1]))
                    local user = row.Name and string.lower(tostring(row.Name)) or ""
                    match = string.find(display, needle, 1, true) ~= nil or string.find(user, needle, 1, true) ~= nil
                end
                if match then table.insert(filtered, {Row = row, Rank = rank}) end
            end
            local pages = math.max(1, math.ceil(#filtered / PAGE_SIZE))
            page = math.clamp(page, 1, pages)
            pageLabel.Text = page .. " / " .. pages
            prevImg.ImageTransparency = page <= 1 and 0.65 or 0
            nextImg.ImageTransparency = page >= pages and 0.65 or 0

            local header = makeThingExist("Frame", {BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, S(20)), LayoutOrder = 0, Parent = panel})
            makeThingExist("ImageLabel", {
                Image = BADGE_ASSETS.Rank, BackgroundTransparency = 1, Position = UDim2.new(0, S(10), 0.5, -S(7)), Size = UDim2.new(0, S(14), 0, S(14)), Parent = header
            })
            label(header, {Text = (needle ~= "" and ("Found  " .. #filtered .. " / " .. #rows) or ("Users  " .. #rows)), TextColor3 = DIM, TextSize = 11 * M, Position = UDim2.new(0, S(30), 0, 0), Size = UDim2.new(0, S(150), 1, 0)})
            label(header, {Text = "Executed", TextColor3 = DIM, TextSize = 11 * M, Position = UDim2.new(0, barX, 0, 0), Size = UDim2.new(0, S(100), 1, 0)})
            label(header, {Text = "Time", TextColor3 = DIM, TextSize = 11 * M, TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -S(12), 0, 0), Size = UDim2.new(0, timeW, 1, 0)})
            table.insert(rendered, header)

            if #filtered == 0 then
                local empty = emptyState(panel, "No player found", "Try another name.")
                empty.LayoutOrder = 1
                table.insert(rendered, empty)
                return
            end

            local first = (page - 1) * PAGE_SIZE + 1
            for position = first, math.min(#filtered, page * PAGE_SIZE) do
                local entry = filtered[position]
                local row, rank = entry.Row, entry.Rank
                local frame = rowSurface(panel, position, row.Highlight)
                frame.Size = UDim2.new(1, 0, 0, S(42))

                -- rank slot: icon for the top 3, number afterwards
                if rank <= 3 then
                    makeThingExist("ImageLabel", {
                        Image = rankAssets[rank], BackgroundTransparency = 1, ScaleType = Enum.ScaleType.Fit,
                        Position = UDim2.new(0, S(7), 0.5, -S(13)), Size = UDim2.new(0, S(26), 0, S(26)), Parent = frame
                    })
                else
                    local badge = makeThingExist("Frame", {
                        BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.92,
                        Position = UDim2.new(0, S(10), 0.5, -S(11)), Size = UDim2.new(0, S(22), 0, S(22)), Parent = frame
                    })
                    makeThingExist("UICorner", {CornerRadius = UDim.new(0, 6), Parent = badge})
                    label(badge, {Text = tostring(rank), TextColor3 = MUTED, Fit = 11, FontFace = font(Enum.FontWeight.Bold), TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.new(1, 0, 1, 0)})
                end

                local avatarImage = row.UserId and ("rbxthumb://type=AvatarHeadShot&id=" .. tostring(row.UserId) .. "&w=150&h=150")
                    or (row.Highlight and ("rbxthumb://type=AvatarHeadShot&id=" .. tostring(localPlayer.UserId) .. "&w=150&h=150") or "")
                local avatar = makeThingExist("ImageLabel", {
                    BackgroundColor3 = avatarColor(tostring(row[1])), Position = UDim2.new(0, S(40), 0.5, -S(14)), Size = UDim2.new(0, S(28), 0, S(28)), Image = avatarImage, Parent = frame
                })
                makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = avatar})
                if avatarImage == "" then
                    label(avatar, {Text = string.upper(string.sub(tostring(row[1]), 1, 1)), TextColor3 = Color3.new(1, 1, 1), Fit = 13, TextXAlignment = Enum.TextXAlignment.Center, FontFace = font(Enum.FontWeight.Bold), Size = UDim2.new(1, 0, 1, 0)})
                end

                -- name + tier icon (Member / VIP / Owner crown)
                local tierName = tierOfRow(row)
                local tierInfo = TIER_INFO[tierName]
                local nameMax = barX - S(78) - S(12) - S(20)
                local nameText = tostring(row[1])
                local nameW = math.min(textServiceBeLikeText:GetTextSize(nameText, 12.5 * M, Enum.Font.GothamSemibold, Vector2.new(400, 20)).X + S(4), nameMax)
                label(frame, {Text = nameText, TextColor3 = Color3.new(1, 1, 1), TextSize = 12.5 * M, Position = UDim2.new(0, S(78), 0, S(6)), Size = UDim2.new(0, nameW, 0, S(16))})
                if tierName ~= "Member" then -- members get no icon (avoids a wall of identical icons); VIP / Owner stand out
                    local tierIcon = badgeImage(frame, tierInfo.Asset, S(15), tierInfo.Fallback, tierInfo.Color)
                    tierIcon.Position = UDim2.new(0, S(78) + nameW + S(3), 0, S(6))
                end

                -- second line: rank star + "You" / "Rank #n"
                makeThingExist("ImageLabel", {
                    Image = BADGE_ASSETS.Rank, BackgroundTransparency = 1, Position = UDim2.new(0, S(78), 0, S(24)), Size = UDim2.new(0, S(12), 0, S(12)), Parent = frame
                })
                label(frame, {
                    Text = (row.Highlight and "You  ·  " or "") .. "Rank #" .. rank .. "  ·  Lv " .. tostring((levelOf(calcXP(row[2], row[3])))), TextColor3 = row.Highlight and neon or DIM, TextSize = 10.5 * M,
                    FontFace = font(Enum.FontWeight.Medium), Position = UDim2.new(0, S(93), 0, S(23)), Size = UDim2.new(0, barX - S(93) - S(12), 0, S(14))
                })

                local track = makeThingExist("Frame", {BackgroundColor3 = Color3.new(1, 1, 1), BackgroundTransparency = 0.9, BorderSizePixel = 0, Position = UDim2.new(0, barX, 0.5, -S(3)), Size = UDim2.new(0, execX - barX - S(14), 0, S(6)), Parent = frame})
                makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = track})
                local fill = makeThingExist("Frame", {BackgroundColor3 = neon, BorderSizePixel = 0, Size = UDim2.new(math.clamp((tonumber(row[2]) or 0) / maxValue, 0.03, 1), 0, 1, 0), Parent = track})
                makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = fill})
                makeThingExist("UIGradient", {Color = ColorSequence.new(neon:Lerp(Color3.fromRGB(32, 32, 34), 0.5), hot), Parent = fill})
                label(frame, {Text = tostring(row[2]), TextColor3 = Color3.fromRGB(190, 186, 205), TextSize = 11.5 * M, Position = UDim2.new(0, execX, 0, 0), Size = UDim2.new(0, ROW_W - execX - timeW - S(24), 1, 0)})
                label(frame, {Text = formatDuration(row[3]), TextColor3 = Color3.fromRGB(230, 228, 238), TextSize = 12 * M, TextXAlignment = Enum.TextXAlignment.Right, AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -S(12), 0, 0), Size = UDim2.new(0, timeW, 1, 0)})
                table.insert(rendered, frame)
            end
        end

        prevBtn.MouseButton1Click:Connect(function() if page > 1 then page = page - 1; render() end end)
        nextBtn.MouseButton1Click:Connect(function() page = page + 1; render() end) -- clamped inside render()
        local searchToken = 0
        searchBox:GetPropertyChangedSignal("Text"):Connect(function()
            query = searchBox.Text
            page = 1
            searchToken = searchToken + 1
            local mine = searchToken
            task.delay(0.15, function() if mine == searchToken and panel.Parent then render() end end)
        end)

        function lb:SetRows(rows) lb.Rows = rows or {}; render() end
        function lb:AddRow(row) table.insert(lb.Rows, row); render() end
        function lb:UpdateRow(index, row) if lb.Rows[index] then lb.Rows[index] = row; render() end end
        function lb:RemoveRow(index) if lb.Rows[index] then table.remove(lb.Rows, index); render() end end
        function lb:Clear() lb.Rows = {}; render() end
        self.LeaderboardTable = lb

        self._refreshLeaderboard = function()
            local usage = self:GetUsage()
            local lrm = self._luarmorInfo
            local executions = (lrm and lrm.Executions) or usage.Executions
            local function selfRow()
                return {localPlayer.DisplayName, executions, usage.Seconds, Highlight = true, UserId = localPlayer.UserId, Name = localPlayer.Name, Premium = self.config.IsPremium == true}
            end
            local rows = {selfRow()}
            for _, row in ipairs(lbCfg.Rows or {}) do table.insert(rows, row) end
            for _, row in ipairs(self._leaderboardExternalRows or {}) do table.insert(rows, row) end
            local adapter = self._leaderboardAdapter
            if adapter then
                if type(adapter.Push) == "function" then pcall(adapter.Push, {Name = localPlayer.Name, DisplayName = localPlayer.DisplayName, UserId = localPlayer.UserId, Executions = executions, Seconds = usage.Seconds, Tier = self._tier, Premium = self.config.IsPremium == true}) end
                if type(adapter.Fetch) == "function" then
                    local ok, fetched = pcall(adapter.Fetch)
                    if ok and type(fetched) == "table" then
                        rows = {}
                        local foundSelf = false
                        for _, row in ipairs(fetched) do
                            if row[1] == localPlayer.DisplayName or row[1] == localPlayer.Name or row.UserId == localPlayer.UserId then
                                row.Highlight = true; row.UserId = row.UserId or localPlayer.UserId; row.Name = row.Name or localPlayer.Name
                                row.Premium = row.Premium or self.config.IsPremium == true
                                foundSelf = true
                            end
                            table.insert(rows, row)
                        end
                        if not foundSelf then table.insert(rows, selfRow()) end
                    end
                end
            end
            lb:SetRows(rows)
        end
        self._refreshLeaderboard()
        -- tier changed (Free <-> Premium): refresh the local row's badge right away
        table.insert(self._tierListeners, function(_, _, changed) if changed and self._refreshLeaderboard then self._refreshLeaderboard() end end)
        task.spawn(function()
            while not self._destroyed do
                task.wait(lbCfg.Interval or 30)
                if self._refreshLeaderboard then pcall(self._refreshLeaderboard) end
            end
        end)
    end

    ----------------------------------------------------------------------
    -- Changelogs
    ----------------------------------------------------------------------
    do
        local panel = newPanel("Changelogs")
        local entries = dash.Changelogs or {{Title = "v1.0", Tag = "Latest", Changes = {"Initial release of " .. tostring(self.config.Name)}}}
        if #entries == 0 then
            emptyState(panel, "No changelog yet", "Release notes will show up here.")
        else
            for index, entry in ipairs(entries) do
                local frame = rowSurface(panel, index, false)
                frame.Size = UDim2.new(1, 0, 0, 0)
                frame.AutomaticSize = Enum.AutomaticSize.Y
                makeThingExist("UIPadding", {PaddingLeft = UDim.new(0, S(14)), PaddingRight = UDim.new(0, S(14)), PaddingTop = UDim.new(0, S(12)), PaddingBottom = UDim.new(0, S(12)), Parent = frame})
                makeThingExist("UIListLayout", {Padding = UDim.new(0, S(6)), SortOrder = Enum.SortOrder.LayoutOrder, Parent = frame})
                local top = makeThingExist("Frame", {BackgroundTransparency = 1, Size = UDim2.new(1, 0, 0, S(20)), LayoutOrder = 1, Parent = frame})
                local tagBounds = entry.Tag and textServiceBeLikeText:GetTextSize(tostring(entry.Tag), 11 * M, Enum.Font.GothamSemibold, Vector2.new(300, 20)).X + S(18) or 0
                label(top, {Text = tostring(entry.Title or ("Entry " .. index)), TextColor3 = Color3.new(1, 1, 1), FontFace = font(Enum.FontWeight.Bold), TextSize = 14 * M, Size = UDim2.new(1, -(tagBounds + S(10)), 1, 0)})
                if entry.Tag then
                    -- [v3.1] modern pill tag: fully rounded, subtle tint, uppercase bold, hairline border
                    local tagText = string.upper(tostring(entry.Tag))
                    local tagColor = index == 1 and neon or Color3.fromRGB(165, 160, 185)
                    local tw = textServiceBeLikeText:GetTextSize(tagText, 10 * M, Enum.Font.GothamBold, Vector2.new(300, 20)).X
                    local pill = makeThingExist("Frame", {
                        BackgroundColor3 = tagColor, BackgroundTransparency = index == 1 and 0.82 or 0.92, BorderSizePixel = 0,
                        AnchorPoint = Vector2.new(1, 0.5), Position = UDim2.new(1, 0, 0.5, 0), Size = UDim2.new(0, tw + S(18), 0, S(18)), Parent = top
                    })
                    makeThingExist("UICorner", {CornerRadius = UDim.new(1, 0), Parent = pill})
                    makeThingExist("UIStroke", {Enabled = false, Color = tagColor, Transparency = 0.75, Parent = pill})
                    -- [v7] dot pada tag "Latest" dihapus
                    label(pill, {Text = tagText, TextColor3 = tagColor:Lerp(Color3.new(1, 1, 1), 0.25), TextSize = 10 * M, FontFace = font(Enum.FontWeight.Bold),
                        TextXAlignment = Enum.TextXAlignment.Center, Size = UDim2.new(1, 0, 1, 0)})
                end
                local lines = {}
                if type(entry.Changes) == "table" then for _, change in ipairs(entry.Changes) do table.insert(lines, "•  " .. tostring(change)) end end
                if entry.Content then table.insert(lines, tostring(entry.Content)) end
                label(frame, {
                    Text = table.concat(lines, "\n"), TextColor3 = Color3.fromRGB(165, 160, 185), FontFace = font(Enum.FontWeight.Medium), TextSize = 12 * M,
                    TextWrapped = true, TextTruncate = Enum.TextTruncate.None, TextYAlignment = Enum.TextYAlignment.Top, RichText = true,
                    Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = 2
                })
            end
        end
    end

    local defaultPage = dash.DefaultPage
    if not panels[defaultPage or ""] then defaultPage = pageNames[1] end
    selectPanel(defaultPage)
end

function superMegaAwesomeLibrary:SetAutoSave(enabled) self._autoSaveEnabled = enabled == true end

function superMegaAwesomeLibrary:_InitConfigSaving()
    local saving = self.config.ConfigurationSaving
    if type(saving) ~= "table" or not saving.Enabled then return end
    task.delay(2, function()
        if self._destroyed then return end
        local path = self._cfgFolder .. "/" .. sanitizeConfigName(self._cfgFile) .. ".json"
        pcall(function()
            if isfile and isfile(path) then self:LoadConfig(self._cfgFile) end
        end)
        while not self._destroyed do
            task.wait(8)
            if self._autoSaveEnabled and not self._destroyed then pcall(function() self:SaveConfig(self._cfgFile) end) end
        end
    end)
end

-- v6: intro NEMESIS dihapus (no-op supaya pemanggil lama tidak error)
function superMegaAwesomeLibrary:_ShowLoadingSplash() end

function superMegaAwesomeLibrary:_InitNemesisPlus()
    self:_InitUsageStats()
    local dash = self.config.Dashboard
    if dash ~= false then
        local ok, err = pcall(function() self:_BuildDashboard(type(dash) == "table" and dash or {}) end)
        if not ok then warn("[Nemesis] Dashboard failed to build: " .. tostring(err)) end
    end
    self:_InitInGameBadge()
    self:_InitConfigSaving()
    self:_ShowLoadingSplash()
end


function superMegaAwesomeLibrary:SetAccentColor(color)
    if typeof(color) ~= "Color3" then
        return
    end
    -- [v7] hanya warna dari Accent color / Theme preset yang diterima
    local function near(a, b) return math.abs(a.R - b.R) < 0.012 and math.abs(a.G - b.G) < 0.012 and math.abs(a.B - b.B) < 0.012 end
    local allowed = false
    for _, c in pairs(superMegaAwesomeLibrary.AccentColors) do if near(color, c) then allowed = true end end
    for _, t in pairs(superMegaAwesomeLibrary.Themes or {}) do if t.Accent and near(color, t.Accent) then allowed = true end end
    if not allowed then return end
    local oldAccent = self.config.AccentColor
    self.config.AccentColor = color
    self:_SwapAccentColors(oldAccent, color)
    for _, section in ipairs(self.sectionsAreAwesome) do
        for _, tab in ipairs(section.tabsInSection or {}) do
            if tab.isActive and tab.buttonFrame then
                tab.buttonFrame.BackgroundColor3 = color
            end
            for _, group in ipairs(tab.groupsInTab or {}) do
                for _, element in ipairs(group.elementsInGroup or {}) do
                    if type(element) == "table" then
                        if element.switchFrame and element.value == true then
                            element.switchFrame.BackgroundColor3 = color
                        end
                        if element.fillFrame then
                            element.fillFrame.BackgroundColor3 = color
                        end
                        if type(element._RefreshAccent) == "function" then pcall(element._RefreshAccent) end
                        if element.toggleSwitchFrame and element.toggleValue == true then
                            element.toggleSwitchFrame.BackgroundColor3 = color
                        end
                    end
                end
            end
        end
    end
    self:_RefreshAccentCore()
    if self.uiSettingsToggleRefs then
        for _, toggleRef in ipairs(self.uiSettingsToggleRefs) do
            if toggleRef and type(toggleRef.Get) == "function" and type(toggleRef.Set) == "function" then
                toggleRef.Set(toggleRef.Get(), true)
            end
        end
    end
    self:_UpdateESPPreview(0)
end

function superMegaAwesomeLibrary:Destroy()
    if self._destroyed then return end
    self._destroyed = true

    for _, section in ipairs(self.sectionsAreAwesome) do
        for _, tab in ipairs(section.tabsInSection or {}) do
            for _, group in ipairs(tab.groupsInTab or {}) do
                for _, element in ipairs(group.elementsInGroup or {}) do
                    if type(element) == "table" and type(element.Close) == "function" then
                        pcall(function()
                            element:Close()
                        end)
                    end
                end
            end
        end
    end

    if self.currentTabYay and type(self.currentTabYay.Deactivate) == "function" then
        pcall(function()
            self.currentTabYay:Deactivate()
        end)
        self.currentTabYay = nil
    end

    for i = #self._connections, 1, -1 do
        local conn = self._connections[i]
        if conn and typeof(conn) == "RBXScriptConnection" then
            pcall(function()
                if conn.Connected then
                    conn:Disconnect()
                end
            end)
        end
        self._connections[i] = nil
    end

    if self._scrollDriver then self._scrollDriver:Disconnect(); self._scrollDriver = nil end
    self._badgeEnabled = false
    if self._badgeGui then pcall(function() self._badgeGui:Destroy() end); self._badgeGui = nil end
    self._smoothScrollFrames = {}
    self._trackedControls = {}
    self:_ClearSnowflakes()
    self:_DestroyESPPreviewCharacter()
    self._fpsRollingWindow = {}
    self._fpsRollingTotal = 0
    self._latestFPSValue = 0
    self._espPreviewState = nil
    self._espPreviewProvider = nil
    self._espPreviewData = nil
    self._espPreviewWalkTrack = nil
    self._espPreviewAnimationId = nil
    self._espPreviewAvatar3DUserId = nil
    self._espPreviewAvatar3DImageUrl = nil
    self._espPreviewRotationYaw = nil
    self._espPreviewRotationTargetYaw = nil
    self._espPreviewPivotYOffset = nil
    self._espPreviewRotateCapture = nil
    self._espPreviewIsRotating = false
    self._espPreviewRotateInput = nil
    self._espPreviewRotateLastX = nil
    self._textGradientAnimationTime = nil

    if self._blurEffectRef and self._blurEffectRef.Parent then
        self._blurEffectRef:Destroy()
    end
    self._blurEffectRef = nil

    if self._espPreviewPanel and self._espPreviewPanel.Parent then
        self._espPreviewPanel:Destroy()
    end
    self._espPreviewPanel = nil
    self._espPreviewViewport = nil
    self._espPreviewWorldModel = nil
    self._espPreviewCamera = nil
    self._espPreviewHighlight = nil
    self._espPreviewHeaderTag = nil
    self._espPreviewBox = nil
    self._espPreviewBoxStroke = nil
    self._espPreviewHealthTrack = nil
    self._espPreviewHealthFill = nil
    self._espPreviewDot = nil
    self._espPreviewTracer = nil
    self._espPreviewName = nil
    self._espPreviewItem = nil
    self._espPreviewDistance = nil
    self._espPreviewRotateCapture = nil

    if self.screenGuiYay and self.screenGuiYay.Parent then
        self.screenGuiYay:Destroy()
    end
end
-- ==========================================
-- FUNGSI ADD CONFIG SECTION (FULL WIDTH & DOUBLE BUTTONS)
-- ==========================================
function superMegaAwesomeLibrary:AddConfigSection(tabObj, options)
    options = options or {}
    local groupIcon = options.Icon or "rbxassetid://10723427199"

    local ConfigGroup = tabObj:AddGroup({ 
        Name = options.Name or "Config Manager", 
        Side = "Full",
        Icon = groupIcon
    })

    -- Pre-declare variabel agar saling terhubung
    local ConfigDropdown
    local ConfigInput
    local configNameInput = ""
    local selectedConfig = ""

    local function getConfigs()
        local list = {}
        if isfolder and isfolder(self._cfgFolder or "NemesisUIConfigs") and listfiles then
            for _, file in ipairs(listfiles(self._cfgFolder or "NemesisUIConfigs")) do
                if file:match("%.json$") then
                    local name = file:match("([^/\\]+)%.json$")
                    table.insert(list, name)
                end
            end
        end
        if #list == 0 then table.insert(list, "None") end
        return list
    end

    ConfigDropdown = ConfigGroup:AddDropdown({
        Name = "Select Config",
        Options = getConfigs(),
        Default = getConfigs()[1],
        Flag = "Config_Select",
        Callback = function(Option)
            selectedConfig = (Option ~= "None") and Option or ""
            
            -- [PERBAIKAN BUG]: Mengosongkan teks input otomatis saat memilih dropdown
            -- Ini mencegah file config lama tertimpa nama yang masih nyangkut di kotak teks
            if ConfigInput and ConfigInput.Set then
                ConfigInput:Set("")
                configNameInput = ""
            end
        end
    })

    ConfigInput = ConfigGroup:AddTextInput({
        Name = "Config Name",
        Placeholder = "Enter new config name...",
        Default = "",
        Flag = "Config_Name",
        Callback = function(Text)
            configNameInput = Text or ""
        end
    })

    ConfigGroup:AddDivider()

    -- Baris Pertama: Update (Kiri) & Load (Kanan)
    ConfigGroup:AddDoubleButton({
        Button1 = {
            Name = "Update Config", -- [NAMA DIGANTI]
            Callback = function()
                local newConfigs = getConfigs()
                ConfigDropdown:UpdateOptions(newConfigs)
                
                -- [PERBAIKAN BUG]: Memaksa UI untuk memilih ulang list terbaru agar sinkron
                local targetSelect = "None"
                if table.find(newConfigs, selectedConfig) then
                    targetSelect = selectedConfig
                elseif #newConfigs > 0 and newConfigs[1] ~= "None" then
                    targetSelect = newConfigs[1]
                end
                
                ConfigDropdown:Set(targetSelect)
                selectedConfig = (targetSelect ~= "None") and targetSelect or ""
                
                self:Notify({Title = "Updated", Description = "Config list has been updated.", Duration = 2})
            end
        },
        Button2 = {
            Name = "Load Config",
            Callback = function()
                -- Mengambil nilai langsung dari dropdown UI untuk memastikan sinkronisasi
                local finalConfig = selectedConfig
                if ConfigDropdown.Value and type(ConfigDropdown.Value) == "string" and ConfigDropdown.Value ~= "None" then
                    finalConfig = ConfigDropdown.Value
                end
                
                if finalConfig == "" or finalConfig == "None" then
                    self:Notify({Title = "Error", Description = "Please select a config to load!", Duration = 3})
                    return
                end
                
                local success, err = self:LoadConfig(finalConfig)
                if success then
                    self:Notify({Title = "Loaded", Description = "Config '" .. finalConfig .. "' loaded!", Duration = 3})
                    selectedConfig = finalConfig
                else
                    self:Notify({Title = "Failed", Description = tostring(err), Duration = 3})
                end
            end
        }
    })

    -- Baris Kedua: Save (Kiri) & Delete (Kanan - WARNA MERAH)
    ConfigGroup:AddDoubleButton({
        Button1 = {
            Name = "Save / Create",
            Callback = function()
                local fallbackSelection = ConfigDropdown.Value or selectedConfig
                local nameToSave = (configNameInput ~= "") and configNameInput or selectedConfig 
                
                if nameToSave == "" or nameToSave == "None" then
                    self:Notify({Title = "Error", Description = "Please enter a name or select a config!", Duration = 3})
                    return
                end
                
                local success, err = self:SaveConfig(nameToSave)
                if success then
                    self:Notify({Title = "Saved", Description = "Config '" .. nameToSave .. "' saved!", Duration = 3})
                    
                    -- Update list otomatis setelah berhasil Save
                    local newConfigs = getConfigs()
                    ConfigDropdown:UpdateOptions(newConfigs)
                    ConfigDropdown:Set(nameToSave)
                    selectedConfig = nameToSave
                    
                    -- Kosongkan kotak teks input setelah save selesai
                    if ConfigInput and ConfigInput.Set then
                        ConfigInput:Set("")
                        configNameInput = ""
                    end
                else
                    self:Notify({Title = "Failed", Description = tostring(err), Duration = 3})
                end
            end
        },
        Button2 = {
            Name = "Delete Config",
            IsRed = true,
            Callback = function()
                local targetConfig = ConfigDropdown.Value or selectedConfig
                if targetConfig == "" or targetConfig == "None" then return end
                
                local path = (self._cfgFolder or "NemesisUIConfigs") .. "/" .. targetConfig .. ".json"
                if isfile and delfile and isfile(path) then
                    delfile(path)
                    self:Notify({Title = "Deleted", Description = "Config '".. targetConfig .."' deleted.", Duration = 3})
                    
                    local newConfigs = getConfigs()
                    ConfigDropdown:UpdateOptions(newConfigs)
                    ConfigDropdown:Set(newConfigs[1])
                    selectedConfig = (newConfigs[1] ~= "None") and newConfigs[1] or ""
                end
            end
        }
    })

    ConfigGroup:AddDivider()
    
    local ImportInputBox = ConfigGroup:AddTextInput({
        Name = "Import Code",
        Placeholder = "Paste config code here...",
        Default = "",
        Flag = "Config_ImportCode",
        Callback = function(Text)
        end
    })
    
    ConfigGroup:AddDoubleButton({
        Button1 = {
            Name = "Import Config",
            Callback = function()
                local codeToImport = ImportInputBox:Get()

                if not codeToImport or codeToImport == "" then
                    if getclipboard then
                        pcall(function() codeToImport = getclipboard() end)
                    end
                    
                    if not codeToImport or codeToImport == "" then
                        self:Notify({Title = "Error", Description = "Please paste the code into the box first!", Duration = 4})
                        return
                    end
                end

                local okDecode, data = pcall(function()
                    return httpServiceNoCap:JSONDecode(codeToImport)
                end)
                
                if not okDecode or type(data) ~= "table" or type(data.controls) ~= "table" then
                    self:Notify({Title = "Error", Description = "Invalid config code!", Duration = 3})
                    return
                end
                
                for flag, rawValue in pairs(data.controls) do
                    local control = self._trackedControls[flag]
                    if control then
                        local decodedValue = deserializeConfigValue(rawValue)
                        pcall(control.set, decodedValue)
                    end
                end
                
                ImportInputBox:Set("")
                self:Notify({Title = "Imported!", Description = "Config successfully applied to your UI.", Duration = 3})
            end
        },
        Button2 = {
            Name = "Export to Clipboard",
            Callback = function()
                local payload = {
                    version = 1,
                    ui = self.config.Name,
                    controls = {}
                }
                
                for flag, control in pairs(self._trackedControls) do
                    local ok, value = pcall(control.get)
                    if ok then
                        payload.controls[flag] = serializeConfigValue(value)
                    end
                end
                
                local okEncode, encoded = pcall(function() 
                    return httpServiceNoCap:JSONEncode(payload) 
                end)
            
                if okEncode and setclipboard then
                    setclipboard(encoded)
                    self:Notify({Title = "Exported!", Description = "Config code copied to clipboard!", Duration = 4})
                else
                    self:Notify({Title = "Failed", Description = "Executor doesn't support setclipboard.", Duration = 3})
                end
            end
        }
    })

    ConfigGroup:AddDivider()

    ConfigGroup:AddDoubleButton({
        Button1 = {
            Name = "Set Autoload",
            Callback = function()
                local targetConfig = ConfigDropdown.Value or selectedConfig
                if targetConfig == "" or targetConfig == "None" then return end
                if writefile then
                    writefile((self._cfgFolder or "NemesisUIConfigs") .. "/autoload.txt", targetConfig)
                    self:Notify({Title = "Autoload Set", Description = targetConfig .. " will load on execute.", Duration = 3})
                end
            end
        },
        Button2 = {
            Name = "Clear Autoload",
            Callback = function()
                if isfile and delfile and isfile((self._cfgFolder or "NemesisUIConfigs") .. "/autoload.txt") then
                    delfile((self._cfgFolder or "NemesisUIConfigs") .. "/autoload.txt")
                    self:Notify({Title = "Autoload Cleared", Description = "Autoload disabled.", Duration = 3})
                end
            end
        }
    })

    local cfgFolderName = self._cfgFolder or "NemesisUIConfigs"
    if isfile and readfile and isfile(cfgFolderName .. "/autoload.txt") then
        local autoConfigName = readfile(cfgFolderName .. "/autoload.txt")
        if autoConfigName ~= "" and isfile(cfgFolderName .. "/" .. autoConfigName .. ".json") then
            local success = self:LoadConfig(autoConfigName)
            if success then
                self:Notify({
                    Title = "Autoload Success",
                    Description = "Automatically loaded config: " .. autoConfigName,
                    Duration = 4
                })
                ConfigDropdown:Set(autoConfigName)
            end
        end
    end
end

-- ====
-- [v3.1] EXTENSIONS: accent presets, nickname privacy, badge visibility, ESP part forcefields, Config tab
-- ====

-- Accent presets. "Default" = the original purple used by this library (unchanged).
superMegaAwesomeLibrary.AccentColors = {
    Default = Color3.fromRGB(123, 47, 190), -- = Royal (accent default UI)
    Royal   = Color3.fromHex and Color3.fromHex("#7B2FBE") or Color3.fromRGB(123, 47, 190),
    Amethyst = Color3.fromHex and Color3.fromHex("#9B59B6") or Color3.fromRGB(155, 89, 182),
    Plum    = Color3.fromHex and Color3.fromHex("#6C3483") or Color3.fromRGB(108, 52, 131),
}
superMegaAwesomeLibrary.AccentColorOrder = {"Royal", "Amethyst", "Plum"}

local function colorsClose(a, b)
    return math.abs(a.R - b.R) < 0.012 and math.abs(a.G - b.G) < 0.012 and math.abs(a.B - b.B) < 0.012
end

-- walks the whole UI and replaces every colour derived from the old accent with the new one
function superMegaAwesomeLibrary:_SwapAccentColors(oldColor, newColor)
    if typeof(oldColor) ~= "Color3" or typeof(newColor) ~= "Color3" or not self.screenGuiYay then return end
    local dark = Color3.fromRGB(20, 20, 20)
    local pairsList = {
        {oldColor, newColor},
        {neonOf(oldColor), neonOf(newColor)},
        {oldColor:Lerp(dark, 0.35), newColor:Lerp(dark, 0.35)},
        {oldColor:Lerp(dark, 0.15), newColor:Lerp(dark, 0.15)},
        {oldColor:Lerp(Color3.new(1, 1, 1), 0.35), newColor:Lerp(Color3.new(1, 1, 1), 0.35)},
    }
    local props = {"BackgroundColor3", "TextColor3", "ImageColor3", "Color", "ScrollBarImageColor3"}
    for _, inst in ipairs(self.screenGuiYay:GetDescendants()) do
        for _, prop in ipairs(props) do
            local ok, value = pcall(function() return inst[prop] end)
            if ok and typeof(value) == "Color3" then
                for _, pair in ipairs(pairsList) do
                    if colorsClose(value, pair[1]) then
                        pcall(function() inst[prop] = pair[2] end)
                        break
                    end
                end
            end
        end
    end
end

-- Window:SetAccentPreset("Default" | "Royal" | "Amethyst" | "Plum")
function superMegaAwesomeLibrary:SetAccentPreset(name)
    local color = superMegaAwesomeLibrary.AccentColors[name]
    if color then self:SetAccentColor(color) end
end

-- ---- Nickname privacy + badge customisation ----
function superMegaAwesomeLibrary:SetHideUsername(hidden)
    self._hideUsername = hidden == true
    local lp = theOneAndOnlyPlayer
    if self._heroNameLabel then self._heroNameLabel.Text = self._hideUsername and "Hidden" or lp.DisplayName end
    if self._heroUserLabel then self._heroUserLabel.Text = self._hideUsername and "@••••••" or ("@" .. lp.Name) end
    if self._LayoutHeroIdentity then pcall(self._LayoutHeroIdentity) end
end

function superMegaAwesomeLibrary:SetHideAvatar(hidden)
    self._hideAvatar = hidden == true
    if self._heroAvatar then
        self._heroAvatar.ImageTransparency = self._hideAvatar and 1 or 0
    end
end

-- Badges the player owns (shown in the Nickname section). Key -> label.
function superMegaAwesomeLibrary:GetOwnedBadges()
    local list = {}
    local tier = self._tier or "Member"
    table.insert(list, {Key = "Tier", Name = (TIER_INFO[tier] or TIER_INFO.Member).Label .. " badge", Asset = (TIER_INFO[tier] or TIER_INFO.Member).Asset})
    table.insert(list, {Key = "Level", Name = "Level " .. tostring(self._level or 1) .. " badge", Asset = LEVELS[self._level or 1].Asset})
    if self._rank and self._rank <= 3 then
        table.insert(list, {Key = "Rank", Name = "Top " .. tostring(self._rank) .. " rank badge", Asset = BADGE_ASSETS["Rank" .. tostring(self._rank)]})
    else
        table.insert(list, {Key = "Rank", Name = "Rank badge (top 3 only)", Asset = BADGE_ASSETS.Rank})
    end
    return list
end

-- Window:SetBadgeVisible("Tier" | "Level" | "Rank", bool) : hides / shows the badge in the dashboard and above your head
function superMegaAwesomeLibrary:SetBadgeVisible(key, visible)
    self._hiddenBadges = self._hiddenBadges or {}
    self._hiddenBadges[key] = visible == false
    if key == "Tier" and self._heroTierIcon then self._heroTierIcon.Visible = visible ~= false end
    if key == "Rank" and self._heroRankIcon then
        self._heroRankIcon.Visible = visible ~= false and self._rank ~= nil and self._rank <= 3
    end
    if self._LayoutHeroIdentity then pcall(self._LayoutHeroIdentity) end
    if self._RefreshInGameBadge then pcall(self._RefreshInGameBadge, self) end
end

-- v4: fitur forcefield per-part dihapus. Stub no-op agar skrip lama tidak error.
function superMegaAwesomeLibrary:SetESPPartForceField(partGroup, enabled, color) end
function superMegaAwesomeLibrary:SetESPPartColor(partGroup, color) end

-- ---- Config tab ----
-- Window:createTab / Window:createSection style helpers + a ready-made Config tab with a "Settings" section.
function superMegaAwesomeLibrary:createSection(name, icon)
    local cfg = type(name) == "table" and name or {Name = name, Icon = icon}
    return self:AddSection(cfg)
end

function superMegaAwesomeLibrary:CreateConfigTab(options)
    options = options or {}
    local section = self:AddSection({Name = options.SectionName or "Settings", Icon = options.SectionIcon or "lucide:settings-2"})
    local tab = section:AddTab({Name = options.Name or "Config", Description = options.Description or "Settings and appearance", Icon = options.Icon or "lucide:save-all"})
    section.createTab = function(_, n, d, i) return section:AddTab(type(n) == "table" and n or {Name = n, Description = d, Icon = i}) end
    tab.createSection = function(_, n, side, i) return tab:AddGroup(type(n) == "table" and n or {Name = n, Side = side or "Left", Icon = i}) end

    -- v4: Config tab berisi HANYA Config Manager.
    -- Settings dipindah ke tab "UI Settings"; Nickname -> grup "Profile & Privacy" (ikon eye/eye-off).
    -- v5: grup Settings & Nickname dipindah ke tab Dashboard (Config hanya Config Manager)
    -- v6: Settings & Nickname sekarang ada di popup "UI Settings" (tombol kiri-bawah window)
    pcall(function() self:AddConfigSection(tab, {Name = "Config Manager"}) end)
    self.ConfigTab = {Section = section, Tab = tab}
    return self.ConfigTab
end

superMegaAwesomeLibrary.CreateSection = superMegaAwesomeLibrary.AddSection -- backwards compatible alias

-- ==========================================================================
-- Built-in demo: executing this file directly opens a full example window.
-- Set RUN_DEMO = false (or getgenv().NemesisLibraryOnly = true before loading) when other scripts load this as a library.
-- ==========================================================================
local RUN_DEMO = false -- set to true to re-enable the built-in demo
local libraryOnly = false
pcall(function() libraryOnly = getgenv().NemesisLibraryOnly == true end)
if RUN_DEMO and not libraryOnly then
    local Library = superMegaAwesomeLibrary
    local okDemo, errDemo = pcall(function()
        local Window = Library.new({
            Name = "NEMESIS",
            BackgroundColor = Color3.fromRGB(16, 16, 16),
            LoadingSubtitle = "Example",
            Theme = "Default", -- "Default", "Midnight", "Moss", "Ember", "Rose", "Mono" or a table {Accent=, Background=, Secondary=}
            ToggleUIKeybind = "RightControl", -- "RightShift", "LeftAlt", "Insert", "F1", ... or Enum.KeyCode.RightShift
            ConfigurationSaving = { Enabled = true, FolderName = "NemesisExample", FileName = "default" },
            IsPremium = false, -- fallback only: overwritten automatically by Luarmor (LRM_IsUserPremium) when available
            -- Optional Luarmor key check (docs.luarmor.net -> Key Check Library):
            -- Luarmor = { ScriptId = "YOUR_SCRIPT_ID", Key = script_key },

            -- The Dashboard tab is built automatically: bento overview cards + a glass Community card
            -- (Leaderboard and Changelogs).
            -- Set Dashboard = false to disable it.
            Dashboard = {
                Name = "Dashboard",
                Welcome = "Welcome back",
                Version = "1.3", -- tier badge (Member / VIP / Owner) is synced from Luarmor automatically
                Stats = { "FPS", "Ping", "Executor", "Game", "Region", "Time" },
                Changelogs = {
                    { Title = "v1.3", Tag = "Latest", Changes = { "Premium / Locked / Fixing states", "Stepper, Progress, Image and Table", "Dashboard redesign (glass bento layout)" } },
                    { Title = "v1.2", Tag = "Sep 12", Changes = { "Collapsible groups", "Auto layout paragraphs" } },
                },
                Leaderboard = { Interval = 30 },           -- local prototype; connect later with Window:SetLeaderboardAdapter
            },
        })

        local Main = Window:AddSection({ Name = "Examples", Icon = "lucide:layout-grid" })

        ----------------------------------------------------------------------
        -- Elements
        ----------------------------------------------------------------------
        local Elements = Main:AddTab({ Name = "Elements", Description = "One of everything", Icon = "lucide:layout-grid" })

        local Buttons = Elements:AddGroup({ Name = "Buttons", Side = "Left", Icon = "lucide:mouse-pointer-click" })
        Buttons:AddSection("Styles")
        Buttons:AddButton({ Name = "Example button", Desc = "Example description", Icon = "lucide:mouse-pointer-click", Callback = function() print("button") end })
        Buttons:AddButton({ Name = "Primary button", Style = "Primary", Callback = function() print("primary") end })
        Buttons:AddButton({ Name = "Danger button", Style = "Danger", Icon = "lucide:trash-2", Callback = function() print("danger") end })
        Buttons:AddButton({ Name = "Click twice to run", Confirm = true, Icon = "lucide:shield-check", Callback = function() print("confirmed") end })
        Buttons:AddSection("States")
        Buttons:AddButton({ Name = "Locked button", Desc = "Locked = true", Locked = true })
        Buttons:AddButton({ Name = "Premium button", Desc = "Premium = true (gold)", Premium = true })
        Buttons:AddButton({ Name = "Fixing button", Desc = "Fixing = true (Perbaikan)", Fixing = true })
        Buttons:AddDoubleButton({
            Button1 = { Name = "Left", Callback = function() print("left") end },
            Button2 = { Name = "Right", Callback = function() print("right") end },
        })

        local Toggles = Elements:AddGroup({ Name = "Toggles", Side = "Right", Icon = "lucide:toggle-right" })
        local ExampleToggle = Toggles:AddToggle({ Name = "Example toggle", Desc = "Example description", Default = false, Flag = "ExampleToggle", Callback = function(v) print("toggle", v) end })
        Toggles:AddToggle({ Name = "Lock the toggle above", Callback = function(v) ExampleToggle:SetLocked(v, "Locked by the switch below") end })
        Toggles:AddToggle({ Name = "Locked toggle", Locked = true })
        Toggles:AddToggle({ Name = "Premium toggle", Premium = true })
        Toggles:AddToggle({ Name = "Fixing toggle", Fixing = true })

        local Values = Elements:AddGroup({ Name = "Sliders", Side = "Left", Icon = "lucide:sliders-horizontal" })
        Values:AddSlider({ Name = "Example slider", Desc = "Click the value to type a number", Range = { 0, 100 }, Increment = 1, Suffix = "%", CurrentValue = 50, Flag = "ExampleSlider", Callback = function(v) print("slider", v) end })
        Values:AddSlider({ Name = "Decimal slider", Min = 0, Max = 2, Increment = 0.05, Default = 1, Flag = "DecimalSlider" })

        local Steppers = Elements:AddGroup({ Name = "Stepper & Progress", Side = "Right", Icon = "lucide:gauge" })
        Steppers:AddStepper({ Name = "Example stepper", Range = { 0, 10 }, Increment = 0.5, CurrentValue = 5, Flag = "ExampleStepper", Callback = function(v) print("stepper", v) end })
        local Progress = Steppers:AddProgress({ Name = "Example progress", CurrentValue = 0.35 })
        Steppers:AddButton({ Name = "Advance progress", Callback = function() Progress:Set(math.min(1, Progress:Get() + 0.15)) end })

        local Text = Elements:AddGroup({ Name = "Text", Side = "Full", Icon = "lucide:text" })
        Text:AddSection({ Name = "Paragraph", Icon = "lucide:align-left" })
        local Para = Text:AddParagraph({ Title = "Auto layout", Content = "Long text wraps by itself, no Lines value is needed. The group grows and everything below moves down with it, even if you change the text later with :SetContent()." })
        Text:AddButton({ Name = "Make the paragraph longer", Callback = function()
            Para:SetContent("Longer text now. " .. string.rep("This keeps wrapping over as many lines as it needs. ", 6))
        end })
        Text:AddLabel({ Text = "Label" })
        Text:AddDivider()
        Text:AddEmpty({ Title = "Empty element", Description = "Use it when a list has nothing to show yet." })

        ----------------------------------------------------------------------
        -- Media (Image + Table)
        ----------------------------------------------------------------------
        local Media = Main:AddTab({ Name = "Media", Description = "Images and tables", Icon = "lucide:image" })
        local Pictures = Media:AddGroup({ Name = "Images", Side = "Left", Icon = "lucide:image" })
        Pictures:AddImage({ Name = "Gradient preset", Image = "Deep Violet", Height = 110, Caption = "Presets: Deep Violet, Ocean, Sunset, Forest, Mono" })
        Pictures:AddImage({ Name = "Avatar", Image = "Avatar", Height = 130, Caption = "Your avatar bust" })
        local Tables = Media:AddGroup({ Name = "Tables", Side = "Right", Icon = "lucide:table" })
        local Board = Tables:AddTable({
            Name = "Leaderboard", Rank = true, MaxRows = 5, SortBy = "Score",
            Columns = { "Player", { Name = "Score", Align = "Right", Width = 0.25 }, { Name = "Balance", Align = "Right", Width = 0.3, Format = function(v) return "$" .. v end } },
            Rows = { { "Player One", 42, 12500 }, { "Player Two", 57, 9800 }, { "You", 31, 15200, Highlight = true }, { "Player Four", 12, 300 } },
            Callback = function(Row, Index) print("row", Row[1], Index) end,
        })
        Tables:AddButton({ Name = "Add random row", Callback = function() Board:AddRow({ "Guest" .. math.random(100, 999), math.random(1, 80), math.random(100, 20000) }) end })

        ----------------------------------------------------------------------
        -- Popups
        ----------------------------------------------------------------------
        local Popups = Main:AddTab({ Name = "Popups", Description = "Notifications and dialogs", Icon = "lucide:bell" })
        local Notifs = Popups:AddGroup({ Name = "Notifications", Side = "Left", Icon = "lucide:bell" })
        for _, Kind in ipairs({ "Info", "Success", "Warning", "Error" }) do
            Notifs:AddButton({ Name = Kind, Callback = function()
                Window:Notify({ Title = Kind, Content = "This is a " .. string.lower(Kind) .. " notification.", Type = Kind, Duration = 4 })
            end })
        end
        local Dialogs = Popups:AddGroup({ Name = "Confirm & Dialog", Side = "Right", Icon = "lucide:message-square" })
        Dialogs:AddButton({ Name = "Confirm", Style = "Primary", Callback = function()
            Window:Confirm({ Title = "Delete config", Content = "Remove this config? This cannot be undone.", ConfirmText = "Delete", Danger = true,
                Callback = function() Window:Notify({ Title = "Deleted", Type = "Success" }) end,
                OnCancel = function() Window:Notify({ Title = "Cancelled", Type = "Info" }) end })
        end })
        Dialogs:AddButton({ Name = "Dialog with 3 buttons", Callback = function()
            Window:Dialog({ Title = "Choose", Content = "A dialog can hold any number of buttons.", Type = "Info",
                Buttons = {
                    { Name = "Later" },
                    { Name = "Maybe", Callback = function() print("maybe") end },
                    { Name = "Yes", Style = "Primary", Callback = function() print("yes") end },
                } })
        end })

        ----------------------------------------------------------------------
        -- Layout: sub tabs, collapsible groups, AddGroup-AddGroup, empty tab
        ----------------------------------------------------------------------
        local Layout = Main:AddTab({ Name = "Layout", Description = "Sub tabs and groups", Icon = "lucide:panels-top-left" })
        local Pages = Layout:AddSubTabs({ { Name = "Groups", Icon = "lucide:layers" }, { Name = "Info", Icon = "lucide:info" }, { Name = "Empty", Icon = "lucide:inbox" } })

        -- Groups can be created back to back and filled afterwards: nothing overlaps.
        local G1 = Pages[1]:AddGroup({ Name = "First group", Side = "Left", Icon = "lucide:layers" })
        local G2 = Pages[1]:AddGroup({ Name = "Second group (collapsed)", Side = "Left", Icon = "lucide:layers", Collapsed = true })
        local G3 = Pages[1]:AddGroup({ Name = "Right group", Side = "Right", Icon = "lucide:layers" })
        G1:AddToggle({ Name = "Toggle in first" })
        G1:AddSlider({ Name = "Slider in first", Min = 0, Max = 10, Default = 3 })
        G2:AddButton({ Name = "Hidden until expanded" })
        G2:AddParagraph({ Content = "Click a group header to collapse it down to its title." })
        G3:AddToggle({ Name = "Toggle in right" })

        local Info = Pages[2]:AddGroup({ Name = "Sub tab info", Side = "Full", Icon = "lucide:info", Collapsible = false })
        Info:AddParagraph({ Content = "Sub tabs work in every tab: Tab:AddSubTab({Name=, Icon=}) or Tab:AddSubTabs({...}). Each one is a page with its own AddGroup." })

        -- Pages[3] stays empty on purpose: it shows the empty style automatically.

        local EmptyTab = Main:AddTab({ Name = "Empty tab", Description = "Shows the empty style", Icon = "lucide:inbox", Empty = { Title = "Nothing here yet", Description = "A tab with no groups shows this placeholder automatically.", Icon = "lucide:inbox" } })

        ----
        -- [v3.1] New elements: AddSlider vs AddInputSlider, every dropdown type, progress glow
        ----
        local NewStuff = Main:AddTab({ Name = "New v3.1", Description = "Sliders, dropdowns, progress", Icon = "lucide:sparkles" })
        local SliderGroup = NewStuff:AddGroup({ Name = "Sliders", Side = "Left", Icon = "lucide:sliders-horizontal" })
        SliderGroup:AddSlider({ Name = "Volume (no input)", Desc = "Only shows the value", Min = 0, Max = 100, Default = 90, ShowPercent = true, Flag = "DemoVolume" })
        SliderGroup:AddSlider({ Name = "Health (no input)", Min = 0, Max = 100, Default = 100, ShowMax = true, Flag = "DemoHealth" })
        SliderGroup:AddInputSlider({ Name = "WalkSpeed (input)", Desc = "Click the box to type", Min = 16, Max = 200, Default = 16, Flag = "DemoWalkSpeed", Callback = function(v) print("walkspeed", v) end })
        SliderGroup:addSlider("Positional slider", "addSlider(name, desc, min, max, default, cb)", 0, 10, 5, function(v) print("pos", v) end)
        SliderGroup:addInputSlider("Positional input", "addInputSlider(...)", 0, 1, 0.5, function(v) print("posInput", v) end)

        local DropGroup = NewStuff:AddGroup({ Name = "Dropdowns", Side = "Right", Icon = "lucide:list" })
        DropGroup:AddDropdown({ Name = "Single select", Options = { "Head", "Torso", "Random" }, Default = "Head", Flag = "DemoSingle", Callback = function(v) print("single", v) end })
        DropGroup:AddMultiDropdown({ Name = "Multi select", Options = { "Players", "NPCs", "Items", "Chests" }, Default = { "Players" }, Flag = "DemoMulti", Callback = function(v) print("multi", v) end })
        DropGroup:AddSearchDropdown({ Name = "Search dropdown", Options = { "Alpha", "Bravo", "Charlie", "Delta", "Echo", "Foxtrot", "Golf", "Hotel" }, Default = "Alpha", Flag = "DemoSearch", Callback = function(v) print("search", v) end })

        local ProgGroup = NewStuff:AddGroup({ Name = "Progress", Side = "Left", Icon = "lucide:gauge" })
        local Prog2 = ProgGroup:AddProgress({ Name = "Glow above 80%", CurrentValue = 0.85 })
        ProgGroup:AddButton({ Name = "Advance progress", Style = "Primary", Callback = function() Prog2:Set((Prog2:Get() + 0.1) > 1.001 and 0 or Prog2:Get() + 0.1) end })

        ----
        -- [v3.1] Config tab: Settings (theme + accent), Nickname (hide username / avatar / badges), ESP parts, config manager
        ----
        Window:CreateConfigTab()

        Window:Notify({ Title = "NEMESIS", Content = "Example loaded. Press " .. tostring(Window.toggleKeyCode.Name) .. " to hide the window.", Type = "Success", Duration = 5 })

    end)
    if not okDemo then warn("[Nemesis demo] " .. tostring(errDemo)) end
end

return superMegaAwesomeLibrary
