
require("gamelist")

MahjongStep = 
{
	SEAT = 0, -- ѡ��λ��Ͷ���ӣ�       ��λ��0.1��
	WIND = 1, -- ѡ������λͷ�ң�     ��λ��0.1��
	DICE = 2, -- ѡ���Ʒ���ׯ�ң�     ��λ��0.1��
	BUILD = 3, -- ���Ƽ��              ��λ��0.1��
	DRAW = 4, -- ���Ƽ��               ��λ����
	CHOW = 5, -- �����ܺ����Ǽ��       ��λ����
	SWAP = 6, -- �����ż��				��λ����
	LACK = 7, -- ѡȱ					��λ����
}

local _GameMahConfig = {
	{
		AI = "MahjongCS",
		
		gameid = GameID.MAH_CS;
		classid = ClassIDType.ROOM_CUSTOM;
		name = "��ɳ�齫";
		
		room_prepare_time = 3;		-- ��λ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
			{ MahjongStep.SEAT, 60 }, -- ��λ: 0.1��
			{ MahjongStep.WIND, 60 }, -- ��λ: 0.1��
			{ MahjongStep.DICE, 30 }, -- ��λ: 0.1��
			{ MahjongStep.BUILD, 5 }, -- ��λ: 0.1��
			{ MahjongStep.DRAW, 10 }, -- ��λ: ��
			{ MahjongStep.CHOW, 10 }, -- ��λ: ��
		}	
	}, 	
	{
		AI = "MahjongSHKnock",
		
		gameid = GameID.SH_KNOCK;
		classid = ClassIDType.ROOM_CUSTOM;
		name = "�Ϻ�����";
		
		room_prepare_time = 3;		-- ��λ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
			{ MahjongStep.SEAT, 60 }, -- ��λ: 0.1��
			{ MahjongStep.WIND, 60 }, -- ��λ: 0.1��
			{ MahjongStep.DICE, 30 }, -- ��λ: 0.1��
			{ MahjongStep.BUILD, 5 }, -- ��λ: 0.1��
			{ MahjongStep.DRAW, 10 }, -- ��λ: ��
			{ MahjongStep.CHOW, 10 }, -- ��λ: ��
		}	
	}, 	
	{
		AI = "MahjongBTTE",
		
		gameid = GameID.BLOOD_TO_THE_END;
		classid = ClassIDType.ROOM_CUSTOM;
		name = "Ѫս����",
		
		room_prepare_time = 3;		-- ��λ����
		room_fighting_time = 180;	-- ��λ����
		
		cmd_time = 
		{
			{ MahjongStep.SEAT, 60 }, -- ��λ: 0.1��
			{ MahjongStep.WIND, 60 }, -- ��λ: 0.1��
			{ MahjongStep.DICE, 30 }, -- ��λ: 0.1��
			{ MahjongStep.BUILD, 5 }, -- ��λ: 0.1��
			{ MahjongStep.DRAW, 10 }, -- ��λ: ��
			{ MahjongStep.CHOW, 10 }, -- ��λ: ��
			{ MahjongStep.SWAP, 300 }, -- ��λ: ��
			{ MahjongStep.LACK, 600 }, -- ��λ: ��
		}	
	},
}

function GetMahCfgList()
	return _GameMahConfig
end

function MahInitCmdTime(condition, ai_name)
	for i,tbl in ipairs(_GameMahConfig) do
		if tbl.AI == ai_name then
			condition.cmd_time = {}
			for j,p in ipairs(tbl.cmd_time) do
				if p[1] < MahjongStep.DRAW then
					condition.cmd_time[p[1]] = p[2] * 100
				else
					condition.cmd_time[p[1]] = p[2] * 1000
				end				
			end
			break
		end
	end
end