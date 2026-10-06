
---@param parent Frame
---@param callback function|nil
---@return Button
function UI.Widgets:CreateCloseButton(parent, callback)
    local closeButton = CreateFrame("Button", nil, parent, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", parent, "TOPRIGHT", 0, 0)
    closeButton:SetScript("OnClick", function()
        PlaySound(SOUNDKIT.IG_MAINMENU_CLOSE);
        if callback then
            callback()
        end
        parent:Hide()
    end)

    return closeButton
end
