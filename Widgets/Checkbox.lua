
---@param name string
---@param parent Frame
---@param labelText string
---@param defaultVal boolean
---@param callback? UI.Widgets.CheckboxCallback
---@return UI.Widgets.Checkbox
function UI.Widgets:CreateCheckboxButton(name, parent, labelText, defaultVal, callback)
    local checkBoxFrame = CreateFrame("Frame", name, parent)
    ---@cast checkBoxFrame UI.Widgets.Checkbox
    local checkBox = CreateFrame("CheckButton", name, checkBoxFrame, "OptionsBaseCheckButtonTemplate")
    checkBox:SetChecked(defaultVal)

    local label = checkBoxFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    label:SetJustifyH("LEFT")
    label:SetFontHeight(14)
    label:SetText(labelText)
    label:SetWidth(label:GetStringWidth())

    checkBox:SetPoint("LEFT", label, "RIGHT", 15, 0)
    label:SetPoint("TOPLEFT", checkBoxFrame, "TOPLEFT", 15, 0)

    function checkBoxFrame:SetCallback(newCallback)
        if newCallback ~= nil and type(newCallback) ~= "function" then
            error("Checkbox callback must be a function or nil", 2)
        end

        callback = newCallback
    end

    checkBox:HookScript("OnClick", function()
        if not checkBox:IsVisible() or not callback then return end
        callback(checkBox:GetChecked())
    end)

    checkBoxFrame.checkBox = checkBox
    checkBoxFrame.Label = label

    checkBoxFrame:SetSize(label:GetWidth() + checkBox:GetWidth(), label:GetHeight())

    return checkBoxFrame
end
