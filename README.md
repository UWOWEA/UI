# Uwowea UI

Uwowea UI is a small World of Warcraft addon library with reusable frame widgets
and native Settings controls.

## Requirements

- World of Warcraft
- The addon is loaded as `Uwowea_UI`

## Installation

1. Place the `UI` project folder in your WoW `Interface/AddOns` directory.
2. Ensure the installed folder is named `Uwowea_UI`.
3. Enable **Uwowea Library: UI** in the AddOns list, then reload the game UI.

## Usage

The addon exposes widget helpers on the global `UI.Widgets` table. Declare
`Uwowea_UI` as a dependency in the consuming addon's `.toc` so the namespace is
loaded before it is used.

```lua
local checkbox = UI.Widgets:CreateCheckboxButton(
    "MyAddonOption",
    parentFrame,
    "Enable option",
    true,
    function(checked)
        -- Apply the selected value.
    end
)

local closeButton = UI.Widgets:CreateCloseButton(parentFrame, function()
    -- Optional work to do when the close button is clicked.
end)
```

## API

### Native Settings controls

Settings helpers create and add controls to a category. The consuming addon
owns the category lifecycle: create it, add controls, then register it once.
These are methods, so call them with `:`.

```lua
local category = Settings.RegisterVerticalLayoutCategory("My Addon")
local settings = UI.Widgets.Settings

settings:CreateCheckbox(
    category,
    "MY_ADDON_ENABLED",
    "Enable feature",
    true,
    function() return MyAddonDB.enabled end,
    function(value) MyAddonDB.enabled = value end
)

settings:CreateSlider(
    category,
    "MY_ADDON_SIZE",
    "Size",
    10,
    100,
    1,
    50,
    function() return MyAddonDB.size end,
    function(value) MyAddonDB.size = value end
)

settings:CreateDropdown(
    category,
    "MY_ADDON_MODE",
    "Mode",
    "normal",
    function() return MyAddonDB.mode end,
    function(value) MyAddonDB.mode = value end,
    {
        { value = "normal", text = "Normal" },
        {
            text = "Advanced",
            subcategory = {
                { value = "fast", text = "Fast" },
                { value = "precise", text = "Precise" },
            },
        },
    }
)

Settings.RegisterAddOnCategory(category)
```

Available helpers:

- `UI.Widgets.Settings:CreateCheckbox(category, variableKey, name, defaultValue, getValue, setValue)`
- `UI.Widgets.Settings:CreateSlider(category, variableKey, name, minValue, maxValue, step, defaultValue, getValue, setValue)`
- `UI.Widgets.Settings:CreateDropdown(category, variableKey, name, defaultValue, getValue, setValue, optionsList)`

Dropdown entries use `{ value, text }`. An entry with `text` and `subcategory`
creates a submenu; child entries use the same `{ value, text }` shape. The
category label itself is not a selectable setting.

### `UI.Widgets:CreateCheckboxButton(name, parent, labelText, defaultVal, callback)`

Creates a checkbox using `OptionsBaseCheckButtonTemplate`, adds a text label,
and returns the `CheckButton`. `callback` is called with the checkbox's new
checked value after a click, provided the checkbox is visible.

### `UI.Widgets:CreateCloseButton(parent, callback)`

Creates a close button using `UIPanelCloseButton` and returns the `Button`.
When clicked, it plays the standard main-menu close sound, invokes the optional
`callback`, and hides `parent`.

## Development

`Uwowea_UI.toc` is the addon manifest and lists the Lua files loaded by WoW.
Add new runtime files to that manifest in the order required by their
dependencies.
