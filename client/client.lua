 
ESX = exports["es_extended"]:getSharedObject()  
local ox_inventory = exports.ox_inventory
local insidee = nil


CreateThread(function() 

  local Mechanicblip = AddBlipForCoord(-205.1958, -1324.8699,30.9134)
  SetBlipSprite(Mechanicblip, 446)
  SetBlipDisplay(Mechanicblip, 2)
  SetBlipScale(Mechanicblip, 0.8)
  SetBlipColour(Mechanicblip, 5)
  SetBlipAsShortRange(Mechanicblip, true)
  BeginTextCommandSetBlipName('STRING')
  AddTextComponentSubstringPlayerName('修车厂')
  EndTextCommandSetBlipName(Mechanicblip)
 

end)


local options = {
  {
      name = 'mechanic',
      event = 'mechanic_menu',
      icon = 'fa-solid fa-wrench',
      label = '技工菜单',
      groups = {["mechanic"] = 0},
      distance = 1,
  } 
}

local optionNames = {'mechanic'}

exports.ox_target:addGlobalVehicle(options)

RegisterNetEvent('mechanic_menu', function()
  lib.registerContext({
    id = 'mechanic_menulib',
    title = '技工菜单', 
    options = {
      {
        title = '维修车辆',
        description = '移除 x1 的维修工具包', 
        onSelect =  repaircar,
      },
      {
        title = '清洁车辆',
        description = '移除 x1 的清洁工具包', 
        onSelect =  washing,
      },
      {
        title = '解锁车辆',
        description = '移除 x1 的焊接工具', 
        onSelect =  unlockcar,
      }, 
      {
        title = '连接/放置',
        description = '连接/放置车辆', 
        onSelect =  linkcar,
      },
      {
        title = '扣押',
        description = '扣押车辆', 
        onSelect =  delcar,
      },
    }
  })

  lib.showContext('mechanic_menulib')
 
end)
function unlockcar()
  lib.hideContext()
  
  local playerPed = PlayerPedId()
  local vehicle = ESX.Game.GetVehicleInDirection(playerPed)
  local weldingtorch = ox_inventory:Search('count', 'welding_torch') 

   
  if IsPedSittingInAnyVehicle(playerPed) then
    lib.notify({
      title = '有玩家在里面', 
      type = 'error'
  })
     return
  end

  if  weldingtorch >= 1  and DoesEntityExist(vehicle)  then 
    TriggerServerEvent('hackcar:remove')
 
    if DoesEntityExist(vehicle) then
      TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)

      if lib.progressBar({
        duration = 10000,
        label = '开锁中',
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = true,
            move = true,
            combat = true,
            mouse = false,
        },
       
    }) then    
      SetVehicleDoorsLocked(vehicle, 1)
      SetVehicleDoorsLockedForAllPlayers(vehicle, false)
      ClearPedTasksImmediately(playerPed)

      else   
 
      end

  
 
  end 
  else
    lib.notify({
      title = '你需要 x1 的焊枪 或 离车太远了', 
      type = 'error'
  })    
end
end
function repaircar()
  lib.hideContext()
  local playerPed = PlayerPedId()
  local vehicle = ESX.Game.GetVehicleInDirection(playerPed)
  local repairkit = ox_inventory:Search('count', 'repair_kit') 
  if  repairkit >= 1  and DoesEntityExist(vehicle)  then 
    FreezeEntityPosition(vehicle, true)
    TriggerServerEvent('repairkit:remove')
    if DoesEntityExist(vehicle) then
      if lib.progressBar({
        duration = 10000,
        label = '维修车辆中',
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = true,
            move = true,
            combat = true,
            mouse = true,
        },
        anim = {
            dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
            clip = 'machinic_loop_mechandplayer'
        },
        --[[prop = {
            model = `v_serv_bs_spray`,
            bone = 60309,
            pos = vec3(0.00, 0.00, 0.00),
            rot = vec3(0.00, 0.00, 0.00)
        },]]
    }) then    
      SetVehicleFixed(vehicle)
      FreezeEntityPosition(vehicle, false)
      else   
 
      end
    end 
  else
    lib.notify({
      title = '你需要 x1 的维修工具 或 离车太远了', 
      type = 'error'
  })   
  end
end


