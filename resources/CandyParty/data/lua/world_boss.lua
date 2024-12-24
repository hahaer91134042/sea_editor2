-- 世界Boss

-- 世界boss配置
g_boss_list =
{
		{ 
	    id = 1,                                         -- BOSS编号
		image = 1,                                      -- BOSS图标		
		name = "暴列炎魔",                        	    -- BOSS名字
		scnario = 2200,                                 -- 场景关卡编号
		blood = 63656250,								-- 初始血量
		level = {30, 44},								-- 等级范围要求
		fight_cd = 90,									-- 挑战CD（秒）
		vigour = 10,									-- 体力消耗
		open_day = {1,2,3,4,5,6,7},						-- 开放日期
		open_time = {{"00:00", "20:30"},},				-- 活动起止时间  
		desc = "炎魔再次来袭！来吧，接受史上最热情的拥抱吧！", 	    	-- BOSS描述
	},
	{ 
	    id = 2,                                         -- BOSS编号
		image = 2,                                      -- BOSS图标
		name = "刚铎背叛者",                              -- BOSS名字
		scnario = 2201,                                 -- 场景关卡编号
		blood = 65250000,								-- 初始血量
		level = {45, 59},								-- 等级范围要求
		fight_cd = 90,									-- 挑战CD（秒）
		vigour = 10,									-- 体力消耗
		open_day = {1,2,3,4,5,6,7},						-- 开放日期
		open_time = {{"00:00", "20:30"},},				-- 活动起止时间  
		desc = "中土世界的勇者啊，我要和你决斗！！放学后，学校食堂左拐50米厕所门口见！！", 				    -- BOSS描述
	},
	{ 
	    id = 3,                                         -- BOSS编号
		image = 3,                                      -- BOSS图标
		name = "魔窟之王",                              -- BOSS名字
		scnario = 2202,                                 -- 场景关卡编号
		blood = 93375000,								-- 初始血量
		level = {60, 74},								-- 等级范围要求
		fight_cd = 90,									-- 挑战CD（秒）
		vigour = 10,									-- 体力消耗
		open_day = {1,2,3,4,5,6,7},						-- 开放日期
		open_time = {{"20:00", "20:30"},},				-- 活动起止时间  
		desc = "中土世界的勇者啊，我要和你决斗！！放学后，学校食堂左拐50米厕所门口见！！", 				    -- BOSS描述
	},	
}

-- 鼓舞属性
g_inspire_attr =
{
    {
	    id = 1,                                 -- buff编号
		image = 111,                              -- buff图标
		desc = "物理攻击,魔法攻击",    -- buff描述
		val1 = 10,                              -- 属性1数值（百分比）
		val2 = 10,                              -- 属性2数值（百分比）
	},
    {
	    id = 2,                                 -- buff编号
		image = 112,                              -- buff图标
		desc = "血量上限,暴击率",              -- buff描述
		val1 = 10,                              -- 属性1数值（百分比）
		val2 = 2,                               -- 属性2数值（百分比）
	},
}

-- 鼓舞参数配置
g_inspire_config =
{
    gold_inspire_price = 10000,             -- 金币鼓舞开销
    gold_inspire_rate = 50,                 -- 金币鼓舞成功率（百分比）
	rmb_inspire_price = 20,                 -- 钻石鼓舞开销
	rmb_inspire_rate = 100,                 -- 钻石鼓舞成功率（百分比）
	max_inspire_count = 10,                 -- 鼓舞的最大次数
}

-- 程序内部调用函数，返回boss列表
function lfx_worldboss_get_boss_list()
	return g_boss_list
end

-- 程序内部调用函数，返回鼓舞属性
function lfx_worldboss_get_inspire_attr()
    return g_inspire_attr
end

-- 程序内部调用函数，返回鼓舞参数配置
function lfx_worldboss_get_inspire_config()
    return g_inspire_config
end