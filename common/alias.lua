local appnames = {}

-- All names in the bar appears in capital case
-- Find exact names (WM_CLASS(STRING)) using `xprop`
-- xprop | grep WM_CLASS
-- For multiple names, use the last one
appnames["kitty"] = "Kitty"
appnames["firefox"] = "Firefox"
appnames["thunderbird"] = "Thunderbird"
appnames["betterbird"] = "Betterbird"
appnames["librewolf"] = "LibreWolf"
appnames["Code"] = "VSCode"
appnames["Pavucontrol"] = "PavuControl"
appnames[".blueman-manager-wrapped"] = "BlueMan"
appnames["KeePassXC"] = "KeePassXC"
appnames["qBittorrent"] = "qBit"
appnames["revolt-desktop"] = "Revolt"
appnames["wihotspot-gui"] = "Hotspot"
appnames["Tribler"] = "Tribler"
appnames["Tor Browser"] = "Tor"
appnames["Pineapple Pictures"] = "PineAppl"
appnames["thunar"] = "Thunar"
appnames["Cozy Drive"] = "Cozy"
appnames["chat-simplex-desktop-MainKt"] = "Simplex"
appnames["org.gnome.Boxes"] = "Boxes"
appnames["GitKraken"] = "GKraken"
appnames["GitHub Desktop"] = "GH Desk"

return appnames
