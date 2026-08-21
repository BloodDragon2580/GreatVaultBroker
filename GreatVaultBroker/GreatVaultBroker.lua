local L = {}
local locale = GetLocale()

-- Lokalisierungstexte für verschiedene Sprachen
if locale == "deDE" then
    L["Great Vault"] = "Great Vault"
    L["Click to open the Great Vault."] = "Klicke, um die Große Schatzkammer zu öffnen."
    L["The Great Vault is not available right now."] = "Die Große Schatzkammer ist momentan nicht verfügbar."
elseif locale == "frFR" then
    L["Great Vault"] = "Great Vault"
    L["Click to open the Great Vault."] = "Cliquez pour ouvrir la Grande Voûte."
    L["The Great Vault is not available right now."] = "La Grande Voûte n'est pas disponible en ce moment."
elseif locale == "esES" then
    L["Great Vault"] = "Great Vault"
    L["Click to open the Great Vault."] = "Haz clic para abrir la Gran Bóveda."
    L["The Great Vault is not available right now."] = "La Gran Bóveda no está disponible en este momento."
else
    -- Fallback für nicht übersetzte Sprachen (Standard Englisch)
    L["Great Vault"] = "Great Vault"
    L["Click to open the Great Vault."] = "Click to open the Great Vault."
    L["The Great Vault is not available right now."] = "The Great Vault is not available right now."
end

-- Funktion, um die Great Vault sicher zu öffnen
local function OpenGreatVault()
    -- Überprüfe, ob der Frame existiert und bereit ist
    if WeeklyRewardsFrame then
        if not WeeklyRewardsFrame:IsShown() then
            WeeklyRewardsFrame:Show() -- Öffne den Frame nur, wenn er nicht bereits geöffnet ist
        end
    else
        print(L["The Great Vault is not available right now."])
    end
end

-- Verzögerungsfunktion, um sicherzustellen, dass der Frame vollständig geladen ist
local function DelayedOpenVault()
    C_Timer.After(0.1, function() -- Warte 0.1 Sekunden, um sicherzustellen, dass der Frame geladen wurde
        OpenGreatVault()
    end)
end

-- Erstellen des Broker-Objekts
local broker = LibStub("LibDataBroker-1.1"):NewDataObject(L["Great Vault"], {
    type = "data source",
    text = L["Great Vault"],
    icon = 237185, -- Icon-ID 237185
    OnTooltipShow = function(tooltip)
        tooltip:AddLine(L["Great Vault"])
        tooltip:AddLine(L["Click to open the Great Vault."])
    end,
    OnClick = function(_, button)
        if button == "LeftButton" then
            -- Blizzard_WeeklyRewards bei Bedarf über die aktuelle AddOn-API laden.
            if not C_AddOns.IsAddOnLoaded("Blizzard_WeeklyRewards") then
                local loaded, reason = C_AddOns.LoadAddOn("Blizzard_WeeklyRewards")
                if loaded then
                    DelayedOpenVault()
                else
                    print(L["The Great Vault is not available right now."] .. (reason and (" (" .. reason .. ")") or ""))
                end
            else
                OpenGreatVault()
            end
        end
    end
})
