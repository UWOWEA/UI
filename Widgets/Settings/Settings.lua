---@meta _
---@class UI.Widgets.Settings.DropdownOption
---@field value? string
---@field text string
---@field label? string
---@field subcategory? UI.Widgets.Settings.DropdownOption[]

---@class UI.Widgets.Settings
---@field CreateCheckbox fun(self: UI.Widgets.Settings, cat: table, variableKey: string, name: string, defaultValue: boolean, getValue: fun(): boolean, setValue: fun(value: boolean)): table
---@field CreateDropdown fun(self: UI.Widgets.Settings, cat: table, variableKey: string, name: string, defaultValue: string, getValue: fun(): string, setValue: fun(value: string), optionsList: UI.Widgets.Settings.DropdownOption[]): table
---@field CreateSlider fun(self: UI.Widgets.Settings, cat: table, variableKey: string, name: string, minValue: number, maxValue: number, step: number, defaultValue: number, getValue: fun(): number, setValue: fun(value: number)): table
UI.Widgets.Settings = {}
