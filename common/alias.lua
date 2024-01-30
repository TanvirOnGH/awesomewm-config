-----------------------------------------------------------------------------------------------------------------------
--                                      Application aliases for tasklist widget                                      --
-----------------------------------------------------------------------------------------------------------------------

local appnames = {}

-- Find exact names (WM_CLASS(STRING)) using `xprop`
appnames["firefox"] = "FF"
appnames["thunderbird"] = "TB"
appnames["betterbird"] = "BB"
appnames["librewolf"] = "L-Wolf"
appnames["Code"] = "VSCode"
appnames["Pavucontrol"] = "PavuCon"
appnames[".blueman-manager-wrapped"] = "BlueMan"
appnames["KeePassXC"] = "KeePass"
appnames["qBittorrent"] = "QBit"
appnames["revolt-desktop"] = "Revolt"

return appnames
