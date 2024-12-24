--

--module("Object", package.seeall)

-- comment
-- 对象基类
Object = 
{
	-- variables
	_parent = nil;
	_obj = 0; -- c++ object
	_uid = 0; -- uuid
	
	-- methods
	GetObject = nil;
	GetUID = nil;

	Create = nil; 
	Destroy = nil;
	Update = nil; 
}

Object.GetObject = function(self)
	return self._obj;
end

Object.GetUID = function(self)
	return self._uid;
end

Object.Create = function(self, obj, uid)
	self._obj = obj;
	self._uid = uid;
end

Object.Destroy = function(self)
end

Object.Update = function(self, frame_tick, delta_tick)
end

-- 
function NewInstance(self, parent)
	local super = parent;
	local inst = {}

	-- copy base parent	
	for k,v in pairs(super) do
		inst[k] = v;
	end

	-- copy target parent
	for k,v in pairs(self) do
		if type(v) == "table" then
			inst[k] = CopyTable(v)
		else
			inst[k] = v;
		end
	end
	--table.dump(inst);
	--debug.dump(inst, "ArenaRush", 3)

	return inst;
end

Misc =
{
	IndexOffset = 1
}
