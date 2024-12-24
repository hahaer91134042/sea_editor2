
-- Battle进程配置表

local _BatCfg =
{
	{
		index = 1, -- battle索引
		gameid = { 0, 1 }, -- 支持游戏列表
	},
}

function GetBatCfgList()
	return _BatCfg
end