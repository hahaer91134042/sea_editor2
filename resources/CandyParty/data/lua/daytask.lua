-- 每日任务（活动）脚本
-- Author Jack

--[[
#define _DAYTASK_ITEM_NUM 10 // 每日任务最大数量
#define _MAX_VIP_LEVEL 15 // VIP等级

BITTAG_DAYTASK_ITEM = 48 * _BITTAG_PITCH + 1, // 每日任务子项状态, _DAYTASK_ITEM_NUM * 5 = 50 bit
--> 385
enum lxTaskAwardEnum
{
    TASK_AWARD_INVALID = 0,		// 无效
    TASK_AWARD_RMB = 1,			// 钻石
    TASK_AWARD_MONEY = 2,		// 金币
    TASK_AWARD_EXP = 3,			// 经验	
    TASK_AWARD_VIGOURPOINT = 4,	// 体力
    TASK_AWARD_ITEM = 5,		// 道具
};

enum lxTaskEventEnum
{
    TASK_EVENT_GENERIC = 0, 		// 无条件
    TASK_EVENT_CHARGE, 				// 充值
	TASK_EVENT_TIMER, 				// 豪华午餐 定时器
	TASK_EVENT_GENERIC_VIP,			// 横扫千军【过期】
	TASK_EVENT_BUY_MONEY,			// 点石成金
	TASK_EVENT_BUY_VIGOUR,			// 购买体力
    TASK_EVENT_DUNGEON_NORMAL,  	// 普通副本【过期】
    TASK_EVENT_DUNGEON_ELITE,		// 精英副本【过期】
    TASK_EVENT_UPGRADE_HERO_SKILL,	// 技能升级
	TASK_EVENT_UPGRADE_LEVEL, 		// 等级升级【过期】
	TASK_EVENT_WEAPONS_CANYOU,		//武器峡谷【过期】
	TASK_EVENT_TREASURE_LAND,		//藏宝之地【过期】
	TASK_EVENT_CALL_BOX,			//召唤宝箱
	TASK_EVENT_ARENA_CHALLENGE,		//竞技挑战
	TASK_EVENT_MONTH_CARD,			//月卡
	TASK_EVENT_DAILY_COIN,			//扫荡山贼	日常金币【新增】
	TASK_EVENT_DAILY_EXP,			//出海试炼	日常经验【新增】
	TASK_EVENT_DAILY_HEROMAT,		//清理矿洞	日常英雄升阶【新增】
	TASK_EVENT_DAILY_WEAPMAT,		//掠夺仓库	日常装备升阶【新增】
	TASK_EVENT_FORM_PRCTICE,		//奇门遁甲	阵型【新增】
	TASK_EVENT_CASINO,			    //招贤纳士	拉把机【新增】
	
	
	图标在sqlbrowser/icon里面，序号对应的任务image序号
};

--]]

-- DB位标识索引
_daytask_bittag_idx = 32;
-- 每个任务标识长度
_daytask_bittag_item_pitch = 6;

