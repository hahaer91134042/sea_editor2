--
package.path = package.path .. ';..\\data\\lua\\?.lua' .. ';..\\?.lua'
package.path = package.path .. ';..\\data\\lua\\scene\\?.lua' .. ';..\\data\\lua\\battle\\?.lua' 
package.path = package.path .. ';..\\data\\lua\\roulette\\?.lua'..';..\\data\\lua\\slot_machine\\?.lua'
package.path = package.path .. ';..\\data\\lua\\mahjong\\?.lua'
package.path = package.path .. ';..\\data\\lua\\AI\\?.lua'
package.path = package.path .. ';..\\data\\lua\\AI\\Mahjong\\?.lua'

function CopyTable(tbl)
	local inst = {}
	for k,v in pairs(tbl) do
		local vty = type(v)
		if(vty == "table") then
			inst[k] = CopyTable(v)
		else
			inst[k] = v
		end
	end
	return inst;
end

function RemoveItem(list, item, removeAll)
    local rmCount = 0
    for i = 1, #list do
        if list[i - rmCount] == item then
            table.remove(list, i - rmCount)
            if removeAll then
                rmCount = rmCount + 1
            else
                break
            end
        end
    end
end

function RandomSeed(seed)
	math.randomseed(seed)
end

-- 封装随机函数api

-- 随机函数在多线程中使用
--[[
考虑到多线程的安全性，采用创建随机对象、设置随机种子、获取随机数值的形式
1. 声明随机对象 local x = lxBlitzppRand()
2. 设置随机种子 x:Seed(tostring(os.time()):reverse():sub(1, 6))
3. 获取随机值 x:RandEx(1,100)

lxBlitzppRand.Seed(seed) 设置随机种子
lxBlitzppRand.Rand() 获取随机值 [0,1)
lxBlitzppRand.RandEx(start,end_) 获取随机值 [start, end_) 这里 start,end_为整数
]]

-- 如果false则调用lua默认random，方便调试
local _USE_BLITZ = false

local blitzpp = nil
if(_USE_BLITZ) then
	blitzpp = lxBlitzppRand()

	-- 默认随机种子
	blitzpp:Seed(tostring(os.time()):reverse():sub(1, 6))
else
	math.randomseed(tostring(os.time()):reverse():sub(1, 6))
end

-- 随机种子
function GameSeed(seed)
	if(_USE_BLITZ) then
		blitzpp:Seed(seed)
	else
		math.randomseed(seed)
	end
end

-- 取值范围： 浮点数 [0,1)
function GameRand()
	if(_USE_BLITZ) then
		return blitzpp:Rand()
	else
		return math.random()
	end
end

-- start: 包括;
-- end__: 不包括 
-- 取值范围：整数 [start, end_)
function GameRandEx(start,end_)
	if(_USE_BLITZ) then
		return blitzpp:RandEx(start,end_)
	else
		if start >= end_ - 1 then
			return start
		else
			return math.random(start,end_-1)
		end
			
	end
end

-- 多线程随机种子 tid：线程id
function RandSeed(tid)
	blitzpp:Seed(tostring(os.time()+tid):reverse():sub(1, 6)) 
end


------------------------------------- 位运算函数 ---------------------------------------
--[[
@brief	位或运算,相当于a|b
]]--
function BitOR(a,b)
	local p,c = 1,0
	while a+b>0 do
		local ra,rb = a%2,b%2
		if ra + rb > 0 then 
			c = c + p 
		end
		a,b,p=(a-ra)/2,(b-rb)/2,p*2
	end
	
	return c
end

--[[
@brief	位非运算,相当于!n
]]--
function BitNOT(n)
	local p,c = 1,0
	while n>0 do
		local r=n%2
		if r<1 then c = c+p end
		n,p = (n-r)/2, p*2
	end
	return c
end

--[[
@brief	位与运算,相当于a&b
]]--
function BitAND(a, b)
	local p,c=1,0
	while a>0 and b>0 do
		local ra,rb = a%2,b%2
		if ra>0 and rb>0 then c = c + p end
		a,b,p=(a-ra)/2, (b-rb)/2, p*2
	end
	return c
end

function RandList(rh)
	local ret = {}

	local size = #rh
	for i=1,size do
		local idx = GameRandEx(1, size + 1)
		while(ret[idx] ~= nil) do
			idx = math.fmod(idx + 1, size)
		end
		ret[idx] = rh[i]
	end
	
	return ret
end



------------------------------------- 排序算法 ---------------------------------------


local function _SortFindIndexRange(list, greater, left, right, val)
	if left > right then
		return right + 1
	end
	
	local i = math.floor((left + right) / 2)
	
	if greater(list[i], val) then
		return _SortFindIndexRange(list, greater, left, i - 1, val)
	else
		return _SortFindIndexRange(list, greater, i + 1, right, val)
	end
end

local function _SortFindIndex(list, greater, val)	
	return _SortFindIndexRange(list, greater, 1, #list, val)
end

--[[
@brief 排序，对每个对象按照顺序插入新序列，进行返回
@param	list: 需要进行排序的对象
		greater: 大小判定函数
]]--
function LX_SORT(list, greater)
	local ret = {}
	
	for i=1,#list do
		local index = _SortFindIndex(ret, greater, list[i])
		
		for j=#ret,index,-1 do
			ret[j+1]=ret[j]
		end
		ret[index]=list[i]
	end
	
	return ret
end

