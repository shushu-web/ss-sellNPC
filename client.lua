-- NPC の配置
for i, npc in ipairs(Config.NPCs) do
    local ped = CreatePed(4, npc.model, npc.coords, 0.0, true, true)
    SetEntityHeading(ped, math.random(0, 360))
    FreezeEntityPosition(ped, true)
    
    -- qb-target の設定
    exports['qb-target']:AddTargetModel(GetEntityModel(ped), {
    options = {
    {
    label = "アイテムを売る",
    action = function()
    TriggerServerEvent('qb-sell:openMenu', i)
    end
    }
    },
    distance = 2.5
    })
    end
    