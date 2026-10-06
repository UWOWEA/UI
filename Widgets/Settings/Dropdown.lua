
---@param cat table
---@param variableKey string
---@param name string
---@param defaultValue string
---@param getValue fun(): string
---@param setValue fun(value: string)
---@param optionsList table[]
---@return table
function UI.Widgets.Settings:CreateDropdown(cat, variableKey, name, defaultValue, getValue, setValue, optionsList)
    local setting = Settings.RegisterProxySetting(cat, variableKey, Settings.VarType.String, name, defaultValue, getValue, setValue)

    local function GetOptions()
        local container = Settings.CreateControlTextContainer()
        for _, entry in ipairs(optionsList) do
            if not entry.subcategory then
                container:Add(entry.value, entry.text)
            end
        end
        return container:GetData()
    end

    local initializer = Settings.CreateDropdown(cat, setting, GetOptions)
    local hasSubcategories = false
    for _, entry in ipairs(optionsList) do
        if entry.subcategory then
            hasSubcategories = true
            break
        end
    end

    if hasSubcategories then
        initializer.customOptionHandler = function(rootDescription)
            for _, entry in ipairs(optionsList) do
                if entry.subcategory then
                    local categoryDescription = rootDescription:CreateButton(entry.text)
                    for _, option in ipairs(entry.subcategory) do
                        Settings.CreateDropdownButton(
                            categoryDescription,
                            option,
                            function(data) return setting:GetValue() == data.value end,
                            function(data) setting:SetValue(data.value) end)
                    end
                end
            end
        end
    end

    return setting
end