-- 每日任务内容
g_daytask_item =
{
	{
	    id = 1,
		name = "豪华午餐", 
		image = 1, 
		text = "每日12:00至14:00可领取60点体力", 
		term_type = TASK_EVENT_TIMER, 
		term_val = {12, 14 },
		award0 = {TASK_AWARD_RMB, 30, 0 },
		award1 = { TASK_AWARD_VIGOURPOINT, 60, 0 }
	 
	},
	{ 
	    id = 2,
		name = "豪华晚餐", 
		image = 1, 
		text = "每日18:00至20:00可领取60点体力", 
		term_type = TASK_EVENT_TIMER, 
		term_val = {18, 20 },
		award0 = {TASK_AWARD_RMB, 20, 0 },
		award1 = { TASK_AWARD_VIGOURPOINT, 60, 0 }
	 
	},
	{ 
	    id = 3,
		name = "甜美夜宵", 
		image = 1, 
		text = "每日21:00至23:00可领取60点体力", 
		term_type = TASK_EVENT_TIMER, 
		term_val = {21, 23 },
		award0 = {TASK_AWARD_RMB, 10, 0 },
		award1 = { TASK_AWARD_VIGOURPOINT, 60, 0 }
	 
	},
	{ 
	    id = 4,
		name = "横扫千军", 
		image = 2, 
		text = "VIP玩家每天可免费领取扫荡许可证", 
		term_type = TASK_EVENT_GENERIC_VIP, 
		term_val = { 0, 0 }, 
		award0 = {TASK_AWARD_ITEM, 999, 30 }, 
		award1 = { TASK_AWARD_INVALID, 0, 0 } 
	 
	},
	{
	    id = 5, 
		name = "点石成金", 
		image = 3, 
		text = "用钻石购买1次金币", 
		term_type = TASK_EVENT_BUY_MONEY, 
		term_val = { 1, 0 }, 
		award0 = {TASK_AWARD_EXP, 200, 0 },
		award1 = { TASK_AWARD_RMB, 5, 0 }
		
	},
	{ 
	    id = 6,
		name = "购买体力", 
		image = 4, 
		text = "用钻石购买1次体力", 
		term_type = TASK_EVENT_BUY_VIGOUR, 
		term_val = { 1, 0 }, 
		award0 = {TASK_AWARD_EXP, 200, 0 },  		
		award1 = { TASK_AWARD_RMB, 5, 0 }
		
	},	
	{ 
	    id = 7,
		name = "副本杀手", 
		image = 5, 
		text = "完成任意副本10次", 
		term_type = TASK_EVENT_DUNGEON_NORMAL,
		term_val = { 10, 0 },
		award0 = {TASK_AWARD_EXP, 300, 0 },  
		award1 = { TASK_AWARD_RMB, 5, 0 }  
	},	
	{ 
	    id = 8,
		name = "精英杀手", 
		image = 6, 
		text = "完成任意精英副本3次", 
		term_type = TASK_EVENT_DUNGEON_ELITE,
		term_val = { 3, 0 },
		award0 = {TASK_AWARD_EXP, 300, 0 },
		award1 = { TASK_AWARD_RMB, 5, 0 } 
		
	},
	{
	    id = 9, 
		name = "技能升级", 
		image = 7, 
		text = "升级任意技能3次", 
		term_type = TASK_EVENT_UPGRADE_HERO_SKILL,
		term_val = { 3, 0 },
		award0 = {TASK_AWARD_EXP, 200, 0 },
		award1 = { TASK_AWARD_RMB, 5, 0 } 
	},
	
	
	{ 
	    id = 10,
		name = "抽到手软", 
		image = 14, 
		text = "抽取5次任意宝箱", 
		term_type = TASK_EVENT_CALL_BOX,
		term_val = { 5, 0 },
		award0 = {TASK_AWARD_EXP, 200, 0 },
		award1 = { TASK_AWARD_RMB, 5, 0 } 
	},
	{
	    id = 11, 
		name = "藏宝之地", 
		image = 15, 
		text = "完成藏宝之地2次", 
		term_type = TASK_EVENT_TREASURE_LAND,
		term_val = { 2, 0 },
		award0 = {TASK_AWARD_EXP, 200, 0 },
		award1 = { TASK_AWARD_RMB, 5, 0 } 
	},
	{ 
	    id = 12,
		name = "武器峡谷", 
		image = 16, 
		text = "完成武器峡谷3次", 
		term_type = TASK_EVENT_WEAPONS_CANYOU,
		term_val = { 3, 0 },
		award0 = {TASK_AWARD_EXP, 200, 0 },
		award1 = { TASK_AWARD_RMB, 5, 0 } 
	},
	{ 
	    id = 13,
		name = "竞技争锋", 
		image = 17, 
		text = "在竞技场完成3次挑战", 
		term_type = TASK_EVENT_ARENA_CHALLENGE,
		term_val = { 3, 0 },
		award0 = {TASK_AWARD_EXP, 200, 0 },
		award1 = { TASK_AWARD_RMB, 5, 0 } 
	},
	{ 
	    id = 14,
		name = "月卡奖励", 
		image = 101, 
		text = "月卡用户每日可领取钻石奖励", 
		term_type = TASK_EVENT_MONTH_CARD,
		term_val = { 0, 0 },
		award0 = {TASK_AWARD_RMB, 100, 0  },
		award1 = { TASK_AWARD_INVALID, 0, 0 } 
	},

}