function washing()

  lib.hideContext()
  local playerPed = PlayerPedId()
  local vehicle = ESX.Game.GetVehicleInDirection(playerPed)
  local washtool = ox_inventory:Search('count', 'wash_tool') 
  
  local sponge = ox_inventory:Search('count', 'sponge') 
  if  washtool >= 1  and sponge >= 1 and DoesEntityExist(vehicle)  then 
    FreezeEntityPosition(vehicle, true)
    TriggerServerEvent('washing:remove')
    if DoesEntityExist(vehicle) then
      if lib.progressBar({
        duration = 5000,
        label = '清洁中',
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = true,
            move = true,
            combat = true,
            mouse = false,
        },
        anim = {
            dict = 'gestures@f@standing@casual',
            clip = 'gesture_point'
        },
        prop = {
            model = `v_serv_bs_spray`,
            bone = 4170,
            pos = vec3(0.00, -0.02, -0.10),
            rot = vec3(1.50, -1.20, -1.00)
        },
    }) then   
       washtwo()
      else   
 
      end
    end 
  else
    lib.notify({
      title = '你需要 x1 的清洁工具 或 离车太远了', 
      type = 'error'
  })   
  end

end

function washtwo()

  local playerPed = PlayerPedId()
  local vehicle = ESX.Game.GetVehicleInDirection(playerPed)
if lib.progressBar({
  duration = 5000,
  label = '清洁中',
  useWhileDead = false,
  canCancel = false,
  disable = {
      car = true,
      move = true,
      combat = true,
      mouse = false,
  },
  anim = {
      dict = 'timetable@floyd@clean_kitchen@base',
      clip = 'base'
  },
  prop = {
      model = `prop_sponge_01`,
      bone = 28422,
      pos = vec3(0.0, 0.0, -0.01),
      rot = vec3(90.0, 0.0, 0.0)
  },
}) then    
SetVehicleDirtLevel(vehicle, 0)
FreezeEntityPosition(vehicle, false)

TriggerServerEvent('washing:dirtysponge')
else   

end

end
 


exports.ox_target:addBoxZone({
  coords = vec3(-206.8220, -1332.8005, 30.8903),
  size = vec3(1, 2, 1),
  rotation = 275.8271,
  distance = 2,
  debug = false,

  options = {
      {
          name = 'washsponge',
          event = 'washdirtysponge',
          icon = 'fa-solid fa-hands-bubbles',
          label = '洗涤盆', 
          groups = {["mechanic"] = 0},

      }
  }
})

RegisterNetEvent('washdirtysponge', function()

 
  local dirtysponge = ox_inventory:Search('count', 'dirty_sponge') 
   
  if  dirtysponge >= 1    then 


    if lib.progressBar({
      duration = 5000,
      label = '洗涤中',
      useWhileDead = false,
      canCancel = false,
      disable = {
          car = true,
          move = true,
          combat = true,
          mouse = false,
      },
      anim = {
        dict = 'anim@heists@prison_heistig1_p1_guard_checks_bus',
        clip = 'loop'
      },
      prop = {
          model = `prop_sponge_01`,
          bone = 28422,
          pos = vec3(0.03, 0.05, -0.01),
          rot = vec3(90.0, 0.0, 0.0)
      },
    }) then     
    TriggerServerEvent('washing:spongeadd')
    else   
    
    end



 
  else
    lib.notify({
      title = '你需要 x1 的脏海绵', 
      type = 'error'
  })  
  end  

end)

 

 
RegisterNetEvent('mechanicshot', function()

  exports.ox_inventory:openInventory('shop', { type = 'mechanicshop', id = 1 })

end)  

