Apps = {
    GLOBAL      = "GLOBAL",
    PREMIERE    = { name = "Adobe Premiere Pro 2020", bundleID = "com.adobe.PremierePro.14"},
    CODE        = { name = "Code", bundleID = "com.microsoft.VSCode"},
    FINDER      = { name = "Finder", bundleID = "com.apple.finder"},
    HAMMERSPOON = { name = "Hammerspoon", bundleID = "org.hammerspoon.Hammerspoon"},
    OUTLOOK     = { name = "Microsoft Outlook", bundleID = "com.microsoft.Outlook"},
    SAFARI      = { name = "Safari", bundleID = "com.apple.safari"},
    AFTERFX     = { name = "Adobe After Effects CC 2018.3 (15.1.2)", bundleID = "com.adobe.AfterEffects"},
    AUDITION    = { name = "Adobe Audition CC", bundleID = "com.adobe.Audition"},
    MEDIAENCODER= { name = "Adobe Media Encoder 2020", bundleID = "com.adobe.ame.application.CC14"},
    BRIDGE      = { name = "Adobe Bridge 2020", bundleID = "com.adobe.bridge10"},
    CYBERDUCK   = { name = "Cyberduck", bundleID = "ch.sudo.cyberduck"},
    DROPBOX     = { name = "Dropbox", bundleID = "com.getdropbox.dropbox"},
    RESOLVE     = { name = "DaVinci Resolve", bundleID = "com.blackmagic-design.DaVinciResolve"}
}

function currentApplication()
    return hs.window:focusedWindow():application()
end

function currentApplicationName()
    return currentApplication():name()
end

function currentApplicationBundleID()
    return currentApplication():bundleID()
end

function isApplicationCurrent(nameOrBundleId)
    local currentAppName = currentApplicationName()
    if currentAppName == nameOrBundleId then
        return true
    else
        local currentAppBundleID = currentApplicationBundleID()
        if currentAppBundleID == nameOrBundleId then
            return true;
        else
            return false
        end
    end
end

function getApplication(nameOrBundleId)
    return hs.application.get(nameOrBundleId)
end

function selectMenuItem(nameOrBundleId, menuItem, onlyIfCurrent)
    if onlyIfCurrent then
        if isApplicationCurrent(nameOrBundleId) then
            local app = getApplication(nameOrBundleId)
            if app then
                app:selectMenuItem(menuItem)
            end
        end
    else
        local app = getApplication(nameOrBundleId)
        if app then
            app:selectMenuItem(menuItem)
        end
    end
end

function launchAppByID(pBundleId)
    hs.application.launchOrFocusByBundleID(pBundleId)
end

function closeAppByID(pBundleId)
    hs.application.get(pBundleId):kill()
end