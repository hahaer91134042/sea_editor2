--[[
	老虎机游戏逻辑脚本，与老虎机数据脚本配合使用
]]--

local debug = require("Debug")
require("DebugInfo")
local BoxType =
{
    MONEY = 0,
    DRAGON = 1,
}
SceneSlotMachine_CandyParty = 
{
	data_FreeSpin = {},
	data = {},
	bet_coin = 0, 
	level = 0,
	level_key_countdown = 15,
	matrix = nil,
	
	SlotOnce = nil;
	FreeSpin = nil;
	Start = nil,
--	GetPrize = nil,
	Bonus = nil, -- XXXXX
}

-----------------------------------------------------------------------------------------
local function _RandomOneGrid(pool)
	local count = #pool
	local ret_i = count
	local rate = GameRandEx(0, pool[count].cur_total)
	for i=1,count do
		ret_i = i
		if rate < pool[i].cur_total then
			break
		end
	end
--	print("rate:"..rate..",ret_i:"..ret_i)
	return pool[ret_i].id
end

local function _GetListIndex(self, x, y)
	return (x - 1) * self.data.levels[self.level].rolls.line_count + y
end

local function _GetCoorIndex(self, list_index)
	local x = math.modf((list_index - 1) / self.data.levels[self.level].rolls.line_count) + 1
	local y = math.fmod((list_index - 1), self.data.levels[self.level].rolls.line_count) + 1
	
	--DebugInfo(LogLevel.GENERIC, string.format(" list_index: %d  line_count: %d  x: %d  y: %d", list_index,self.data.levels[self.level].rolls.line_count,x,y))
	
	return x, y
end
 
local function _RollOneRoll(self, list_index, o_res)
	local line_count = self.data.levels[self.level].rolls.line_count
	
	local x, y = _GetCoorIndex(self, list_index)
	local rate = GameRandEx(0, self.data.levels[self.level].uc.total)
	if rate >= self.data.levels[self.level].uc.rolls[list_index].uc then
		local rand_field = {}
		local t = 0
		for i=1,#self.data.levels[self.level].uc.rolls[list_index].relation do
			local o_x, o_y = _GetCoorIndex(self, self.data.levels[self.level].uc.rolls[list_index].relation[i].target)
			if o_res[o_x][o_y] ~= nil then
				t = t + self.data.levels[self.level].uc.rolls[list_index].relation[i].weight --self.data.levels[self.level].objs[o_res[o_x][o_y]].k *
			end
			rand_field[i] = t
		end
		if t > 0 then
			rate = GameRandEx(0, t)
			for i=1,#rand_field do
				if rate < rand_field[i] then
					local o_x, o_y = _GetCoorIndex(self, self.data.levels[self.level].uc.rolls[list_index].relation[i].target)
					if self.data.levels[self.level].objs[o_res[o_x][o_y]].disable_copy ~= nil and self.data.levels[self.level].objs[o_res[o_x][o_y]].disable_copy ==1 then
					--	debug.log (string.format ("disable_copy id %d", o_res[o_x][o_y]))
						break
					end
					o_res[x][y] = o_res[o_x][o_y]
					return
				end
			end
		end
	end
	
	o_res[x][y] = _RandomOneGrid(self.data.levels[self.level].rolls.rolls[list_index])

end

local function _RollAllRolls(self)
	local ret = { }
	for i=1,self.data.levels[self.level].rolls.roll_count do
		ret[i] = {}
	end

	for i=1,#self.data.levels[self.level].uc.order do
		if self.data.test_result ~= nil and self.cheated == true then
			local x, y = _GetCoorIndex(self, self.data.levels[self.level].uc.order[i])
			ret[x][y] = self.data.test_result[x][y]
		else
			_RollOneRoll(self, self.data.levels[self.level].uc.order[i], ret)
		end
	end
	
	if self.cheated == true then
		self.cheated = false
	end
	
	return ret
end

local function _RollMatrix(self)
	if self.matrix == nil then
		self.matrix = _RollAllRolls(self)
	else
		for i=1,#self.data.levels[self.level].uc.order do
			local x, y = _GetCoorIndex(self, self.data.levels[self.level].uc.order[i])
			if self.data.test_result ~= nil and self.cheated == true then
				self.matrix[x][y] = self.data.test_result[x][y]
			else
				if self.matrix[x][y] == nil then
					_RollOneRoll(self, self.data.levels[self.level].uc.order[i], self.matrix)
				end				
			end			
		end
		
		if self.cheated == true then
			self.cheated = false
		end
	end
	return self.matrix
end

--获得下一个未处理的物件格子
local function _GetNextGridIndex(self, mask)
    local grid_idx = 0
	for i=1,#self.data.levels[self.level].uc.order do
		local x, y = _GetCoorIndex(self, self.data.levels[self.level].uc.order[i])
	    if mask[x][y] == 0 then
		   grid_idx = _GetListIndex(self, x, y)
		   break
		end 
	end
	
	return grid_idx
end

