---@meta _
---@class UI.Widgets
---@field Settings UI.Widgets.Settings
---@field CreateSubmitButton fun(self: UI.Widgets, name: string, parent: Frame, labelText: string, callback: fun()): Button
---@field CreateCloseButton fun(self: UI.Widgets, parent: Frame, callback: fun()|nil): Button
---@field CreateCheckboxButton fun(self: UI.Widgets, name: string, parent: Frame, labelText: string, defaultVal: boolean, callback?: UI.Widgets.CheckboxCallback): UI.Widgets.Checkbox
---@field CreateSlider fun(self: UI.Widgets, name: string, parent: Frame, labelText: string, minVal: number, maxVal: number, stepSize: number, defaultVal: number, callback: fun(value: number)): UI.Widgets.SliderFrame
UI.Widgets = {}

---@alias UI.Widgets.CheckboxCallback fun(checked: boolean)

---@class UI.Widgets.Checkbox: Frame
---@field checkBox CheckButton
---@field Label FontString
---@field SetCallback fun(self: UI.Widgets.Checkbox, callback: UI.Widgets.CheckboxCallback|nil)

---@class UI.Widgets.SliderFrame: Frame, MinimalSliderWithSteppersTemplate
