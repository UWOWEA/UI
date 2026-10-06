---@class SliderFrame : Frame, MinimalSliderWithSteppersTemplate
---@field Label FontString
local sliderMixin

---@param name string
---@param parent Frame
---@param labelText string
---@param minVal number
---@param maxVal number
---@param stepSize number
---@param defaultVal number
---@param callback function
---@return SliderFrame
function UI.Widgets:CreateSlider(name, parent, labelText, minVal, maxVal, stepSize, defaultVal, callback)
    local slider = CreateFrame("Frame", name, parent, "MinimalSliderWithSteppersTemplate")

    local formatters = {}
    formatters[MinimalSliderWithSteppersMixin.Label.Right] = function(value)
        return tostring(math.floor(value + 0.5))
    end

    local numSteps = (maxVal - minVal) / stepSize
    slider:Init(defaultVal, minVal, maxVal, numSteps, formatters)

    if slider.Slider then
        slider.Slider:HookScript("OnValueChanged", function(self, value)
            if not slider:IsVisible() then return end
            callback(math.floor(value + 0.5))
        end)
    end

    local label = parent:CreateFontString(nil, "OVERLAY", "GameFontHighlightMedium")
    label:SetJustifyH("LEFT")
    label:SetWidth(120)
    label:SetText(labelText)
    label:SetFontHeight(14)

    slider.Label = label
    return slider
end
