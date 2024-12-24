
--[[抢点模式配置表]]

g_grab_cfg =
{	
	time_game_duration = 100, -- 游戏时长，单位：秒
	time_win_tick = 2, -- 倒计时完成后，胜利间隔
	time_sel_hero = 30, -- 选择英雄倒计时
	time_start_game = 30, -- 开始倒计时
	time_unlock_rgn = 30, -- 区域解锁
	time_grab_rgn = 8, -- 占领区域时长
	time_grab_overtime = 5, --延时时长
	time_grab_overtime_decrease = 0.5, -- 延时时长(每次递减）
	time_revived = 10, -- 复活时间
	time_revived_ext = 2, -- 复活时间在延时阶段，额外增加的时间

	
	grab_rgn_factor = { 1.0, 1.25, 1.5 }, -- 多人占领速率
	



	max_team_num = 2, -- 单场匹配玩家数量（最大6）
}