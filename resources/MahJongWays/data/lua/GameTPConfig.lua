
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
		gameid = GameID.ROULETTE_1;
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
		gameid = GameID.ROULETTE_2;
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
		gameid = GameID.ROULETTE_CUSTOM;
		classid = ClassIDType.ROOM_SINGLE;
		name = "ŷʽ����";
		
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
	{
		gameid = GameID.FREE_CLOCK;
		classid = ClassIDType.ROOM_SINGLE;
		name = "������";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.ROAD_RACER;
		classid = ClassIDType.ROOM_SINGLE;
		name = "��Ұʱ��";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.QUANTUM_MATRIX;
		classid = ClassIDType.ROOM_SINGLE;
		name = "���Ӿ���";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.COSTA_RICA;
		classid = ClassIDType.ROOM_SINGLE;
		name = "��˹�����";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.ATLANTIS;
		classid = ClassIDType.ROOM_SINGLE;
		name = "��������˹";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.CROWNMARY;
		classid = ClassIDType.ROOM_SINGLE;
		name = "�ʹ�С����";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.NEZHA;
		classid = ClassIDType.ROOM_NOCLOSE;
		name = "��߸";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.NEZHA_1;
		classid = ClassIDType.ROOM_NOCLOSE;
		name = "��߸";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.NEZHA_2;
		classid = ClassIDType.ROOM_NOCLOSE;
		name = "��߸";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	
	{
		gameid = GameID.HT343;
		classid = ClassIDType.ROOM_SINGLE;
		name = "���ɽ�";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	
	{
		gameid = GameID.ANCIENT_TOMB;
		classid = ClassIDType.ROOM_SINGLE;
		name = "��Ĺ����";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	
	{
		gameid = GameID.HT345;
		classid = ClassIDType.ROOM_SINGLE;
		name = "��ʥҹ����";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	
	{
		gameid = GameID.FISH_ROULETTE;
		classid = ClassIDType.ROOM_SINGLE;
		name = "��������������";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	
	{
		gameid = GameID.PURGATORY;
		classid = ClassIDType.ROOM_SINGLE;
		name = "����";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.FARM;
		classid = ClassIDType.ROOM_SINGLE;
		name = "ũ������";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.MAH_SLOT;
		classid = ClassIDType.ROOM_SINGLE;
		name = "�Ƶ���";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.WORLD;
		classid = ClassIDType.ROOM_SINGLE;
		name = "��������";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.MINER;
		classid = ClassIDType.ROOM_SINGLE;
		name = "����ڽ�";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.CUTIE;
		classid = ClassIDType.ROOM_SINGLE;
		name = "�����ȱ�";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.HAOJIANG;
		classid = ClassIDType.ROOM_SINGLE;
		name = "婽�֮ҹ";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.SUPER8;
		classid = ClassIDType.ROOM_SINGLE;
		name = "���8";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.RAINBOW;
		classid = ClassIDType.ROOM_SINGLE;
		name = "�ʺ�����";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.LONGFENG;
		classid = ClassIDType.ROOM_SINGLE;
		name = "�������";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.LUCKY_RABBIT;
		classid = ClassIDType.ROOM_SINGLE;
		name = "��������";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.PHARAOH;
		classid = ClassIDType.ROOM_SINGLE;
		name = "���޺�����";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.FRUIT_LIGHT;
		classid = ClassIDType.ROOM_SINGLE;
		name = "ˮ�����̵�";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.CLASSIC_4STAR;
		classid = ClassIDType.ROOM_SINGLE;
		name = "��������";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
			{ CommonTimeType.CLASSIC4STAR, 20 }		-- ��λ: ��
		}
	},
	{
		gameid = GameID.TREASURE;
		classid = ClassIDType.ROOM_SINGLE;
		name = "����ӱ���";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.SERIAL_RAIDERS;
		classid = ClassIDType.ROOM_SINGLE;
		name = "�����ᱦ";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.FRUIT_EXPERT;
		classid = ClassIDType.ROOM_SINGLE;
		name = "ˮ������";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.TDRB;
		classid = ClassIDType.ROOM_SINGLE;
		name = "����֮��";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.FARM_ESCAPE;
		classid = ClassIDType.ROOM_SINGLE;
		name = "ũ��������";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.MARBLES;
		classid = ClassIDType.ROOM_SINGLE;
		name = "��������";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	{
		gameid = GameID.FOREST;
		classid = ClassIDType.ROOM_NOCLOSE;
		name = "ɭ�����";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
			{ ForestStep.BET, 20 },	-- ��λ: ��
			{ ForestStep.CLOSE_ACCOUNT, 3 },	-- ��λ: ��
			{ ForestStep.SHOW, 15 }, -- ��λ: ��
			{ ForestStep.NOTIFY, 3 }, -- ��λ: ��
			{ ForestStep.SYS_BET, 7 }, -- ��λ: ��
		}
	},
	{
		gameid = GameID.LuckyCandy;
		classid = ClassIDType.ROOM_SINGLE;
		name = "�����ǹ�";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	
	{
		gameid = GameID.JIN_PING_MEI;
		classid = ClassIDType.ROOM_SINGLE;
		name = "��ƿ÷";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	
	{
		gameid = GameID.GANGS;
		classid = ClassIDType.ROOM_SINGLE;
		name = "�ڰ�";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	
	{
		gameid = GameID.PROMOTION;
		classid = ClassIDType.ROOM_SINGLE;
		name = "���ٷ���";
		
		room_prepare_time = 0;		-- ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
		}
	},
	
	{
		gameid = GameID.WILDNESS;
		classid = ClassIDType.ROOM_SINGLE;
		name = "Ұ�Կ�";
		
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