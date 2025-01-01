# HierarchyBuilder
React alike instance hierarchy builder


## Example usage:

```luau
local buildInstance = require(InstanceBuilder)

-- 1 instance example
buildInstance{ Name = "TestPart";
  Type = "Part"
  Parent = workspace;
  Position = Vector3.new(12,0,10);
}

-- hierarachy example
buildInstance{ Name = "HierarchyTest";
  Type = "Folder";
  Parent = workspace;

  { Type = "StringValue";
    Value = "hello world";
    -- no need for parent param since we already build under the folder
  };
}

-- redundant instances example
buildInstance{ Name = "RedundantTest";
  Type = "Folder";
  Parent = workspace;

  { Type = "StringValue";
    Value = "hello world";
    
    _count = 15;
  };
}

-- init example
buildInstance{ Name = "InitTest";
  Type = "BindableEvent";
  Parent = workspace;

  _init = function(self:BindableEvent) -- type would match the instance type you create
    self.Event:Connect(function()
      print("I did actually init!")
    end)
  end;
}

-- init and redundant example
buildInstance{ Name = "FinalTest";
  Type = "Folder";
  Parent = workspace; 

  _count = 20;
  _init = function(self:Folder,id:number) -- extra param for _init if _count is present
    self.Name = `Folder_{id}`
  end;
  
  { Type = "NumberValue"
    _count = 20;
    _init = function(self:NumberValue,id:number)
      self.Value = id 
    end;
  };
}

-- complex example
local events = {
	Type = "Folder";

	Name = "EventFolder";
	Parent = game:GetService("ReplicatedStorage");

	{ Name = "CharacterOption";
		Parent = workspace;
		_count = 12;
		Type = "BindableFunction";
		OnInvoke = function(Type)
			return false, "No option is here yet!"
		end;
		{ Type = "Configuration";
			_count = 12;
			_init = function(self:Configuration,count:number)
				print("run")
				self.Name = tostring(count)
			end;
		}
	};
}

buildInstance(events)
```