--获得下一个未处理的炸弹物件格子
local function _GetNextKeyIndex(self, mask)
	local grid_idx = 0
	for i=1,#self.data.levels[self.level].uc.order do
		local x, y = _GetCoorIndex(self, self.data.levels[self.level].uc.order[i])
	    if mask[x][y] == 0 then
		   local obj_id = self.matrix[x][y]
		   if self.data.levels[self.level].objs[obj_id].key > 0 then 
		      grid_idx = _GetListIndex(self, x, y)
		      break
		   end
		end
	end
	return grid_idx
end

local DirPos = { {-1, -1}, {0, -1},{1, -1}, {1, 0}, {1, 1}, {0, 1},{-1, 1}, {-1, 0} }

--判断是否可消除的相同或相关物件
local function _CheckEqu(self,obj_id,x,y,mask)
  if x>0 and y>0 and x<=self.data.levels[self.level].rolls.roll_count and y<=self.data.levels[self.level].rolls.line_count and mask[x][y]==0 then
	local next_obj_id =  self.matrix[x][y]
    if obj_id == next_obj_id then
	   return true
	else 
	   if #self.data.levels[self.level].objs[obj_id].wild > 0 then 
	      for k=1,#self.data.levels[self.level].objs[obj_id].wild do
		    if self.data.levels[self.level].objs[obj_id].wild[k] == next_obj_id then
			   return true
			end
		  end
	   else
	      for k=1,#self.data.levels[self.level].objs[next_obj_id].wild do
		    if self.data.levels[self.level].objs[next_obj_id].wild[k] == obj_id then
			   return true
			end
		  end
	   end 
	end
  end
  return false
end

--获得可消除物件连线与奖励
local function _GetLinePrize(self, result,mask,grid_idx)
	local prize_line = nil --{}
	local prize_objs = {}
	local prize_count = 0
	local x,y = _GetCoorIndex(self, grid_idx)
	local obj_id = result[x][y]
	local stack = {}
	local stack_top = 1
	stack[stack_top] = grid_idx
	mask[x][y] = 1
	
	local next_x = 0
	local next_y = 0
	local next_idx = 0	
	local chk_flag = false
	
	prize_count = prize_count + 1
	prize_objs[prize_count]=grid_idx
	
	local times = 1;
	
	local test_count =0
	
	if #self.data.levels[self.level].objs[obj_id].wild > 0 then 
		times = times * 2;
	end 
	
	while(stack_top > 0)
	do
	   local cur_idx = stack[stack_top]
	   local cur_x,cur_y = _GetCoorIndex(self, cur_idx)
	   chk_flag = false
