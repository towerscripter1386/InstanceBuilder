local function parentCheck(instance:{Type:string|Instance,Parent:Instance?,_init:(self:Instance,id:number?) -> ()?,_count:number?;[any]:any},obj:Instance,returnT)
	if instance.Parent then
		obj.Parent = instance.Parent
	else
		table.insert(returnT,obj)
	end
end

local blockedEntries = {
	"_count";
	"_init";
	"Parent";
	"Type";
}
--[[
	Builds instances of hierarchy, it is meant to be used in scripts for convenience.
	The way it works is similar to react
	
	<strong>instance</strong> : instance hierarchy of any creatable type 
]]
local function buildInstance(instance:{
	Type:string|Instance,
	Parent:Instance?,
	_init:(self:Instance,id:number?) -> ()?,
	_count:number?;
	[any]:any
	}) : ...Instance

	local object:Instance
	if typeof(instance.Type) == "Instance" then
		object = instance.Type:Clone()
	else
		object = Instance.new(instance.Type)
	end

	for i,v in instance do
		if typeof(i) == "string" then
			if table.find(blockedEntries,i) then continue end
			object[i] = v
		else
			local arg = table.pack(buildInstance(v))
			for i = 1,arg.n do
				if not arg[i].Parent then arg[i].Parent = object end
			end
		end
	end

	if instance.Parent then object.Parent = instance.Parent end

	local returnT = {}

	if instance._count then
		if instance._init then
			task.defer(instance._init,object,1)
		end
		local t:typeof(instance)
		-- despite being a single function. It has so much weird fixes that I belive react
		-- has multiple modules for a reason
		if instance._count >= 2 then
			t = table.clone(instance)
			t._count = 0
		end
		for i = 2,instance._count do
			local localObject = buildInstance(t)
			parentCheck(instance,localObject,returnT)
			if instance._init then
				task.defer(instance._init,localObject,i)
			end
		end	
	else
		if instance._init then
			task.defer(instance._init,object)
		end
	end

	return object,table.unpack(returnT)
end

return buildInstance