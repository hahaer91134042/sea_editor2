----
require("debug")

GameID =
{
	
	ROULETTE = 300, 		-- 欧式轮盘
	SLOT_MACHINE = 301,		-- 老虎机
	PINBALL_BINGO = 302,
	PINBALL_LIGHTS = 303,
	PINBALL_5COLOR = 304,
	USA_ROULETTE = 305,
	HUGA = 306,
	DRAGON = 307,
	WSDL = 308,
	THIRD_PRINCE = 309,
	CLASSIC7 = 310,
	DATANG = 311,
	NINJIA = 312,
	FOREVER_DIAMOND = 313,
	
	POKER_DZ = 501    --德州扑克
}

ClassIDType =
{
	ROOM_BASE = 0, 		-- 基本
	ROOM_SINGLE = 1, 	-- 单人
	ROOM_NOCLOSE = 2,	-- 常开
	ROOM_CUSTOM = 3,	-- 玩家开房
}

local _GameList =
{
	{
		gameid = GameID.ROULETTE;
		name = "欧式轮盘",
		desc = "roulette_base.txt",
		rule = "roulette_custom.json",

		-- 类型
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "单人",
				playernum = 1, -- 房间玩家数量
				notify_roommate = true,
			},
			{
				id = ClassIDType.ROOM_CUSTOM, 
				name = "房卡",
				playernum = 17, -- 房间玩家数量
				notify_roommate = true,
			},
			{
				id = ClassIDType.ROOM_NOCLOSE, 
				name = "百人",
				playernum = 1000, -- 房间玩家数量
				notify_roommate = false,
			},
		},
	},
	{
		gameid = GameID.SLOT_MACHINE;
		name = "老虎机",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- 类型
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "单人",
				playernum = 1, -- 房间玩家数量
				notify_roommate = true,
			}
		},
	},
	{
		gameid = GameID.PINBALL_BINGO;
		name = "BINGO弹珠",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- 类型
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "单人",
				playernum = 1, -- 房间玩家数量
				notify_roommate = true,
			}
		},		
	},
	{
		gameid = GameID.PINBALL_LIGHTS;
		name = "一发弹珠",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- 类型
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "单人",
				playernum = 1, -- 房间玩家数量
				notify_roommate = true,
			}
		},		
	},
	{
		gameid = GameID.PINBALL_5COLOR;
		name = "五灯弹珠",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- 类型
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "单人",
				playernum = 1, -- 房间玩家数量
				notify_roommate = true,
			}
		},		
	},
	{
		gameid = GameID.USA_ROULETTE;
		name = "美式轮盘",
		desc = "roulette_base.txt",
		rule = "roulette_custom.json",

		-- 类型
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "单人",
				playernum = 1, -- 房间玩家数量
				notify_roommate = true,
			},
			{
				id = ClassIDType.ROOM_CUSTOM, 
				name = "房卡",
				playernum = 17, -- 房间玩家数量
				notify_roommate = true,
			},
			{
				id = ClassIDType.ROOM_NOCLOSE, 
				name = "百人",
				playernum = 1000, -- 房间玩家数量
				notify_roommate = false,
			},
		},
	},
	{
		gameid = GameID.HUGA;
		name = "HUGA",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- 类型
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "单人",
				playernum = 1, -- 房间玩家数量
				notify_roommate = true,
			}
		},
	},
	{
		gameid = GameID.DRAGON;
		name = "龙来宝",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- 类型
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "单人",
				playernum = 1, -- 房间玩家数量
				notify_roommate = true,
			}
		},
	},
	{
		gameid = GameID.WSDL;
		name = "五色丹炉",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- 类型
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "单人",
				playernum = 1, -- 房间玩家数量
				notify_roommate = true,
			}
		},
	},
	{
		gameid = GameID.THIRD_PRINCE;
		name = "三太子",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- 类型
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "单人",
				playernum = 1, -- 房间玩家数量
				notify_roommate = true,
			}
		},
	},
	{
		gameid = GameID.CLASSIC7;
		name = "经典7",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- 类型
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "单人",
				playernum = 1, -- 房间玩家数量
				notify_roommate = true,
			}
		},
	},
	{
		gameid = GameID.DATANG;
		name = "大唐",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- 类型
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "单人",
				playernum = 1, -- 房间玩家数量
				notify_roommate = true,
			}
		},
	},
	{
		gameid = GameID.NINJIA;
		name = "忍者",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- 类型
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "单人",
				playernum = 1, -- 房间玩家数量
				notify_roommate = true,
			}
		},
	},
	{
		gameid = GameID.FOREVER_DIAMOND;
		name = "永恒宝石",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- 类型
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "单人",
				playernum = 1, -- 房间玩家数量
				notify_roommate = true,
			}
		},
	},
	{
		gameid = GameID.POKER_DZ;
		name = "德州扑克",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- 类型
		classid = 
		{
			{
				id = ClassIDType.ROOM_BASE, 
				name = "德州扑克",
				playernum = 9, -- 房间玩家数量
				notify_roommate = true,
			}
		},	
	},

}

function GetGameList()
	return _GameList
end