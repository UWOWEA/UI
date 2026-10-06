
---@param name string
---@param parent Frame
---@param labelText string
---@param defaultVal boolean
---@param callback function (checked)
---@return CheckButton
function UI.Widgets:CreateCheckboxButton(name, parent, labelText, defaultVal, callback)
    local checkBox = CreateFrame("CheckButton", name, parent, "OptionsBaseCheckButtonTemplate")
    checkBox:SetChecked(defaultVal)

    checkBox.Label = parent:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    checkBox.Label:SetJustifyH("LEFT")
    checkBox.Label:SetWidth(120)
    checkBox.Label:SetText(labelText)
    checkBox.Label:SetFontHeight(14)

    checkBox:SetPoint("LEFT", checkBox.Label, "RIGHT", 15, 0)
    checkBox.Label:SetPoint("TOPLEFT", parent, "TOPLEFT", 15, -215)

    checkBox:HookScript("OnClick", function()
        if not checkBox:IsVisible() then return end
        callback(checkBox:GetChecked())
    end)

    return checkBox
end
