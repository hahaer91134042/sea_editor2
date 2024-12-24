

-- 0：随机值，1:默认；2:2倍；3：3倍；
-- 随机值共计16个
-- 字段格式：编号，随机倍率，扩展倍率（原来随机倍率的基础上再加上该数值）
local _speud_tick_state =
{
	{ 1,2,0 },
	{ 2,2,3 },
	{ 3,1,0 },
	{ 4,2,0 },
	{ 5,1,1 },
	{ 6,1,2 },
	{ 7,1,3 },
	{ 8,2,3 },
	{ 9,2,0 },
	{ 10,2,0 },
	{ 11,2,2 },
	{ 12,1,4 },
	{ 13,1,0 },
	{ 14,2,0 },
	{ 15,1,2 },
	{ 16,1,0 },
}

--[[
购买金币
参数：base_money: 金币基础值; tick: 当前伪随机tick次数，基于0索引
返回：获得金币数值,倍率
--]]
function lfx_shop_convert_money(base_money, tick)
	
	local idx = math.mod(tick, 17);
	if idx == 0 then
		idx = 1
	end
	
	local item = _speud_tick_state[idx];
	
	local ratio = item[2];
	-- 判断扩展倍率
	if item[3] > 0 then
		ratio = ratio + math.random(item[3]);
	end
	
	local val = base_money * ratio;
	
	return val,ratio;
end

--[[
购买体力
--]]
local _vigour_cost =
{
	{ 1, 50 },
	{ 2, 100 },
	{ 3, 100 },
	{ 4, 100 },
	{ 5, 100 },
	{ 6, 200 },
	{ 7, 200 },
	{ 8, 200 },
	{ 9, 200 },
	{ 10, 300 },
	{ 11, 300 },
	{ 12, 300 },
	{ 13, 300 },
	{ 14, 500 },
	{ 15, 500 },
}

--[[
tick: 当前购买次数，基于0索引
返回：花费钻石数量
--]]
function lfx_shop_buy_vigour_cost(tick)
	tick = tick + 1;
	if tick > 15 then
		tick = 15;
	end
	return _vigour_cost[tick][2];
end