g_daytask_vip_award =  	
{
	{ TASK_AWARD_ITEM, 999, 30 },
	{ TASK_AWARD_ITEM, 11, 120 },
	{ TASK_AWARD_ITEM, 11, 130 },
	{ TASK_AWARD_ITEM, 11, 140 },
	{ TASK_AWARD_ITEM, 11, 140 },
	{ TASK_AWARD_ITEM, 11, 150 },
	{ TASK_AWARD_ITEM, 11, 160 },
	{ TASK_AWARD_ITEM, 11, 170 },
	{ TASK_AWARD_ITEM, 11, 180 },
	{ TASK_AWARD_ITEM, 11, 190 },
	{ TASK_AWARD_ITEM, 11, 190 },
	{ TASK_AWARD_ITEM, 11, 190 },
	{ TASK_AWARD_ITEM, 11, 190 },
	{ TASK_AWARD_ITEM, 11, 190 },
	{ TASK_AWARD_ITEM, 11, 190 },
}

function lfx_daytask_get_item()
	return g_daytask_item;
end

function lfx_daytask_get_vip_award()
	return g_daytask_vip_award;
end

-- 重置每日任务（当服务器端日期变化，新的一天到来时）
function lfx_daytask_reset_state(player)
    local bigtag_offset;

	for i = 1, table.getn(g_daytask_item) do
		
		local task = g_daytask_item[i];
	    bittag_offset = _daytask_bittag_idx + _daytask_bittag_item_pitch * task.id;

		-- 设置任务状态为未完成状态，任务完成次数为0
	    cfx_player_set_bittag(player, bittag_offset, _daytask_bittag_item_pitch, 0);

		-- 通知客户端更新任务状态
		cfx_daytask_notify(player, i, 0, 0);
	end
end

-- wparam 参数数值（如关卡编号，英雄编号等）
-- lparam 条件数值，用作存盘，数值不超过64，如：关卡扫荡次数、英雄星级等
function lfx_daytask_input_event(player, event_type, wparam, lparam)

	local bittag_offset;
	
	for i = 1, table.getn(g_daytask_item) do
		
		local task = g_daytask_item[i];
		if task.term_type == event_type then
			bittag_offset = _daytask_bittag_idx + _daytask_bittag_item_pitch * task.id;
			-- 获得完成状态
			flag = cfx_player_get_bittag(player, bittag_offset, 2);
			if flag == 2 then
			    if event_type == TASK_EVENT_TIMER then
				    if lparam >= task.term_val[2] then
						-- 如果过期未领奖，置该任务已领奖（已过期）
						flag = 1;
						cfx_player_set_bittag(player, bittag_offset, 2, flag);

						-- 投递通知消息
						cfx_daytask_notify(player, task.id, flag, 0);
					end
				end
			elseif flag == 0 then
				if event_type == TASK_EVENT_GENERIC_VIP  				-- 横扫千军
					or (event_type == TASK_EVENT_BUY_MONEY)				-- 点石成金
					or (event_type == TASK_EVENT_BUY_VIGOUR) 			-- 购买体力
					or (event_type == TASK_EVENT_MONTH_CARD) then		-- 月卡
						local idx = bittag_offset + 2;
						local bit_val = cfx_player_get_bittag(player, idx, 4);
						-- 判断是否已经通知过
						if bit_val == 0 then
							-- 保存状态
							flag = 2; -- 状态为可完成
							cfx_player_set_bittag(player, bittag_offset, 2, flag);
							cfx_player_set_bittag(player, idx, 4, 1);
							-- 投递通知消息
							cfx_daytask_notify(player, task.id, 2, 1);
						end

				elseif event_type == TASK_EVENT_TIMER then -- 定时器 -- 豪华午餐、夜宵
					-- 判断时间段
					if lparam >= task.term_val[1] and lparam < task.term_val[2] then
						-- 获得当前tick状态
						local idx = bittag_offset + 2;
						local bit_val = cfx_player_get_bittag(player, idx, 4);
						-- 判断是否已经通知过
						if bit_val == 0 then
							-- 保存状态
							flag = 2; -- 状态为可完成
							cfx_player_set_bittag(player, bittag_offset, 2, flag);
							cfx_player_set_bittag(player, idx, 4, 1);
							-- 投递通知消息
							cfx_daytask_notify(player, task.id, 2, 1);
						end
					end
				elseif (event_type == TASK_EVENT_DUNGEON_NORMAL)		-- 普通副本
					or (event_type == TASK_EVENT_DUNGEON_ELITE) 		-- 精英副本
					or (event_type == TASK_EVENT_UPGRADE_HERO_SKILL) 	-- 技能升级	
					or (event_type == TASK_EVENT_WEAPONS_CANYOU)        -- 武器峡谷
	                or (event_type == TASK_EVENT_TREASURE_LAND)         -- 藏宝之地
	                or (event_type == TASK_EVENT_CALL_BOX)              -- 召唤宝箱
	                or (event_type == TASK_EVENT_ARENA_CHALLENGE) then  -- 竞技挑战

					local term_val = task.term_val[1];
					-- 获得当前完成次数
					local idx = bittag_offset + 2;
					local bit_val = cfx_player_get_bittag(player, idx, 4);
					if bit_val < term_val then
						bit_val = bit_val + lparam;
						if bit_val > term_val then
							bit_val = term_val
						end
						-- 刷新完成次数
						cfx_player_set_bittag(player, idx, 4, bit_val);
					end
					
					-- 投递通知消息
					--local flag;
					--if bit_val >= term_val then
					--	flag = 2;
					--else
					--	flag = 0;
					--end
					local flag = (bit_val >= term_val) and 2 or 0;
					if flag == 2 then
					    -- 更新任务状态为可完成（2 - 可完成，1 - 已完成， 0 - 未完成）
						cfx_player_set_bittag(player, bittag_offset, 2, flag);
					end
					cfx_daytask_notify(player, task.id, flag, bit_val);
							
				end
			end
		end
	end
	