--	   print("cur_idx:"..cur_idx..",obj_id:"..obj_id)
	   --上
	   next_x = cur_x
	   next_y = cur_y - 1
	   if _CheckEqu(self,obj_id,next_x,next_y,mask) then
	      next_idx = _GetListIndex(self, next_x, next_y)
	      mask[next_x][next_y] = 1
		  --push stack
		  stack_top = stack_top + 1
		  stack[stack_top] = next_idx
		  
		  prize_count = prize_count + 1
		  prize_objs[prize_count] = next_idx
		
		  --普通物件与高阶物件相关连属于普通物件连线
		  local next_obj_id = result[next_x][next_y]
		  if #self.data.levels[self.level].objs[next_obj_id].wild > 0 then 
		     times = times * 2;
	      end 
		  if next_obj_id~= obj_id and #self.data.levels[self.level].objs[obj_id].wild > 0 then
			obj_id = next_obj_id
		  end
		  
		  chk_flag = true
	   end
	   
	   --下
	   if not chk_flag then
	     next_x = cur_x
	     next_y = cur_y + 1
	     if _CheckEqu(self,obj_id,next_x,next_y,mask) then
		 	next_idx = _GetListIndex(self, next_x, next_y)
	        mask[next_x][next_y] = 1
		    --push stack
		    stack_top = stack_top + 1
		    stack[stack_top] = next_idx
			
			prize_count = prize_count + 1
			prize_objs[prize_count] = next_idx
			
		  --普通物件与高阶物件相关连属于普通物件连线
		  local next_obj_id = result[next_x][next_y]
		  if #self.data.levels[self.level].objs[next_obj_id].wild > 0 then 
		     times = times * 2;
	      end 
		  if next_obj_id~= obj_id and #self.data.levels[self.level].objs[obj_id].wild > 0 then
			obj_id = next_obj_id
		  end
		  
		    chk_flag = true
		 end
	   end
	   
	   --左
	   if not chk_flag then
	     next_x = cur_x + 1
	     next_y = cur_y 
	     if _CheckEqu(self,obj_id,next_x,next_y,mask) then
		 	next_idx = _GetListIndex(self, next_x, next_y)
	        mask[next_x][next_y] = 1
		    --push stack
		    stack_top = stack_top + 1
		    stack[stack_top] = next_idx
			
			prize_count = prize_count + 1
			prize_objs[prize_count] = next_idx
			
		  --普通物件与高阶物件相关连属于普通物件连线
		  local next_obj_id = result[next_x][next_y]
		  if #self.data.levels[self.level].objs[next_obj_id].wild > 0 then 
		     times = times * 2;
	      end 
		  if next_obj_id~= obj_id and #self.data.levels[self.level].objs[obj_id].wild > 0 then
			obj_id = next_obj_id
		  end
		  
		    chk_flag = true
		 end
	   end
	   
	   --右
	   if not chk_flag then
	     next_x = cur_x - 1
	     next_y = cur_y
	     if _CheckEqu(self,obj_id,next_x,next_y,mask) then
		 	next_idx = _GetListIndex(self, next_x, next_y)
	        mask[next_x][next_y] = 1
		    --push stack
		    stack_top = stack_top + 1
		    stack[stack_top] = next_idx
			
			prize_count = prize_count + 1
			prize_objs[prize_count] = next_idx
			
		  --普通物件与高阶物件相关连属于普通物件连线
		  local next_obj_id = result[next_x][next_y]
		  if #self.data.levels[self.level].objs[next_obj_id].wild > 0 then 
		     times = times * 2;
	      end 
		  if next_obj_id~= obj_id and #self.data.levels[self.level].objs[obj_id].wild > 0 then
			obj_id = next_obj_id
		  end
		  
		    chk_flag = true
		 end
	   end
	   
	   --相连没有匹配物件时
	   if not chk_flag then
	     --pop stack
		 if stack_top > 0 then
		    stack_top = stack_top - 1
		 end
	   end
	   
	  -- test_count = test_count+1
	  -- if test_count >100 then
	  --    break;
	  -- end
	   
	end
	
	k = 2
	chk_count = 99
	if #self.data.levels[self.level].objs[obj_id].wild > 0 then
	   obj_id = self.data.levels[self.level].objs[obj_id].wild[1]
	end
	
	while(self.data.levels[self.level].objs[obj_id]["cont"..k] ~=nil)
	do
	    if #self.data.levels[self.level].objs[obj_id]["cont"..k]>0 then
		   chk_count = k
		   break;
		end
		k = k + 1
	end
	
	if prize_count<=36 and chk_count <= prize_count then 
		prize_line = {}
		prize_line.type ="Line"
		prize_line.obj_id = obj_id
		prize_line.prize = self.data.levels[self.level].objs[obj_id]["cont"..prize_count]
		prize_line.prize_objs = prize_objs
	    prize_line.prize_count = prize_count
		prize_line.extra_rate = 1
		
		local obj_extra_rate = self.data.levels[self.level].objs[obj_id].extra_rate
		if obj_extra_rate == 0 then
		   obj_extra_rate = 1
		end
		
		if #self.data.levels[self.level].objs[obj_id].wild == 0 then
		  prize_line.extra_rate = times
		end
		
		prize_line.extra_rate = prize_line.extra_rate * obj_extra_rate
		
	end
	
	return prize_line
end

--获得炸弹物件与奖励
local function _GetKeyPrize(self, result,mask,grid_idx)
	local prize_line = {}
	local prize_objs = {}
    prize_objs[1] = grid_idx 
	local x0,y0 = _GetCoorIndex(self, grid_idx)
	local obj_id = result[x0][y0]	
    mask[x0][y0] = 1
	
	prize_line.type ="Key"
	prize_line.obj_id = obj_id
	prize_line.prize_objs = prize_objs
	prize_line.prize_count = 1

	if false then
		local randf = GameRandEx(1, self.data.levels[self.level].dragon_factor + self.data.levels[self.level].money_factor + 1)	
		if randf <= self.data.levels[self.level].money_factor then 
			prize_line.box_type = BoxType.MONEY
			prize_line.box_prize = 0     
			
			local moneys = self.data.levels[self.level].moneys   	 
			local total_factor= 0
			for i=1,#moneys do 
				total_factor = total_factor + moneys[i].factor
			end 
			
			local rand_factor = GameRandEx(1, total_factor + 1)
			local find_index = 0
			local add_factor = 0
			for i=1,#moneys do  
				add_factor = add_factor + moneys[i].factor
				if rand_factor <= add_factor then
					find_index = i
					break
				end
			end	
			
			if find_index > 0 then
				local tmp = GameRandEx(moneys[find_index].prize_min, moneys[find_index].prize_max + 1)	
				prize_line.box_prize = tmp*self.bet_coin/self.data.levels[self.level].deno
			end 	 
		else
			prize_line.box_type = BoxType.DRAGON
			prize_line.box_prize = 1
		end 
	end
		return prize_line
	end

