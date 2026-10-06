---@param cat table
---@param variableKey string
---@param name string
---@param defaultValue boolean
---@param getValue fun(): boolean
---@param setValue fun(value: boolean)
---@return table
function UI.Widgets.Settings:CreateCheckbox(cat, variableKey, name, defaultValue, getValue, setValue)
    local setting = Settings.RegisterProxySetting(cat, variableKey, Settings.VarType.Boolean, name, defaultValue, getValue, setValue)
    Settings.CreateCheckbox(cat, setting)
    return setting
end
