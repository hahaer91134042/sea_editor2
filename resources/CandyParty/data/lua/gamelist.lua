----
require("debug")

GameID =
{
	
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
	
	POKER_DZ = 501    --�����˿�
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
		gameid = GameID.NINJIA;
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
		gameid = GameID.POKER_DZ;
		name = "�����˿�",
		desc = "roulette_base.txt",
		rule = "roulette_base.json",
		
		-- ����
		classid = 
		{
			{
				id = ClassIDType.ROOM_BASE, 
				name = "�����˿�",
				playernum = 9, -- �����������
				notify_roommate = true,
			}
		},	
	},

}

function GetGameList()
	return _GameList
end