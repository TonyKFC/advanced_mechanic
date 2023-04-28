ESX = exports["es_extended"]:getSharedObject()  




TriggerEvent('esx_phone:registerNumber', 'mechanic', 'phone', true, true)
TriggerEvent('esx_society:registerSociety', 'mechanic', 'mechanic', 'society_mechanic', 'society_mechanic', 'society_mechanic', {type = 'private'})


 
lib.callback.register('repairkit:remove', function(source, item, metadata, target)

    local Player = source
    exports.ox_inventory:RemoveItem(Player, 'repair_kit', 1)

end)

 

lib.callback.register('washing:remove', function(source, item, metadata, target)
    
	local Player = source
    exports.ox_inventory:RemoveItem(Player, 'wash_tool', 1)
    exports.ox_inventory:RemoveItem(Player, 'sponge', 1) 

end)

 
lib.callback.register('washing:dirtysponge', function(source, item, metadata, target)

	local Player = source 
    local success = exports.ox_inventory:AddItem(Player, 'dirty_sponge', 1)

end)

lib.callback.register('washing:spongeadd', function(source, item, metadata, target)

	local Player = source 
    exports.ox_inventory:RemoveItem(Player, 'dirty_sponge', 1) 
    local success = exports.ox_inventory:AddItem(Player, 'sponge', 1)

end)
 
lib.callback.register('hackcar:remove', function(source, item, metadata, target)

	local Player = source 
    exports.ox_inventory:RemoveItem(Player, 'welding_torch', 1)  

end) 
 