local function _GetPrizeTotal(self, result)
	local prize_line = {}
	local prize_line_count = 0
	local mask = {}
	for i=1,self.data.levels[self.level].rolls.roll_count do
	  mask[i]={}
	  for j=1,self.data.levels[self.level].rolls.line_count do
		mask[i][j] = 0
	  end
	end
 
	--key物件
	local key_idx = _GetNextKeyIndex(self, mask)
	if key_idx > 0 then
		local ret_prize_line = _GetKeyPrize(self, result,mask,key_idx)
		key_idx = _GetNextKeyIndex(self, mask)
		while(key_idx > 0)
		do
			local _prize_line = _GetKeyPrize(self, result,mask,key_idx)
			key_idx = _GetNextKeyIndex(self, mask)
			if _prize_line ~= nil then
				ret_prize_line.prize_count = ret_prize_line.prize_count + 1
				ret_prize_line.prize_objs[#ret_prize_line.prize_objs + 1] = _prize_line.prize_objs[1]
			end
		end
		prize_line_count = prize_line_count + 1
		prize_line[prize_line_count] = ret_prize_line
		return prize_line	-- 中Key單獨消除
	end
	
	--相连物件
	grid_idx = _GetNextGridIndex(self, mask)
	while(grid_idx > 0)
	do
	    --print("prize_count::"..prize_count..",grid_idx:"..grid_idx)
	    local ret_prize_line = _GetLinePrize(self, result,mask,grid_idx)
		if ret_prize_line ~= nil then
			prize_line_count = prize_line_count + 1
			prize_line[prize_line_count] = ret_prize_line
		end
	
	   grid_idx = _GetNextGridIndex(self, mask)
	end
	
	--[[
	--prize_line = _GetPrize(self, result,mask,grid_idx)
	print("sz:"..#prize_line)
	for i=1,#prize_line do
	  print("------------------------obj_id: "..prize_line[i].obj_id.."  type: "..prize_line[i].type.."  times: "..prize_line[i].extra_rate)
	  if prize_line[i].prize_objs ~=nil then
	    for j=1,#prize_line[i].prize_objs do
           print(prize_line[i].prize_objs[j])
	    end
	  end
	end
	--]]
	
	return prize_line
end

local function _GetKeyTotal(result)
	local count = 0

	for i=1,#result do 
		local prize_line = result[i].prize_line
		for j=1,#prize_line do 
			local prize = prize_line[j]
			if prize.type == "Key" then
				count = count + 1
			end	
		end
	end

	return count	
end

local function _GetFreeSpinMulti(self)
	local prize_multi = self.data.levels[self.level].prize_multi   	 
	local total_k= 0
	for i=1,#prize_multi do 
		total_k = total_k + prize_multi[i].k
	end 

	local rand = GameRandEx(1, total_k + 1)	
	local find_index = 0
	local add = 0
	for i=1,#prize_multi do  
		add = add + prize_multi[i].k
		if rand <= add then
			find_index = i
			break
		end
	end	

	return prize_multi[find_index].prize
end

local function _CheckScatter(self, result, obj_id)
	local obj = self.data.levels[self.level].objs[obj_id]
	if obj.scatter == nil or not obj.scatter.flag then
		return nil
	end

	local prize_objs = {}
	local scatter_count = 0
	for i=1,#result do
		for j=1,#result[i] do
			if result[i][j] == obj_id then
				scatter_count = scatter_count + 1
				prize_objs[scatter_count] = _GetListIndex(self, i, j)
			end
		end
	end

	if scatter_count == 0 then
		return nil		
	end

	local scatter_prize = nil
	if obj.scatter["cont"..scatter_count] == nil or #obj.scatter["cont"..scatter_count] <= 0 then
		return nil
	end
	scatter_prize = obj.scatter["cont"..scatter_count]

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
	prize_info.prize_objs = prize_objs
	return prize_info
end

local function _GetPrizeScatter(self, result)
	local prize_line = {}
	local cur_prize_index = 1

	for x=1,#self.data.levels[self.level].objs do
		local prize_info = _CheckScatter(self, result, self.data.levels[self.level].objs[x].id)
		if prize_info ~=nil then			
			prize_line[cur_prize_index] = prize_info
			cur_prize_index = cur_prize_index + 1
		end
	end
	if cur_prize_index == 1 then
		return nil
	end
	return prize_line	
end

local function _GetBonusId(self)
	for i=1,#self.data.levels[self.level].objs do
	    if self.data.levels[self.level].objs[i].bonus > 0 then
		    return self.data.levels[self.level].objs[i].id
		end
	end 
	return 0
end

local function _IsMakeBonus(self)
	local rkey = GameRandEx(1, 1000 + 1)	
	if rkey <= self.data.levels[self.level].bonus_weight then
		return true 
	end
	 
	return false
end

local function _GetJackoptId(self)
	for i=1,#self.data.levels[self.level].objs do
	    if self.data.levels[self.level].objs[i].jackpot > 0 then
		    return self.data.levels[self.level].objs[i].id
		end
	end 
	return 0
end

local function _IsMakeJackopt(self)
	local rkey = GameRandEx(1, self.data.jackpot.total + 1)
	for i = 1, #self.data.jackpot.type, 1 do
		if rkey < self.data.jackpot.type[i].weight then
			return self.data.jackpot.type[i].prize_count
		end
		rkey = rkey - self.data.jackpot.type[i].weight
	end	
	return false
end

local function _GetKeyId(self)
	for i=1,#self.data.levels[self.level].objs do
	    if self.data.levels[self.level].objs[i].key > 0 then
		    return self.data.levels[self.level].objs[i].id
		end
	end 
	return 0
end

local function _RandKey(self)
	local randx = GameRandEx(1, self.data.levels[self.level].rolls.roll_count + 1)	
	local randy = GameRandEx(1, self.data.levels[self.level].rolls.line_count + 1)	 
	self.matrix[randx][randy] = _GetKeyId(self)
	
	return self.matrix
end

local function _IsMakeKey(self)
	local rkey = GameRandEx(1, 1000 + 1)	
	if rkey <= self.data.levels[self.level].key_weight then
		return true 
	end
	 
	return false
end
local function _CalcTotalPrize(self, prize_line)
	local total = 0
	local prize_den = 1
	if  self.data.obj_deno ~= nil then
		prize_den = self.data.obj_deno
	end
	for i=1,#prize_line do
		if prize_line[i].prize ~= nil then
		for j=1,#prize_line[i].prize do
			if prize_line[i].prize[j].event == 0 then
				local extra_rate=1
				if prize_line[i].obj_id~=0 and prize_line[i].extra_rate>0 then
					extra_rate = prize_line[i].extra_rate
				end
				total = total + prize_line[i].prize[j].param * extra_rate * self.bet_coin / prize_den
			elseif prize_line[i].prize[j].event == 3 then
				local extra_rate=1
				if prize_line[i].obj_id~=0 and prize_line[i].extra_rate>0 then
					extra_rate = prize_line[i].extra_rate
				end
				total = total + prize_line[i].prize[j].param * extra_rate * self.bet_coin / prize_den
			end
		end
		end
	end
	return total
end

local function _TryKickOut(self, prize)
	local tmp = 0
	local max_key = 0
	local multi_p = prize / self.bet_coin
	for i=1,#self.data.levels[self.level].kick_out.multiple do
		local key_val = self.data.levels[self.level].kick_out.multiple[i].key_val
		if multi_p > key_val and key_val > max_key then
			tmp = i
			max_key = key_val
		end
	end
	if tmp > 0 then
		local rate = GameRandEx(0, self.data.levels[self.level].kick_out.total)
		if rate < self.data.levels[self.level].kick_out.multiple[tmp].weight then
			return true
		end
	end
	
	tmp = 0
	max_key = 0
	local quota_p = prize
	for i=1,#self.data.levels[self.level].kick_out.quota do
		local key_val = self.data.levels[self.level].kick_out.quota[i].key_val
		if quota_p > key_val and key_val > max_key then
			tmp = i
			max_key = key_val
		end
	end
	if tmp > 0 then
		local rate = GameRandEx(0, self.data.levels[self.level].kick_out.total)
		if rate < self.data.levels[self.level].kick_out.quota[tmp].weight then
			return true
		end
	end
	
	return false
end

local function _SlotOnce(self, index, count)
	local ret = {}
	ret.result = _RollMatrix(self)
	
	ret.prize_line = _GetPrizeTotal(self, ret.result)
	local prize = _CalcTotalPrize(self, ret.prize_line)

	if true then
		return ret, prize	--!!!!!!!!!!!
	end
 
	local kick_count = 0
	while(_TryKickOut(self, prize)) do 
		--DebugInfo(LogLevel.GENERIC, string.format("[prize] %d kick_count%d", prize,kick_count))
		ret.result = _RollAllRolls(self)
		ret.prize_line = _GetPrizeTotal(self, ret.result)
	    prize = _CalcTotalPrize(self, ret.prize_line)
		kick_count = kick_count + 1
		--超过10次将放弃
		if kick_count >= 10 then
			debug.log(string.format("kick_count:%d",kick_count));
		   break
		end
	end 		
	--[[
		--ret.bomb_cont = _GetBombContTotal(self, ret.result)
		-- 第一次生成key  10次无奖强制随机生成key位置 
		if (index == 1 and #ret.prize_line > 0) or (count and count >= 10) then  
			if _IsMakeKey(self) then 
				local randx = GameRandEx(1, self.data.levels[self.level].rolls.roll_count + 1)	
				local randy = GameRandEx(1, self.data.levels[self.level].rolls.line_count + 1)	
				
				ret.result[randx][randy] = _GetBonusId(self) -- _GetKeyId(self)  
				ret.prize_line = _GetPrizeTotal(self, ret.result)
			end
		end
	]]
	--[[
	if index == 1 and #ret.prize_line > 0 then 
		-- 随机生成key位置  除去已获奖位置
		if _IsMakeKey(self) then 
			local randx = GameRandEx(1, self.data.levels[self.level].rolls.roll_count + 1)	
			local randy = GameRandEx(1, self.data.levels[self.level].rolls.line_count + 1)	
			local objid = ret.result[randx][randy] 
			
			local ismake = 0
			for i = 1,10 do  
				local isfind = 1
				for j = 1,#ret.prize_line do 
					if ret.prize_line[j].obj_id == objid then
						isfind = 0
						break
					end
				end	
				
				if isfind == 1 then
					ismake = 1
					break
				end
				
				randx = GameRandEx(1, self.data.levels[self.level].rolls.roll_count + 1)	
				randy = GameRandEx(1, self.data.levels[self.level].rolls.line_count + 1)	
				objid = ret.result[randx][randy] 
			end	
			
			if ismake == 1 then
				ret.result[randx][randy] = _GetKeyId(self)  
	    		ret.prize_line = _GetPrizeTotal(self, ret.result)
			end 
		end
		if _IsMakeKey(self) then 
			local randx = GameRandEx(1, self.data.levels[self.level].rolls.roll_count + 1)	
			local randy = GameRandEx(1, self.data.levels[self.level].rolls.line_count + 1)	
			local objid = ret.result[randx][randy] 
			
			local ismake = 0
			for i = 1,10 do  
				local isfind = 1
				for j = 1,#ret.prize_line do 
					if ret.prize_line[j].obj_id == objid then
						isfind = 0
						break
					end
				end	
				
				if isfind == 1 then
					ismake = 1
					break
				end
				
				randx = GameRandEx(1, self.data.levels[self.level].rolls.roll_count + 1)	
				randy = GameRandEx(1, self.data.levels[self.level].rolls.line_count + 1)	
				objid = ret.result[randx][randy] 
			end	
			
			if ismake == 1 then
				ret.result[randx][randy] = _GetKeyId(self)  
	    		ret.prize_line = _GetPrizeTotal(self, ret.result)
			end 
		end
	elseif count and count >= 10 then  
		-- 10次无奖强制随机生成key位置 
		if _IsMakeKey(self) then 
			local randx = GameRandEx(1, self.data.levels[self.level].rolls.roll_count + 1)	
			local randy = GameRandEx(1, self.data.levels[self.level].rolls.line_count + 1)	
 
			ret.result[randx][randy] = _GetKeyId(self)  
			ret.prize_line = _GetPrizeTotal(self, ret.result)
		end
	end	--]]
	return ret, prize
end


local function _CheckBroken(self, prizes)
	local broken = false
	local ret = {}
	for i=1,self.data.levels[self.level].rolls.roll_count do
		ret[i] = {}
		for j=1,self.data.levels[self.level].rolls.line_count do
			ret[i][j] = false
			local obj_id = self.matrix[i][j]
			if self.data.levels[self.level].objs[obj_id].key >0 then
				ret[i][j] = true
			end
		end
	end

	for i=1,#prizes do
		for j=1,#prizes[i].prize_objs do
		   local cur_idx = prizes[i].prize_objs[j]
		   local cur_x,cur_y = _GetCoorIndex(self, cur_idx)
		   ret[cur_x][cur_y] = true
		   broken = true
		end
	end
	
	return broken, ret
end

local function _RemoveBroken(self, broken_arr)
	ret = {}
	for i=1,self.data.levels[self.level].rolls.roll_count do
		ret[i] = {}
		
		local ret_j = self.data.levels[self.level].rolls.line_count
		for j=self.data.levels[self.level].rolls.line_count,1,-1 do
			if not broken_arr[i][j] then
				ret[i][ret_j] = self.matrix[i][j]
				ret_j = ret_j - 1
			end
		end
	end
	
	return ret
end

local function _getTopAdds (self, matrix)
	ret = {}
	for i=1,self.data.levels[self.level].rolls.roll_count do
		ret[i] = nil
		
		for j=self.data.levels[self.level].rolls.line_count,1,-1 do
			if ret[i] == nil and matrix[i][j] == nil then
				ret[i] = j	
				break
			end
		end
	end
	return ret	
end	

local function _CheckNRemove(self, result)
	local is_broken, broken_arr = _CheckBroken(self, result.prize_line)
	if is_broken then
		self.matrix = _RemoveBroken(self, broken_arr)
		result.top = _getTopAdds (self, self.matrix)
	end	
	return is_broken
end

local function _RollSA(self, objs)
	local total = 0
	for i=1,#objs do
		total = total + objs[i].weight
	end
	
	local rate = GameRandEx(0, total)
	for i=1,#objs do
		if rate < objs[i].weight then
			return objs[i]
		else
			rate = rate - objs[i].weight
		end
	end	
	return 0
end

local function _TrySpecialAward(self)
	local sa_index = 0
	for i=1,#self.data.levels[self.level].sa.items do
		local rate = GameRandEx(0, self.data.levels[self.level].sa.total)
		if rate < self.data.levels[self.level].sa.items[i].rate then
			sa_index = i
			break
		end
	end

	if sa_index > 0 then
		local ret = { }
		for i=1,self.data.levels[self.level].rolls.roll_count do
			ret[i] = {}
		end
		
		local sa_obj = _RollSA(self, self.data.levels[self.level].sa.items[sa_index].objs)	
		for i=1,#self.data.levels[self.level].uc.order do
			local x, y = _GetCoorIndex(self, self.data.levels[self.level].uc.order[i])
			local rate = GameRandEx(0, 100)
			if rate < self.data.levels[self.level].sa.items[sa_index].arr_rate[x][y] then
				ret[x][y] = sa_obj.obj_id
				--print("id:"..sa_obj.obj_id..",x:"..x..",y:"..y)
			else
				_RollOneRoll(self, self.data.levels[self.level].uc.order[i], ret)
			end	
          local	 obj_val = ret[x][y]		
         --debug.log(string.format("id: %d ,x: %d,y: %d	", obj_val))	
		end
		self.matrix = ret
		return self.matrix	
	else
		return nil
	end
end

local function _Slot(self) 
	local ret = {}
	local ret_i = 1
	local total = 0
	local prize	= 0

	ret[ret_i]= {}
	ret[ret_i].result = _TrySpecialAward(self)
	if ret[ret_i].result ~= nil then
	   ret[ret_i].prize_line = _GetPrizeTotal(self, ret[ret_i].result)
	   total = _CalcTotalPrize (self, ret[ret_i].prize_line)
	end

	if ret[ret_i].result == nil then
	   --防止第一次生成物件阵就无法消除
	   for i = 1,1 do -- just 1
	   	  ret[ret_i], prize = _SlotOnce(self, ret_i, i)
		  if #ret[ret_i].prize_line > 0 then
		      break
		  end
	   end
	end
	total = total + prize
	while (_CheckNRemove(self,ret[ret_i])) do 
		ret_i = ret_i + 1
		ret[ret_i], prize = _SlotOnce(self, ret_i, 0)
		total = total + prize
		
		if ret_i>50 then
			break
		end
	end
 
	return ret, total
end

function _StartFreeSpin(self, life, Multi)
	self.data = _MakeFreeSpin (self.data, self.data_FreeSpin)

	local ret = {}
	local total = 0

	while life > 0 do
		local o_ret = {}
		local prize

		self.matrix = nil
		o_ret, prize = _Slot (self)
		prize = prize * Multi

		local kick_count = 0
		while(_TryKickOut(self, prize)) do 
			o_ret = {}
			self.matrix = nil
			o_ret, prize = _Slot (self)
			prize = prize * Multi
			kick_count = kick_count + 1
			--超过10次将放弃
			if kick_count >= 10 then
				debug.log(string.format("kick_count:%d",kick_count));
			   break
			end
		end 

		total = total + prize

		--debug.dump (o_ret, "FS ret("..life..")win: ".. prize, 10)
		
		for i = 1, #o_ret do
			o_ret[i].FreeSpin = life.."."..#o_ret + 1 - i
			ret[#ret + 1] = CopyTable (o_ret[i])	
		end	

		-- 過關	
			for i = 1, #o_ret do
				local prize_line = 	o_ret[i].prize_line[1]
				if prize_line ~= nil and prize_line.type == "Key" then
					for jj = 1, prize_line.prize_count do
						if self.level_key_countdown == 1 then
							self.level = self.level % 3 + 1
							self.level_key_countdown = self.data.levels[self.level].pass_key_count
						else
							self.level_key_countdown = self.level_key_countdown - 1	
						end				
					end
				end
			end

		life = life - 1
	end

	return ret, total
end

-- Jackpot
local function _Jackpot(self) 
	local cnt = _IsMakeJackopt(self)
	if cnt == false then
		return nil
	end
	
	local prize
	local ret = {}
	repeat
		ret = {}
		local ret_i = 1
		self.matrix = nil
		ret[1], prize = _SlotOnce(self, ret_i, 1)
	until #ret[1].prize_line == 0

	if cnt then 
		local id = _GetJackoptId(self)
		for i = 1, cnt, 1 do
			local randx = GameRandEx(1, self.data.levels[self.level].rolls.roll_count + 1)	
			local randy = GameRandEx(1, self.data.levels[self.level].rolls.line_count + 1)	
			if ret[1].result[randx][randy] ~= id then
				ret[1].result[randx][randy] = id
			else
				cnt = cnt + 1
			end 
		end
	end

	--print ("Jackpot id_cnt:".. cnt)
	local prize_line = _GetPrizeScatter(self, ret[1].result)	
	if prize_line ~= nil then
		ret[1].prize_line = prize_line	
	end	

	return ret, prize
end

-- Main Game
function SceneSlotMachine_CandyParty:Start()
	if __SetSeed then __SetSeed ("debug.getinfo(1).name", nil) end

	local prize
	local ret = {}

	-- JP 
	ret, prize = _Jackpot (self)
	if ret ~= nil then
		return ret, prize
	end

	self.matrix = nil
	ret, prize = _Slot(self)

	local kick_count = 0
	while(_TryKickOut(self, prize)) do 
		ret = {}
		self.matrix = nil
		ret, prize = _Slot(self)
		kick_count = kick_count + 1
		--超过10次将放弃
		if kick_count >= 10 then
			debug.log(string.format("kick_count:%d",kick_count));
		   break
		end
	end 

	-- FreeSpin
	if #ret == 1 then	-- No Win
		if _IsMakeBonus(self) then 
			local randx = GameRandEx(1, self.data.levels[self.level].rolls.roll_count + 1)	
			local randy = GameRandEx(1, self.data.levels[self.level].rolls.line_count + 1)	
			ret[1].result[randx][randy] = _GetBonusId(self) 
		end
		local prize_line = _GetPrizeScatter(self, ret[1].result)	
		if prize_line ~= nil then
			ret[1].prize_line = prize_line	
			-- FreeSpin Multi
			ret[1].prize_line[#ret[1].prize_line].FreeSpin_Multi = _GetFreeSpinMulti (self)
		end
	end
	return ret, prize
end
 
--[[
function SceneSlotMachine_Raider:Bonus(bet, win) 
    local ret = {}
	ret.win_index = 0
	ret.win_score = 0
	ret.score = {}
	
	local total_factor = 0
    for i = 1, #self.data.bonus.propertys do
	    local property = self.data.bonus.propertys[i]
		total_factor = total_factor + property.factor
		
		local rbase = GameRandEx(property.base_min, property.base_max + 1)
		local tmp = bet-win 
		if tmp <= 0 then
		    tmp = 0
		end
		 
		local tc = tmp*property.n + (bet/self.data.bonus.deno)*property.x 
	    local score = math.floor(tc*rbase/self.data.bonus.deno)
		ret.score[i] = score 
    end	
	
	local rand_factor = GameRandEx(1, total_factor + 1)
	local find_index = 0
	local add_factor = 0
	for i=1,#self.data.bonus.propertys do  
		add_factor = add_factor + self.data.bonus.propertys[i].factor
		if rand_factor <= add_factor then
			find_index = i
			break
		end
	end	
	
    if find_index > 0 then
	    ret.win_index = find_index - 1
		ret.win_score = ret.score[find_index]
	end	
 
	return ret
end
]]

local function _Slot_Top(self)
	local ret = {}
	local resultTop = _RollAllRolls(self)
	for x, value in ipairs(resultTop) do			
		ret[x] = value[4]
	end
	-- ret = {9,9,9,9,9,9,9} --XXXX
	return ret
end

local function _AddResultTop (self, i_ret)
	local top = _Slot_Top(self)

	for i = #i_ret, 1, -1 do
		local tbl = i_ret[i]
		if tbl.top then	
			local result1 = i_ret[i + 1].result
			local top1 = i_ret[i + 1].top
			-- copy
			for x = 1, #tbl.result do
				if tbl.top[x] ~= nil then
					local y = tbl.top[x]
					tbl.top[x] = result1[x][y] 
				else
					tbl.top[x] = top1[x]
				end	
			end
		else
			tbl.top = {}
			for x = 1, #tbl.result do
				tbl.top[x] = top[x]
			end
		end
	end
end

local function _ChangeResultTable(self, i_ret)
	local Data = {}
	local Data_1 = nil
	local top = _Slot_Top(self)

	for i = 1, #i_ret do
		if i ~= #i_ret then
			Data_1 = i_ret[i + 1].result
		end	
		local tbl = i_ret[i]
		if tbl.result then
			Data[i] = tbl.result

			if tbl.top then
				for x, tbx in ipairs(Data[i]) do
					table.insert(tbx, 1, nil)	-- Top
					if tbl.top[x] ~= nil then
						y = tbl.top[x]
						tbx[1] = Data_1[x][y] 
					else
						tbx[1] = top[x]		
					end	
				end
			else	
				for x, tbx in ipairs(Data[i]) do
					table.insert(tbx, 1, top[x])	-- Top
				end

				top = _Slot_Top(self)
			end
		end		
	end
	--debug.dump (Data, "Data", 10)
	return Data	
end


function SceneSlotMachine_CandyParty:StartAll()
    if __SetSeed then
        __SetSeed(self, "StartAll", nil)
    end	

	-- Main
    local ret, prize = self.Start(self)
 
	--debug.dump (ret, "main ret", 10);
    if cBookKeep then
        cBookKeep.fMain(cBookKeep, self.bet_coin, prize, ret)
    end

    -- FreeSpin
    if true then
        if #ret[#ret].prize_line ~= 0 then
            local life = ret[#ret].prize_line[1].prize[1].param
            local multi = ret[#ret].prize_line[1].FreeSpin_Multi
			--print (string.format("life :%d Multi :%d\n", life, multi))
			--ret[#ret].prize_line[1].FreeSpin_Multi = 1
            local o_ret
            local prize = 0
            o_ret, prize = _StartFreeSpin(self, life, multi)

            --	debug.dump (o_ret, "free ret", 10);
            for i = 1, #o_ret do
                ret[#ret + 1] = o_ret[i]
            end
            if cBookKeep then
                cBookKeep.fFree(cBookKeep, self.bet_coin, prize, o_ret, multi)
            end
        end
    else
        if #ret[#ret].prize_line ~= 0 then
            if cBookKeep then
                cBookKeep.fFree(cBookKeep, self.bet_coin, 0, nil)
            end
        end
    end

    --	debug.dump (ret, "ret", 10);
	_AddResultTop (self, ret)
    return ret
end

function SceneSlotMachine_CandyParty:GetPrize(result)
	local ret = {}
	ret.prize_line = _GetPrizeTotal(self, result)
	return ret
end

function _MakeFreeSpin(Main, FreeSpin)
	local ret = nil
	for i = 1, #FreeSpin.levels, 1 do			
		FreeSpin.levels[i].objs = Main.levels[i].objs
	end	
	ret = CopyTable(Main)
	ret.levels = FreeSpin.levels
	return ret
end

print ("CandyParty_lua ver 0.4.0")	-- JP
