
--- func desc
---@param parent Frame
---@param label string
---@return FontString
function UI.Window:CreateTitle(parent, label)
   local title = parent:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    title:SetPoint("TOP", parent, "TOP", 0, -20)
    title:SetText(label)
    title:SetFontHeight(16)

    return title
end