function linkcar() 
  lib.hideContext()
  local playerPed = PlayerPedId()
  local vehicle = GetVehiclePedIsIn(playerPed, true)

  local towmodel = `flatbed`
  local isVehicleTow = IsVehicleModel(vehicle, towmodel)


  if isVehicleTow then
    local targetVehicle = ESX.Game.GetVehicleInDirection()

    if CurrentlyTowedVehicle == nil then
      if targetVehicle ~= 0 then
        if not IsPedInAnyVehicle(playerPed, true) then
          if vehicle ~= targetVehicle then
            AttachEntityToEntity(targetVehicle, vehicle, 20, -0.5, -5.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
            CurrentlyTowedVehicle = targetVehicle 
            lib.notify({
              title = '车辆成功连接', 
              type = 'inform'
          })

       
          else 
            lib.notify({
              title = '你不能连接自己的拖车', 
              type = 'error'
          })
          end
        end
      else 
        
        lib.notify({
          title = '没有要附加的车辆', 
          type = 'error'
      })
      end
    else
      AttachEntityToEntity(CurrentlyTowedVehicle, vehicle, 20, -0.5, -12.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
      DetachEntity(CurrentlyTowedVehicle, true, true)

    
       
      CurrentlyTowedVehicle = nil 
      
      lib.notify({
        title = '车辆成功分离！', 
        type = 'inform'
    })
    end
  else 
    lib.notify({
      title = '动作不可能！你需要一个平板来装载车辆', 
      type = 'inform'
  })
  end
end


function delcar()

  lib.hideContext()
  local playerPed = PlayerPedId()
  local vehicle = ESX.Game.GetVehicleInDirection(playerPed)
 
  if IsPedSittingInAnyVehicle(playerPed) then
    lib.notify({
      title = '有玩家在里面', 
      type = 'error'
  })
     return
  end
  if    DoesEntityExist(vehicle)  then 
  
    if DoesEntityExist(vehicle) then
      TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)

      if lib.progressBar({
        duration = 10000,
        label = '扣押中',
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = true,
            move = true,
            combat = true,
            mouse = false,
        }, 
       
    }) then     
      ESX.Game.DeleteVehicle(vehicle)
      ClearPedTasksImmediately(playerPed)
      else   
 
      end
  end 
  else
    lib.notify({
      title = '离车太远了', 
      type = 'error'
  })    
end

 end

 exports.ox_target:addBoxZone({
  coords = vec3(-198.7028, -1339.9189, 30.8846),
  size = vec3(1, 2, 1),
  rotation = 78.7772,
  distance = 2,
  debug = false,

  options = {
      {
          name = 'mechanicclothing',
          event = 'mechanic_clothing',
          icon = 'fa-solid fa-shirt',
          label = '衣柜', 
          groups = {["mechanic"] = 0},

      }
  }
})
RegisterNetEvent('mechanic_clothing', function(args)
  
  lib.registerContext({
    id = 'mechanic_clothing',
    title = '衣柜', 
    options = {
      {
        title = '工作衣服',
        description ='更换',
        onSelect = worlkclothing,
      },
      {
        title = '休闲衣服',
        description ='更换',
        onSelect = loadSkinclothing,
      },
    }
  })

  lib.showContext('mechanic_clothing')

end)

 
function worlkclothing(uniform, playerPed)
  TriggerEvent('skinchanger:getSkin', function(skin)
		local uniformObject

		if skin.sex == 0 then
			uniformObject = Config.Uniforms.worlk.male
		else
      
			uniformObject = Config.Uniforms.worlk.female
 		end

	 	if uniformObject then
			TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
 
		else
 		end
	end)


 end

function loadSkinclothing()

 ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
  TriggerEvent('skinchanger:loadSkin', skin)
end)

end
Citizen.CreateThread(function()
  while true do
    local sleep = 0
    if IsControlJustReleased(0, 167) and  not insidee  and ESX.PlayerData.job and ESX.PlayerData.job.name == 'burgershot' then  
      lib.showContext('mechanicbillingtwo')
    elseif IsControlJustReleased(0, 177) then      
      HideUI()
    end  
    Citizen.Wait(sleep)
  end      
end)   
 
function inside()
 
  insidee = true
  if IsControlJustReleased(0, 167) and    insidee  and ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' then  
    lib.showContext('mechanicbillingone')
  end 
end

function onExit()
  insidee = false
end
local box = lib.zones.box({
  coords = vec3(-201.9793, -1300.0927, 31.2961),
  size = vec3(18, 28, 5),
  rotation = 93.6036,
  debug = false,
  inside = inside, 
  onExit = onExit,
})
 


lib.registerContext({
  id = 'mechanicbillingone',
  title = '开账单',
 
  options = {
 
      {
        title = '开账单',
        description = '给附件玩家开账单', 
        event = 'advanced_mechanic:mechanicbilling', 
        icon = 'file-lines',
        
      },
      {
        title = '取出',
        description = '取出车辆',
        event = 'advanced_mechanic:mechanicgarageSpawnVehicle',
        icon = 'left-long',
        
      },
      {
        title = '存入',
        description = '存入车辆',
        event = 'advanced_mechanic:mechanicgarageDeleteVehicle', 
        icon = 'right-long',
        
      },
    
  },
 
})
lib.registerContext({
  id = 'mechanicbillingtwo',
  title = '开账单',
 
  options = {
 
      {
        title = '开账单',
        description = '给附件玩家开账单', 
        event = 'advanced_mechanic:mechanicbilling', 
        icon = 'file-lines',
      },
    
  },
 
})


