-- 试炼塔

-- Buff配置
g_buff_item =
{
	{ 
	    id = 1,                                         -- BUFF编号
		image = 1,                                      -- 图标
		name = "利刃",                            		-- BUFF名字
		desc = "增加上阵英雄攻击力",					-- BUFF描述
	},
	{ 
	    id = 2,                                         -- BUFF编号
		image = 2,                                      -- 图标
		name = "精准",                            	    -- BUFF名字
		desc = "增加上阵英雄命中率",					-- BUFF描述
	},
	{ 
	    id = 3,                                         -- BUFF编号
		image = 3,                                      -- 图标
		name = "坚韧",                            		-- BUFF名字
		desc = "增加上阵英雄血量",						-- BUFF描述
	},
	{ 
	    id = 4,                                         -- BUFF编号
		image = 4,                                      -- 图标
		name = "残暴",                            		-- BUFF名字
		desc = "增加上阵英雄暴击力",					-- BUFF描述
	},
	{ 
	    id = 5,                                         -- BUFF编号
		image = 5,                                      -- 图标
		name = "闪避",                            		-- BUFF名字
		desc = "增加上阵英雄闪避力",					-- BUFF描述
	},
}
	
-- 数值
g_random_value =
{	
	--范围内随机
	value_range = {2,8,12,16,25}, 	
}	
	
-- 宝箱
g_drop_box =
{	
	--掉落规则ID,20层掉落对应的20个宝箱
	drop_id = {2500,2501,2502,2503,2504,2505,2506,2507,2508,2509,2510,2511,2512,2513,2514,2515,2516,2517,2518,2519}, 	
}

-- 程序内部调用函数，返回buff配置列表
function lfx_tower_get_buff_item()
	return g_buff_item
end

-- 程序内部调用函数，返回随机数值配置
function lfx_tower_get_random_value()
    return g_random_value
end

-- 程序内部调用函数，返回宝箱配置
function lfx_tower_get_drop_box()
    return g_drop_box
end
