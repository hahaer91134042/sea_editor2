--[[

伤害计算类型
enum lxSandDamageParamEnum
{
    SAND_CALC_RIGOR_FACTOR = 1, // 命中率系数
    SAND_CALC_RIGOR_RIGOR = 2, // 攻击方命中
    SAND_CALC_RIGOR_DODGE = 3, // 被攻击方闪避
    SAND_CALC_RIGOR_RATIO = 4, // 攻击方命中率 -- 范围：(0,1) 如果为1则命中率100%
    SAND_CALC_RIGOR_RAND = 5, // 命中率随机值
	
    SAND_CALC_CRITICAL_FACTOR = 6, // 暴击率系数
    SAND_CALC_CRITICAL_CRITICAL = 7, // 攻击方暴击
    SAND_CALC_CRITICAL_TENACITY = 8, // 被攻击方韧性
    SAND_CALC_CRITICAL_RATIO = 9, // 攻击方触发暴击率  -- 范围：(0,1) 如果为1则暴击率100%
    SAND_CALC_CRITICAL_RAND = 10, // 暴击率随机值
    SAND_CALC_CRITICAL_DAMAGE = 11, // 基础暴击伤害（倍率）
	
    SAND_CALC_DAMAGE_ATTACK = 12, // 攻击方数值
    SAND_CALC_DAMAGE_DEFENCE = 13, // 被攻击方防御
    SAND_CALC_DAMAGE_FACTOR = 14, // 攻击系数
    SAND_CALC_DAMAGE_RESULT = 15, // 伤害值
	
    SAND_CALC_HEAL_VALUE = 16, // 治疗值

};

英雄属性类型
enum lxHeroAttrEnum
{
    HERO_ATTR_HP = 0, // 生命
    HERO_ATTR_ATTACK = 1, // 攻击
    HERO_ATTR_DEFENCE = 2, // 防御
    HERO_ATTR_RIGOR = 3, // 命中
    HERO_ATTR_DODGE = 4, // 闪避
    HERO_ATTR_CRIRAT = 5, // 暴击
    HERO_ATTR_CRIDMG = 6, // 暴击伤害
    HERO_ATTR_TENACITY = 7, // 韧性
    HERO_ATTR_SPEED = 8, // 行动速度

    HERO_ATTR_EXT_MAXHP = 101, // 最大生命（默认）
    HERO_ATTR_EXT_POS = 102, // 阵型位置

};

获得英雄属性
lxi32 cfx_sand_get_hero_attr(lua_State* L);

获得英雄临时属性
lxi32 cfx_sand_get_hero_attrtemp(lua_State* L);

查找英雄身上状态ID
lxi32 cfx_sand_find_hero_state(lua_State* L);

获得伤害计算参数
lxi32 cfx_sand_calc_get_param(lua_State* L);

设置伤害计算参数
lxi32 cfx_sand_calc_set_param(lua_State* L);

--]]

--[[
背水
作用：自身HP越少技能威力越大
--]]
function lfx_sand_damage_backwater(calc, owner, target)
	
	local val;
	local hp = cfx_sand_get_hero_attr(owner, HERO_ATTR_HP);
	local max_hp = cfx_sand_get_hero_attr(owner, HERO_ATTR_EXT_MAXHP);
	local damage = cfx_sand_calc_get_param(calc, SAND_CALC_DAMAGE_RESULT);
	
	-- 生命百分比
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
崩溃
作用：对方HP越高，伤害越大
--]]
function lfx_sand_damage_crash(calc, owner, target)
	
	local val;
	local hp = cfx_sand_get_hero_attr(target, HERO_ATTR_HP);
	local max_hp = cfx_sand_get_hero_attr(target, HERO_ATTR_EXT_MAXHP);
	local damage = cfx_sand_calc_get_param(calc, SAND_CALC_DAMAGE_RESULT);
	
	-- 生命百分比
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
斩杀
作用：对方HP越少，伤害越大
--]]
function lfx_sand_damage_crikill(calc, owner, target)
	
	local val;
	local hp = cfx_sand_get_hero_attr(target, HERO_ATTR_HP);
	local max_hp = cfx_sand_get_hero_attr(target, HERO_ATTR_EXT_MAXHP);
	local damage = cfx_sand_calc_get_param(calc, SAND_CALC_DAMAGE_RESULT);
	
	-- 生命百分比
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
错药
作用：自身处于中毒、麻痹或烧伤状态时技能威力翻倍
--]]
function lfx_sand_damage_dotstate(calc, owner, target)
	
	local damage = cfx_sand_calc_get_param(calc, SAND_CALC_DAMAGE_RESULT);
	-- 技能状态列表
	local state_id = { 2021, 2041, 2091, 3101, 4011 };
	

	for i = 1, table.getn(state_id) do
		local flag = cfx_sand_find_hero_state(owner, state_id[i]);
		if flag == 1 then
			cfx_sand_calc_set_param(calc, SAND_CALC_DAMAGE_RESULT, damage * 1.5);
			break;
		end
	end
		
end

