--[[

�˺���������
enum lxSandDamageParamEnum
{
    SAND_CALC_RIGOR_FACTOR = 1, // ������ϵ��
    SAND_CALC_RIGOR_RIGOR = 2, // ����������
    SAND_CALC_RIGOR_DODGE = 3, // ������������
    SAND_CALC_RIGOR_RATIO = 4, // ������������ -- ��Χ��(0,1) ���Ϊ1��������100%
    SAND_CALC_RIGOR_RAND = 5, // ���������ֵ
	
    SAND_CALC_CRITICAL_FACTOR = 6, // ������ϵ��
    SAND_CALC_CRITICAL_CRITICAL = 7, // ����������
    SAND_CALC_CRITICAL_TENACITY = 8, // ������������
    SAND_CALC_CRITICAL_RATIO = 9, // ����������������  -- ��Χ��(0,1) ���Ϊ1�򱩻���100%
    SAND_CALC_CRITICAL_RAND = 10, // ���������ֵ
    SAND_CALC_CRITICAL_DAMAGE = 11, // ���������˺������ʣ�
	
    SAND_CALC_DAMAGE_ATTACK = 12, // ��������ֵ
    SAND_CALC_DAMAGE_DEFENCE = 13, // ������������
    SAND_CALC_DAMAGE_FACTOR = 14, // ����ϵ��
    SAND_CALC_DAMAGE_RESULT = 15, // �˺�ֵ
	
    SAND_CALC_HEAL_VALUE = 16, // ����ֵ

};

Ӣ����������
enum lxHeroAttrEnum
{
    HERO_ATTR_HP = 0, // ����
    HERO_ATTR_ATTACK = 1, // ����
    HERO_ATTR_DEFENCE = 2, // ����
    HERO_ATTR_RIGOR = 3, // ����
    HERO_ATTR_DODGE = 4, // ����
    HERO_ATTR_CRIRAT = 5, // ����
    HERO_ATTR_CRIDMG = 6, // �����˺�
    HERO_ATTR_TENACITY = 7, // ����
    HERO_ATTR_SPEED = 8, // �ж��ٶ�

    HERO_ATTR_EXT_MAXHP = 101, // ���������Ĭ�ϣ�
    HERO_ATTR_EXT_POS = 102, // ����λ��

};

���Ӣ������
lxi32 cfx_sand_get_hero_attr(lua_State* L);

���Ӣ����ʱ����
lxi32 cfx_sand_get_hero_attrtemp(lua_State* L);

����Ӣ������״̬ID
lxi32 cfx_sand_find_hero_state(lua_State* L);

����˺��������
lxi32 cfx_sand_calc_get_param(lua_State* L);

�����˺��������
lxi32 cfx_sand_calc_set_param(lua_State* L);

--]]

--[[
��ˮ
���ã�����HPԽ�ټ�������Խ��
--]]
function lfx_sand_damage_backwater(calc, owner, target)
	
	local val;
	local hp = cfx_sand_get_hero_attr(owner, HERO_ATTR_HP);
	local max_hp = cfx_sand_get_hero_attr(owner, HERO_ATTR_EXT_MAXHP);
	local damage = cfx_sand_calc_get_param(calc, SAND_CALC_DAMAGE_RESULT);
	
	-- �����ٷֱ�
	local r = hp / max_hp;
	
	if r < 0.3 then
		if r < 0.1 then
			val = damage * 3;
		elseif r < 0.2 then
			val = damage * 2;
		else
			val = damage * 1.5;	
		end
		
		cfx_sand_calc_set_param(calc, SAND_CALC_DAMAGE_RESULT, val);
	end
end

--[[
����
���ã��Է�HPԽ�ߣ��˺�Խ��
--]]
function lfx_sand_damage_crash(calc, owner, target)
	
	local val;
	local hp = cfx_sand_get_hero_attr(target, HERO_ATTR_HP);
	local max_hp = cfx_sand_get_hero_attr(target, HERO_ATTR_EXT_MAXHP);
	local damage = cfx_sand_calc_get_param(calc, SAND_CALC_DAMAGE_RESULT);
	
	-- �����ٷֱ�
	local r = hp / max_hp;
	
	if r > 0.7 then
		if r > 0.9 then
			val = damage * 3;
		elseif r > 0.8 then
			val = damage * 2;
		else
			val = damage * 1.5;
		end
		
		cfx_sand_calc_set_param(calc, SAND_CALC_DAMAGE_RESULT, val);
	end
	
end

--[[
նɱ
���ã��Է�HPԽ�٣��˺�Խ��
--]]
function lfx_sand_damage_crikill(calc, owner, target)
	
	local val;
	local hp = cfx_sand_get_hero_attr(target, HERO_ATTR_HP);
	local max_hp = cfx_sand_get_hero_attr(target, HERO_ATTR_EXT_MAXHP);
	local damage = cfx_sand_calc_get_param(calc, SAND_CALC_DAMAGE_RESULT);
	
	-- �����ٷֱ�
	local r = hp / max_hp;
	
	if r < 0.3 then
		if r < 0.1 then
			val = damage * 3;
		elseif r < 0.2 then
			val = damage * 2;
		else
			val = damage * 1.5;	
		end
		
		cfx_sand_calc_set_param(calc, SAND_CALC_DAMAGE_RESULT, val);
	end
	
end

--[[
��ҩ
���ã��������ж�����Ի�����״̬ʱ������������
--]]
function lfx_sand_damage_dotstate(calc, owner, target)
	
	local damage = cfx_sand_calc_get_param(calc, SAND_CALC_DAMAGE_RESULT);
	-- ����״̬�б�
	local state_id = { 2021, 2041, 2091, 3101, 4011 };
	

	for i = 1, table.getn(state_id) do
		local flag = cfx_sand_find_hero_state(owner, state_id[i]);
		if flag == 1 then
			cfx_sand_calc_set_param(calc, SAND_CALC_DAMAGE_RESULT, damage * 1.5);
			break;
		end
	end
		
end