end

-- task_id: 为lua索引（base 1）
-- 返回值: 0: 失败; 1: 成功; 2: 已完成
function lfx_daytask_get_award(player, task_id)
	
	-- 判断编号是否越界
	if task_id > table.getn(g_daytask_item) then
		return 0;
	end
	
	local bittag_offset = _daytask_bittag_idx + _daytask_bittag_item_pitch * task_id;
	-- 获得完成状态
	local flag = cfx_player_get_bittag(player, bittag_offset, 2);
	if flag == 1 then
		return 2;
	end

	local task = g_daytask_item[task_id];
	
	if task.term_type == DAYTASK_TERM_DUNGEON_NORMAL
		or task.term_type == DAYTASK_TERM_DUNGEON_ELITE
		or task.term_type == DAYTASK_TERM_UPGRADE_SKILL
		or task.term_type == TASK_EVENT_WEAPONS_CANYOU
	    or task.term_type == TASK_EVENT_TREASURE_LAND
	    or task.term_type == TASK_EVENT_CALL_BOX
	    or task.term_type == TASK_EVENT_ARENA_CHALLENGE then
		
		-- 判断次数
		local bit_val = cfx_player_get_bittag(player, bittag_offset + 2, 4);
		if bit_val < task.term_val[1] then
			return 0;
		end
		
	elseif task.term_type == TASK_EVENT_TIMER then
		local bit_val = cfx_player_get_bittag(player, bittag_offset + 2, 4);
		if bit_val == 0 then
			return 0;
		end
	end
	
	-- 设置已完成状态（2 - 可完成，1 - 已完成， 0 - 未完成）
	flag = 1;
	cfx_player_set_bittag(player, bittag_offset, 2, flag);
	
	-- 通知消息
	cfx_daytask_notify(player, task_id, flag, 0);
	
	-- 发送奖励道具
	cfx_daytask_add_award(player, task.name, task.award0[1], task.award0[2], task.award0[3]);
	if task.award1[1] ~= TASK_AWARD_INVALID then
		cfx_daytask_add_award(player, task.name, task.award1[1], task.award1[2], task.award1[3]);
	end
	
	return 1;
end

