
require("gamelist")

MahjongStep = 
{
	SEAT = 0, -- 选座位（投骰子）       单位：0.1秒
	WIND = 1, -- 选风向（座位头家）     单位：0.1秒
	DICE = 2, -- 选起牌方向（庄家）     单位：0.1秒
	BUILD = 3, -- 起牌间隔              单位：0.1秒
	DRAW = 4, -- 出牌间隔               单位：秒
	CHOW = 5, -- 吃碰杠胡考虑间隔       单位：秒
	SWAP = 6, -- 换三张间隔				单位：秒
	LACK = 7, -- 选缺					单位：秒
}

local _GameMahConfig = {
	{
		AI = "MahjongCS",
		
		gameid = GameID.MAH_CS;
		classid = ClassIDType.ROOM_CUSTOM;
		name = "长沙麻将";
		
		room_prepare_time = 3;		-- 单位：分
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
			{ MahjongStep.SEAT, 60 }, -- 单位: 0.1秒
			{ MahjongStep.WIND, 60 }, -- 单位: 0.1秒
			{ MahjongStep.DICE, 30 }, -- 单位: 0.1秒
			{ MahjongStep.BUILD, 5 }, -- 单位: 0.1秒
			{ MahjongStep.DRAW, 10 }, -- 单位: 秒
			{ MahjongStep.CHOW, 10 }, -- 单位: 秒
		}	
	}, 	
	{
		AI = "MahjongSHKnock",
		
		gameid = GameID.SH_KNOCK;
		classid = ClassIDType.ROOM_CUSTOM;
		name = "上海敲麻";
		
		room_prepare_time = 3;		-- 单位：分
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
			{ MahjongStep.SEAT, 60 }, -- 单位: 0.1秒
			{ MahjongStep.WIND, 60 }, -- 单位: 0.1秒
			{ MahjongStep.DICE, 30 }, -- 单位: 0.1秒
			{ MahjongStep.BUILD, 5 }, -- 单位: 0.1秒
			{ MahjongStep.DRAW, 10 }, -- 单位: 秒
			{ MahjongStep.CHOW, 10 }, -- 单位: 秒
		}	
	}, 	
	{
		AI = "MahjongBTTE",
		
		gameid = GameID.BLOOD_TO_THE_END;
		classid = ClassIDType.ROOM_CUSTOM;
		name = "血战到底",
		
		room_prepare_time = 3;		-- 单位：分
		room_fighting_time = 180;	-- 单位：分
		
		cmd_time = 
		{
			{ MahjongStep.SEAT, 60 }, -- 单位: 0.1秒
			{ MahjongStep.WIND, 60 }, -- 单位: 0.1秒
			{ MahjongStep.DICE, 30 }, -- 单位: 0.1秒
			{ MahjongStep.BUILD, 5 }, -- 单位: 0.1秒
			{ MahjongStep.DRAW, 10 }, -- 单位: 秒
			{ MahjongStep.CHOW, 10 }, -- 单位: 秒
			{ MahjongStep.SWAP, 300 }, -- 单位: 秒
			{ MahjongStep.LACK, 600 }, -- 单位: 秒
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