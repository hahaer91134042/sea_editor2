
require("gamelist")

RouletteStep = 
{
	BET = 0,
	CLOSE_ACCOUNT = 1,
	END = 2,
	NOTIFY = 3,
	SYS_BET = 4,
}

ForestStep =
{
	BET = 0,
	CLOSE_ACCOUNT = 1,
	SHOW = 2,
	NOTIFY = 3,
	SYS_BET = 4,
}

CommonTimeType = 
{
	CLASSIC4STAR = 0,
}
PinBallStep = 
{
	END = 0,
}

local _TPSceneCfg = 
{
	{
		gameid = GameID.ROULETTE;
		classid = ClassIDType.ROOM_NOCLOSE;
		name = "欧式轮盘";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
			{ RouletteStep.BET, 42 },	-- 单位: 秒
			{ RouletteStep.CLOSE_ACCOUNT, 4 },	-- 单位: 秒
			{ RouletteStep.END, 25 }, -- 单位: 秒
			{ RouletteStep.NOTIFY, 5 }, -- 单位: 秒
			{ RouletteStep.SYS_BET, 7 }, -- 单位: 秒
		}
	},
	{
		gameid = GameID.ROULETTE;
		classid = ClassIDType.ROOM_SINGLE;
		name = "欧式轮盘-单人";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
			{ RouletteStep.BET, 0 },	-- 单位: 秒
			{ RouletteStep.CLOSE_ACCOUNT, 4 },	-- 单位: 秒
			{ RouletteStep.END, 25 }, -- 单位: 秒
			{ RouletteStep.NOTIFY, 5 }, -- 单位: 秒
			{ RouletteStep.SYS_BET, 7 }, -- 单位: 秒
		}
	},
	{
		gameid = GameID.ROULETTE;
		classid = ClassIDType.ROOM_CUSTOM;
		name = "欧式轮盘-房卡";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
			{ RouletteStep.BET, 42 },	-- 单位: 秒
			{ RouletteStep.CLOSE_ACCOUNT, 4 },	-- 单位: 秒
			{ RouletteStep.END, 25 }, -- 单位: 秒
			{ RouletteStep.NOTIFY, 5 }, -- 单位: 秒
			{ RouletteStep.SYS_BET, 3 }, -- 单位: 秒
		}
	},
	{
		gameid = GameID.USA_ROULETTE;
		classid = ClassIDType.ROOM_NOCLOSE;
		name = "美式轮盘";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
			{ RouletteStep.BET, 30 },	-- 单位: 秒
			{ RouletteStep.CLOSE_ACCOUNT, 4 },	-- 单位: 秒
			{ RouletteStep.END, 25 }, -- 单位: 秒
			{ RouletteStep.NOTIFY, 5 }, -- 单位: 秒
			{ RouletteStep.SYS_BET, 7 }, -- 单位: 秒
		}
	},
	{
		gameid = GameID.USA_ROULETTE;
		classid = ClassIDType.ROOM_SINGLE;
		name = "美式轮盘-单人";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
			{ RouletteStep.BET, 0 },	-- 单位: 秒
			{ RouletteStep.CLOSE_ACCOUNT, 4 },	-- 单位: 秒
			{ RouletteStep.END, 25 }, -- 单位: 秒
			{ RouletteStep.NOTIFY, 5 }, -- 单位: 秒
			{ RouletteStep.SYS_BET, 7 }, -- 单位: 秒
		}
	},
	{
		gameid = GameID.USA_ROULETTE;
		classid = ClassIDType.ROOM_CUSTOM;
		name = "美式轮盘-房卡";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
			{ RouletteStep.BET, 30 },	-- 单位: 秒
			{ RouletteStep.CLOSE_ACCOUNT, 4 },	-- 单位: 秒
			{ RouletteStep.END, 25 }, -- 单位: 秒
			{ RouletteStep.NOTIFY, 5 }, -- 单位: 秒
			{ RouletteStep.SYS_BET, 3 }, -- 单位: 秒
		}
	},
	{
		gameid = GameID.ROULETTE_1;
		classid = ClassIDType.ROOM_NOCLOSE;
		name = "欧式轮盘";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
			{ RouletteStep.BET, 42 },	-- 单位: 秒
			{ RouletteStep.CLOSE_ACCOUNT, 4 },	-- 单位: 秒
			{ RouletteStep.END, 25 }, -- 单位: 秒
			{ RouletteStep.NOTIFY, 5 }, -- 单位: 秒
			{ RouletteStep.SYS_BET, 7 }, -- 单位: 秒
		}
	},
	{
		gameid = GameID.ROULETTE_2;
		classid = ClassIDType.ROOM_NOCLOSE;
		name = "欧式轮盘";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
			{ RouletteStep.BET, 42 },	-- 单位: 秒
			{ RouletteStep.CLOSE_ACCOUNT, 4 },	-- 单位: 秒
			{ RouletteStep.END, 25 }, -- 单位: 秒
			{ RouletteStep.NOTIFY, 5 }, -- 单位: 秒
			{ RouletteStep.SYS_BET, 7 }, -- 单位: 秒
		}
	},
	{
		gameid = GameID.ROULETTE_CUSTOM;
		classid = ClassIDType.ROOM_SINGLE;
		name = "欧式轮盘";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
			{ RouletteStep.BET, 30 },	-- 单位: 秒
			{ RouletteStep.CLOSE_ACCOUNT, 4 },	-- 单位: 秒
			{ RouletteStep.END, 25 }, -- 单位: 秒
			{ RouletteStep.NOTIFY, 5 }, -- 单位: 秒
			{ RouletteStep.SYS_BET, 3 }, -- 单位: 秒
		}
	},
	{
		gameid = GameID.SLOT_MACHINE;
		classid = ClassIDType.ROOM_SINGLE;
		name = "老虎机";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.PINBALL_BINGO;
		classid = ClassIDType.ROOM_SINGLE;
		name = "BINGO弹珠";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
			{ PinBallStep.END, 3 }, -- 单位: 秒
		}
	},
	{
		gameid = GameID.PINBALL_LIGHTS;
		classid = ClassIDType.ROOM_SINGLE;
		name = "一发弹珠";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
			{ PinBallStep.END, 3 }, -- 单位: 秒
		}
	},
	{
		gameid = GameID.PINBALL_5COLOR;
		classid = ClassIDType.ROOM_SINGLE;
		name = "五灯弹珠";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
			{ PinBallStep.END, 3 }, -- 单位: 秒
		}
	},
	{
		gameid = GameID.HUGA;
		classid = ClassIDType.ROOM_SINGLE;
		name = "HUGA";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.DRAGON;
		classid = ClassIDType.ROOM_SINGLE;
		name = "龙来宝";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.WSDL;
		classid = ClassIDType.ROOM_SINGLE;
		name = "龙来宝";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.THIRD_PRINCE;
		classid = ClassIDType.ROOM_SINGLE;
		name = "三太子";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.CLASSIC7;
		classid = ClassIDType.ROOM_SINGLE;
		name = "经典7";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.DATANG;
		classid = ClassIDType.ROOM_SINGLE;
		name = "大唐";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.NINJIA;
		classid = ClassIDType.ROOM_SINGLE;
		name = "忍者";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.FOREVER_DIAMOND;
		classid = ClassIDType.ROOM_SINGLE;
		name = "永恒宝石";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.FREE_CLOCK;
		classid = ClassIDType.ROOM_SINGLE;
		name = "自由钟";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.ROAD_RACER;
		classid = ClassIDType.ROOM_SINGLE;
		name = "狂野时速";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.QUANTUM_MATRIX;
		classid = ClassIDType.ROOM_SINGLE;
		name = "量子矩阵";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.COSTA_RICA;
		classid = ClassIDType.ROOM_SINGLE;
		name = "哥斯达黎加";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.ATLANTIS;
		classid = ClassIDType.ROOM_SINGLE;
		name = "亚特兰蒂斯";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.CROWNMARY;
		classid = ClassIDType.ROOM_SINGLE;
		name = "皇冠小玛丽";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.NEZHA;
		classid = ClassIDType.ROOM_NOCLOSE;
		name = "哪吒";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.NEZHA_1;
		classid = ClassIDType.ROOM_NOCLOSE;
		name = "哪吒";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.NEZHA_2;
		classid = ClassIDType.ROOM_NOCLOSE;
		name = "哪吒";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	
	{
		gameid = GameID.HT343;
		classid = ClassIDType.ROOM_SINGLE;
		name = "上仙劫";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	
	{
		gameid = GameID.ANCIENT_TOMB;
		classid = ClassIDType.ROOM_SINGLE;
		name = "古墓玄奇";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	
	{
		gameid = GameID.HT345;
		classid = ClassIDType.ROOM_SINGLE;
		name = "万圣夜惊魂";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	
	{
		gameid = GameID.FISH_ROULETTE;
		classid = ClassIDType.ROOM_SINGLE;
		name = "红鲤鱼与绿鲤鱼";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	
	{
		gameid = GameID.PURGATORY;
		classid = ClassIDType.ROOM_SINGLE;
		name = "炼狱";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.FARM;
		classid = ClassIDType.ROOM_SINGLE;
		name = "农场物语";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.MAH_SLOT;
		classid = ClassIDType.ROOM_SINGLE;
		name = "推倒胡";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.WORLD;
		classid = ClassIDType.ROOM_SINGLE;
		name = "环游世界";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.MINER;
		classid = ClassIDType.ROOM_SINGLE;
		name = "疯狂挖金";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.CUTIE;
		classid = ClassIDType.ROOM_SINGLE;
		name = "家有萌宝";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.HAOJIANG;
		classid = ClassIDType.ROOM_SINGLE;
		name = "濠江之夜";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.SUPER8;
		classid = ClassIDType.ROOM_SINGLE;
		name = "疯狂超8";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.RAINBOW;
		classid = ClassIDType.ROOM_SINGLE;
		name = "彩虹连击";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.LONGFENG;
		classid = ClassIDType.ROOM_SINGLE;
		name = "龙凤呈祥";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.LUCKY_RABBIT;
		classid = ClassIDType.ROOM_SINGLE;
		name = "幸运兔子";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.PHARAOH;
		classid = ClassIDType.ROOM_SINGLE;
		name = "尼罗河神庙";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.FRUIT_LIGHT;
		classid = ClassIDType.ROOM_SINGLE;
		name = "水果红绿灯";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.CLASSIC_4STAR;
		classid = ClassIDType.ROOM_SINGLE;
		name = "经典四星";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
			{ CommonTimeType.CLASSIC4STAR, 20 }		-- 单位: 秒
		}
	},
	{
		gameid = GameID.TREASURE;
		classid = ClassIDType.ROOM_SINGLE;
		name = "红胡子宝藏";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.SERIAL_RAIDERS;
		classid = ClassIDType.ROOM_SINGLE;
		name = "连环夺宝";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.FRUIT_EXPERT;
		classid = ClassIDType.ROOM_SINGLE;
		name = "水果达人";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.TDRB;
		classid = ClassIDType.ROOM_SINGLE;
		name = "冰火之灵";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.FARM_ESCAPE;
		classid = ClassIDType.ROOM_SINGLE;
		name = "农场大逃亡";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.MARBLES;
		classid = ClassIDType.ROOM_SINGLE;
		name = "满贯连珠";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.FOREST;
		classid = ClassIDType.ROOM_NOCLOSE;
		name = "森林舞会";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
			{ ForestStep.BET, 20 },	-- 单位: 秒
			{ ForestStep.CLOSE_ACCOUNT, 3 },	-- 单位: 秒
			{ ForestStep.SHOW, 15 }, -- 单位: 秒
			{ ForestStep.NOTIFY, 3 }, -- 单位: 秒
			{ ForestStep.SYS_BET, 7 }, -- 单位: 秒
		}
	},
	{
		gameid = GameID.LuckyCandy;
		classid = ClassIDType.ROOM_SINGLE;
		name = "幸运糖果";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	
	{
		gameid = GameID.JIN_PING_MEI;
		classid = ClassIDType.ROOM_SINGLE;
		name = "金瓶梅";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	
	{
		gameid = GameID.GANGS;
		classid = ClassIDType.ROOM_SINGLE;
		name = "黑帮";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	
	{
		gameid = GameID.PROMOTION;
		classid = ClassIDType.ROOM_SINGLE;
		name = "升官发财";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	
	{
		gameid = GameID.WILDNESS;
		classid = ClassIDType.ROOM_SINGLE;
		name = "野性狂奔";
		
		room_prepare_time = 0;		-- 无限
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
		}
	},
	
}

function GetTPCfgList()
	return _TPSceneCfg
end