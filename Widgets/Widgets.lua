---@meta _
---@class UI.Widgets
---@field Settings UI.Widgets.Settings
---@field CreateSubmitButton fun(self: UI.Widgets, name: string, parent: Frame, labelText: string, callback: fun()): Button
---@field CreateCloseButton fun(self: UI.Widgets, parent: Frame, callback: fun()|nil): Button
---@field CreateCheckboxButton fun(self: UI.Widgets, name: string, parent: Frame, labelText: string, defaultVal: boolean, callback: fun(checked: boolean)): UI.Widgets.CheckButton
---@field CreateSlider fun(self: UI.Widgets, name: string, parent: Frame, labelText: string, minVal: number, maxVal: number, stepSize: number, defaultVal: number, callback: fun(value: number)): UI.Widgets.SliderFrame
UI.Widgets = {}

---@class UI.Widgets.CheckButton: CheckButton

---@class UI.Widgets.SliderFrame: Frame, MinimalSliderWithSteppersTemplate
