-- 抽奖系统脚本


--[[

// 奖励类型
enum lxLotteryAwardEnum
{
    LOTTERY_AWARD_INVALID = 0,		             // 无奖励
    LOTTERY_AWARD_HERO = 1,			             // 奖励英雄，英雄ID, 星级
    LOTTERY_AWARD_ITEM = 2,		                 // 奖励道具, 道具ID, 数量
};

--]]

------------------------------------------------------------------------------------------------------------------------------------------

-- 抽奖活动内容
g_lottery_item_list =
{
	{ 
		id = 1,                                                -- 编号
		name = "金币召唤",                                     -- 名称
		text = "使用金币召唤，有几率中高级装备和高品质英雄",   -- 描述
		free_count = 5,                                        -- 免费次数
		free_interval = 5,                                     -- 免费间隔时间（分钟）
		draw_lottery_cost = 10000,                             -- 单抽花费金币数量
		continous_draw_lottery_discount = 0.9,                 -- 连抽折扣率
	},
	{ 
		id = 2,                                                -- 编号
		name = "钻石召唤",                                     -- 名称
		text = "使用钻石召唤，有几率中高级装备和高品质英雄",   -- 描述
		free_count = 1,                                        -- 免费次数
		free_interval = 2880,                                  -- 免费间隔时间（分钟）
		draw_lottery_cost = 280,                               -- 单抽消耗钻石数量
		continous_draw_lottery_discount = 0.9,                 -- 连抽折扣率
	},
}

-- 奖励英雄编号列表(不要超过128个)
g_award_hero_list = 
{
    {1,3,5,7,18},  -- 新手英雄
	{2,12,15,22,27,31,33,34},  -- 精英英雄
	{10,13,16,19,43,44,45,46,49,50,51,52,53,54},  -- 达人英雄
	{8,11,35,36,47,48},  -- 传奇英雄
}

-- 奖励英雄星级概率（分别对应1星，2星，3星出现概率百分比）
g_award_hero_star_rate =
{
    star_rate = {65, 30, 5}
}

-- 奖励道具掉落方案列表（按战队等级每10级对应一个掉落方案，不要超过32个）
g_award_item_drop_id_list = 
{
	{2001},                        -- drop_id_10
	{2001,2002},                   -- drop_id_20
	{2001,2002,2003},              -- drop_id_30
	{2001,2002,2003,2004},         -- drop_id_40
	{2001,2002,2003,2004,2005}     -- drop_id_50
}

------------------------------------------------------------------------------------------------------------------------------------------

-- 获得抽奖活动内容
function lfx_lottery_get_item_list()
	return g_lottery_item_list;
end

-- 获得奖励英雄列表
function lfx_lottery_get_hero_list()
	return g_award_hero_list;
end

-- 获得奖励英雄星级概率表
function lfx_lottery_get_hero_star_rate_list()
	return g_award_hero_star_rate;
end

-- 获得奖励道具掉落方案列表
function lfx_lottery_get_item_drop_id_list()
    return g_award_item_drop_id_list;
end