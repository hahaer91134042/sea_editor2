--[[
	�ϻ���3300��Ϸ�߼��ű������Ӧ���ݽű����ʹ��
]]--
local debug = require("Debug")
SceneSlotMachine_MahJongWays = 
{
	data = {},
	related_data = {},
	bet_coin = 0,
	bet_total = 0,
	
	SlotOnce = nil;
	FreeSpin = nil;
	Start = nil;
}

local function _Slot_Top(self)
	local ret = {}
	self.related_data.objs =	self.data.objs

		local resultTop = Slot_RollMatrix(self)
		for x, value in ipairs(resultTop) do			
			ret[x] = value[4]
		end
	return ret
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

local function _TryKickOut(kick_out, bet_total, prize)
	local tmp = 0
	local max_key = 0
	local multi_p = prize / bet_total

	for i=1,#kick_out.multiple do
		local key_val = kick_out.multiple[i].key_val
		if multi_p > key_val and key_val > max_key then
			tmp = i
			max_key = key_val
		end
	end
	if tmp > 0 then
		local rate = GameRandEx(0, kick_out.total)
		if rate < kick_out.multiple[tmp].weight then
			return true
		end
	end
	
	tmp = 0
	max_key = 0
	local quota_p = prize
	for i=1,#kick_out.quota do
		local key_val = kick_out.quota[i].key_val
		if quota_p > key_val and key_val > max_key then
			tmp = i
			max_key = key_val
		end
	end
	if tmp > 0 then
		local rate = GameRandEx(0, kick_out.total)
		if rate < kick_out.quota[tmp].weight then
			return true
		end
	end
	
	return false
end

function SceneSlotMachine_MahJongWays:SlotOnce()
	local x = MiniGameRock_MJ
	x.related_data = self.data	--OBJS
	x.data = self.data
	x.bet_coin = self.bet_coin
	x.bet_total = self.bet_total
	x.bet_line = -1
	x.cheated = self.cheated

	x.cheated = false 
	x.related_data.test_result = {
		{5,6,6,6},
		{5,2,4,5},
		{5,6,4,5},
		{5,9,2,5},	
		 {7,2,4,9},	
	}

	return x:Start()
end

function SceneSlotMachine_MahJongWays:FreeSpin()
	local x = MiniGameRock_MJ
	x.related_data = self.data	--OBJS
	x.data = self.related_data
	x.bet_coin = self.bet_coin
	x.bet_total = self.bet_total
	x.bet_line = -1
	
	return x:Start()
end

function _Run_FreeSpin(self, life)
	local ret = {}
	local total = 0
	
	while life > 0 do
		local o_ret = {}
		local prize
		o_ret, prize = self.FreeSpin(self)
		total = total + prize
		for i = 1, #o_ret do
			o_ret[i].FreeSpin = life.."."..#o_ret + 1 - i
			table.insert(ret, o_ret[i])			
		end		
		
		--print ("win :".. total .. prize)

		-- Retrigger
		if #ret[#ret].prize_line ~= 0 then
			life = life + ret[#ret].prize_line[1].prize[1].param
			--print ( life, ret[#ret].prize_line[1].prize[1].param)
			--debug.dump (o_ret[#o_ret], "o_ret ", 10)
		end				
		life = life - 1
	end	
	return ret, total
end

function SceneSlotMachine_MahJongWays:Start()
--[[
	local seed = GameRandEx (0, 99999999)
	seed = 28239450
	GameSeed (seed) --FS
	print ("MahjongWays  \t\tseed: "..seed )
	]]

	-- Main 
	local ret, prize = self.SlotOnce (self)

	local kick_count = 0
	while(_TryKickOut(self.data.kick_out, self.bet_total, prize)) do
		ret, prize = self.SlotOnce (self)
		
		kick_count = kick_count + 1
		--超过10次将放弃
		if kick_count >= 10 then
		   --debug.log(string.format("kick_count:%d",kick_count));
		   break
		end
	end 	

		-- FreeSpin
	if true then
		if #ret[#ret].prize_line ~= 0 then
			local life = ret[#ret].prize_line[1].prize[1].param
			--print ("life : %u\n", life)
			local o_ret
			local prize
			o_ret, prize = _Run_FreeSpin (self, life)

			local kick_count = 0
			while(_TryKickOut(self.related_data.kick_out, self.bet_total, prize)) do
				o_ret, prize = _Run_FreeSpin (self, life)				
				
				kick_count = kick_count + 1
				--超过10次将放弃
				if kick_count >= 10 then
					--debug.log(string.format("kick_count:%d",kick_count));
					break
				end
			end
			-- copy
			for i = 1, #o_ret do
				o_ret[i].FreeSpin = life.."."..#o_ret + 1 - i
				table.insert(ret, o_ret[i])			
			end	
		end				
	else	
	end	
		return _ChangeResultTable (self, ret)	
end	

