--[[
-- 指挥阶段 补充能量、手牌脚本

enum lxSandCreatureTypeEnum
{
    _SAND_PLAYER_INVALID = 0,
    _SAND_PLAYER_MONSTER = 1,
    _SAND_PLAYER_CHARACTER = 2,
};

--]]


-- 新手引导配置 (卡牌：{ 卡牌类型, 等级 }) 
-- 0	攻击
-- 1	防御
-- 2	命中
-- 3	闪避
-- 4	暴击
-- 5	韧性
-- 6	风元素
-- 7	火元素
-- 8	水元素
-- 9	土元素

g_newbie_card_item = 
{
    ------------------- 章节1 ---------------------
	{
	     ------------关卡1-------------------
	    {
		    -- 初始牌
		    init = {
		        init_energy_p0 = 3,                  -- P0初始能量点
		        init_card_p0 = {{0,1}, {7,1}},     -- P0初始牌

		        init_energy_p1 = 3,                  -- P1初始能量点
		        init_card_p1 = {{0,1}, {7,1}},    -- P1初始牌
	        },

			-- 回合1
		    {
			    energy_p0 = 1,                  -- P0能量点
			    drawcard_p0 = {{0,1}, {0,1}}, -- P0摸牌
			    playcard_p0 = {{0,1}, {0,1}, {0,1}},          -- P0出牌

			    energy_p1 = 1,                  -- P1能量点
			    drawcard_p1 = {{0,1}, {7,1}},-- P1摸牌
			    playcard_p1 = {},-- P1出牌
		    },
		    -- 回合2
		    {
			    energy_p0 = 1,                  -- P0能量点
			    drawcard_p0 = {{7,1}, {7,1}}, -- P0摸牌
			    playcard_p0 = {{7,1}, {7,1}, {7,1}},          -- P0出牌

			    energy_p1 = 1,                  -- P1能量点
			    drawcard_p1 = {{0,1}, {7,1}},-- P1摸牌
			    playcard_p1 = {},         -- P1出牌
		    },
		   
		},

		 ------------关卡2-------------------
	    {
		    -- 初始牌
		    init = {
		        init_energy_p0 = 3,                  -- P0初始能量点
		        init_card_p0 = {{0,1}, {1,1}, {2,1}, {3,1}},     -- P0初始牌

		        init_energy_p1 = 3,                  -- P1初始能量点
		        init_card_p1 = {{0,1}, {1,1}, {2,1}, {3,1}},    -- P1初始牌
	        },

			-- 回合1
		    {
			    energy_p0 = 1,                  -- P0能量点
			    drawcard_p0 = {{4,1}, {0,1}}, -- P0摸牌
			    playcard_p0 = {{0,1}, {3,1}},          -- P0出牌

			    energy_p1 = 1,                  -- P1能量点
			    drawcard_p1 = {{4,1}, {5,1}},-- P1摸牌
			    playcard_p1 = {},-- P1出牌
		    },
		    -- 回合2
		    {
			    energy_p0 = 1,                  -- P0能量点
			    drawcard_p0 = {{8,1}, {3,1}}, -- P0摸牌
			    playcard_p0 = {{0,1}, {1,1}, {2,1}, {4,1}, {8,1}},          -- P0出牌

			    energy_p1 = 1,                  -- P1能量点
			    drawcard_p1 = {{6,1}, {7,1}},-- P1摸牌
			    playcard_p1 = {},         -- P1出牌
		    },
		    
		},

		 ------------关卡3-------------------
	    
	},
};

-- 获得新手引导卡牌
--[[
chapter 章节数
scenario 关卡数
round 回合数
sand_player 战斗对象
draw_flag 抽牌 or 出牌？
--]]
function lfx_sand_newbie_get_card(chapter, scenario, round, sand_player, card_flag)
    local chapter_num = table.getn(g_newbie_card_item);
	if chapter > chapter_num then
	    chapter = chapter_num;
	end

	local scenario_num = table.getn(g_newbie_card_item[chapter]);
	if scenario > scenario_num then
	    scenario = scenario_num;
	end

	local round_num = table.getn(g_newbie_card_item[chapter][scenario]);
	if round > round_num then
	    round = round_num;
	end

	if card_flag == 0 then
	    return get_init_card(chapter, scenario, round, sand_player);
    elseif card_flag == 1 then
	    return get_drawcard(chapter, scenario, round, sand_player);
	elseif card_flag == 2 then
	    return get_playcard(chapter, scenario, round, sand_player);
	end
end

function get_init_card(chapter, scenario, round, sand_player)
    local energy = 0;
	local card = {};

    local item = g_newbie_card_item[chapter][scenario]["init"];
	if player_type ~= _SAND_PLAYER_MONSTER then
	    energy = item.init_energy_p0;
		card = item.init_card_p0;
	else
		energy = item.init_energy_p1;
		card = item.init_card_p1;
	end

	return energy, card;
end

-- 获得指定关卡和回合数对应的能量点以及手牌
function get_drawcard(chapter, scenario, round, sand_player)
    local player_type = cfx_sand_get_player_type(sand_player);
	local energy = 0;
	local card = {};
	
	local item = g_newbie_card_item[chapter][scenario][round];
    if player_type ~= _SAND_PLAYER_MONSTER then
	    energy = item.energy_p0;
		card = item.drawcard_p0;
	else
		energy = item.energy_p1;
	    card = item.drawcard_p1;
	end

	return energy, card;
end

-- 获得指定关卡和回合数对应的应出手牌
function get_playcard(chapter, scenario, round, sand_player)
    local player_type = cfx_sand_get_player_type(sand_player);
	local card = {};

	local item = g_newbie_card_item[chapter][scenario][round];
    if player_type ~= _SAND_PLAYER_MONSTER then
		card = item.playcard_p0;
	else
	    card = item.playcard_p1;
	end

	return card;
end