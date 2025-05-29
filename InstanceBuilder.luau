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
local Get:(self:Instance,key:keyof<Instance>|string) -> any xpcall(function() return game[nil] end,function() local f = debug.info(2,"f") if f == error then Get = function(self,key) return self[key] end else Get = f end end)
local Set:(self:Instance,key:keyof<Instance>|string,value:any) -> () xpcall(function() game[nil] = nil end,function() local f = debug.info(2,"f") if f == error then Set = function(self,key,value) self[key] = value end else Set = f end end)
local Clone = script.Clone

--Variables
local blockedEntries = {
	"_count";
	"_init";
	"_base";
	"_exec";
	"Parent";
	"Type";
}

--Types
export type InstanceEntry = {
	Type:string|Instance|InstanceEntry;
	Parent:Instance?;
	_base:InstanceEntry?;
	_init:(self:Instance,id:number?) -> ()?;
	_count:number?;
	_exec:{[string]:{{any}}}?;
	[number|string]:InstanceEntry|any;
}

--[[
	Builds instances of hierarchy, it is meant to be used in scripts for convenience.
	The way it works is similar to react
	
	<strong>instance</strong> : instance hierarchy of any creatable type 
]]
local function buildInstance(instance:InstanceEntry,object:Instance?) : ...Instance
	local Type = instance.Type
	local Count = instance._count
	local Parent = instance.Parent
	local Init = instance._init
	local Base = instance._base
	local Exec = instance._exec

	if not object then
		local tType = typeof(Type)
		if tType == "Instance" then
			object = Clone(Type::Instance)
		elseif tType == "string" then
			object = Instance.new(Type::string)
		else
			local t = table.clone(Type)::InstanceEntry
			t._count = nil
			object = buildInstance(t)
			Set(object,"Parent",nil)
		end
	end

	if Base then
		buildInstance(Base,object)
	end

	for i,v in instance do
		if type(i) == "string" then
			if table.find(blockedEntries,i) then continue end
			Set(object,i,v)
		else
			for j,k in {buildInstance(v)} do
				if not Get(k,"Parent") then Set(k,"Parent",object) end
			end
		end
	end
	
	if Exec then
		for fName,execArgs in Exec do
			local func = object[fName]::(self:Instance,...any) -> ...any
			for i,argT in execArgs do
				func(object,table.unpack(argT))
			end
		end
	end

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

	if Parent then Set(object,"Parent",Parent) end

	return object,table.unpack(returnT)
end

return buildInstance
