
--[[
任务字段说明
id 当前任务编号，从1开始，可以不连续，任务编号不能大于1023
next_id 任务完成后触发的下一个任务（显示）
image 任务头像
text 任务文本
term_type 任务触发事件
term_val 任务条件，根据不同的term_type定义不同
award0 任务奖励1
award1 任务奖励2
备注：任意时刻，同时可接取任务数量不能超过8个
--]]
g_task_item =
{
	{
		id = 1,
		next_id = {2,3},
		name = "新手送英雄", 
		image = 1, 
		text = "免费的", 
		term_type = TASK_EVENT_GENERIC, 
		term_val = {0, 0 },
		award0 = { TASK_AWARD_HERO, 1, 2 }, 
		award1 = {TASK_AWARD_INVALID, 3, 4 }
	},
	{
		id = 2,
		next_id = {0},
		name = "逃离夏尔", 
		image = 1, 
		text = "免费的", 
		term_type = TASK_EVENT_DUNGEON_NORMAL, 
		term_val = {1, 0 },
		award0 = { TASK_AWARD_EXP, 100, 0 }, 
		award1 = {TASK_AWARD_MONEY, 300, 0 }
	},
	{
		id = 3,
		next_id = {0},
		name = "逃离夏尔-2", 
		image = 1, 
		text = "免费的", 
		term_type = TASK_EVENT_LEVELUP, 
		term_val = {5, 0 },
		award0 = { TASK_AWARD_EXP, 100, 0 }, 
		award1 = {TASK_AWARD_MONEY, 300, 0 }
	},
}