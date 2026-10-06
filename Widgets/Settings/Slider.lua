---@param cat table
---@param variableKey string
---@param name string
---@param minValue number
---@param maxValue number
---@param step number
---@param defaultValue number
---@param getValue fun(): number
---@param setValue fun(value: number)
---@return table
function UI.Widgets.Settings:CreateSlider(cat, variableKey, name, minValue, maxValue, step, defaultValue, getValue, setValue)
    local setting = Settings.RegisterProxySetting(cat, variableKey, Settings.VarType.Number, name, defaultValue, getValue, setValue)
    local options = Settings.CreateSliderOptions(minValue, maxValue, step)
    options:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, function(value)
        return tostring(math.floor(value + 0.5))
    end)
    Settings.CreateSlider(cat, setting, options)
    return setting
end
