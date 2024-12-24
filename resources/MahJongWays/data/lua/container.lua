lxStack = 
{
	new = nil;
	push = nil;
	pop = nil;
	top = nil;
	foreachdo = nil;
	find = nil;
}

function lxStack:new()
	return CopyTable(self)
end

function lxStack:push(val)
	table.insert(self, val)
end

function lxStack:pop()
	table.remove(self)
end

function lxStack:top()
	return self[#self]
end

function lxStack:foreachdo(foo)
	for i=1,#self do
		foo(self[i])
	end
end

function lxStack:find(foo)
	for i=1,#self do
		if foo(self[i]) then
			return i
		end
	end
	return 0
end