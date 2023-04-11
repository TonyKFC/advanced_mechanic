ESX = exports["es_extended"]:getSharedObject()  
RegisterServerEvent('repairkit:remove')
AddEventHandler('repairkit:remove', function()
	local Player = source
    exports.ox_inventory:RemoveItem(Player, 'repair_kit', 1)

end)
RegisterServerEvent('washing:remove')
AddEventHandler('washing:remove', function()
	local Player = source
    exports.ox_inventory:RemoveItem(Player, 'wash_tool', 1)
    exports.ox_inventory:RemoveItem(Player, 'sponge', 1) 

end)

RegisterServerEvent('washing:dirtysponge')
AddEventHandler('washing:dirtysponge', function()
	local Player = source 
    local success = exports.ox_inventory:AddItem(Player, 'dirty_sponge', 1)

end)

RegisterServerEvent('washing:spongeadd')
AddEventHandler('washing:spongeadd', function()

	local Player = source 
    
    exports.ox_inventory:RemoveItem(Player, 'dirty_sponge', 1) 
    local success = exports.ox_inventory:AddItem(Player, 'sponge', 1)

end)    


RegisterServerEvent('hackcar:remove')
AddEventHandler('hackcar:remove', function()

	local Player = source 
    
    exports.ox_inventory:RemoveItem(Player, 'welding_torch', 1)  

end)    
