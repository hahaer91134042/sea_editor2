----
require("debug")

GameID =
{
	SH_KNOCK = 101, -- �齫
	MAH_STANDARD = 102, -- ����
	BLOOD_TO_THE_END = 103,		-- Ѫս����
	MAH_CS = 105, -- ��ɳ�齫
	
	ROULETTE = 300, 		-- ŷʽ����
	SLOT_MACHINE = 301,		-- �ϻ���
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
	FREE_CLOCK = 314,   --������
	ROAD_RACER = 315,   --����
	QUANTUM_MATRIX = 316,   --���Ӿ���
	COSTA_RICA = 317,  --��˹�����
	ATLANTIS = 318,  --��������˹
	CROWNMARY = 319,  --�ʹ�С����
	NEZHA = 320,  --��߸
	HT343 = 321,  --����343
	ANCIENT_TOMB = 322, --��Ĺ����
	HT345 = 323,	-- ����345 ��ʥҹ
	FISH_ROULETTE = 324,		-- ��������
	PURGATORY = 325,   -- ����(4*5)
	FARM = 326,        -- ũ��
	MAH_SLOT = 327,		-- �Ƶ���
	WORLD = 328,        -- ��������
	MINER = 329,		-- �ڽ��
	CUTIE = 330,		-- �����ȱ�
	HAOJIANG = 331,		-- 婽�֮ҹ
	SUPER8 = 332,		-- ���8
	RAINBOW = 333,		-- �ʺ�����
	LONGFENG = 334,		-- �������
	PHARAOH = 335,		-- ������
	LUCKY_RABBIT = 336,	-- ��������
	FRUIT_LIGHT = 337,	-- ˮ�����̵�
	CLASSIC_4STAR = 338,	-- ��������
	TREASURE = 339,		-- ����ӱ���
	SERIAL_RAIDERS = 343, -- �����ᱦ
	FRUIT_EXPERT = 341, -- ˮ������
	TDRB = 342,         -- 2��Ԫ(����֮��)
	LuckyCandy = 344,   -- �����ǹ�
	FARM_ESCAPE = 345,   -- ũ��������
	JIN_PING_MEI = 346,  -- ��ƿ÷
	MARBLES = 347,       -- ��������
	GANGS = 348,       -- �ڰ�
	PROMOTION = 349,   -- ���ٷ���
	WILDNESS = 350,    -- Ұ�Կ�
	
	POKER_DZ = 501,    --�����˿�
	
	FISH = 601, -- ����
	LOTTERY = 701, --ħŮ
	SAN = 702, -- ������
	PK = 801, -- 5pk
	ANIMAL = 901, -- ����
	BALL = 902, -- ���̶Զ���
	FOREST = 1001, -- ɭ�����
	BOX = 1101, -- �Ⱥ�
	
	-- ����Ϊ�����Կ�����
	ROULETTE_1 = 3001, 		-- ŷʽ����-1
	ROULETTE_2 = 3002, 		-- ŷʽ����-2
	ROULETTE_CUSTOM = 3003,	-- ŷʽ����-���˷�
	NEZHA_1 = 3201,  --��߸-1
	NEZHA_2 = 3202,  --��߸-2
	-- end
		
}

ClassIDType =
{
	ROOM_BASE = 0, 		-- ����
	ROOM_SINGLE = 1, 	-- ����
	ROOM_NOCLOSE = 2,	-- ����
	ROOM_CUSTOM = 3,	-- ��ҿ���
}

