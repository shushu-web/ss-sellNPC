fx_version 'cerulean'
game 'gta5'

author 'ShuShuServer' --作成者名
description 'NPCitemsellSystem' --スクリプトの説明文
version '1.1.0' --スクリプトのバージョン

-- サーバースクリプト
server_scripts {
    'server.lua',
}

-- クライアントスクリプト
client_scripts {
    'client.lua',
}
--ここまでは基本的なスクリプトの構成

--ここから下はスクリプトによって必要なものを記載する。
-- QBCoreと依存関係があることを宣言
dependencies {
    'qb-core',
}