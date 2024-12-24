----
require("debug")

GameID =
{
	SH_KNOCK = 101, -- 麻将
	MAH_STANDARD = 102, -- 国标
	BLOOD_TO_THE_END = 103,		-- 血战到底
	MAH_CS = 105, -- 长沙麻将
	
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
	FREE_CLOCK = 314,   --自由钟
	ROAD_RACER = 315,   --房车
	QUANTUM_MATRIX = 316,   --量子矩阵
	COSTA_RICA = 317,  --哥斯达黎加
	ATLANTIS = 318,  --亚特兰蒂斯
	CROWNMARY = 319,  --皇冠小玛丽
	NEZHA = 320,  --哪吒
	HT343 = 321,  --异型343
	ANCIENT_TOMB = 322, --古墓玄奇
	HT345 = 323,	-- 异型345 万圣夜
	FISH_ROULETTE = 324,		-- 红绿鲤鱼
	PURGATORY = 325,   -- 炼狱(4*5)
	FARM = 326,        -- 农场
	MAH_SLOT = 327,		-- 推倒胡
	WORLD = 328,        -- 环游世界
	MINER = 329,		-- 挖金矿
	CUTIE = 330,		-- 家有萌宝
	HAOJIANG = 331,		-- 濠江之夜
	SUPER8 = 332,		-- 疯狂超8
	RAINBOW = 333,		-- 彩虹连击
	LONGFENG = 334,		-- 龙凤呈祥
	PHARAOH = 335,		-- 法老王
	LUCKY_RABBIT = 336,	-- 幸运兔子
	FRUIT_LIGHT = 337,	-- 水果红绿灯
	CLASSIC_4STAR = 338,	-- 经典四星
	TREASURE = 339,		-- 红胡子宝藏
	SERIAL_RAIDERS = 343, -- 连环夺宝
	FRUIT_EXPERT = 341, -- 水果达人
	TDRB = 342,         -- 2次元(冰火之灵)
	LuckyCandy = 344,   -- 幸运糖果
	FARM_ESCAPE = 345,   -- 农场大逃亡
	JIN_PING_MEI = 346,  -- 金瓶梅
	MARBLES = 347,       -- 满贯连珠
	GANGS = 348,       -- 黑帮
	PROMOTION = 349,   -- 升官发财
	WILDNESS = 350,    -- 野性狂奔
	
	POKER_DZ = 501,    --德州扑克
	
	FISH = 601, -- 钓鱼
	LOTTERY = 701, --魔女
	SAN = 702, -- 三国发
	PK = 801, -- 5pk
	ANIMAL = 901, -- 动物
	BALL = 902, -- 红绿对对碰
	FOREST = 1001, -- 森林舞会
	BOX = 1101, -- 萌盒
	
	-- 以下为多属性开房间
	ROULETTE_1 = 3001, 		-- 欧式轮盘-1
	ROULETTE_2 = 3002, 		-- 欧式轮盘-2
	ROULETTE_CUSTOM = 3003,	-- 欧式轮盘-单人房
	NEZHA_1 = 3201,  --哪吒-1
	NEZHA_2 = 3202,  --哪吒-2
	-- end
		
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
		gameid = GameID.SH_KNOCK;
		name = "上海敲麻",
		desc = "shknock.txt",
		rule = "shknock.json",

		-- 类型
		classid = 
		{
			{
				id = ClassIDType.ROOM_CUSTOM, 
				name = "标注",
				playernum = 2, -- 房间玩家数量
				notify_roommate = false,
			},
		},
	},

	{
		gameid = GameID.MAH_CS;
		name = "长沙麻将",
		desc = "shknock.txt",
		rule = "shknock.json",

		-- 类型
		classid = 
		{
			{
				id = ClassIDType.ROOM_CUSTOM, 
				name = "标注",
				playernum = 2, -- 房间玩家数量
				notify_roommate = true,
			},
		},
	},

	{
		gameid = GameID.BLOOD_TO_THE_END;
		name = "血战到底",
		desc = "shknock.txt",
		rule = "shknock.json",

		-- 类型
		classid = 
		{
			{
				id = ClassIDType.ROOM_CUSTOM, 
				name = "标注",
				playernum = 4, -- 房间玩家数量
				notify_roommate = true,
			},
		},
	},

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
		gameid = GameID.ROULETTE_1;
		name = "欧式轮盘",
		desc = "roulette_base.txt",
		rule = "roulette_custom.json",

		-- 类型
		classid = 
		{
			{
				id = ClassIDType.ROOM_NOCLOSE, 
				name = "百人",
				playernum = 1000, -- 房间玩家数量
				notify_roommate = false,
			},
		},
	},
	{
		gameid = GameID.ROULETTE_2;
		name = "欧式轮盘",
		desc = "roulette_base.txt",
		rule = "roulette_custom.json",

		-- 类型
		classid = 
		{
			{
				id = ClassIDType.ROOM_NOCLOSE, 
				name = "百人",
				playernum = 1000, -- 房间玩家数量
				notify_roommate = false,
			},
		},
	},	
	{
		gameid = GameID.ROULETTE_CUSTOM;
		name = "欧式轮盘",
		desc = "roulette_base.txt",
		rule = "roulette_custom.json",

		-- 类型
		classid = 
		{
			{
				id = ClassIDType.ROOM_CUSTOM, 
				name = "房卡",
				playernum = 17, -- 房间玩家数量
				notify_roommate = true,
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
		name = "大唐水果传",
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
		name = "忍者联盟",
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
		gameid = GameID.FREE_CLOCK;
		name = "幸运钟声",
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
		gameid = GameID.ROAD_RACER;
		name = "狂野时速",
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
		gameid = GameID.QUANTUM_MATRIX;
		name = "量子矩阵",
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
		gameid = GameID.COSTA_RICA;
		name = "呱呱呱呱",
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
		gameid = GameID.ATLANTIS;
		name = "尼莫的遗产",
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
		gameid = GameID.CROWNMARY;
		name = "皇冠小玛丽",
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
		gameid = GameID.NEZHA;
		name = "哪吒",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- 类型
		classid = 
		{
			{
				id = ClassIDType.ROOM_NOCLOSE, 
				name = "百人",
				playernum = 400, -- 房间玩家数量
				notify_roommate = true,
			}
		},	
	},
	{
		gameid = GameID.NEZHA_1;
		name = "哪吒",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- 类型
		classid = 
		{
			{
				id = ClassIDType.ROOM_NOCLOSE, 
				name = "百人",
				playernum = 400, -- 房间玩家数量
				notify_roommate = true,
			}
		},	
	},
	{
		gameid = GameID.NEZHA_2;
		name = "哪吒",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- 类型
		classid = 
		{
			{
				id = ClassIDType.ROOM_NOCLOSE, 
				name = "百人",
				playernum = 400, -- 房间玩家数量
				notify_roommate = true,
			}
		},	
	},
	{
		gameid = GameID.ANCIENT_TOMB;
		name = "古墓玄奇",
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
				name = "普通",
				playernum = 9, -- 房间玩家数量
				notify_roommate = true,
			}
		},	
	},

	{
		gameid = GameID.FISH;
		name = "钓鱼",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- 类型
		classid = 
		{
			{
				id = ClassIDType.ROOM_NOCLOSE, 
				name = "钓鱼",
				playernum = 4, -- 房间玩家数量
				notify_roommate = true,
			}
		},	
	},

	{
		gameid = GameID.LOTTERY;
		name = "彩票",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- 类型
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "彩票",
				playernum = 1, -- 房间玩家数量
				notify_roommate = true,
			}
		},	
	},
	
	{
		gameid = GameID.SAN;
		name = "三国发",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- 类型
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "三国发",
				playernum = 1, -- 房间玩家数量
				notify_roommate = true,
			}
		},	
	},
	

	{
		gameid = GameID.PK;
		name = "5pk",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- 类型
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "5pk",
				playernum = 1, -- 房间玩家数量
				notify_roommate = true,
			}
		},	
	},
	{
		gameid = GameID.HT343;
		name = "上仙劫",
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
		gameid = GameID.HT345;
		name = "万圣夜惊魂",
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
		gameid = GameID.FISH_ROULETTE;
		name = "红鲤鱼与绿鲤鱼",
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
		gameid = GameID.ANIMAL;
		name = "Animal",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- 类型
		classid = 
		{
			{
				id = ClassIDType.ROOM_NOCLOSE, 
				name = "Animal",
				playernum = 100, -- 房间玩家数量
				notify_roommate = true,
			}
		},	
	},
	{
		gameid = GameID.PURGATORY;
		name = "炼狱",
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
		gameid = GameID.FARM;
		name = "农场物语",
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
		gameid = GameID.MAH_SLOT;
		name = "推倒胡",
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
		gameid = GameID.WORLD;
		name = "环游世界",
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
		gameid = GameID.MINER;
		name = "疯狂挖金",
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
		gameid = GameID.CUTIE;
		name = "家有萌宝",
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
		gameid = GameID.HAOJIANG;
		name = "濠江之夜",
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
		gameid = GameID.SUPER8;
		name = "疯狂超8",
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
		gameid = GameID.RAINBOW;
		name = "彩虹连击",
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
		gameid = GameID.LONGFENG;
		name = "龙凤呈祥",
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
		gameid = GameID.LUCKY_RABBIT;
		name = "幸运兔子",
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
		gameid = GameID.PHARAOH;
		name = "尼罗河神庙",
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
		gameid = GameID.FOREST;
		name = "森林舞会",
		desc = "roulette_base.txt",
		rule = "roulette_custom.json",

		-- 类型
		classid = 
		{
			{
				id = ClassIDType.ROOM_NOCLOSE, 
				name = "百人",
				playernum = 1000, -- 房间玩家数量
				notify_roommate = false,
			},
		},
	},
	
	{
		gameid = GameID.BALL;
		name = "Ball",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- 类型
		classid = 
		{
			{
				id = ClassIDType.ROOM_NOCLOSE, 
				name = "百人",
				playernum = 100, -- 房间玩家数量
				notify_roommate = true,
			}
		},	
	},
	
	{
		gameid = GameID.FRUIT_LIGHT;
		name = "水果红绿灯",
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
		gameid = GameID.CLASSIC_4STAR;
		name = "经典四星",
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
		gameid = GameID.TREASURE;
		name = "红胡子宝藏",
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
		gameid = GameID.SERIAL_RAIDERS;
		name = "连环夺宝",
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
		gameid = GameID.FRUIT_EXPERT;
		name = "水果达人",
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
		gameid = GameID.TDRB;
		name = "冰火之灵",
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
		gameid = GameID.LuckyCandy;
		name = "幸运糖果",
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
		gameid = GameID.FARM_ESCAPE;
		name = "农场大逃亡",
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
		gameid = GameID.JIN_PING_MEI;
		name = "金瓶梅",
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
		gameid = GameID.MARBLES;
		name = "满贯连珠",
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
		gameid = GameID.BOX;
		name = "萌盒",
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
		gameid = GameID.GANGS;
		name = "黑帮",
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
		gameid = GameID.PROMOTION;
		name = "升官发财",
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
		gameid = GameID.WILDNESS;
		name = "野性狂奔",
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
}

function GetGameList()
	return _GameList
end