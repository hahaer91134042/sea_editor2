require("container")

local _ChunkType = 
{
	OBJECT = 0,
	ARRAY = 1,
}

local function _PushChunk(chunk, type)
	local c = {}
	c.type = type
	c.count = 0
	
	chunk:push(c)
end

local function _PopChunk(chunk)
	chunk:pop()
end

local function _AddCommaFrontKey(self)
	local chk = self.chunk:top()
	if chk ~= nil then
		if chk.type == _ChunkType.OBJECT and chk.count > 0 then
			self.str = self.str..","
		end
		chk.count = chk.count + 1
	end
end

local function _AddCommaFrontValue(self)
	local chk = self.chunk:top()
	if chk ~= nil then
		if chk.type == _ChunkType.ARRAY and chk.count > 0 then
			self.str = self.str..","
		end
		chk.count = chk.count + 1
	end
end

JsonBuilder = 
{
	str = "",
	chunk = lxStack:new(),
	
	new = nil;
	clear = nil;
	BeginObject = nil;
	EndObject = nil;
	BeginArray = nil;
	EndArray = nil;
	AddKey = nil;
	AddValue = nil;
	AddText = nil;
	AddObject = nil;
	AddKeyValue = nil;
	AddKeyText = nil;
	AddKeyObject = nil;
}

function JsonBuilder:new()
	return CopyTable(self)
end

function JsonBuilder:clear()
	self.str = ""
	self.chunk = lxStack:new()
end

function JsonBuilder:BeginObject()
	_AddCommaFrontValue(self)
	
	_PushChunk(self.chunk, _ChunkType.OBJECT)
	self.str = self.str.."{"
end

function JsonBuilder:EndObject()
	local chk = self.chunk:top()
	if chk.type == _ChunkType.OBJECT then
		_PopChunk(self.chunk)
	end	
	self.str = self.str.."}"
end

function JsonBuilder:BeginArray()
	_AddCommaFrontValue(self)
	
	_PushChunk(self.chunk, _ChunkType.ARRAY)
	self.str = self.str.."["
end

function JsonBuilder:EndArray()
	local chk = self.chunk:top()
	if chk.type == _ChunkType.ARRAY then
		_PopChunk(self.chunk)
	end	
	self.str = self.str.."]"
end

function JsonBuilder:AddKey(key)
	_AddCommaFrontKey(self)
	
	self.str = self.str.."\""..key.."\":"
end

function JsonBuilder:AddValue(num)
	_AddCommaFrontValue(self)
	
	self.str = self.str..num
end

function JsonBuilder:AddText(txt)
	_AddCommaFrontValue(self)
	
	self.str = self.str.."\""..txt.."\""
end

function JsonBuilder:AddObject(str)
	_AddCommaFrontValue(self)
	
	self.str = self.str..str
end

function JsonBuilder:AddKeyValue(key, num)
	self:AddKey(key)
	self:AddValue(num)
end

function JsonBuilder:AddKeyText(key,txt)
	self:AddKey(key)
	self:AddText(txt)
end

function JsonBuilder:AddKeyObject(key, str)
	self:AddKey(key)
	self:AddObject(str)
end