RegisterNetEvent('advanced_mechanic:mechanicbilling')
AddEventHandler('advanced_mechanic:mechanicbilling', function()
  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
  local input = lib.inputDialog(locale('billing'), {{ type = "number", label = locale('Amount'), default = 0 }, })
  if not input then return end
   local amount = tonumber(input[1])
   if amount >0  then
 
      if closestPlayer == -1 or closestDistance > 3.0 then 
          lib.notify({
            title = '账单',
            description = '附近没有玩家',
            type = 'error'
        })
      else
          TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_burgershot',
              'mechanic', amount)
        
          lib.notify({
            title ='账单',
            description = '账单已寄出',
            type = 'success'
        })
      end
   
   else 
      lib.notify({
        title = '账单',
        description = '输入数字无效',
        type = 'error'
    })
   end

 end)  


 RegisterNetEvent('advanced_mechanic:mechanicgarageSpawnVehicle')
AddEventHandler('advanced_mechanic:mechanicgarageSpawnVehicle', function(vehicle)
  local playerPed = PlayerPedId()
  local pedCoords = GetEntityCoords(playerPed)
 
 -- ESX.Game.SpawnVehicle(Config.SpawnVehicle.Spawn.model, vector3(Config.SpawnVehicle.Spawn.Pos.x,Config.SpawnVehicle.Spawn.Pos.y, Config.SpawnVehicle.Spawn.Pos.z), Config.SpawnVehicle.Spawn.Pos.w, function(vehicle)
 ESX.Game.SpawnVehicle(Config.SpawnVehicle.Spawn.model, vector3(pedCoords.x,pedCoords.y, pedCoords.z), pedCoords.w, function(vehicle)
    if DoesEntityExist(vehicle) then  
      DoScreenFadeOut(100)
   
  		SetPedIntoVehicle(playerPed,vehicle,-1)
      SetVehicleNumberPlateText(vehicle,Config.SpawnVehicle.Spawn.Plate)
      SetVehicleNumberPlateTextIndex(vehicle,vehicle,Config.SpawnVehicle.Spawn.PlateColor)
 
      local ped = PlayerPedId()
      local vehicle = GetVehiclePedIsUsing(ped)
      local model = GetEntityModel(vehicle)
      local name = GetDisplayNameFromVehicleModel(model)
      local plate = GetVehicleNumberPlateText(vehicle)
      TriggerServerEvent('sy_carkeys:CreateKey', plate, name)  
      
      lib.notify({
        title = '技工车库',
        description = '已经获取车钥匙,按 [U] 锁定车辆',
        type = 'inform'
    })
    Wait(1000)
    DoScreenFadeIn(100)
    end
 end)
end)
 

RegisterNetEvent('advanced_mechanic:mechanicgarageDeleteVehicle')
AddEventHandler('advanced_mechanic:mechanicgarageDeleteVehicle', function(vehicle)
  local playerPed = PlayerPedId()
  local vehicle = GetVehiclePedIsIn(playerPed, false,-1)
  if GetEntityModel(vehicle) == `flatbed` then
 
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsUsing(ped)
    local model = GetEntityModel(vehicle)
    local name = GetDisplayNameFromVehicleModel(model)
    local plate = GetVehicleNumberPlateText(vehicle)
    TriggerServerEvent('sy_carkeys:DeleteKey', 1, plate, name)  

    TaskLeaveVehicle(playerPed, vehicle, 0)
    Wait(1000)
    ESX.Game.DeleteVehicle(vehicle)

  else
    lib.notify({
      title = '车库',
      description = '你只能停工作车辆',
      type = 'error'
  })
  end
   
end)


exports.ox_target:addBoxZone({
  coords = vec3(-207.0927, -1340.0275, 30.8904),
  size = vec3(1, 1, 1),
  rotation = 94.1569,
  distance = 2,
  debug = false,

  options = {
      {
          name = 'mechanicboss',
          event = 'advanced_mechanic:bossmenu',
          icon = 'fa-solid fa-align-justify',
          label = 'Boss菜单', 
          groups = {["mechanic"] = 4},

      }
  }
})


RegisterNetEvent('advanced_mechanic:bossmenu')
AddEventHandler('advanced_mechanic:bossmenu', function()
  TriggerEvent('esx_society:openBossMenu', ESX.PlayerData.job.name, function(data, menu)
    menu.close()
end, {wash = false})
end)  
 