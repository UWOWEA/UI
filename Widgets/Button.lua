---@param name string
---@param parent Frame
---@param labelText string
---@param callback fun()
---@return Button
function UI.Widgets:CreateSubmitButton(name, parent, labelText, callback)
    local button = CreateFrame('Button', name, parent, "UIPanelButtonTemplate")
    button:SetSize(100, 30)
    button:SetText(labelText)
    button:HookScript("OnClick", function (self)
        if not button:IsVisible() then return end
        callback()
    end)

    return button
end