local _GameList =
{
	{
		gameid = GameID.SH_KNOCK;
		name = "�Ϻ�����",
		desc = "shknock.txt",
		rule = "shknock.json",

		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_CUSTOM, 
				name = "��ע",
				playernum = 2, -- �����������
				notify_roommate = false,
			},
		},
	},

	{
		gameid = GameID.MAH_CS;
		name = "��ɳ�齫",
		desc = "shknock.txt",
		rule = "shknock.json",

		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_CUSTOM, 
				name = "��ע",
				playernum = 2, -- �����������
				notify_roommate = true,
			},
		},
	},

	{
		gameid = GameID.BLOOD_TO_THE_END;
		name = "Ѫս����",
		desc = "shknock.txt",
		rule = "shknock.json",

		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_CUSTOM, 
				name = "��ע",
				playernum = 4, -- �����������
				notify_roommate = true,
			},
		},
	},

	{
		gameid = GameID.ROULETTE;
		name = "ŷʽ����",
		desc = "roulette_base.txt",
		rule = "roulette_custom.json",

		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			},
			{
				id = ClassIDType.ROOM_CUSTOM, 
				name = "����",
				playernum = 17, -- �����������
				notify_roommate = true,
			},
			{
				id = ClassIDType.ROOM_NOCLOSE, 
				name = "����",
				playernum = 1000, -- �����������
				notify_roommate = false,
			},
		},
	},
	{
		gameid = GameID.ROULETTE_1;
		name = "ŷʽ����",
		desc = "roulette_base.txt",
		rule = "roulette_custom.json",

		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_NOCLOSE, 
				name = "����",
				playernum = 1000, -- �����������
				notify_roommate = false,
			},
		},
	},
	{
		gameid = GameID.ROULETTE_2;
		name = "ŷʽ����",
		desc = "roulette_base.txt",
		rule = "roulette_custom.json",

		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_NOCLOSE, 
				name = "����",
				playernum = 1000, -- �����������
				notify_roommate = false,
			},
		},
	},	
	{
		gameid = GameID.ROULETTE_CUSTOM;
		name = "ŷʽ����",
		desc = "roulette_base.txt",
		rule = "roulette_custom.json",

		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_CUSTOM, 
				name = "����",
				playernum = 17, -- �����������
				notify_roommate = true,
			},
		},
	},	
	{
		gameid = GameID.SLOT_MACHINE;
		name = "�ϻ���",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},
	},
	{
		gameid = GameID.PINBALL_BINGO;
		name = "BINGO����",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},		
	},
	{
		gameid = GameID.PINBALL_LIGHTS;
		name = "һ������",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},		
	},
	{
		gameid = GameID.PINBALL_5COLOR;
		name = "��Ƶ���",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},		
	},
	{
		gameid = GameID.USA_ROULETTE;
		name = "��ʽ����",
		desc = "roulette_base.txt",
		rule = "roulette_custom.json",

		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			},
			{
				id = ClassIDType.ROOM_CUSTOM, 
				name = "����",
				playernum = 17, -- �����������
				notify_roommate = true,
			},
			{
				id = ClassIDType.ROOM_NOCLOSE, 
				name = "����",
				playernum = 1000, -- �����������
				notify_roommate = false,
			},
		},
	},
	{
		gameid = GameID.HUGA;
		name = "HUGA",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},
	},
	{
		gameid = GameID.DRAGON;
		name = "������",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},
	},
	{
		gameid = GameID.WSDL;
		name = "��ɫ��¯",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},
	},
	{
		gameid = GameID.THIRD_PRINCE;
		name = "��̫��",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},
	},
	{
		gameid = GameID.CLASSIC7;
		name = "����7",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},
	},
	{
		gameid = GameID.DATANG;
		name = "����ˮ����",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},
	},
	{
		gameid = GameID.NINJIA;
		name = "��������",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},
	},
	{
		gameid = GameID.FOREVER_DIAMOND;
		name = "���㱦ʯ",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},
	},
	{
		gameid = GameID.FREE_CLOCK;
		name = "��������",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},
	},
	{
		gameid = GameID.ROAD_RACER;
		name = "��Ұʱ��",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},
	},
	{
		gameid = GameID.QUANTUM_MATRIX;
		name = "���Ӿ���",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},
	},
	{
		gameid = GameID.COSTA_RICA;
		name = "��������",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},
	},
	{
		gameid = GameID.ATLANTIS;
		name = "��Ī���Ų�",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},
	},
	{
		gameid = GameID.CROWNMARY;
		name = "�ʹ�С����",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},
	},
	{
		gameid = GameID.NEZHA;
		name = "��߸",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_NOCLOSE, 
				name = "����",
				playernum = 400, -- �����������
				notify_roommate = true,
			}
		},	
	},
	{
		gameid = GameID.NEZHA_1;
		name = "��߸",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_NOCLOSE, 
				name = "����",
				playernum = 400, -- �����������
				notify_roommate = true,
			}
		},	
	},
	{
		gameid = GameID.NEZHA_2;
		name = "��߸",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_NOCLOSE, 
				name = "����",
				playernum = 400, -- �����������
				notify_roommate = true,
			}
		},	
	},
	{
		gameid = GameID.ANCIENT_TOMB;
		name = "��Ĺ����",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},	
	},
	
	{
		gameid = GameID.POKER_DZ;
		name = "�����˿�",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_BASE, 
				name = "��ͨ",
				playernum = 9, -- �����������
				notify_roommate = true,
			}
		},	
	},

	{
		gameid = GameID.FISH;
		name = "����",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_NOCLOSE, 
				name = "����",
				playernum = 4, -- �����������
				notify_roommate = true,
			}
		},	
	},

	{
		gameid = GameID.LOTTERY;
		name = "��Ʊ",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "��Ʊ",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},	
	},
	
	{
		gameid = GameID.SAN;
		name = "������",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "������",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},	
	},
	

	{
		gameid = GameID.PK;
		name = "5pk",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "5pk",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},	
	},
	{
		gameid = GameID.HT343;
		name = "���ɽ�",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},
	},
	{
		gameid = GameID.HT345;
		name = "��ʥҹ����",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},
	},
	{
		gameid = GameID.FISH_ROULETTE;
		name = "��������������",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},
	},
	
	{
		gameid = GameID.ANIMAL;
		name = "Animal",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_NOCLOSE, 
				name = "Animal",
				playernum = 100, -- �����������
				notify_roommate = true,
			}
		},	
	},
	{
		gameid = GameID.PURGATORY;
		name = "����",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},
	},
	{
		gameid = GameID.FARM;
		name = "ũ������",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},
	},
	{
		gameid = GameID.MAH_SLOT;
		name = "�Ƶ���",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},
	},
	{
		gameid = GameID.WORLD;
		name = "��������",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},
	},
	{
		gameid = GameID.MINER;
		name = "����ڽ�",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},
	},
	{
		gameid = GameID.CUTIE;
		name = "�����ȱ�",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},
	},
	{
		gameid = GameID.HAOJIANG;
		name = "婽�֮ҹ",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},
	},
	{
		gameid = GameID.SUPER8;
		name = "���8",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},
	},
	{
		gameid = GameID.RAINBOW;
		name = "�ʺ�����",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},
	},
	{
		gameid = GameID.LONGFENG;
		name = "�������",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},
	}, 
	{
		gameid = GameID.LUCKY_RABBIT;
		name = "��������",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},
	},
	{
		gameid = GameID.PHARAOH;
		name = "���޺�����",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},
	},
	{
		gameid = GameID.FOREST;
		name = "ɭ�����",
		desc = "roulette_base.txt",
		rule = "roulette_custom.json",

		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_NOCLOSE, 
				name = "����",
				playernum = 1000, -- �����������
				notify_roommate = false,
			},
		},
	},
	
	{
		gameid = GameID.BALL;
		name = "Ball",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_NOCLOSE, 
				name = "����",
				playernum = 100, -- �����������
				notify_roommate = true,
			}
		},	
	},
	
	{
		gameid = GameID.FRUIT_LIGHT;
		name = "ˮ�����̵�",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},	
	},
	
	{
		gameid = GameID.CLASSIC_4STAR;
		name = "��������",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},	
	},
	
	{
		gameid = GameID.TREASURE;
		name = "����ӱ���",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},	
	},
	
	{
		gameid = GameID.SERIAL_RAIDERS;
		name = "�����ᱦ",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},
	},
	
	{
		gameid = GameID.FRUIT_EXPERT;
		name = "ˮ������",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},
	},
	
	{
		gameid = GameID.TDRB;
		name = "����֮��",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},
	},
	
	{
		gameid = GameID.LuckyCandy;
		name = "�����ǹ�",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},
	},
	
	{
		gameid = GameID.FARM_ESCAPE;
		name = "ũ��������",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},
	},
	
	{
		gameid = GameID.JIN_PING_MEI;
		name = "��ƿ÷",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},
	},

	{
		gameid = GameID.MARBLES;
		name = "��������",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},
	}, 
	{
		gameid = GameID.BOX;
		name = "�Ⱥ�",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},	
	}, 
	{
		gameid = GameID.GANGS;
		name = "�ڰ�",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},
	}, 
	
	{
		gameid = GameID.PROMOTION;
		name = "���ٷ���",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},
	},
	
	{
		gameid = GameID.WILDNESS;
		name = "Ұ�Կ�",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_SINGLE, 
				name = "����",
				playernum = 1, -- �����������
				notify_roommate = true,
			}
		},
	}, 
}

function GetGameList()
	return _GameList
end