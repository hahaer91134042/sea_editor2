
--加命
local function _Checklife(self, prize_info)
	local t = 0
	for j=1,#prize_info.prize do
		if prize_info.prize[j].event == 4 then
			t = t + prize_info.prize[j].param
		end
	end
	return t
end

function Slot_Checklife(self, once)
	local t = 0
	for i=1,#once.prize_line do
		t = t + _Checklife(self, once.prize_line[i])
	end
	return t
end

function Slot_FillStay(self, matrix, stay)
	if matrix ~= nil then
		for i=1,#matrix do
			if matrix[i] ~= nil then
				for j=1,#matrix[i] do
					local obj_id = matrix[i][j]
					if self.data.objs[obj_id].stay or self.data.objs[obj_id].free_stay then
						stay[i][j] = obj_id
					end
				end				
			end
		end
	end
end

function Slot_InitStay(self, matrix, data, roll_count, line_count)
	data.stay = {}
	for i=1,roll_count do
		data.stay[i] = {}
		for j=1, line_count do
			data.stay[i][j] = nil
		end
	end
	Slot_FillStay(self, matrix, data.stay)
end

function Slot_GetStay(self, x, y)
	if self.data.stay ~= nil and self.data.stay[x] ~= nil then
		return self.data.stay[x][y]
	end	
	
	return nil
end

