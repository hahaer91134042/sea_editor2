
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
		name = "ŷʽ����";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
			{ RouletteStep.BET, 42 },	-- ��λ: ��
			{ RouletteStep.CLOSE_ACCOUNT, 4 },	-- ��λ: ��
			{ RouletteStep.END, 25 }, -- ��λ: ��
			{ RouletteStep.NOTIFY, 5 }, -- ��λ: ��
			{ RouletteStep.SYS_BET, 7 }, -- ��λ: ��
		}
	},
	{
		gameid = GameID.ROULETTE;
		classid = ClassIDType.ROOM_SINGLE;
		name = "ŷʽ����-����";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
			{ RouletteStep.BET, 0 },	-- ��λ: ��
			{ RouletteStep.CLOSE_ACCOUNT, 4 },	-- ��λ: ��
			{ RouletteStep.END, 25 }, -- ��λ: ��
			{ RouletteStep.NOTIFY, 5 }, -- ��λ: ��
			{ RouletteStep.SYS_BET, 7 }, -- ��λ: ��
		}
	},
	{
		gameid = GameID.ROULETTE;
		classid = ClassIDType.ROOM_CUSTOM;
		name = "ŷʽ����-����";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
			{ RouletteStep.BET, 42 },	-- ��λ: ��
			{ RouletteStep.CLOSE_ACCOUNT, 4 },	-- ��λ: ��
			{ RouletteStep.END, 25 }, -- ��λ: ��
			{ RouletteStep.NOTIFY, 5 }, -- ��λ: ��
			{ RouletteStep.SYS_BET, 3 }, -- ��λ: ��
		}
	},
	{
		gameid = GameID.USA_ROULETTE;
		classid = ClassIDType.ROOM_NOCLOSE;
		name = "��ʽ����";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
			{ RouletteStep.BET, 30 },	-- ��λ: ��
			{ RouletteStep.CLOSE_ACCOUNT, 4 },	-- ��λ: ��
			{ RouletteStep.END, 25 }, -- ��λ: ��
			{ RouletteStep.NOTIFY, 5 }, -- ��λ: ��
			{ RouletteStep.SYS_BET, 7 }, -- ��λ: ��
		}
	},
	{
		gameid = GameID.USA_ROULETTE;
		classid = ClassIDType.ROOM_SINGLE;
		name = "��ʽ����-����";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
			{ RouletteStep.BET, 0 },	-- ��λ: ��
			{ RouletteStep.CLOSE_ACCOUNT, 4 },	-- ��λ: ��
			{ RouletteStep.END, 25 }, -- ��λ: ��
			{ RouletteStep.NOTIFY, 5 }, -- ��λ: ��
			{ RouletteStep.SYS_BET, 7 }, -- ��λ: ��
		}
	},
	{
		gameid = GameID.USA_ROULETTE;
		classid = ClassIDType.ROOM_CUSTOM;
		name = "��ʽ����-����";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
			{ RouletteStep.BET, 30 },	-- ��λ: ��
			{ RouletteStep.CLOSE_ACCOUNT, 4 },	-- ��λ: ��
			{ RouletteStep.END, 25 }, -- ��λ: ��
			{ RouletteStep.NOTIFY, 5 }, -- ��λ: ��
			{ RouletteStep.SYS_BET, 3 }, -- ��λ: ��
		}
	},
	{
		gameid = GameID.SLOT_MACHINE;
		classid = ClassIDType.ROOM_SINGLE;
		name = "�ϻ���";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.PINBALL_BINGO;
		classid = ClassIDType.ROOM_SINGLE;
		name = "BINGO����";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
			{ PinBallStep.END, 3 }, -- ��λ: ��
		}
	},
	{
		gameid = GameID.PINBALL_LIGHTS;
		classid = ClassIDType.ROOM_SINGLE;
		name = "һ������";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
			{ PinBallStep.END, 3 }, -- ��λ: ��
		}
	},
	{
		gameid = GameID.PINBALL_5COLOR;
		classid = ClassIDType.ROOM_SINGLE;
		name = "��Ƶ���";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
			{ PinBallStep.END, 3 }, -- ��λ: ��
		}
	},
	{
		gameid = GameID.HUGA;
		classid = ClassIDType.ROOM_SINGLE;
		name = "HUGA";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.DRAGON;
		classid = ClassIDType.ROOM_SINGLE;
		name = "������";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.WSDL;
		classid = ClassIDType.ROOM_SINGLE;
		name = "������";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.THIRD_PRINCE;
		classid = ClassIDType.ROOM_SINGLE;
		name = "��̫��";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.CLASSIC7;
		classid = ClassIDType.ROOM_SINGLE;
		name = "����7";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.DATANG;
		classid = ClassIDType.ROOM_SINGLE;
		name = "����";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.NINJIA;
		classid = ClassIDType.ROOM_SINGLE;
		name = "����";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.FOREVER_DIAMOND;
		classid = ClassIDType.ROOM_SINGLE;
		name = "���㱦ʯ";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
}

function GetTPCfgList()
	return _TPSceneCfg
end