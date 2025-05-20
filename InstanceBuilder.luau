--[[
   Copyright 2025 Arsenij Ivashenko

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
]]

--!optimize 2
--!strict

--Hacks
local Get:(self:Instance,key:keyof<Instance>|string) -> any xpcall(function() return script[nil] end,function() local f = debug.info(2,"f") if f == error then Get = function(self,key) return self[key] end else Get = f end end)
local Set:(self:Instance,key:keyof<Instance>|string,value:any) -> () xpcall(function() script[nil] = nil end,function() local f = debug.info(2,"f") if f == error then Set = function(self,key,value) self[key] = value end else Set = f end end)
local Clone = script.Clone

--Variables
local blockedEntries = {
	"_count";
	"_init";
	"_base";
	"Parent";
	"Type";
}

--Types
export type InstanceEntry = {
	Type:string|Instance|InstanceEntry;
	Parent:Instance?;
	_base:{[number|string]:InstanceEntry|any}?;
	_init:(self:Instance,id:number?) -> ()?;
	_count:number?;
	[number|string]:InstanceEntry|any;
}

local buildInstance:(instance:InstanceEntry) -> ...Instance

local function loopAndBuild(t:{[number|string]:InstanceEntry|any;},o:Instance,check:boolean)
	for i,v in t do
		if type(i) == "string" then
			if check then
				if table.find(blockedEntries,i) then continue end
			end
			Set(o,i,v)
		else
			--local arg = table.pack(buildInstance(v))
			for j,k in {buildInstance(v)} do
				if not Get(k,"Parent") then Set(k,"Parent",o) end
			end
		end
	end
end

--[[
	Builds instances of hierarchy, it is meant to be used in scripts for convenience.
	The way it works is similar to react
	
	<strong>instance</strong> : instance hierarchy of any creatable type 
]]
buildInstance = function(instance:InstanceEntry) : ...Instance
	local object:Instance

	local Type = instance.Type
	local Count = instance._count
	local Parent = instance.Parent
	local Init = instance._init
	local Base = instance._base

	local tType = typeof(Type)
	if tType == "Instance" then
		object = Clone(Type::Instance)
	elseif tType == "string" then
		object = Instance.new(Type::string)
	else
		local t = table.clone(Type)::InstanceEntry
		t._count = nil
		object = buildInstance(t)
		object.Parent = nil
	end

	if Base then
		loopAndBuild(Base,object,false)
	end

	loopAndBuild(instance,object,true)

	if instance.Parent then Set(object,"Parent",instance.Parent) end

	local returnT = {}

	if Count then
		if Init then
			task.defer(Init,object,1)
		end
		local t:typeof(instance)
		if Count >= 2 then
			t = table.clone(instance)
			t._count = nil::any
			t._init = nil
		end
		for i = 2, Count do
			local localObject = buildInstance(t)
			if Parent then
				Set(localObject,"Parent",Parent)
			else
				table.insert(returnT,localObject)
			end
			if Init then
				task.defer(Init,localObject,i)
			end
		end	
	else
		if Init then
			task.defer(Init,object)
		end
	end

	return object,table.unpack(returnT)
end

return buildInstance