function Slot_EgnorePrizeLast(self, once)
	local other_id = 0
	once.egnore_prize = {}
	for i=1,#once.prize_line do
		local prize_info = once.prize_line[i]
		local obj = self.data.objs[prize_info.obj_id]
		if obj ~= nil and obj.prize_last then
			once.egnore_prize[#once.egnore_prize+1] = once.prize_line[i]
		else
			other_id = other_id + 1
			once.prize_line[other_id] = once.prize_line[i]
		end
	end
	
	for i=other_id+1,#once.prize_line do
		once.prize_line[i] = nil
	end
end

function Slot_RecoverEgnoredPrize(self, once)
	for i=1,#once.egnore_prize do
		once.prize_line[#once.prize_line + 1] = once.egnore_prize[i]
	end
end

function Slot_RandomOneGrid(pool, mutex)
	local count = #pool
	local ret_i = count
	local total = 0
	for i=1,count do
	   if not mutex[pool[i].id] then
	      total = total + pool[i].drag
	   end
	end
	local rate = GameRandEx(0, total)
	local cur_total = 0
	for i=1,count do
		if not mutex[pool[i].id] then
			cur_total = cur_total+pool[i].drag
			if rate < cur_total then
				ret_i = i
				break
			end
		end
	end
	
	return pool[ret_i].id
end

function Slot_GetListIndex(self, x, y)
	return (x - 1) * self.data.rolls.line_count + y
end

function Slot_GetCoorIndex(self, list_index)
	local x = math.modf((list_index - 1) / self.data.rolls.line_count) + 1
	local y = math.fmod((list_index - 1), self.data.rolls.line_count) + 1
	return x, y
end


--UC Mutex
function Slot_ObjRelation(self, list_index, o_res, mutex, fa_mutex)
	local x, y = Slot_GetCoorIndex(self, list_index)
	local r_mutex = {}
	for i=1,#r_mutex do
	   r_mutex[i]=mutex[i]
	end
	
	local uc_roll = self.data.uc.rolls[list_index]
	local rate = GameRandEx(0, uc_roll.total)
	
	local r_type = 0
	local target = 0
	local weight = 0
	
	weight = weight + uc_roll.cp_numerator
	--copy
	if rate < weight then
	   r_type = 1
	end
	weight = weight + uc_roll.col_cp_numerator
	--column copy
	if r_type == 0 and rate < weight then
	   r_type = 2
	end
	weight = weight + uc_roll.uc_mutex_numerator
	--uncopy(mutex)
	if r_type == 0 and rate < weight then
	    --r_type = 3
		for i=1,#uc_roll.uncopy do
			local target = uc_roll.uncopy[i].target
			local x1, y1 = Slot_GetCoorIndex(self, target)
			if o_res[x1][y1] ~=nil and o_res[x1][y1] ~=0 then
				mutex[o_res[x1][y1]] = true
			end
		end
	end
	
	if r_type == 1 or r_type == 2 then
		local rand_field = {}
		local t = 0
		local relation = self.data.uc.rolls[list_index].relation
		if r_type == 2 then
		   relation = self.data.uc.rolls[list_index].columncopy
		end

		for i=1,#relation do
			--debug.log(string.format("target:%d",relation[i].target))
			local o_x, o_y = Slot_GetCoorIndex(self,relation[i].target)
			if o_res[o_x][o_y] ~= nil then
				t = t + relation[i].weight 
			end
			rand_field[i] = t
		end
		if t > 0 then
			rate = GameRandEx(0, t)
			for i=1,#rand_field do
				if rate < rand_field[i] then
					local o_x, o_y = Slot_GetCoorIndex(self, relation[i].target)
					if mutex[o_res[o_x][o_y]] then
						break
					else
					    if self.related_data.objs[o_res[o_x][o_y]].disable_copy ~= nil and self.related_data.objs[o_res[o_x][o_y]].disable_copy ==1 then
						  break
						end
						if r_type == 1 then
							o_res[x][y] = o_res[o_x][o_y]
						else
							for i=1,self.data.rolls.line_count do
								o_res[x][i] = o_res[o_x][o_y]
							end
						end
						return
					end
				end
			end
		end
	end
	
	if o_res[x][y]==nil or o_res[x][y]==0 then
	    local obj_id = Slot_RandomOneGrid(self.data.rolls.rolls[list_index], mutex)
		--debug.log(string.format("order:%d,obj_id:%d,r_type:%d,rate:%d",uc_roll.order,obj_id,r_type,rate))
		o_res[x][y] = obj_id
		if self.related_data.objs[o_res[x][y]].mutex ~= nil then
			for i=1,#self.related_data.objs[o_res[x][y]].mutex do
				fa_mutex[self.related_data.objs[o_res[x][y]].mutex[i]] = true
			end
		end
	end
	
end

function Slot_RollOneRoll(self, list_index, o_res, fa_mutex)
	local line_count = self.data.rolls.line_count
	
	local x, y = Slot_GetCoorIndex(self, list_index)
	
	-- STAY
	local stay = Slot_GetStay(self, x, y)
	if stay ~= nil then
		o_res[x][y] = stay
		if self.related_data.objs[o_res[x][y]].mutex ~= nil then
			for i=1,#self.related_data.objs[o_res[x][y]].mutex do
				fa_mutex[self.related_data.objs[o_res[x][y]].mutex[i]] = true
			end
		end
		return
	end
	
	-- 计算互斥
	local mutex = {}
	for i=1,#self.related_data.objs do
		if fa_mutex[self.related_data.objs[i].id] then
			mutex[self.related_data.objs[i].id] = true
		else
			mutex[self.related_data.objs[i].id] = false
		end
	end
	for tx = 1,self.data.rolls.roll_count do
		if o_res[tx][y]~=nil and o_res[tx][y]~=0 and self.related_data.objs[o_res[tx][y]].line_mutex~=nil then
			for i=1,#self.related_data.objs[o_res[tx][y]].line_mutex do
				mutex[self.related_data.objs[o_res[tx][y]].line_mutex[i]] = true
			end
		end
	end
	for ty=1,self.data.rolls.line_count do
		if o_res[x][ty]~=nil and o_res[x][ty]~=0 and self.related_data.objs[o_res[x][ty]].roll_mutex~=nil then
			for i=1,#self.related_data.objs[o_res[x][ty]].roll_mutex do
				mutex[self.related_data.objs[o_res[x][ty]].roll_mutex[i]] = true
			end
		end
	end	
	--是否为4x5的1024线
	if self.data.uc.uc_type ~=nil and self.data.uc.uc_type == "UC_MUTEX" then
		Slot_ObjRelation(self, list_index, o_res, mutex, fa_mutex)
	    return 
	end

	-- 修正结果
	local rate = GameRandEx(0, self.data.uc.total)
	if rate >= self.data.uc.rolls[list_index].uc then
		local rand_field = {}
		local t = 0
		for i=1,#self.data.uc.rolls[list_index].relation do
			local o_x, o_y = Slot_GetCoorIndex(self, self.data.uc.rolls[list_index].relation[i].target)
			if o_res[o_x][o_y] ~= nil then
				t = t + self.data.uc.rolls[list_index].relation[i].weight --self.related_data.objs[o_res[o_x][o_y]].k *
			end
			rand_field[i] = t
		end
		if t > 0 then
			rate = GameRandEx(0, t)
			for i=1,#rand_field do
				if rate < rand_field[i] then
					local o_x, o_y = Slot_GetCoorIndex(self, self.data.uc.rolls[list_index].relation[i].target)
					if mutex[o_res[o_x][o_y]] then
						break
					else
					    if self.related_data.objs[o_res[o_x][o_y]].disable_copy ~= nil and self.related_data.objs[o_res[o_x][o_y]].disable_copy ==1 then
						  break
						end
						o_res[x][y] = o_res[o_x][o_y]
						return
					end
				end
			end
		end
	end
	
	o_res[x][y] = Slot_RandomOneGrid(self.data.rolls.rolls[list_index], mutex)
	if self.related_data.objs[o_res[x][y]].mutex ~= nil then
		for i=1,#self.related_data.objs[o_res[x][y]].mutex do
			fa_mutex[self.related_data.objs[o_res[x][y]].mutex[i]] = true
		end
	end

end

function Slot_RollAllRolls(self)
	local ret = { }
	local fa_mutex = {}
	for i=1,self.data.rolls.roll_count do
		ret[i] = {}
	end
	for i=1,#self.related_data.objs do
		fa_mutex[self.related_data.objs[i].id] = false
	end

	for i=1,#self.data.uc.order do
		if self.data.test_result ~= nil and self.cheated == true then
			local x, y = Slot_GetCoorIndex(self, self.data.uc.order[i])
			ret[x][y] = self.data.test_result[x][y]
		else
			Slot_RollOneRoll(self, self.data.uc.order[i], ret, fa_mutex)
		end
	end
	
	if self.cheated == true then
		self.cheated = false
	end
	
	return ret
end

function Slot_ReRollMatrix(self)
	local fa_mutex = {}
	for i=1,#self.related_data.objs do
		fa_mutex[self.related_data.objs[i].id] = false
	end	
	
	for i=1,#self.data.uc.order do
		local x, y = Slot_GetCoorIndex(self, self.data.uc.order[i])
		if self.matrix[x][y] ~= nil and self.related_data.objs[self.matrix[x][y]].mutex ~= nil then
			for i=1,#self.related_data.objs[self.matrix[x][y]].mutex do
				fa_mutex[self.related_data.objs[self.matrix[x][y]].mutex[i]] = true
			end
		end
	end
	
	for i=1,#self.data.uc.order do
		local x, y = Slot_GetCoorIndex(self, self.data.uc.order[i])
		if self.matrix[x][y] == nil then
			if self.data.test_result ~= nil and self.cheated == true then
				self.matrix[x][y] = self.data.test_result[x][y]
			else
				Slot_RollOneRoll(self, self.data.uc.order[i], self.matrix, fa_mutex)
			end
		end
	end
	
	if self.cheated then
		self.cheated = false
	end
end

function Slot_RollMatrix(self)
	if self.matrix == nil then
		self.matrix = Slot_RollAllRolls(self)
	else
		Slot_ReRollMatrix(self)
	end
	return self.matrix
end

function Slot_ObjWild(self, obj, obj_id)
	if obj.wild == nil or #obj.wild == 0 then
		return false
	end
	if obj_id == 0 then
		return true
	end
	for i=1,#obj.wild do
		if obj.wild[i] == obj_id then
			return true
		end
	end
	return false
end

function Slot_WriteObjPrizeInfo(self, prize_info, obj_id, continue, with_wild, wild_count, extra_rate)
	if obj_id > 0 and continue >= 2 and #self.related_data.objs[obj_id]["cont"..continue] > 0 then
		prize_info.obj_id = obj_id
		prize_info.group_id = 0
		prize_info.prize = self.related_data.objs[obj_id]["cont"..continue]
		prize_info.continue = continue
		prize_info.with_wild = with_wild
		prize_info.wild_count = wild_count
		prize_info.extra_rate = extra_rate
	end
end

function Slot_WriteGroupPrizeInfo(self, prize_info, group_id, continue, with_wild, wild_count, extra_rate)
	if group_id > 0 and continue >= 2 and #self.related_data.groups[group_id]["cont"..continue] > 0 then
		prize_info.obj_id = 0
		prize_info.group_id = group_id
		prize_info.prize = self.related_data.groups[group_id]["cont"..continue]
		prize_info.continue = continue
		prize_info.with_wild = with_wild
		prize_info.wild_count = wild_count
		prize_info.extra_rate = extra_rate
	end
end

function Slot_CheckWinLine(self, result, line_id, is_left)
	local obj_id = 0
	local group_id = 0
	local check_group = nil
	local group_remain_count = 0
	local con_time = 0
	local with_wild = false
	local wild_count = 0
	local wild_obj = nil
	local extra_rate = 0
	
	local prize_info = {}
	prize_info.type = "line"
	prize_info.obj_id = 0
	prize_info.group_id = 0
	prize_info.continue = 0
	prize_info.prize = {}
	prize_info.with_wild = false
	prize_info.wild_count = 0
	prize_info.extra_rate = 0	

	local check_type = 0
	local loop_max = 0
	local certain_roll = 0
	if self.related_data.win_line[line_id].line[1] <= 0 then
		check_type = 2
		loop_max = self.data.rolls.line_count
		for i=1,#self.related_data.win_line[line_id].line do
			if self.related_data.win_line[line_id].line[i] < 0 then
				certain_roll = i
				break
			end
		end
	else
		check_type = 1
		loop_max = #self.related_data.win_line[line_id].line
	end

	for i=1,loop_max do
		local idx = 0
		local obj = nil

		if not is_left then
			i = loop_max + 1 - i
		end

		if check_type == 1 then
			idx = self.related_data.win_line[line_id].line[i]
			obj = self.related_data.objs[result[i][idx]]
		else
			idx = i
			obj = self.related_data.objs[result[certain_roll][idx]]
		end		
	
		if check_group == nil then
			if obj_id == 0 then
				if Slot_ObjWild(self, obj, obj_id) then
					with_wild = true
					wild_obj = obj
					wild_count = wild_count + 1
					con_time = con_time + 1
					if obj.extra_rate ~= nil then
						extra_rate = extra_rate + obj.extra_rate
					end										
					Slot_WriteObjPrizeInfo(self, prize_info, obj_id, con_time, with_wild, wild_count, extra_rate)
				else
				  local wild_obj_id = 0
				  if wild_obj ~= nil then
				     wild_obj_id = wild_obj.id
				  end
				    if wild_count > 0 then
					   if Slot_ObjWild(self, wild_obj, obj.id) == false then
					      return false, nil
					   end
					end
					obj_id = obj.id
					con_time = con_time + 1
					if obj.extra_rate ~= nil then
						extra_rate = extra_rate + obj.extra_rate
					end					
					Slot_WriteObjPrizeInfo(self, prize_info, obj_id, con_time, with_wild, wild_count, extra_rate)
				end
			else
				if Slot_ObjWild(self, obj, obj_id) then
					with_wild = true
					wild_count = wild_count + 1
					con_time = con_time + 1
					if obj.extra_rate ~= nil then
						extra_rate = extra_rate + obj.extra_rate
					end					
					Slot_WriteObjPrizeInfo(self, prize_info, obj_id, con_time, with_wild, wild_count, extra_rate)
				elseif obj_id == obj.id then
					con_time = con_time + 1
					if obj.extra_rate ~= nil then
						extra_rate = extra_rate + obj.extra_rate
					end					
					Slot_WriteObjPrizeInfo(self, prize_info, obj_id, con_time, with_wild, wild_count, extra_rate)
				else
					check_group = {}
					for j=1,#self.related_data.groups do
						local b1 = false
						local b2 = false
						check_group[j] = false
						for x=1,#self.related_data.groups[j].group do
							if self.related_data.groups[j].group[x] == obj_id then
								b1 = true
							elseif self.related_data.groups[j].group[x] == obj.id then
								b2 = true
							end
							if b1 and b2 then
								group_id = j
								check_group[j] = true
								group_remain_count = group_remain_count + 1
								Slot_WriteGroupPrizeInfo(self, prize_info, group_id, con_time + 1, with_wild, wild_count, extra_rate)
								break
							end
						end
					end
					if group_remain_count == 0 then
						break
					else
						con_time = con_time + 1
						if obj.extra_rate ~= nil then
							extra_rate = extra_rate + obj.extra_rate
						end					
					end
				end
			end
		else
			if not Slot_ObjWild(self, obj, obj_id) then
				for j=1,#self.related_data.groups do
					if check_group[j] then
						local bb = false
						for x=1,#self.related_data.groups[j].group do
							if self.related_data.groups[j].group[x] == obj.id then
								bb = true
								group_id = j
								Slot_WriteGroupPrizeInfo(self, prize_info, group_id, con_time + 1, with_wild, wild_count, extra_rate)
								break
							end
						end
						if not bb then
							check_group[j] = false
							group_remain_count = group_remain_count - 1
						end
					end
				end
			end
			if group_remain_count > 0 then
				con_time = con_time + 1
				if obj.extra_rate ~= nil then
					extra_rate = extra_rate + obj.extra_rate
				end					
			else
				break
			end
		end
	end
	
	if con_time < 2 then
		return false, nil
	else
		if prize_info.obj_id == 0 and prize_info.group_id == 0 then
			return false, nil
		end

		return true, prize_info
	end
end

function Slot_CheckScatter(self, result, obj_id)
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
		if obj.scatterxn == nil and scatter_count > 5 then
			scatter_count = 5
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

function Slot_CheckGroupScatterCount(self, result, group_id)
	local group_obj = self.related_data.groups[group_id]
	if group_obj.scatter_cnt == nil or #group_obj.scatter_cnt==0 then
		return nil
	end
	
	local group_obj_id = 0
	local rlt_cnt={}
	local scatter_count = 0
	for i=1,#result do
		for j=1,#result[i] do
		    for k=1,#group_obj.group do
			  local obj_id = group_obj.group[k]
			  if result[i][j] == obj_id then
			      local obj = self.related_data.objs[obj_id]
				  scatter_count = scatter_count + 1
				  rlt_cnt[scatter_count] ={}
				  rlt_cnt[scatter_count].index = _GetListIndex(self,i,j)
				  rlt_cnt[scatter_count].prize = 0
				  
				  if group_obj_id == 0 then 
				     group_obj_id = obj_id
				  end
				  
				  if obj.scatter_box.flag and obj.scatter_box.denominator>0 then 
				     local rate = GameRandEx(obj.scatter_box.low, obj.scatter_box.high)
					 local times = rate/obj.scatter_box.denominator
					 local cnt = group_obj.scatter_cnt[1]
					 if cnt.event == 3 then
					    rlt_cnt[scatter_count].prize = times * self.bet_line
					 else
					    rlt_cnt[scatter_count].prize = times
					 end

				  end
				  
			  end
			end
		end
	end
	
	local flag = false
	for i=1,#group_obj.scatter_cnt do
	   local cnt = group_obj.scatter_cnt[i]
	   if cnt.count <= scatter_count then
	       flag = true
	       break
	   end
	end
	if not flag then
	   return nil
	end
	
	local prize_info = {}
	prize_info.type = "GroupScatterCount"
	prize_info.obj_id = group_obj_id
	prize_info.group_id = group_id
	prize_info.continue = scatter_count
	prize_info.with_wild = false
	prize_info.prize = {}
	prize_info.group_scatter_cnt = rlt_cnt
	prize_info.extra_rate = 0
	
	
	return prize_info
	
end

function Slot_CheckObjScatterTrans(self, result, obj_id)
	local obj = self.related_data.objs[obj_id]
	if obj.scatter_trans == nil or #obj.scatter_trans.targets == 0 then
		return nil
	end
	
	local rlt_cnt = {}
	local scatter_count = 0
	for i=1,#result do
		for j=1,#result[i] do
			if result[i][j] == obj_id then
				scatter_count = scatter_count + 1
				rlt_cnt[scatter_count] = Slot_GetListIndex(self, i, j)
			end
		end
	end
	
	if scatter_count < obj.scatter_trans.times then
		return nil
	end
	
	local index = GameRandEx(1, #obj.scatter_trans.targets + 1)	
	
	local prize_info = {}
	prize_info.type = "ScatterTrans"
	prize_info.obj_id = obj_id
	prize_info.group_id = 0
	prize_info.continue = scatter_count
	prize_info.with_wild = false
	prize_info.prize = {}
	prize_info.scatter_trans = rlt_cnt
	prize_info.scatter_trans_into = obj.scatter_trans.targets[index]
	prize_info.extra_rate = 0	
	
	return prize_info
end

function Slot_CheckCount(self, result, obj_id)
	local obj = self.related_data.objs[obj_id]
	if obj.count == nil or not obj.count.flag then
		return nil
	end
		
	local count_count = 0
	for i=1,#result do
		for j=1,#result[i] do
			if result[i][j] == obj_id then
				count_count = count_count + 1
			end
		end
	end
	if count_count > 5 then
		count_count = 5
	end
	
	if obj.count["cont"..count_count] == nil or #obj.count["cont"..count_count] <= 0 then
		return nil
	end
	
	local prize_info = {}
	prize_info.type = "Count"
	prize_info.obj_id = obj.id
	prize_info.group_id = 0
	prize_info.continue = count_count
	prize_info.with_wild = false
	prize_info.prize = obj.count["cont"..count_count]
	prize_info.extra_rate = 0
	if obj.extra_rate ~= nil then
		prize_info.extra_rate = obj.extra_rate * count_count	
	else
		prize_info.extra_rate = 0
	end	
	
	return prize_info
end

function Slot_CheckWild(self, result, line_id, is_left)
	local group_id = 0
	local check_group = nil
	local group_remain_count = 0
	local con_time = 0
	local with_wild = false
	local wild_count = 0
	local extra_rate = 0
	
	local prize_info = {}
	prize_info.type = "line"
	prize_info.obj_id = 0
	prize_info.group_id = 0
	prize_info.continue = 0
	prize_info.prize = {}
	prize_info.with_wild = false
	prize_info.wild_count = 0	
	prize_info.extra_rate = 0

	local check_type = 0
	local loop_max = 0
	local certain_roll = 0
	if self.related_data.win_line[line_id].line[1] <= 0 then
		check_type = 2
		loop_max = self.data.rolls.line_count
		for i=1,#self.related_data.win_line[line_id].line do
			if self.related_data.win_line[line_id].line[i] < 0 then
				certain_roll = i
				break
			end
		end
	else
		check_type = 1
		loop_max = #self.related_data.win_line[line_id].line
	end

	for i=1,loop_max do
		local idx = 0
		local obj = nil

		if not is_left then
			i = loop_max + 1 - i
		end

		if check_type == 1 then
			idx = self.related_data.win_line[line_id].line[i]
			obj = self.related_data.objs[result[i][idx]]
		else
			idx = i
			obj = self.related_data.objs[result[certain_roll][idx]]
		end		
	
		if Slot_ObjWild(self, obj, 0) then
			with_wild = true
			wild_count = wild_count + 1
			con_time = con_time + 1
			if obj.extra_rate ~= nil then
				extra_rate = extra_rate + obj.extra_rate
			end			
			Slot_WriteObjPrizeInfo(self, prize_info, obj.id, con_time, with_wild, wild_count, extra_rate)
		else
			break
		end
	end
	
	if con_time < 2 then
		return false, nil
	else
		if prize_info.obj_id == 0 then
			return false, nil
		end

		return true, prize_info
	end
end

function Slot_WriteObjFullPrize(self, prize_info, obj_id, wild_count, extra_rate)
	if #self.related_data.objs[obj_id]["full"] > 0 then
		prize_info.obj_id = obj_id
		prize_info.group_id = 0
		prize_info.prize = self.related_data.objs[obj_id]["full"]
		prize_info.continue = wild_count
		prize_info.with_wild = wild_count > 0
		prize_info.wild_count = wild_count
		prize_info.extra_rate = extra_rate
	end
end

function Slot_WriteGroupFullPrize(self, prize_info, group_id, wild_count, extra_rate)
	if #self.related_data.groups[group_id]["full"] > 0 then
		prize_info.obj_id = 0
		prize_info.group_id = group_id
		prize_info.prize = self.related_data.groups[group_id]["full"]
		prize_info.continue = wild_count
		prize_info.with_wild = wild_count > 0
		prize_info.wild_count = wild_count
		prize_info.extra_rate = extra_rate
	end
end

function Slot_CheckFull(self, result)
	local obj_id = 0
	local group_id = 0
	local check_group = nil
	local group_remain_count = 0
	local wild_count = 0
	local wild_obj = nil
	local extra_rate = 0
	
	local prize_info = {}
	prize_info.type = "Full"
	prize_info.obj_id = 0
	prize_info.group_id = 0
	prize_info.continue = 0
	prize_info.prize = {}
	prize_info.with_wild = false
	prize_info.wild_count = 0	
	prize_info.extra_rate = 0
	
	for i=1,#result do
		for j=1,#result[i] do
			local obj = self.related_data.objs[result[i][j]]
			if check_group == nil then
				if Slot_ObjWild(self, obj, obj_id) then
				    wild_obj = obj
					wild_count = wild_count + 1
					if obj.extra_rate ~= nil then
						--extra_rate = extra_rate + obj.extra_rate
					end
                    local id = obj.id
                    if obj_id > 0 then
                       id = obj_id
                    end 					
					Slot_WriteObjFullPrize(self, prize_info, id, wild_count, extra_rate)
				elseif obj_id == 0 then
					obj_id = obj.id
					if wild_count > 0 then
					   if Slot_ObjWild(self, wild_obj, obj.id) == false then
					      return  nil
					   end
					end
					if obj.extra_rate ~= nil then
						extra_rate = extra_rate + obj.extra_rate
					end					
					Slot_WriteObjFullPrize(self, prize_info, obj.id, wild_count, extra_rate)
				elseif obj_id ~= obj.id then
					check_group = {}
					for j=1,#self.related_data.groups do
						local b1 = false
						local b2 = false
						check_group[j] = false
						for x=1,#self.related_data.groups[j].group do
							if self.related_data.groups[j].group[x] == obj_id then
								b1 = true
							elseif self.related_data.groups[j].group[x] == obj.id then
								b2 = true
							end
							if b1 and b2 then
								group_id = j
								check_group[j] = true
								group_remain_count = group_remain_count + 1
								wild_count = wild_count + 1
								Slot_WriteGroupFullPrize(self, prize_info, group_id, wild_count, extra_rate)
								break
							end
						end
					end
					if group_remain_count == 0 then
						return nil
					else
						if obj.extra_rate ~= nil then
							extra_rate = extra_rate + obj.extra_rate
						end					
					end
				end
			else
			    local isWild = true
				if not Slot_ObjWild(self, obj, obj_id) then
					for j=1,#self.related_data.groups do
						if check_group[j] then
							local bb = false
							for x=1,#self.related_data.groups[j].group do
								if self.related_data.groups[j].group[x] == obj.id then
									bb = true
									group_id = j
									Slot_WriteGroupFullPrize(self, prize_info, group_id, wild_count+1, extra_rate)
									break
								end
							end
							if not bb then
								check_group[j] = false
								group_remain_count = group_remain_count - 1
							end
						end
					end
					isWild = false;
				end
				if group_remain_count > 0 then
					wild_count = wild_count + 1
					if obj.extra_rate ~= nil and not isWild then
						extra_rate = extra_rate + obj.extra_rate
					end					
				else
					return nil
				end
			end
			
		end
	end
	
	return prize_info
end

function Slot_WriteObjFullLinePrize(self, prize_info, obj_id, continue, with_wild, wild_count, extra_rate, lines_count)
	if obj_id > 0 and continue >= 2 and #self.related_data.objs[obj_id]["cont"..continue] > 0 then
		prize_info.obj_id = obj_id
		prize_info.group_id = 0
		prize_info.prize = self.related_data.objs[obj_id]["cont"..continue]
		prize_info.continue = continue
		prize_info.with_wild = with_wild
		prize_info.wild_count = wild_count
		prize_info.extra_rate = extra_rate
		prize_info.lines_count = lines_count
	end
end

function Slot_CheckObjFullLine(self, result, obj_id)
	local con_time = 0
	local with_wild = false
	local wild_count = 0
	local wild_obj = nil
	local lines_count = 1
	local extra_rate = 0
	
	local prize_info = {}
	prize_info.type = "FullLine"
	prize_info.obj_id = 0
	prize_info.group_id = 0
	prize_info.continue = 0
	prize_info.prize = {}
	prize_info.with_wild = false
	prize_info.wild_count = 0	
	prize_info.extra_rate = 0
	prize_info.lines_count = 0
	
	for i=1,#result do									
		local count_pl = 0
		for idx=1,#result[i] do
			local obj = self.related_data.objs[result[i][idx]]					
			
			if Slot_ObjWild(self, obj, obj_id) then
				with_wild = true
				wild_count = wild_count + 1
				count_pl = count_pl + 1
			elseif obj.id == obj_id then
				count_pl = count_pl + 1
			end
			
			if obj.extra_rate ~= nil then
				extra_rate = extra_rate + obj.extra_rate
			end
		end
		if count_pl > 0 then
			con_time = con_time + 1
			lines_count = lines_count * count_pl
			Slot_WriteObjFullLinePrize(self, prize_info, obj_id, con_time, with_wild, wild_count, extra_rate, lines_count)
		else
			break
		end
	end
	
	if con_time < 2 then
		return false, nil
	else
		if prize_info.obj_id == 0 and prize_info.group_id == 0 then
			return false, nil
		end

		return true, prize_info
	end
end

function Slot_GetPrizeFullLine(self, result, prize_line, cur_prize_index)
	for index=1,#self.related_data.objs do
		local obj_id = self.related_data.objs[index].id
		
		local checked, prize_info = Slot_CheckObjFullLine(self, result, obj_id)
		if checked and #prize_info.prize > 0 then
			prize_line[cur_prize_index] = prize_info
			cur_prize_index = cur_prize_index + 1
		end
	end
	
	return prize_line, cur_prize_index
end

function Slot_GetPrizeWinLine(self, result, prize_line, cur_prize_index)
	for x=1,self.bet_line do
		local both_way = true
		
		if self.related_data.win_line[x].line_type == 1 or self.related_data.win_line[x].line_type == 3 then
			local checked, prize_info = Slot_CheckWinLine(self, result, x, true)
			if checked and #prize_info.prize > 0 then
				prize_info.param = x
				prize_line[cur_prize_index] = prize_info
				cur_prize_index = cur_prize_index + 1
				
				if prize_info.continue == self.data.rolls.roll_count then
				   both_way = false
				end
			end
		end
		
		if both_way and (self.related_data.win_line[x].line_type == 2 or self.related_data.win_line[x].line_type == 3) then
			local checked, prize_info = Slot_CheckWinLine(self, result, x, false)
			if checked and #prize_info.prize > 0 then
				prize_info.param = -x
				prize_line[cur_prize_index] = prize_info
				cur_prize_index = cur_prize_index + 1
			end
		end
		
		both_way = true
		
		if self.related_data.win_line[x].line_type == 1 or self.related_data.win_line[x].line_type == 3 then
			local checked, prize_info = Slot_CheckWild(self, result, x, true)
			if checked and #prize_info.prize > 0 then
				prize_info.param = x
				prize_line[cur_prize_index] = prize_info
				cur_prize_index = cur_prize_index + 1
				
				both_way = false
			end
		end

		if both_way and (self.related_data.win_line[x].line_type == 2 or self.related_data.win_line[x].line_type == 3) then
			local checked, prize_info = Slot_CheckWild(self, result, x, false)
			if checked and #prize_info.prize > 0 then
				prize_info.param = -x
				prize_line[cur_prize_index] = prize_info
				cur_prize_index = cur_prize_index + 1
			end
		end
	end
		
	return prize_line, cur_prize_index
end

function Slot_GetPrizeTotal(self, result)
	local prize_line = {}
	local cur_prize_index = 1
	
	if self.related_data.win_line == nil then
		prize_line, cur_prize_index = Slot_GetPrizeFullLine(self, result, prize_line, cur_prize_index)
	else
		prize_line, cur_prize_index = Slot_GetPrizeWinLine(self, result, prize_line, cur_prize_index)
	end
	
	for x=1,#self.related_data.objs do
		local prize_info = Slot_CheckScatter(self, result, self.related_data.objs[x].id)
		if prize_info ~=nil then			
			prize_line[cur_prize_index] = prize_info
			cur_prize_index = cur_prize_index + 1
		end
	end
	
	for x=1,#self.related_data.objs do
		local prize_info = Slot_CheckCount(self, result, self.related_data.objs[x].id)
		if prize_info ~=nil then			
			prize_line[cur_prize_index] = prize_info
			cur_prize_index = cur_prize_index + 1
		end
	end
	
	if self.related_data.is_fa then
		local prize_info = Slot_CheckFull(self, result)
		if prize_info ~= nil then
			prize_line[cur_prize_index] = prize_info
			cur_prize_index = cur_prize_index + 1
		end
	end
	
	--check group scatter cnt
	local chk_mask={}
	for x=1,#self.related_data.groups do
	    local prize_info = Slot_CheckGroupScatterCount(self, result, self.related_data.groups[x].id)
		if prize_info ~=nil then			
			prize_line[cur_prize_index] = prize_info
			cur_prize_index = cur_prize_index + 1
		end
	end
	
	--check objcect scatter trans
	for x=1,#self.related_data.objs do
		local prize_info = Slot_CheckObjScatterTrans(self, result, self.related_data.objs[x].id)
		if prize_info ~= nil then
			prize_line[cur_prize_index] = prize_info
			cur_prize_index = cur_prize_index + 1
		end
	end
		
	return prize_line
end

function Slot_CheckWinLineBroken(self, line_id, count, b_arr)
	local broken = false
	
	local is_left = true
	if line_id < 0 then
		line_id = -line_id
		is_left = false
	end
	
	local check_type = 0
	local loop_max = 0
	local certain_roll = 0
	if self.related_data.win_line[line_id].line[1] <= 0 then
		check_type = 2
		loop_max = self.data.rolls.line_count
		for i=1,#self.related_data.win_line[line_id].line do
			if self.related_data.win_line[line_id].line[i] < 0 then
				certain_roll = i
				break
			end
		end
	else
		check_type = 1
		loop_max = #self.related_data.win_line[line_id].line
	end

	for i=1,count do
		local idx = 0

		if not is_left then
			i = loop_max + 1 - i
		end

		if check_type == 1 then
			idx = self.related_data.win_line[line_id].line[i]
			b_arr[i][idx] = true
		else
			idx = i
			b_arr[certain_roll][idx] = true
		end
		broken = true
	end
	
	return broken
end

function Slot_CheckFullLineBroken(self, result, obj_id, count, b_arr)
	local broken = false
	for x=1,count do
		for y=1,#result[x] do
			local obj = self.related_data.objs[result[x][y]]
			if obj.id == obj_id or Slot_ObjWild(self, obj, obj_id) then
				b_arr[x][y] = true
				broken = true
			end
		end
	end
	return broken
end

function Slot_CheckScatterBroken(self, result, obj_id, b_arr)
	local broken = false
	for x=1,#result do
		for y=1,#result[x] do
			local obj = self.related_data.objs[result[x][y]]
			if obj.id == obj_id or Slot_ObjWild(self, obj, obj_id) then
				b_arr[x][y] = true
				broken = true
			end
		end
	end
	return broken
end

function Slot_CheckBroken(self, result)
	local broken = false
	local prizes = result.prize_line
	local ret = {}
	for i=1,self.data.rolls.roll_count do
		ret[i] = {}
		for j=1,self.data.rolls.line_count do
			ret[i][j] = false
		end
	end

	for i=1,#prizes do
		if prizes[i].type == "Full" then
			for a=1,self.data.rolls.roll_count do
				for b=1,self.data.rolls.line_count do
					ret[a][b] = true
				end
			end
			broken = true
			break
		elseif prizes[i].type == "FullLine" then
			broken = Slot_CheckFullLineBroken(self, result.result, prizes[i].obj_id, prizes[i].continue,ret) or broken
		elseif prizes[i].type == "line" then
			broken = Slot_CheckWinLineBroken(self, prizes[i].param, prizes[i].continue, ret) or broken
		elseif prizes[i].type == "Scatter" then
			broken = Slot_CheckScatterBroken(self, result.result, prizes[i].obj_id, ret) or broken
		end
	end
	
	return broken, ret
end

function Slot_RemoveBroken(self, broken_arr)
	ret = {}
	for i=1,self.data.rolls.roll_count do
		ret[i] = {}
		
		local ret_j = self.data.rolls.line_count
		for j=self.data.rolls.line_count,1,-1 do
			if not broken_arr[i][j] then
				ret[i][ret_j] = self.matrix[i][j]
				ret_j = ret_j - 1
			end
		end
	end
	
	return ret
end


function Slot_PrintResult(x, xx)
	local prize = 0
	
	if xx.lightR ~= nil then
		print("lightR = "..xx.lightR.."("..x.data.out_circle.list[xx.lightR].obj_id..")")
	end
	
	for i=1,#xx.result do
		if xx.result[i] ~= nil then
			local tmp = ""
			for j=1,#xx.result[i] do
				tmp = tmp..xx.result[i][j].."  "
			end
			print(tmp)
		end
	end
	
	if xx.extra_line ~= nil then
		local tmp = "extra line: "
		for i=1,#xx.extra_line do
			tmp = tmp.."  x"..xx.extra_line[i]
		end
		print(tmp)
	end
	
	if xx.lightG ~= nil then
		print("lightG = "..xx.lightG.."("..x.data.out_circle.list[xx.lightG].obj_id..")")
	end
	
	for i=1,#xx.prize_line do
		local rate = 1
		if xx.prize_line[i].extra_rate > 0 then
			rate = xx.prize_line[i].extra_rate
		end		

		if xx.prize_line[i].type == "line" then
			print("line"..i.."   "..xx.prize_line[i].param.."    "..xx.prize_line[i].obj_id.."    "..xx.prize_line[i].group_id.."    "..xx.prize_line[i].continue)
		elseif xx.prize_line[i].type == "FullLine" then
			print("Fullline"..i.."    "..xx.prize_line[i].obj_id.."    "..xx.prize_line[i].continue.."    *"..xx.prize_line[i].lines_count)
			rate = rate * xx.prize_line[i].lines_count
		elseif xx.prize_line[i].type == "Broken" then
			print("Broken List: ")
			local list = xx.prize_line[i].broken_list
			for b=1,#list do
				local bx, by = Slot_GetCoorIndex(x, list[b].index)
				local tmp = "{"..bx..","..by.."}["..list[b].obj_id.."]"
				if list[b].prize ~= nil then
					tmp = tmp..":{"
					for j=1,#list[b].prize do
						tmp=tmp.."("..list[b].prize[j].event..","..list[b].prize[j].param..")"
						if j ~= #list[b].prize then
							tmp=tmp..","
						end
						if list[b].prize[j].event == 0 then
							prize = prize + list[b].prize[j].param * rate * x.bet_coin
						elseif list[b].prize[j].event == 3 then
							prize = prize + list[b].prize[j].param * rate * x.bet_total
						end

					end
					tmp = tmp.."}"
				end
				print(tmp)
			end
		elseif xx.prize_line[i].type == "BOMB" then
			local list = xx.prize_line[i].broken_list
			local tmp = "BOMB List: "
			for b=1,#list do
				local bx, by = Slot_GetCoorIndex(x, list[b])
				tmp = tmp.."{"..bx..","..by.."}"
				if b ~= #list then
					tmp = tmp..", "
				end
			end
			print(tmp)
		elseif xx.prize_line[i].type == "ScatterTrans" then
			local list = xx.prize_line[i].scatter_trans
			local tmp = "Scatter trans {"
			for b=1,#list do
				local bx, by = Slot_GetCoorIndex(x, list[b])
				tmp = tmp.."("..bx..","..by..")"
				if b ~= #list then
					tmp = tmp..", "
				end
			end
			print(tmp.."} into "..xx.prize_line[i].scatter_trans_into)
		else
			print(xx.prize_line[i].type..i.."    "..xx.prize_line[i].obj_id.."    "..xx.prize_line[i].group_id.."    "..xx.prize_line[i].continue)
		end
		if xx.prize_line[i].prize ~= nil then
			for j=1,#xx.prize_line[i].prize do
				if xx.prize_line[i].extra_rate > 1 then 
					print("    "..xx.prize_line[i].prize[j].event.."    "..xx.prize_line[i].prize[j].param.." * "..rate)
				else
					print("    "..xx.prize_line[i].prize[j].event.."    "..xx.prize_line[i].prize[j].param)
				end
				if xx.prize_line[i].prize[j].event == 0 then
					prize = prize + xx.prize_line[i].prize[j].param * rate * x.bet_coin
				elseif xx.prize_line[i].prize[j].event == 3 then
					prize = prize + xx.prize_line[i].prize[j].param * rate * x.bet_total
				end
			end
		end
	end
	return prize
end


CommonFun =
{

	GetMax = function(x,y)
		if x>y then
			print("x:"..x)
		else
			print("y:"..y)
		end
	end,
	TestPrint = function(x)
		--print("x:"..x)
		CommonFun.GetMax(x,88)
	end,
	
	_GetStay = function(self, x, y)
		if self.data.stay ~= nil and self.data.stay[x] ~= nil then
			return self.data.stay[x][y]
		end	
		
		return nil
	end,
	
	_RandomOneGrid = function(pool, mutex)
		local count = #pool
		local ret_i = count
		local total = 0
		for i=1,count do
		   if not mutex[pool[i].id] then
			  total = total + pool[i].drag
		   end
		end
		local rate = GameRandEx(0, total)
		local cur_total = 0
		for i=1,count do
			if not mutex[pool[i].id] then
				cur_total = cur_total+pool[i].drag
				if rate < cur_total then
					ret_i = i
					break
				end	
			end
		end
		
		return pool[ret_i].id
	end,

	_GetListIndex = function(self, x, y)
		return (x - 1) * self.data.rolls.line_count + y
	end,

	_GetCoorIndex = function(self, list_index)
		local x = math.modf((list_index - 1) / self.data.rolls.line_count) + 1
		local y = math.fmod((list_index - 1), self.data.rolls.line_count) + 1
		return x, y
	end,

	_ObjRelation = function(self, list_index, o_res, mutex, fa_mutex)
		local x, y = CommonFun._GetCoorIndex(self, list_index)
		local r_mutex = {}
		for i=1,#r_mutex do
		   r_mutex[i]=mutex[i]
		end
		
		local uc_roll = self.data.uc.rolls[list_index]
		local rate = GameRandEx(0, uc_roll.total)
		
		local r_type = 0
		local target = 0
		local weight = 0
		
		weight = weight + uc_roll.cp_numerator
		--copy
		if rate < weight then
		   r_type = 1
		end
		weight = weight + uc_roll.col_cp_numerator
		--column copy
		if r_type == 0 and rate < weight then
		   r_type = 2
		end
		weight = weight + uc_roll.uc_mutex_numerator
		--uncopy(mutex)
		if r_type == 0 and rate < weight then
			--r_type = 3
			for i=1,#uc_roll.uncopy do
				local target = uc_roll.uncopy[i].target
				local x1, y1 = CommonFun._GetCoorIndex(self, target)
				if o_res[x1][y1] ~=nil and o_res[x1][y1] ~=0 then
					mutex[o_res[x1][y1]] = true
				end
			end
		end
		
		if r_type == 1 or r_type == 2 then
			local rand_field = {}
			local t = 0
			local relation = self.data.uc.rolls[list_index].relation
			if r_type == 2 then
			   relation = self.data.uc.rolls[list_index].columncopy
			end

			for i=1,#relation do
				--debug.log(string.format("target:%d",relation[i].target))
				local o_x, o_y = CommonFun._GetCoorIndex(self,relation[i].target)
				if o_res[o_x][o_y] ~= nil then
					t = t + relation[i].weight 
				end
				rand_field[i] = t
			end
			if t > 0 then
				rate = GameRandEx(0, t)
				for i=1,#rand_field do
					if rate < rand_field[i] then
						local o_x, o_y = CommonFun._GetCoorIndex(self, relation[i].target)
						if mutex[o_res[o_x][o_y]] then
							break
						else
							if self.data.objs[o_res[o_x][o_y]].disable_copy ~= nil and self.data.objs[o_res[o_x][o_y]].disable_copy ==1 then
							  break
							end
							if r_type == 1 then
								o_res[x][y] = o_res[o_x][o_y]
							else
								for i=1,self.data.rolls.line_count do
									o_res[x][i] = o_res[o_x][o_y]
								end
							end
							return
						end
					end
				end
			end
		end
		
		if o_res[x][y]==nil or o_res[x][y]==0 then
			local obj_id = CommonFun._RandomOneGrid(self.data.rolls.rolls[list_index], mutex)
			--debug.log(string.format("order:%d,obj_id:%d,r_type:%d,rate:%d",uc_roll.order,obj_id,r_type,rate))
			o_res[x][y] = CommonFun._RandomOneGrid(self.data.rolls.rolls[list_index], mutex)
			if self.data.objs[o_res[x][y]].mutex ~= nil then
				for i=1,#self.data.objs[o_res[x][y]].mutex do
					fa_mutex[self.data.objs[o_res[x][y]].mutex[i]] = true
				end
			end
		end
		
	end,

	_RollOneRoll = function(self, list_index, o_res, fa_mutex)
		local line_count = self.data.rolls.line_count
		
		local x, y = CommonFun._GetCoorIndex(self, list_index)
		
		-- STAY
		local stay = CommonFun._GetStay(self, x, y)
		if stay ~= nil then
			o_res[x][y] = stay
			if self.data.objs[o_res[x][y]].mutex ~= nil then
				for i=1,#self.data.objs[o_res[x][y]].mutex do
					fa_mutex[self.data.objs[o_res[x][y]].mutex[i]] = true
				end
			end
			return
		end
		
		-- 计算互斥
		local mutex = {}
		for i=1,#self.data.objs do
			if fa_mutex[self.data.objs[i].id] then
				mutex[self.data.objs[i].id] = true
			else
				mutex[self.data.objs[i].id] = false
			end
		end
		for tx = 1,self.data.rolls.roll_count do
			if o_res[tx][y]~=nil and o_res[tx][y]~=0 and self.data.objs[o_res[tx][y]].line_mutex~=nil then
				for i=1,#self.data.objs[o_res[tx][y]].line_mutex do
					mutex[self.data.objs[o_res[tx][y]].line_mutex[i]] = true
				end
			end
		end
		for ty=1,self.data.rolls.line_count do
			if o_res[x][ty]~=nil and o_res[x][ty]~=0 and self.data.objs[o_res[x][ty]].roll_mutex~=nil then
				for i=1,#self.data.objs[o_res[x][ty]].roll_mutex do
					mutex[self.data.objs[o_res[x][ty]].roll_mutex[i]] = true
				end
			end
		end	
		--是否为4x5的1024线
		if self.data.uc.uc_type ~=nil and self.data.uc.uc_type == "UC_MUTEX" then
			CommonFun._ObjRelation(self, list_index, o_res, mutex, fa_mutex)
			return 
		end
		
		-- 修正结果
		local rate = GameRandEx(0, self.data.uc.total)
		if rate >= self.data.uc.rolls[list_index].uc then
			local rand_field = {}
			local t = 0
			for i=1,#self.data.uc.rolls[list_index].relation do
				local o_x, o_y = CommonFun._GetCoorIndex(self, self.data.uc.rolls[list_index].relation[i].target)
				if o_res[o_x][o_y] ~= nil then
					t = t + self.data.uc.rolls[list_index].relation[i].weight --self.data.objs[o_res[o_x][o_y]].k *
				end
				rand_field[i] = t
			end
			if t > 0 then
				rate = GameRandEx(0, t)
				for i=1,#rand_field do
					if rate < rand_field[i] then
						local o_x, o_y = CommonFun._GetCoorIndex(self, self.data.uc.rolls[list_index].relation[i].target)
						if mutex[o_res[o_x][o_y]] then
							break
						else
							if self.data.objs[o_res[o_x][o_y]].disable_copy ~= nil and self.data.objs[o_res[o_x][o_y]].disable_copy ==1 then
							  break
							end
							o_res[x][y] = o_res[o_x][o_y]
							return
						end
					end
				end
			end
		end
		
		o_res[x][y] = CommonFun._RandomOneGrid(self.data.rolls.rolls[list_index], mutex)
		if self.data.objs[o_res[x][y]].mutex ~= nil then
			for i=1,#self.data.objs[o_res[x][y]].mutex do
				fa_mutex[self.data.objs[o_res[x][y]].mutex[i]] = true
			end
		end
		
	end,

	--同轴SLOT
	_CoaxialOneRollBySlotIndex = function(self, roll_index,slot_index, o_res)
		local roll_slot=self.data.roll_slots[roll_index].roll_slot
		local sz=#roll_slot;

		if slot_index >0 then
			local _idx=slot_index-1
			o_res[roll_index][2]=roll_slot[_idx+1].obj_id
			_idx = math.fmod(slot_index+sz-1-1,sz)
			o_res[roll_index][1]=roll_slot[_idx+1].obj_id
			_idx = math.fmod(slot_index+sz-1+1,sz)
			o_res[roll_index][3]=roll_slot[_idx+1].obj_id

		end
	end,

	_CoaxialFillResult = function(self, arr, x, y, obj_id)
		local stay = CommonFun._GetStay(self, x, y)
		if stay == nil then
			arr[x][y] = obj_id
		else
			arr[x][y] = stay
		end
	end,

	--同轴SLOT
	_CoaxialOneRoll = function(self, roll_index, o_res, border)
		local roll_slot=self.data.roll_slots[roll_index].roll_slot
		local total_drag=self.data.roll_slots[roll_index].total_drag
		local rate = GameRandEx(0, total_drag)

		local sum=0;
		local idx=0;
		local sz=#roll_slot;

		for i=1,sz do
		   if roll_slot[i].drag+sum > rate then
			   idx=i
			   break;
		   end
		  sum = sum+roll_slot[i].drag
		end
		
		local bpt = nil
		if self.data.rolls ~= nil and self.data.rolls.break_pts ~= nil then
			bpt = self.data.rolls.break_pts[self.coaxial_break]
		end

		if idx >0 then
			if bpt == nil or self.data.rolls.lines == nil or #self.data.rolls.lines < roll_index or #bpt < roll_index then
				
				local _idx=idx-1;
				CommonFun._CoaxialFillResult(self, o_res, roll_index, 2, roll_slot[_idx+1].obj_id)
				_idx = math.fmod(idx+sz-1-1,sz)
				CommonFun._CoaxialFillResult(self, o_res, roll_index, 1, roll_slot[_idx+1].obj_id)
				CommonFun._idx = math.fmod(idx+sz-1+1,sz)
				CommonFun._CoaxialFillResult(self, o_res, roll_index, 3, roll_slot[_idx+1].obj_id)
				
				_idx = math.fmod(idx+sz-1-2,sz)
				CommonFun._CoaxialFillResult(self, border, roll_index, 1, roll_slot[_idx+1].obj_id)
				_idx = math.fmod(idx+sz-1+2,sz)
				CommonFun._CoaxialFillResult(self, border, roll_index, 2, roll_slot[_idx+1].obj_id)
				
			else
				
				local _idx = (idx - 1 - bpt[roll_index]) % sz
				CommonFun._CoaxialFillResult(self, border, roll_index, 1, roll_slot[_idx+1].obj_id)
				_idx = (_idx + 1) % sz
				for i=1,self.data.rolls.lines[roll_index] do
					CommonFun._CoaxialFillResult(self, o_res, roll_index, i, roll_slot[_idx+1].obj_id)
					_idx = (_idx + 1) % sz
				end
				CommonFun._CoaxialFillResult(self, border, roll_index, 2, roll_slot[_idx+1].obj_id)
				
			end

		end
	end,

	--同轴kick out
	_CoaxialKickOutOneRoll = function(self,o_res,border)

	   local ko_weight=self.data.kick_out.roll_ko_weight;
	   local total_weight=0
	   local sum=0
	   local roll_index=0
	   for i=1,#ko_weight do
		  total_weight=total_weight+ko_weight[i]
	   end
	   local rate = GameRandEx(0, total_weight)
	   for i=1,#ko_weight do
		  if sum+ko_weight[i]> rate then 
			roll_index=i
			break;
		  end
		  sum=sum+ko_weight[i]
	   end
	   
	   if roll_index>0 then
		   CommonFun._CoaxialOneRoll(self, roll_index, o_res, border)
	   end
	   
	end,

	 --同轴老虎机
	_CoaxialRollAllRolls = function(self)
		local ret = { }
		local border = { }
		for i=1,self.data.roll_slot_info.roll_count do
			ret[i] = {}
			border[i] = {}
		end
		
		if self.data.test_result ~= nil then
			for x=1, self.data.roll_slot_info.roll_count do
				if self.data.rolls ~= nil and self.data.rolls.lines ~= nil and #self.data.rolls.lines >= x then
					for y=1,self.data.rolls.lines[x] do
						ret[x][y] = self.data.test_result[x][y]
					end
				else
					for y=1,3 do
						ret[x][y] = self.data.test_result[x][y]
					end
				end
			end
		else
		
			for i=1,self.data.roll_slot_info.roll_count do
				CommonFun._CoaxialOneRoll(self, i, ret, border)
			end
		
		end
		
		return ret,border
	end,

	_RollAllRolls = function(self)
		local ret = { }
		local fa_mutex = {}
		for i=1,self.data.rolls.roll_count do
			ret[i] = {}
		end
		for i=1,#self.data.objs do
			fa_mutex[self.data.objs[i].id] = false
		end
		
		for i=1,#self.data.uc.order do
			if self.data.test_result ~= nil then
				local x, y = CommonFun._GetCoorIndex(self, self.data.uc.order[i])
				ret[x][y] = self.data.test_result[x][y]
			else
				CommonFun._RollOneRoll(self, self.data.uc.order[i], ret, fa_mutex)
			end
		end

		return ret
	end,

	_ObjWild = function(self, obj, obj_id)
		if obj.wild == nil or #obj.wild == 0 then
			return false
		end
		if obj_id == 0 then
			return true
		end
		for i=1,#obj.wild do
			if obj.wild[i] == obj_id then
				return true
			end
		end
		return false
	end,

	_WriteObjSLPrizeInfo = function(self, prize_info, obj_id, continue, with_wild, wild_count, extra_rate)
		if obj_id > 0 and continue >= 2 and self.data.objs[obj_id]["sl_cont"..continue]~=nil and #self.data.objs[obj_id]["sl_cont"..continue] > 0 then
			prize_info.obj_id = obj_id
			prize_info.group_id = 0
			prize_info.prize = self.data.objs[obj_id]["sl_cont"..continue]
			prize_info.continue = continue
			prize_info.with_wild = with_wild
			prize_info.wild_count = wild_count
			prize_info.extra_rate = extra_rate
		end
	end,

	_WriteGroupSLPrizeInfo = function(self, prize_info, group_id, continue, with_wild, wild_count, extra_rate)
		if group_id > 0 and continue >= 2 and self.data.groups[group_id]["sl_cont"..continue]~=nil and #self.data.groups[group_id]["sl_cont"..continue] > 0 then
			prize_info.obj_id = 0
			prize_info.group_id = group_id
			prize_info.prize = self.data.groups[group_id]["sl_cont"..continue]
			prize_info.continue = continue
			prize_info.with_wild = with_wild
			prize_info.wild_count = wild_count
			prize_info.extra_rate = extra_rate
		end
	end,

	--SL
	_CheckSLWinLineObj = function(self, result, line_id, obj_id)
		local group_id = 0
		local check_group = nil
		local group_remain_count = 0
		local con_time = 0
		local with_wild = false
		local wild_count = 0
		local wild_obj = nil
		local extra_rate = 0
		
		local prize_info = {}
		prize_info.type = "sl_line"
		prize_info.obj_id = 0
		prize_info.group_id = 0
		prize_info.continue = 0
		prize_info.prize = {}
		prize_info.with_wild = false
		prize_info.wild_count = 0
		prize_info.extra_rate = 0	

		local check_type = 0
		local loop_max = 0
		local certain_roll = 0
		if self.data.win_line[line_id].line[1] <= 0 then
			check_type = 2
			loop_max = self.data.rolls.line_count
			for i=1,#self.data.win_line[line_id].line do
				if self.data.win_line[line_id].line[i] < 0 then
					certain_roll = i
					break
				end
			end
		else
			check_type = 1
			loop_max = #self.data.win_line[line_id].line
		end
		

		for i=1,loop_max do
			local idx = 0
			local obj = nil

			if check_type == 1 then
				idx = self.data.win_line[line_id].line[i]
				obj = self.data.objs[result[i][idx]]
			else
				idx = i
				obj = self.data.objs[result[certain_roll][idx]]
			end	
			if check_group == nil  or #check_group ==0 then

				if CommonFun._ObjWild(self, obj, obj_id) then
					with_wild = true
					wild_count = wild_count + 1
					con_time = con_time + 1
					if obj.extra_rate ~= nil then
						extra_rate = extra_rate + obj.extra_rate
					end
					if prize_info.continue < con_time then
						CommonFun._WriteObjSLPrizeInfo(self, prize_info, obj_id, con_time, with_wild, wild_count, extra_rate)
					end
				elseif obj_id == obj.id then
					con_time = con_time + 1
					if obj.extra_rate ~= nil then
						extra_rate = extra_rate + obj.extra_rate
					end		
					if prize_info.continue < con_time then
						CommonFun._WriteObjSLPrizeInfo(self, prize_info, obj_id, con_time, with_wild, wild_count, extra_rate)
					end
				else
					check_group = {}
					for j=1,#self.data.groups do
						local b1 = false
						local b2 = false
						check_group[j] = false
						for x=1,#self.data.groups[j].group do
							if self.data.groups[j].group[x] == obj_id then
								b1 = true
							elseif self.data.groups[j].group[x] == obj.id then
								b2 = true
							end
							if b1 and b2 then
								group_id = j
								check_group[j] = true
								group_remain_count = group_remain_count + 1
								if prize_info.continue < con_time+1 then
									CommonFun._WriteGroupSLPrizeInfo(self, prize_info, group_id, con_time + 1, with_wild, wild_count, extra_rate)
								end
								break
							end
						end
					end
					if group_remain_count > 0 then
						con_time = con_time + 1
						if obj.extra_rate ~= nil then
							extra_rate = extra_rate + obj.extra_rate
						end					
					end
				end

			else
				if not CommonFun._ObjWild(self, obj, obj_id) then
					for j=1,#self.data.groups do
						if check_group[j] then
							local bb = false
							for x=1,#self.data.groups[j].group do
								if self.data.groups[j].group[x] == obj.id then
									bb = true
									group_id = j
									if prize_info.continue < con_time then
										CommonFun._WriteGroupSLPrizeInfo(self, prize_info, group_id, con_time + 1, with_wild, wild_count, extra_rate)
									end
									break
								end
							end
							if not bb then
								check_group[j] = false
								group_remain_count = group_remain_count - 1
							end
						end
					end
				end
				if group_remain_count > 0 then
					con_time = con_time + 1
					if obj.extra_rate ~= nil then
						extra_rate = extra_rate + obj.extra_rate
					end					
				end
			end
		end
		
		
		if prize_info.continue < 2 then
			return false, nil
		else
			if prize_info.obj_id == 0 and prize_info.group_id == 0 then
				return false, nil
			end

			return true, prize_info
		end
		
	end,

	_CheckSLWinLine = function(self, result, line_id,prize_line,cur_prize_index)
		local check_type = 0
		local loop_max = 0
		local certain_roll = 0
		if self.data.win_line[line_id].line[1] <= 0 then
			check_type = 2
			loop_max = self.data.rolls.line_count
			for i=1,#self.data.win_line[line_id].line do
				if self.data.win_line[line_id].line[i] < 0 then
					certain_roll = i
					break
				end
			end
		else
			check_type = 1
			loop_max = #self.data.win_line[line_id].line
		end
		
		local line_objs={}
		local line_obj_id=0
		local ct =0
		for i=1,loop_max do
			if check_type == 1 then
				idx = self.data.win_line[line_id].line[i]
				line_obj_id = result[i][idx]
			else
				idx = i
				line_obj_id = result[certain_roll][idx]
			end	
			
			local exists = false
			for x=1,#line_objs do
				if line_objs[x] == line_obj_id then
					exists =true
					break
				end
			end
			
			if not exists then
				ct = ct + 1
				line_objs[ct] = line_obj_id
			end
		end
		
		for x=1,ct do
			local obj_id = line_objs[x]
			local checked, prize_info = CommonFun._CheckSLWinLineObj(self, result, line_id, obj_id)
			if checked and #prize_info.prize > 0 then
				prize_info.param = line_id
				prize_line[cur_prize_index] = prize_info
				cur_prize_index = cur_prize_index + 1
			end
		end
		
		return cur_prize_index
	end,

	_WriteObjPrizeInfo = function(self, prize_info, obj_id, continue, with_wild, wild_count, extra_rate)
		if obj_id > 0 and continue >= 2 and #self.data.objs[obj_id]["cont"..continue] > 0 then
			prize_info.obj_id = obj_id
			prize_info.group_id = 0
			prize_info.prize = self.data.objs[obj_id]["cont"..continue]
			prize_info.continue = continue
			prize_info.with_wild = with_wild
			prize_info.wild_count = wild_count
			prize_info.extra_rate = extra_rate
		end
	end,

	_WriteGroupPrizeInfo = function(self, prize_info, group_id, continue, with_wild, wild_count, extra_rate)
		if group_id > 0 and continue >= 2 and #self.data.groups[group_id]["cont"..continue] > 0 then
			prize_info.obj_id = 0
			prize_info.group_id = group_id
			prize_info.prize = self.data.groups[group_id]["cont"..continue]
			prize_info.continue = continue
			prize_info.with_wild = with_wild
			prize_info.wild_count = wild_count
			prize_info.extra_rate = extra_rate
		end
	end,

	_CheckWinlineType4 = function(self, result, line_id)
		local prize_info = {}
		prize_info.type = "sline"
		prize_info.obj_id = 0
		prize_info.group_id = 0
		prize_info.continue = 0
		prize_info.prize = {}
		prize_info.with_wild = false
		prize_info.wild_count = 0
		prize_info.extra_rate = 0	
		
		local obj_summ = {}
		local wild_list = {}
		for i=1,#self.data.objs do
			local obj = self.data.objs[i]
			
			obj_summ[obj.id] = 0		
			
			if obj.wild ~= nil and #obj.wild > 0 then
				wild_list[#wild_list + 1] = obj.id
			end
		end
		
		local check_type = 0
		local loop_max = 0
		local certain_roll = 0
		if self.data.win_line[line_id].line[1] <= 0 then
			check_type = 2
			loop_max = self.data.rolls.line_count
			for i=1,#self.data.win_line[line_id].line do
				if self.data.win_line[line_id].line[i] < 0 then
					certain_roll = i
					break
				end
			end
		else
			check_type = 1
			loop_max = #self.data.win_line[line_id].line
		end

		for i=1,loop_max do
			local idx = 0
			local obj = nil

			if not is_left then
				i = loop_max + 1 - i
			end

			if check_type == 1 then
				idx = self.data.win_line[line_id].line[i]
				obj = self.data.objs[result[i][idx]]
			else
				idx = i
				obj = self.data.objs[result[certain_roll][idx]]
			end	
			
			obj_summ[obj.id] = obj_summ[obj.id] + 1
		end
		
		for i=1,#self.data.objs do		
			local obj = self.data.objs[i]
			local continue = obj_summ[obj.id]
			local with_wild = false
			local wild_count = 0
			local extra_rate = 0
			if obj.extra_rate ~= nil then
				extra_rate = extra_rate + obj.extra_rate * obj_summ[obj.id]
			end
			for j=1,#wild_list do
				local wild_obj = self.data.objs[wild_list[j]]
				if CommonFun._ObjWild(self, wild_obj, obj.id) then
					with_wild = true
					wild_count = wild_count + obj_summ[wild_obj.id]
					continue = continue + obj_summ[wild_obj.id]
					if wild_obj.extra_rate ~= nil then
						extra_rate = extra_rate + wild_obj.extra_rate * obj_summ[wild_obj.id]
					end
				end
			end
			if continue > prize_info.continue then
				CommonFun._WriteObjPrizeInfo(self, prize_info, obj.id, continue, with_wild, wild_count, extra_rate)
			end
		end
		
		--if prize_info.obj_id == 0 then
			for i=1,#self.data.groups do
				local group = self.data.groups[i]
				local continue = 0
				local with_wild = false
				local wild_count = 0
				local extra_rate = 0
				local wild_check = {}
				for gi=1,#group.group do
					local obj = self.data.objs[group.group[gi]]
					continue = continue + obj_summ[obj.id]
					if obj.extra_rate ~= nil then
						extra_rate = extra_rate + obj.extra_rate * obj_summ[obj.id]
					end
					for j=1,#wild_list do
						local wild_obj = self.data.objs[wild_list[j]]
						if wild_check[wild_obj.id] == nil and CommonFun._ObjWild(self, wild_obj, obj.id) then
							with_wild = true
							wild_count = wild_count + obj_summ[wild_obj.id]
							continue = continue + obj_summ[wild_obj.id]
							if wild_obj.extra_rate ~= nil then
								extra_rate = extra_rate + wild_obj.extra_rate * obj_summ[wild_obj.id]
							end
						end
					end
				end
				if continue > prize_info.continue then
					CommonFun._WriteGroupPrizeInfo(self, prize_info, group.id, continue, with_wild, wild_count, extra_rate)
				end			
			end
		--end
		
		if prize_info.obj_id == 0 and prize_info.group_id == 0 then
			return false, nil
		end	
		
		return true, prize_info
	end,

	_CheckWinLine = function(self, result, line_id, is_left)
		local obj_id = 0
		local group_id = 0
		local check_group = nil
		local group_remain_count = 0
		local con_time = 0
		local with_wild = false
		local wild_count = 0
		local wild_obj = nil
		local extra_rate = 0
		
		local prize_info = {}
		prize_info.type = "line"
		prize_info.obj_id = 0
		prize_info.group_id = 0
		prize_info.continue = 0
		prize_info.prize = {}
		prize_info.with_wild = false
		prize_info.wild_count = 0
		prize_info.extra_rate = 0	

		local check_type = 0
		local loop_max = 0
		local certain_roll = 0
		if self.data.win_line[line_id].line[1] <= 0 then
			check_type = 2
			loop_max = self.data.rolls.line_count
			for i=1,#self.data.win_line[line_id].line do
				if self.data.win_line[line_id].line[i] < 0 then
					certain_roll = i
					break
				end
			end
		else
			check_type = 1
			loop_max = #self.data.win_line[line_id].line
		end

		for i=1,loop_max do
			local idx = 0
			local obj = nil

			if not is_left then
				i = loop_max + 1 - i
			end

			if check_type == 1 then
				idx = self.data.win_line[line_id].line[i]
				obj = self.data.objs[result[i][idx]]
			else
				idx = i
				obj = self.data.objs[result[certain_roll][idx]]
			end	
			
			if check_group == nil then
				if obj_id == 0 then
					if CommonFun._ObjWild(self, obj, obj_id) then
						with_wild = true
						wild_obj = obj
						wild_count = wild_count + 1
						con_time = con_time + 1
						if obj.extra_rate ~= nil then
							extra_rate = extra_rate + obj.extra_rate
						end										
						CommonFun._WriteObjPrizeInfo(self, prize_info, obj_id, con_time, with_wild, wild_count, extra_rate)
					else
					  local wild_obj_id = 0
					  if wild_obj ~= nil then
						 wild_obj_id = wild_obj.id
					  end
						if wild_count > 0 then
						   if CommonFun._ObjWild(self, wild_obj, obj.id) == false then
							  return false, nil
						   end
						end
						obj_id = obj.id
						con_time = con_time + 1
						if obj.extra_rate ~= nil then
							extra_rate = extra_rate + obj.extra_rate
						end					
						CommonFun._WriteObjPrizeInfo(self, prize_info, obj_id, con_time, with_wild, wild_count, extra_rate)
					end
				else
					if CommonFun._ObjWild(self, obj, obj_id) then
						with_wild = true
						wild_count = wild_count + 1
						con_time = con_time + 1
						if obj.extra_rate ~= nil then
							extra_rate = extra_rate + obj.extra_rate
						end					
						CommonFun._WriteObjPrizeInfo(self, prize_info, obj_id, con_time, with_wild, wild_count, extra_rate)
					elseif obj_id == obj.id then
						con_time = con_time + 1
						if obj.extra_rate ~= nil then
							extra_rate = extra_rate + obj.extra_rate
						end					
						CommonFun._WriteObjPrizeInfo(self, prize_info, obj_id, con_time, with_wild, wild_count, extra_rate)
					else
						check_group = {}
						for j=1,#self.data.groups do
							local b1 = false
							local b2 = false
							check_group[j] = false
							for x=1,#self.data.groups[j].group do
								if self.data.groups[j].group[x] == obj_id then
									b1 = true
								elseif self.data.groups[j].group[x] == obj.id then
									b2 = true
								end
								if b1 and b2 then
									group_id = j
									check_group[j] = true
									group_remain_count = group_remain_count + 1
									CommonFun._WriteGroupPrizeInfo(self, prize_info, group_id, con_time + 1, with_wild, wild_count, extra_rate)
									break
								end
							end
						end
						if group_remain_count == 0 then
							break
						else
							con_time = con_time + 1
							if obj.extra_rate ~= nil then
								extra_rate = extra_rate + obj.extra_rate
							end					
						end
					end
				end
			else
				local objw = CommonFun._ObjWild(self, obj, obj_id)
				
				for j=1,#self.data.groups do
					if check_group[j] then
						local bb = false
						if objw then
							bb = true
							group_id = j
							CommonFun._WriteGroupPrizeInfo(self, prize_info, group_id, con_time + 1, with_wild, wild_count, extra_rate)
						else
							for x=1,#self.data.groups[j].group do
								if self.data.groups[j].group[x] == obj.id then
									bb = true
									group_id = j
									CommonFun._WriteGroupPrizeInfo(self, prize_info, group_id, con_time + 1, with_wild, wild_count, extra_rate)
									break
								end
							end
						end
						if not bb then
							check_group[j] = false
							group_remain_count = group_remain_count - 1
						end
					end
				end
					
				if group_remain_count > 0 then
					con_time = con_time + 1
					if obj.extra_rate ~= nil then
						extra_rate = extra_rate + obj.extra_rate
					end					
				else
					break
				end
			end
		end
		
		if con_time < 2 then
			return false, nil
		else
			if prize_info.obj_id == 0 and prize_info.group_id == 0 then
				return false, nil
			end

			return true, prize_info
		end
	end,

	_CheckScatter = function(self, result, obj_id)
		local obj = self.data.objs[obj_id]
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
			for sci=1,tmp_count do
				if obj.scatterxn[sci] ~= nil and #obj.scatterxn[sci] > 0 then
					scatter_prize = obj.scatterxn[sci]
					scatter_count = sci + 5
				end
			end
			if scatter_prize == nil then
				return nil
			end
		else
			if obj.scatterxn == nil and scatter_count > 5 then
				scatter_count = 5
			end
			if obj.scatter["cont"..scatter_count] ~= nil and #obj.scatter["cont"..scatter_count] > 0 then
				scatter_prize = obj.scatter["cont"..scatter_count]
			elseif obj.scatter["range"..scatter_count] ~= nil and #obj.scatter["range"..scatter_count] > 0 then
				scatter_prize = CopyTable(obj.scatter["range"..scatter_count])
				for x=1,#scatter_prize do
					scatter_prize[x].param = GameRandEx(scatter_prize[x].param.low, scatter_prize[x].param.high + 1)
				end
			else
				return nil
			end
			
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
	end,

	_CheckGroupScatterCount = function(self, result, group_id)
		local group_obj = self.data.groups[group_id]
		if group_obj.scatter_cnt == nil or #group_obj.scatter_cnt==0 then
			return nil
		end
		
		local group_obj_id = 0
		local rlt_cnt={}
		local scatter_count = 0
		for i=1,#result do
			for j=1,#result[i] do
				for k=1,#group_obj.group do
				  local obj_id = group_obj.group[k]
				  if result[i][j] == obj_id then
					  local obj = self.data.objs[obj_id]
					  scatter_count = scatter_count + 1
					  rlt_cnt[scatter_count] ={}
					  rlt_cnt[scatter_count].index = CommonFun._GetListIndex(self,i,j)
					  rlt_cnt[scatter_count].prize = 0
					  
					  if group_obj_id == 0 then 
						 group_obj_id = obj_id
					  end
					  
					  if obj.scatter_box.flag and obj.scatter_box.denominator>0 then 
						 local rate = GameRandEx(obj.scatter_box.low, obj.scatter_box.high)
						 local times = rate/obj.scatter_box.denominator
						 local cnt = group_obj.scatter_cnt[1]
						 if cnt.event == 3 then
							rlt_cnt[scatter_count].prize = times * self.bet_line
						 else
							rlt_cnt[scatter_count].prize = times
						 end

					  end
					  
				  end
				end
			end
		end
		
		local flag = false
		for i=1,#group_obj.scatter_cnt do
		   local cnt = group_obj.scatter_cnt[i]
		   if cnt.count <= scatter_count then
			   flag = true
			   break
		   end
		end
		if not flag then
		   return nil
		end
		
		local prize_info = {}
		prize_info.type = "GroupScatterCount"
		prize_info.obj_id = group_obj_id
		prize_info.group_id = group_id
		prize_info.continue = scatter_count
		prize_info.with_wild = false
		prize_info.prize = {}
		prize_info.group_scatter_cnt = rlt_cnt
		prize_info.extra_rate = 0
		
		
		return prize_info
		
	end,

	_CheckObjScatterCount = function(self, result, obj_id)
		local obj = self.data.objs[obj_id]
		if obj.scatter_cnt == nil or #obj.scatter_cnt == 0 then
			return nil
		end
		
		local rlt_cnt = {}
		local scatter_count = 0
		for i=1,#result do
			for j=1,#result[i] do
				if result[i][j] == obj_id then
					scatter_count = scatter_count + 1
					rlt_cnt[scatter_count] = {}
					rlt_cnt[scatter_count].index = CommonFun._GetListIndex(self, i, j)
					rlt_cnt[scatter_count].prize = 0
					
					if obj.scatter_box.flag and obj.scatter_box.denominator > 0 then
						local rate = GameRandEx(obj.scatter_box.low, obj.scatter_box.high)
						rlt_cnt[scatter_count].prize = rate / obj.scatter_box.denominator
					end
				end
			end
		end
		
		local flag = 0
		local max_count = 0
		for i=1,#obj.scatter_cnt do
			local cnt = obj.scatter_cnt[i]
			if cnt.count <= scatter_count and cnt.count > max_count then
				flag = i
				max_count = cnt.count
			end
		end
		if flag <= 0 then
			return nil
		end
		
		local prize_info = {}
		prize_info.type = "ScatterCount"
		prize_info.obj_id = obj_id
		prize_info.group_id = 0
		prize_info.continue = scatter_count
		prize_info.with_wild = false
		prize_info.prize = {}
		prize_info.scatter_cnt = rlt_cnt
		prize_info.scatter_cnt.event = obj.scatter_cnt[flag].event
		prize_info.extra_rate = 0	
		
		return prize_info
	end,

	_CheckCount = function(self, result, obj_id)
		local obj = self.data.objs[obj_id]
		if obj.count == nil or not obj.count.flag then
			return nil
		end
			
		local count_count = 0
		for i=1,#result do
			for j=1,#result[i] do
				if result[i][j] == obj_id then
					count_count = count_count + 1
				end
			end
		end
		if count_count > 5 then
			count_count = 5
		end
		
		if obj.count["cont"..count_count] == nil or #obj.count["cont"..count_count] <= 0 then
			return nil
		end
		
		local prize_info = {}
		prize_info.type = "Count"
		prize_info.obj_id = obj.id
		prize_info.group_id = 0
		prize_info.continue = count_count
		prize_info.with_wild = false
		prize_info.prize = obj.count["cont"..count_count]
		prize_info.extra_rate = 0
		if obj.extra_rate ~= nil then
			prize_info.extra_rate = obj.extra_rate * count_count	
		else
			prize_info.extra_rate = 0
		end	
		
		return prize_info
	end,

	_CheckWild = function(self, result, line_id, is_left)
		local group_id = 0
		local check_group = nil
		local group_remain_count = 0
		local con_time = 0
		local with_wild = false
		local wild_count = 0
		local extra_rate = 0
		
		local prize_info = {}
		prize_info.type = "line"
		prize_info.obj_id = 0
		prize_info.group_id = 0
		prize_info.continue = 0
		prize_info.prize = {}
		prize_info.with_wild = false
		prize_info.wild_count = 0	
		prize_info.extra_rate = 0

		local check_type = 0
		local loop_max = 0
		local certain_roll = 0
		if self.data.win_line[line_id].line[1] <= 0 then
			check_type = 2
			loop_max = self.data.rolls.line_count
			for i=1,#self.data.win_line[line_id].line do
				if self.data.win_line[line_id].line[i] < 0 then
					certain_roll = i
					break
				end
			end
		else
			check_type = 1
			loop_max = #self.data.win_line[line_id].line
		end

		for i=1,loop_max do
			local idx = 0
			local obj = nil

			if not is_left then
				i = loop_max + 1 - i
			end

			if check_type == 1 then
				idx = self.data.win_line[line_id].line[i]
				obj = self.data.objs[result[i][idx]]
			else
				idx = i
				obj = self.data.objs[result[certain_roll][idx]]
			end		
		
			if CommonFun._ObjWild(self, obj, 0) then
				with_wild = true
				wild_count = wild_count + 1
				con_time = con_time + 1
				if obj.extra_rate ~= nil then
					extra_rate = extra_rate + obj.extra_rate
				end			
				CommonFun._WriteObjPrizeInfo(self, prize_info, obj.id, con_time, with_wild, wild_count, extra_rate)
			else
				break
			end
		end
		
		if con_time < 2 then
			return false, nil
		else
			if prize_info.obj_id == 0 then
				return false, nil
			end

			return true, prize_info
		end
	end,

	_WriteObjFullPrize = function(self, prize_info, obj_id, wild_count, extra_rate)
		if #self.data.objs[obj_id]["full"] > 0 then
			prize_info.obj_id = obj_id
			prize_info.group_id = 0
			prize_info.prize = self.data.objs[obj_id]["full"]
			prize_info.continue = wild_count
			prize_info.with_wild = wild_count > 0
			prize_info.wild_count = wild_count
			prize_info.extra_rate = extra_rate
		end
	end,

	_WriteGroupFullPrize = function (self, prize_info, group_id, wild_count, extra_rate)
		if #self.data.groups[group_id]["full"] > 0 then
			prize_info.obj_id = 0
			prize_info.group_id = group_id
			prize_info.prize = self.data.groups[group_id]["full"]
			prize_info.continue = wild_count
			prize_info.with_wild = wild_count > 0
			prize_info.wild_count = wild_count
			prize_info.extra_rate = extra_rate
		end
	end,

	_CheckFull = function(self, result)
		local obj_id = 0
		local group_id = 0
		local check_group = nil
		local group_remain_count = 0
		local wild_count = 0
		local wild_obj = nil
		local extra_rate = 0
		
		local prize_info = {}
		prize_info.type = "Full"
		prize_info.obj_id = 0
		prize_info.group_id = 0
		prize_info.continue = 0
		prize_info.prize = {}
		prize_info.with_wild = false
		prize_info.wild_count = 0	
		prize_info.extra_rate = 0
		
		for i=1,#result do
			for j=1,#result[i] do
				local obj = self.data.objs[result[i][j]]
				if check_group == nil then
					if CommonFun._ObjWild(self, obj, obj_id) then
						wild_obj = obj
						wild_count = wild_count + 1
						if obj.extra_rate ~= nil then
							--extra_rate = extra_rate + obj.extra_rate
						end
						local id = obj.id
						if obj_id > 0 then
						   id = obj_id
						end 					
						CommonFun._WriteObjFullPrize(self, prize_info, id, wild_count, extra_rate)
					elseif obj_id == 0 then
						obj_id = obj.id
						if wild_count > 0 then
						   if CommonFun._ObjWild(self, wild_obj, obj.id) == false then
							  return  nil
						   end
						end
						if obj.extra_rate ~= nil then
							extra_rate = extra_rate + obj.extra_rate
						end					
						CommonFun._WriteObjFullPrize(self, prize_info, obj.id, wild_count, extra_rate)
					elseif obj_id ~= obj.id then
						check_group = {}
						for j=1,#self.data.groups do
							local b1 = false
							local b2 = false
							check_group[j] = false
							for x=1,#self.data.groups[j].group do
								if self.data.groups[j].group[x] == obj_id then
									b1 = true
								elseif self.data.groups[j].group[x] == obj.id then
									b2 = true
								end
								if b1 and b2 then
									group_id = j
									check_group[j] = true
									group_remain_count = group_remain_count + 1
									wild_count = wild_count + 1
									CommonFun._WriteGroupFullPrize(self, prize_info, group_id, wild_count, extra_rate)
									break
								end
							end
						end
						if group_remain_count == 0 then
							return nil
						else
							if obj.extra_rate ~= nil then
								extra_rate = extra_rate + obj.extra_rate
							end					
						end
					end
				else
					local isWild = true
					if not CommonFun._ObjWild(self, obj, obj_id) then
						for j=1,#self.data.groups do
							if check_group[j] then
								local bb = false
								for x=1,#self.data.groups[j].group do
									if self.data.groups[j].group[x] == obj.id then
										bb = true
										group_id = j
										CommonFun._WriteGroupFullPrize(self, prize_info, group_id, wild_count+1, extra_rate)
										break
									end
								end
								if not bb then
									check_group[j] = false
									group_remain_count = group_remain_count - 1
								end
							end
						end
						isWild = false;
					end
					if group_remain_count > 0 then
						wild_count = wild_count + 1
						if obj.extra_rate ~= nil and not isWild then
							extra_rate = extra_rate + obj.extra_rate
						end					
					else
						return nil
					end
				end
				
			end
		end
		
		return prize_info
	end,

	_WriteObjFullLinePrize = function(self, prize_info, obj_id, continue, with_wild, wild_count, extra_rate, lines_count)
		if obj_id > 0 and continue >= 2 and #self.data.objs[obj_id]["cont"..continue] > 0 then
			prize_info.obj_id = obj_id
			prize_info.group_id = 0
			prize_info.prize = self.data.objs[obj_id]["cont"..continue]
			prize_info.continue = continue
			prize_info.with_wild = with_wild
			prize_info.wild_count = wild_count
			prize_info.extra_rate = extra_rate
			prize_info.lines_count = lines_count
		end
	end,

	_WriteGroupFullLinePrize = function(self, prize_info, group_id, continue, with_wild, wild_count, extra_rate, lines_count)
		if group_id > 0 and continue >= 2 and #self.data.groups[group_id]["cont"..continue] > 0 then
			prize_info.obj_id = 0
			prize_info.group_id = group_id
			prize_info.prize = self.data.groups[group_id]["cont"..continue]
			prize_info.continue = continue
			prize_info.with_wild = with_wild
			prize_info.wild_count = wild_count
			prize_info.extra_rate = extra_rate
			prize_info.lines_count = lines_count
		end
	end,

	_CheckObjFullLine = function (self, result, obj_id)
		local con_time = 0
		local with_wild = false
		local wild_count = 0
		local wild_obj = nil
		local lines_count = 1
		local extra_rate = 0
		
		local prize_info = {}
		prize_info.type = "FullLine"
		prize_info.obj_id = 0
		prize_info.group_id = 0
		prize_info.continue = 0
		prize_info.prize = {}
		prize_info.with_wild = false
		prize_info.wild_count = 0	
		prize_info.extra_rate = 0
		prize_info.lines_count = 0
		
		local has_obj_self = false
		
		for i=1,#result do									
			local count_pl = 0
			for idx=1,#result[i] do
				local obj = self.data.objs[result[i][idx]]		
				local bingo = false			
				
				if CommonFun._ObjWild(self, obj, obj_id) then
					with_wild = true
					wild_count = wild_count + 1
					count_pl = count_pl + 1
					bingo = true
				elseif obj.id == obj_id then
					has_obj_self = true
					count_pl = count_pl + 1
					bingo = true
				end
				
				if bingo and obj.extra_rate ~= nil then
					extra_rate = extra_rate + obj.extra_rate
				end
			end
			
			if count_pl > 0 then
				con_time = con_time + 1
				lines_count = lines_count * count_pl
				CommonFun._WriteObjFullLinePrize(self, prize_info, obj_id, con_time, with_wild, wild_count, extra_rate, lines_count)
			else
				break
			end
		end
		
		if not has_obj_self or con_time < 2 then
			return false, nil
		else
			if prize_info.obj_id == 0 and prize_info.group_id == 0 then
				return false, nil
			end

			return true, prize_info
		end
	end,

	_CheckGroupFullLine = function(self, result, group_id)
		local con_time = 0;
		local with_wild = false
		local wild_count = 0
		local wild_obj = nil
		local lines_count = 1
		local extra_rate = 0

		local prize_info = {}
		prize_info.type = "FullLine"
		prize_info.obj_id = 0
		prize_info.group_id = 0
		prize_info.continue = 0
		prize_info.prize = {}
		prize_info.with_wild = false
		prize_info.wild_count = 0	
		prize_info.extra_rate = 0
		prize_info.lines_count = 0
		
		local roll_pl = {}
		for x=1,#result do
			roll_pl[x] = {}
			roll_pl[x].check = {}
			for y=1,#result[x] do
				roll_pl[x].check[y] = false
			end
		end
		
		local group = self.data.groups[group_id]
		for gi=1,#group.group do
			local obj_id = group.group[gi]
			
			for x=1,#result do
				for y=1,#result[x] do
					local obj = self.data.objs[result[x][y]]
									
					if CommonFun._ObjWild(self, obj, obj_id) or obj.id == obj_id then
						roll_pl[x].check[y] = true
					end
				end			
			end
		end

		local has_obj_self = false
		for x=1,#result do
			local count_pl = 0
			for y=1,#result[x] do
				local obj = self.data.objs[result[x][y]]		
				local bingo = roll_pl[x].check[y]
				
				if bingo then
					if obj.wild == nil or #obj.wild == 0 then
						has_obj_self = true
					else
						with_wild = true
						wild_count = wild_count + 1	
					end
					count_pl = count_pl + 1
					if obj.extra_rate ~= nil then
						extra_rate = extra_rate + obj.extra_rate
					end
				end
			end
			
			if count_pl > 0 then
				con_time = con_time + 1
				lines_count = lines_count * count_pl
				CommonFun._WriteGroupFullLinePrize(self, prize_info, group_id, con_time, with_wild, wild_count, extra_rate, lines_count)
			else
				break
			end
		end		

		if not has_obj_self or con_time < 2 then
			return false, nil
		else
			if prize_info.obj_id == 0 and prize_info.group_id == 0 then
				return false, nil
			end

			return true, prize_info
		end

	end,

	_GetPrizeFullLine = function(self, result, prize_line, cur_prize_index)
		local obj_prize = {}
			
		for index=1,#self.data.objs do
			local obj_id = self.data.objs[index].id
			
			local checked, prize_info = CommonFun._CheckObjFullLine(self, result, obj_id)
			if checked and #prize_info.prize > 0 then
				obj_prize[obj_id] = prize_info	
			end
		end
		
		for index=1,#self.data.groups do
			local group_id = self.data.groups[index].id

			local checked, prize_info = CommonFun._CheckGroupFullLine(self, result, group_id)
			if checked and #prize_info.prize > 0 then
				for ii=1,#self.data.groups[index].group do
					if obj_prize[self.data.groups[index].group[ii]] ~= nil and prize_info.continue <= obj_prize[self.data.groups[index].group[ii]].continue then
						checked = false
						break
					end
				end
			end
			
			if checked and #prize_info.prize > 0 then
				prize_line[cur_prize_index] = prize_info
				cur_prize_index = cur_prize_index + 1
				for ii=1,#self.data.groups[index].group do
					obj_prize[self.data.groups[index].group[ii]] = nil
				end
			end
		end
		
		for i=1,#self.data.objs do
			if obj_prize[i] ~= nil then
				prize_line[cur_prize_index] = obj_prize[i]
				cur_prize_index = cur_prize_index + 1
			end
		end
		
		return prize_line, cur_prize_index
	end,

	_GetPrizeWinLine = function(self, result, prize_line, cur_prize_index)
		for x=1,self.bet_line do
			local both_way = true
			
			if self.data.win_line[x].line_type == 1 or self.data.win_line[x].line_type == 3 then
				local checked, prize_info = CommonFun._CheckWinLine(self, result, x, true)
				if checked and #prize_info.prize > 0 then
					prize_info.param = x
					prize_line[cur_prize_index] = prize_info
					cur_prize_index = cur_prize_index + 1
					
					if self.data.rolls ~=nil and prize_info.continue == self.data.rolls.roll_count then
					   both_way = false
					elseif self.data.roll_slot_info ~=nil and prize_info.continue == self.data.roll_slot_info.roll_count then
					   both_way = false
					end
				end
			end
			
			if both_way and (self.data.win_line[x].line_type == 2 or self.data.win_line[x].line_type == 3) then
				local checked, prize_info = CommonFun._CheckWinLine(self, result, x, false)
				if checked and #prize_info.prize > 0 then
					prize_info.param = -x
					prize_line[cur_prize_index] = prize_info
					cur_prize_index = cur_prize_index + 1
				end
			end
			
			if self.data.win_line[x].line_type == 4 then
				local checked, prize_info = CommonFun._CheckWinlineType4(self, result, x)
				if checked and #prize_info.prize > 0 then
					prize_info.param = x
					prize_line[cur_prize_index] = prize_info
					cur_prize_index = cur_prize_index + 1
				end
			end
			
			both_way = true
			
			if self.data.win_line[x].line_type == 1 or self.data.win_line[x].line_type == 3 then
				local checked, prize_info = CommonFun._CheckWild(self, result, x, true)
				if checked and #prize_info.prize > 0 then
					prize_info.param = x
					prize_line[cur_prize_index] = prize_info
					cur_prize_index = cur_prize_index + 1
					
					both_way = false
				end
			end

			if both_way and (self.data.win_line[x].line_type == 2 or self.data.win_line[x].line_type == 3) then
				local checked, prize_info = CommonFun._CheckWild(self, result, x, false)
				if checked and #prize_info.prize > 0 then
					prize_info.param = -x
					prize_line[cur_prize_index] = prize_info
					cur_prize_index = cur_prize_index + 1
				end
			end
			
			--SL不连续的奖励线
			if self.data.win_line[x].line_type > 0 then
				cur_prize_index = CommonFun._CheckSLWinLine(self, result, x, prize_line,cur_prize_index)
			end
		end
			
		return prize_line, cur_prize_index
	end,

	_GetPrizeTotal = function(self, result)
		local prize_line = {}
		local cur_prize_index = 1
		
		if self.data.win_line == nil then
			prize_line, cur_prize_index = CommonFun._GetPrizeFullLine(self, result, prize_line, cur_prize_index)
		else
			prize_line, cur_prize_index = CommonFun._GetPrizeWinLine(self, result, prize_line, cur_prize_index)
		end
		
		for x=1,#self.data.objs do
			local prize_info = CommonFun._CheckScatter(self, result, self.data.objs[x].id)
			if prize_info ~=nil then			
				prize_line[cur_prize_index] = prize_info
				cur_prize_index = cur_prize_index + 1
			end
		end
		
		for x=1,#self.data.objs do
			local prize_info = CommonFun._CheckCount(self, result, self.data.objs[x].id)
			if prize_info ~=nil then			
				prize_line[cur_prize_index] = prize_info
				cur_prize_index = cur_prize_index + 1
			end
		end
		
		if self.data.is_fa then
			local prize_info = CommonFun._CheckFull(self, result)
			if prize_info ~= nil then
				prize_line[cur_prize_index] = prize_info
				cur_prize_index = cur_prize_index + 1
			end
		end
		
		--check group scatter cnt
		local chk_mask={}
		for x=1,#self.data.groups do
			local prize_info = CommonFun._CheckGroupScatterCount(self, result, self.data.groups[x].id)
			if prize_info ~=nil then			
				prize_line[cur_prize_index] = prize_info
				cur_prize_index = cur_prize_index + 1
			end
		end
		for x=1,#self.data.objs do
			local prize_info = CommonFun._CheckObjScatterCount(self, result, self.data.objs[x].id)
			if prize_info ~= nil then
				prize_line[cur_prize_index] = prize_info
				cur_prize_index = cur_prize_index + 1
			end
		end
			
		return prize_line
	end,

	_CalcTotalPrize = function(self, prize_line)
		local total = 0
		local prize_den = 1
		if  self.data.prize_den ~= nil then
			prize_den = self.data.prize_den
		end
		for i=1,#prize_line do
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
					total = total + prize_line[i].prize[j].param * extra_rate * self.bet_total / prize_den
				end
			end
		end
		return total
	end,

	--同轴SLOT的Scatter奖励处理
	_CalcTotalPrizeByCoaxial = function(self, prize_line)
		local total = 0
		local prize_den = 1
		if  self.data.prize_den ~= nil then
			prize_den = self.data.prize_den
		end
		for i=1,#prize_line do
			for j=1,#prize_line[i].prize do
				local tmp = 0
				if prize_line[i].prize[j].event == 0 then
					if prize_line[i].type == "Scatter" and prize_line[i].prize[j].param ~= nil and type(prize_line[i].prize[j].param) == "table" then
						local left = prize_line[i].prize[j].param[1];
						local right = prize_line[i].prize[j].param[2];
						local rate = GameRandEx(left, right)
						local val = rate;
						total = total + val * prize_line[i].extra_rate * self.bet_coin / prize_den
					else
						local extra_rate = prize_line[i].extra_rate
						if extra_rate < 1 then
						   extra_rate = 1
						end
						total = total + prize_line[i].prize[j].param * extra_rate * self.bet_coin / prize_den
					end
				elseif prize_line[i].prize[j].event == 3 then
					local extra_rate = prize_line[i].extra_rate
					if extra_rate < 1 then
					   extra_rate = 1
					end
					total = total + prize_line[i].prize[j].param * extra_rate * self.bet_total / prize_den
				end
			end
		end
		return total
	end,

	_TryKickOut = function(self, prize)
		local tmp = 0
		local max_key = 0
		local multi_p = prize / self.bet_total
		for i=1,#self.data.kick_out.multiple do
			local key_val = self.data.kick_out.multiple[i].key_val
			if multi_p > key_val and key_val > max_key then
				tmp = i
				max_key = key_val
			end
		end
		if tmp > 0 then
			local rate = GameRandEx(0, self.data.kick_out.total)
			if rate < self.data.kick_out.multiple[tmp].weight then
				return true
			end
		end
		
		tmp = 0
		max_key = 0
		local quota_p = prize
		for i=1,#self.data.kick_out.quota do
			local key_val = self.data.kick_out.quota[i].key_val
			if quota_p > key_val and key_val > max_key then
				tmp = i
				max_key = key_val
			end
		end
		if tmp > 0 then
			local rate = GameRandEx(0, self.data.kick_out.total)
			if rate < self.data.kick_out.quota[tmp].weight then
				return true
			end
		end
		
		return false
	end,

	_RollSA = function(self, objs)
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
	end,

	_GetSAObjID = function(self, sa_obj)
		if sa_obj.obj_id == 0 then
			local group = self.data.groups[sa_obj.group_id]
			local index = GameRandEx(1, #group.group+1)
			if group.group[index] == nil then
				return group.group[#group.group]
			end
			return group.group[index]
		else
			return sa_obj.obj_id
		end
	end,

	_TrySpecialAward = function(self)
		local sa_index = 0
		for i=1,#self.data.sa.items do
			local rt = GameRandEx(0, self.data.sa.total)
			if rt < self.data.sa.items[i].rate then
				sa_index = i
				break
			end
		end

		if sa_index > 0 and #self.data.sa.items[sa_index].objs > 0 then
			local ret = { }
			for i=1,self.data.rolls.roll_count do
				ret[i] = {}
			end
			local fa_mutex = {}
			for i=1,#self.data.objs do
				fa_mutex[self.data.objs[i].id] = false
			end

			local sa_obj = CommonFun._RollSA(self, self.data.sa.items[sa_index].objs)	
			for i=1,#self.data.uc.order do
				local x, y = CommonFun._GetCoorIndex(self, self.data.uc.order[i])
				local rr = GameRandEx(0, 100)
				if rr < self.data.sa.items[sa_index].arr_rate[x][y] then
					ret[x][y] = CommonFun._GetSAObjID(self, sa_obj)
					if self.data.objs[ret[x][y]].mutex ~= nil then
						for i=1,#self.data.objs[ret[x][y]].mutex do
							fa_mutex[self.data.objs[ret[x][y]].mutex[i]] = true
						end
					end
				else
					CommonFun._RollOneRoll(self, self.data.uc.order[i], ret, fa_mutex)
				end			
			end
			
			return ret	
		else
			return nil
		end
	end,


}



