# Uwowea UI

Uwowea UI is a small World of Warcraft addon library with reusable UI helpers.
The addon currently provides helpers for creating a checkbox and a close button.

## Requirements

- World of Warcraft
- The addon is loaded as `Uwowea_UI`

## Installation

1. Place the `UI` project folder in your WoW `Interface/AddOns` directory.
2. Ensure the installed folder is named `Uwowea_UI`.
3. Enable **Uwowea Library: UI** in the AddOns list, then reload the game UI.

## Usage

The addon exposes widget helpers on the global `UI.Widgets` table. Load this
addon before using them from another addon.

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
