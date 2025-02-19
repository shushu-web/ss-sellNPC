local QBCore = exports['qb-core']:GetCoreObject()

-- NPCスポーン
Citizen.CreateThread(function()
    for _, npc in pairs(Config.NPCs) do
        RequestModel(GetHashKey(npc.model))
        while not HasModelLoaded(GetHashKey(npc.model)) do
            Wait(10)
        end
        
        local ped = CreatePed(4, GetHashKey(npc.model), npc.coords.x, npc.coords.y, npc.coords.z - 1.0, npc.coords.w, false, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        FreezeEntityPosition(ped, true)

        -- qb-targetの設定
        exports['qb-target']:AddTargetEntity(ped, {
            options = {
                {
                    type = "client",
                    event = "sellItems:openMenu",
                    icon = "fas fa-dollar-sign",
                    label = "アイテムを売る",
                    npcData = npc -- NPCのデータを保持
                }
            },
            distance = 2.0
        })
    end
end)

-- メニューを開く
RegisterNetEvent("sellItems:openMenu", function(data)
    local menu = {}

    for _, item in pairs(data.npcData.buyItems) do
        table.insert(menu, {
            header = QBCore.Shared.Items[item.item].label .. " ($" .. item.price .. ")",
            txt = "売却可能",
            params = {
                event = "sellItems:sellItem",
                args = { itemName = item.item, price = item.price }
            }
        })
    end

    table.insert(menu, { header = "閉じる", params = { event = "qb-menu:client:closeMenu" } })
    exports['qb-menu']:openMenu(menu)
end)

-- アイテム売却処理
RegisterNetEvent("sellItems:sellItem", function(data)
    TriggerServerEvent("sellItems:processSale", data.itemName, data.price)
end)
