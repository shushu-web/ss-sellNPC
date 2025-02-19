local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("sellItems:processSale", function(itemName, price)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player.Functions.RemoveItem(itemName, 1) then
        Player.Functions.AddMoney("cash", price)
        TriggerClientEvent("QBCore:Notify", src, "アイテムを売却しました！", "success")
    else
        TriggerClientEvent("QBCore:Notify", src, "売るアイテムがありません！", "error")
    end
end)
