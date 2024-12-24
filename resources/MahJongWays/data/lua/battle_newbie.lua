--[[
-- ָ�ӽ׶� �������������ƽű�

enum lxSandCreatureTypeEnum
{
    _SAND_PLAYER_INVALID = 0,
    _SAND_PLAYER_MONSTER = 1,
    _SAND_PLAYER_CHARACTER = 2,
};

--]]


-- ������������ (���ƣ�{ ��������, �ȼ� }) 
-- 0	����
-- 1	����
-- 2	����
-- 3	����
-- 4	����
-- 5	����
-- 6	��Ԫ��
-- 7	��Ԫ��
-- 8	ˮԪ��
-- 9	��Ԫ��

g_newbie_card_item = 
{
    ------------------- �½�1 ---------------------
	{
	     ------------�ؿ�1-------------------
	    {
		    -- ��ʼ��
		    init = {
		        init_energy_p0 = 3,                  -- P0��ʼ������
		        init_card_p0 = {{0,1}, {7,1}},     -- P0��ʼ��

		        init_energy_p1 = 3,                  -- P1��ʼ������
		        init_card_p1 = {{0,1}, {7,1}},    -- P1��ʼ��
	        },

			-- �غ�1
		    {
			    energy_p0 = 1,                  -- P0������
			    drawcard_p0 = {{0,1}, {0,1}}, -- P0����
			    playcard_p0 = {{0,1}, {0,1}, {0,1}},          -- P0����

			    energy_p1 = 1,                  -- P1������
			    drawcard_p1 = {{0,1}, {7,1}},-- P1����
			    playcard_p1 = {},-- P1����
		    },
		    -- �غ�2
		    {
			    energy_p0 = 1,                  -- P0������
			    drawcard_p0 = {{7,1}, {7,1}}, -- P0����
			    playcard_p0 = {{7,1}, {7,1}, {7,1}},          -- P0����

			    energy_p1 = 1,                  -- P1������
			    drawcard_p1 = {{0,1}, {7,1}},-- P1����
			    playcard_p1 = {},         -- P1����
		    },
		   
		},

		 ------------�ؿ�2-------------------
	    {
		    -- ��ʼ��
		    init = {
		        init_energy_p0 = 3,                  -- P0��ʼ������
		        init_card_p0 = {{0,1}, {1,1}, {2,1}, {3,1}},     -- P0��ʼ��

		        init_energy_p1 = 3,                  -- P1��ʼ������
		        init_card_p1 = {{0,1}, {1,1}, {2,1}, {3,1}},    -- P1��ʼ��
	        },

			-- �غ�1
		    {
			    energy_p0 = 1,                  -- P0������
			    drawcard_p0 = {{4,1}, {0,1}}, -- P0����
			    playcard_p0 = {{0,1}, {3,1}},          -- P0����

			    energy_p1 = 1,                  -- P1������
			    drawcard_p1 = {{4,1}, {5,1}},-- P1����
			    playcard_p1 = {},-- P1����
		    },
		    -- �غ�2
		    {
			    energy_p0 = 1,                  -- P0������
			    drawcard_p0 = {{8,1}, {3,1}}, -- P0����
			    playcard_p0 = {{0,1}, {1,1}, {2,1}, {4,1}, {8,1}},          -- P0����

			    energy_p1 = 1,                  -- P1������
			    drawcard_p1 = {{6,1}, {7,1}},-- P1����
			    playcard_p1 = {},         -- P1����
		    },
		    
		},

		 ------------�ؿ�3-------------------
	    
	},
};

-- ���������������
--[[
chapter �½���
scenario �ؿ���
round �غ���
sand_player ս������
draw_flag ���� or ���ƣ�
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

-- ���ָ���ؿ��ͻغ�����Ӧ���������Լ�����
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

-- ���ָ���ؿ��ͻغ�����Ӧ��Ӧ������
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