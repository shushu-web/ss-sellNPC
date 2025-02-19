-- qb-core のイベントをトリガー
RegisterServerEvent('qb-sell:openMenu')
AddEventHandler('qb-sell:openMenu', function(npcId)
local src = source
local npc = Config.NPCs[npcId]

-- メニューを作成
local menu = {}
for i, item in ipairs(npc.items) do
table.insert(menu, {
title = item.name,
description = "$" .. item.price,
value = item.name
})
end

-- メニューを表示
TriggerClientEvent('qb-menu:openMenu', src, '販売', menu, function(data)
if data then
local selectedItem = npc.items[data.value]
local player = QBCore.Functions.GetPlayerByCitizenId(src)

-- 所持金を確認
if player.PlayerData.money.cash >= selectedItem.price then
-- アイテムを販売
player.Functions.RemoveMoney('cash', selectedItem.price)
-- TODO: アイテムをプレイヤーに渡す処理

-- メッセージを表示
QBCore.Functions.Notify(src, "アイテムを販売しました。", "success")
else
QBCore.Functions.Notify(src, "所持金が足りません。", "error")
end
end
end)
end)