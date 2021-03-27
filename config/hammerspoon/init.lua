mash = {"⌥"}

--- A closure function
function open(name)
    return function()
        hs.application.launchOrFocus(name)
    end
end

hs.hotkey.bind(mash, "C", open("Google Chrome"))
hs.hotkey.bind(mash, "T", open("iTerm"))
hs.alert("Hammerspoon config loaded")

