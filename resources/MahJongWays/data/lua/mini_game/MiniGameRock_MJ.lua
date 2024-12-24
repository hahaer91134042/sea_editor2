--[[
	消消乐游戏逻辑脚本，与消消乐数据脚本配合使用
]]--
local debug = require("Debug")
MiniGameRock_MJ = 
{
	related_data = {},
	data = {},
	bet_line = 0,
	cheated = false,
	
	matrix = nil,
	
	Start = nil,
	StartEx = nil,
	Hit = nil,
}

local function _CheckScatter(self, result, obj_id)
	local obj = self.related_data.objs[obj_id]
	if obj.scatter == nil or not obj.scatter.flag then
		return nil
	end
		
	local scatter_count = 0
	for i=1,#result do
		for j=1,#result[i] do
			if result[i][j] == obj_id then
				scatter_count = scatter_count + 1
			end
		end
	end
	
	local scatter_prize = nil
	if scatter_count > 5 and obj.scatterxn ~= nil then
		local tmp_count = scatter_count - 5
		if obj.scatterxn[tmp_count] == nil or #obj.scatterxn[tmp_count] <= 0 then
			return nil
		end
		scatter_prize = obj.scatterxn[tmp_count]
	else
		if obj.scatterxn == nil and scatter_count > 20 then
			scatter_count = 20
		end
		if obj.scatter["cont"..scatter_count] == nil or #obj.scatter["cont"..scatter_count] <= 0 then
			return nil
		end
		scatter_prize = obj.scatter["cont"..scatter_count]
	end
	
	local prize_info = {}
	prize_info.type = "Scatter"
	prize_info.obj_id = obj.id
	prize_info.group_id = 0
	prize_info.continue = scatter_count
	prize_info.with_wild = false
	prize_info.prize = scatter_prize
	prize_info.extra_rate = 0
	if obj.extra_rate ~= nil then
		prize_info.extra_rate = obj.extra_rate * scatter_count	
	else
		prize_info.extra_rate = 0
	end	
	
	return prize_info
end

local function _GetPrizeScatter(self, result)
	local prize_line = {}
	local cur_prize_index = 1

	for x=1,#self.related_data.objs do
		local prize_info = _CheckScatter(self, result, self.related_data.objs[x].id)
		if prize_info ~=nil then			
			prize_line[cur_prize_index] = prize_info
			cur_prize_index = cur_prize_index + 1
		end
	end
	return prize_line	
end


local function _GetPrizeTotal(self, result)
	local prize_line = {}
	local cur_prize_index = 1
	
	if self.related_data.win_line == nil then
		prize_line, cur_prize_index = Slot_GetPrizeFullLine(self, result, prize_line, cur_prize_index)
	else
		prize_line, cur_prize_index = Slot_GetPrizeWinLine(self, result, prize_line, cur_prize_index)
	end
	return prize_line
end	

local function _SlotOnce(self)
	local ret = {}
	ret.result = Slot_RollMatrix(self)
	ret.prize_line = _GetPrizeTotal(self, ret.result)
	
	return ret
end

local function _RemoveBroken(self, broken_arr)
	ret = {}
	for i=1,self.data.rolls.roll_count do
		ret[i] = {}
		
		local ret_j = self.data.rolls.line_count
		for j=self.data.rolls.line_count,1,-1 do
			if not broken_arr[i][j] then
				ret[i][ret_j] = self.matrix[i][j]
				ret_j = ret_j - 1
			-- Change Wild	
			elseif self.related_data.objs[self.matrix[i][j]].is_ChangeID ~= nil then	
				ret[i][ret_j] = self.related_data.objs[self.matrix[i][j]].is_ChangeID
				ret_j = ret_j - 1
			end
		end
	end
	
	return ret
end

local function _getTopAdds (self, matrix)
	ret = {}
	for i=1,self.data.rolls.roll_count do
		ret[i] = nil
		
		for j=self.data.rolls.line_count,1,-1 do
			if ret[i] == nil and matrix[i][j] == nil then
				ret[i] = j	
			end
		end
	end

	return ret	
end	

local function _CheckNRemove(self, result)
	local is_broken, broken_arr = Slot_CheckBroken(self, result)
	if is_broken then
		self.matrix = _RemoveBroken(self, broken_arr)
		result.top = _getTopAdds (self, self.matrix)
	end	
	return is_broken
end

local HitPos = { {0, -1}, {-1, 0}, {0, 0}, {1, 0}, {0, 1} }
local function _Hit(self, x, y)
	local broken_arr = {}
	for i=1,self.data.rolls.roll_count do
		broken_arr[i] = {}
		for j=1,self.data.rolls.line_count do
			broken_arr[i][j] = false
		end
	end
	
	for i=1,#HitPos do
		local x1 = x + HitPos[i][1]
		local y1 = y + HitPos[i][2]
		if x1 > 0 and x1 <= self.data.rolls.roll_count and y1 > 0 and y1 <= self.data.rolls.line_count then
			broken_arr[x1][y1] = true
		end
	end
	
	self.matrix = Slot_RemoveBroken(self, broken_arr)
end

local function _CallTotalPrize(self, prize_line, ret_i)
	local total = 0
	local prize_den = 1
	if self.related_data.prize_den ~= nil and self.related_data.prize_den > 0 then
		prize_den = self.related_data.prize_den
	end

	for i=1,#prize_line do
		for j=1,#prize_line[i].prize do
			if prize_line[i].prize[j].event == 0 then
				local extra_rate=1
				if prize_line[i].obj_id~=0 and prize_line[i].extra_rate>0 then
					extra_rate = prize_line[i].extra_rate
				end
				total = total + (prize_line[i].prize[j].param * prize_line[i].lines_count * extra_rate * self.bet_coin) / prize_den
			elseif prize_line[i].prize[j].event == 3 then
				local extra_rate=1
				if prize_line[i].obj_id~=0 and prize_line[i].extra_rate>0 then
					extra_rate = prize_line[i].extra_rate
				end
				total = total + (prize_line[i].prize[j].param * prize_line[i].lines_count * extra_rate * self.bet_coin * self.bet_line / prize_den)
			end

		end
			
	end
-- 	prize_multi
	if total > 0 then
		local prize_multi
		if ret_i >= #self.data.prize_multi then
			prize_multi = self.data.prize_multi[#self.data.prize_multi]
		else	
			prize_multi = self.data.prize_multi[ret_i]
		end
		total = total * prize_multi
	end

	return total
end

local function _Slot(self)
	local ret = {}
	local ret_i = 1
	local total = 0
	local win

	ret[ret_i] = _SlotOnce(self)
	total = _CallTotalPrize (self, ret[ret_i].prize_line, ret_i)
	while (_CheckNRemove(self,ret[ret_i])) do
		ret_i = ret_i + 1
		ret[ret_i] = _SlotOnce(self)
		total = total + _CallTotalPrize (self, ret[ret_i].prize_line, ret_i)
	end
	-- get FreeSpin
	ret[ret_i].prize_line = _GetPrizeScatter(self, ret[ret_i].result)
	
	if #ret[ret_i].prize_line > 1 then
		debug.log (string.format ("ret[ret_i].prize_line > 1"))
	end
	return ret, total
end

function MiniGameRock_MJ:Start()
	self.matrix = nil
	return _Slot(self)
end

function MiniGameRock_MJ:StartEx()
	return _Slot(self)
end

function MiniGameRock_MJ:Hit(x, y)
	local ret = {}
	local ret_i = 1
	
	_Hit(self, x, y)
	
	return _Slot(self)
end