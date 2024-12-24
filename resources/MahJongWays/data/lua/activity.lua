-- 活动脚本

--[[

enum lxActivityAwardEnum
{
    ACTIVITY_AWARD_INVALID = 0,		// 无效
    ACTIVITY_AWARD_RMB = 1,			// 钻石
    ACTIVITY_AWARD_MONEY = 2,		// 金币
    ACTIVITY_AWARD_EXP = 3,			// 经验	
    ACTIVITY_AWARD_VIGOURPOINT = 4,	// 体力
    ACTIVITY_AWARD_ITEM = 5,		// 道具
};

--]]

-- 活动内容
g_activity_item =
{
------------------藏宝之地--------------------------	
	{ 
		id = 1,                                         -- 活动编号
		image = 1,                                      -- 图标
		type = 1,		                                -- 活动类型, 1 - 藏宝之地, 2 - 武器峡谷
		name = "巨龙的宝藏",                            -- 活动描述
		open_day = {1,3,5,7},                           -- 开放日，每周1，3，5，7开放
		cost = 12,                                       -- 每次挑战消耗6点体力值
		level_limit = {{1,14,2101},{2,30,2102},{3,50,2103},{4,70,2104}},  -- 开放等级限制: {难度等级，等级限制}
		max_count = 2,                                  -- 每日挑战次数
		refresh_time = 0,                               -- 每日刷新时间点
		drop_item = {1001,1002,1003,1004},				-- 掉落道具界面显示
		text1 = "每周一、三、五、日00:00点开启",
		text2 = "",
		award0 = {TASK_AWARD_MONEY, 200, 0 },  			-- 奖励
		award1 = { TASK_AWARD_RMB, 0, 0 }
	},

	{ 
		id = 2,                                         -- 活动编号
		image = 2,                                      -- 图标
		type = 1,		                                -- 活动类型, 1 - 藏宝之地, 2 - 武器峡谷
		name = "矮人堡垒",                              -- 活动描述
		open_day = {2,4,6,7},                             -- 开放日，每周2，4，6开放
		cost = 12,                                       -- 每次挑战消耗6点体力值
		level_limit = {{1,14,2105},{2,30,2106},{3,50,2107},{4,80,2108}},  -- 开放等级限制: {难度等级，等级限制}
		max_count = 2,                                  -- 每日挑战次数
		refresh_time = 0,                               -- 每日刷新时间点
		drop_item = {1101,1102,1103,1104},				--掉落道具界面显示
		text1 = "每周二、四、六、日00:00点开启",
		text2 = "",
		award0 = {TASK_AWARD_MONEY, 200, 0 },  			-- 奖励
		award1 = { TASK_AWARD_RMB, 0, 0 }
	},
	
	------------------武器峡谷--------------------------	

	{ 
		id = 3,                                         -- 活动编号
		image = 3,                                      -- 图标
		type = 2,		                                -- 活动类型, 1 - 藏宝之地, 2 - 武器峡谷
		name = "精灵丛林",                              -- 活动描述
		open_day = {3,6,7},                             -- 开放日，每周3，6，7开放
		cost = 12,                                       -- 每次挑战消耗6点体力值
		level_limit = {{1,25,2109},{2,40,2110},{3,60,2111},{4,75,2112}},  -- 开放等级限制: {难度等级，等级限制, 关卡编号}
		max_count = 5,                                  -- 每日挑战次数
		refresh_time = 0,                               -- 每日刷新时间点  已经作废
		drop_item = {5,20,35,50,65},					--掉落道具界面显示
		text1 = "每周三、六、日05:00点开启",
		text2 = "建议选精灵族英雄",
		award0 = {TASK_AWARD_MONEY, 200, 0 },  			-- 奖励
		award1 = { TASK_AWARD_RMB, 0, 0 }
	},
	{ 
		id = 4,                                         -- 活动编号
		image = 4,                                      -- 图标
		type = 2,		                                -- 活动类型, 1 - 藏宝之地, 2 - 武器峡谷
		name = "厄运火山",                              -- 活动描述
		open_day = {1,4,7},                             -- 开放日，每周1，4，7开放
		cost = 12,                                       -- 每次挑战消耗6点体力值
		level_limit = {{1,25,2113},{2,40,2114},{3,60,2115},{4,75,2116}},  -- 开放等级限制: {难度等级，等级限制, 关卡编号}
		max_count = 5,                                  -- 每日挑战次数
		refresh_time = 0,                               -- 每日刷新时间点
		drop_item = {10,25,40,55,70},					--掉落道具界面显示
		text1 = "每周一、四、日05:00点开启",
		text2 = "建议选择魔法伤害英雄",
		award0 = {TASK_AWARD_MONEY, 200, 0 },  			-- 奖励
		award1 = { TASK_AWARD_RMB, 0, 0 }
	},
	{ 
		id = 5,                                         -- 活动编号
		image = 5,                                      -- 图标
		type = 2,		                                -- 活动类型, 1 - 藏宝之地, 2 - 武器峡谷
		name = "种族的崛起",                            -- 活动描述
		open_day = {2,5,7},                             -- 开放日，每周2，5，7开放
		cost = 12,                                       -- 每次挑战消耗6点体力值
		level_limit = {{1,25,2117},{2,40,2118},{3,60,2119},{4,75,2120}},   -- 开放等级限制: {难度等级，等级限制, 关卡编号}
		max_count = 5,                                  -- 每日挑战次数
		refresh_time = 0,                               -- 每日刷新时间点
		drop_item = {15,30,45,60,75},					--掉落道具界面显示
		text1 = "每周二、五、日05:00点开启",
		text2 = "建议选择物理伤害英雄",
		award0 = {TASK_AWARD_MONEY, 200, 0 },  			-- 奖励
		award1 = { TASK_AWARD_RMB, 0, 0 }
	},
	
	
	
}

function lfx_activity_get_item()
	return g_activity_item;
end
