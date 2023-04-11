fx_version 'bodacious'
lua54 'yes'
game  'gta5'

author 'TonyKFC'

version '1.0.0'
 
client_scripts{
	'client/client.lua', 
	'config.lua',
	'@es_extended/locale.lua' 
 
}

server_scripts{
	'server/server.lua',
	'@oxmysql/lib/MySQL.lua',
	'config.lua',
    '@es_extended/locale.lua' 
 
}


shared_scripts {
	'@ox_lib/init.lua',
	'@es_extended/imports.lua', 
  }
 