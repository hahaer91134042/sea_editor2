
require("gamelist")

RouletteStep = 
{
	BET = 0,
	CLOSE_ACCOUNT = 1,
	END = 2,
	NOTIFY = 3,
	SYS_BET = 4,
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
}

function GetTPCfgList()
	return _TPSceneCfg
end