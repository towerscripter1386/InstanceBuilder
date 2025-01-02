Copied from the dev forum post

# Structure

all tables in the hierarchy should have a `Type` index:
```luau
local example = { Type = "Folder";
   { Type = "Configuration"
      { Type = "Frame"
         
      };
   };
}
```
To build, simply put the table into the function:
```luau
local buildInstance = require(InstanceBuilder)
local test = buildInstance(example) -- it will also return reference to the built instance
```
Or you can directly build, like:
```luau
buildInstance{ Type = "Folder";
   { Type = "Configuration"
      { Type = "Frame"
         
      };
   };
}
```
you can also put an actual instance instead of a type string in case you are building from a pre-existing instance:
```luau
local example = { Type = workspace:FindFirstChildOfClass("BasePart")

}
```
> **Note:**
All instances inside the hierarchy are created individually, not through clone. This is done to avoid issues with `_init`, with the exception being if you put `Type` as an instance, that would be cloned.

This is required since you can't really do a hierarchy without creating an instance of any type. 

# Instance params
you can change instance parameters just as you would usually trough `Instance.new`:

```luau
local example = { Name = "TestPart" -- I highly suggest to put the names on the same line as you open the table, this is mostly done for convenient reading
   Type = "Part"

   Parent = workspace;
   Position = Vector3.new(12,10,0);

   { Type = "NumberValue";
      Value = 10; 
      -- no need for a parent param since we already build under the Part
   };
}
```
If instead you put `Type` as an instance, it will override the properties you specified in the table, with the exception being `Parent` since roblox itself resets it.

> **Note:** 
Hierarchy will always build their properties and children first before setting their own parent to a specified instance if `Parent` index is specified

# `_init` 
you can specify a function to be run after the whole hierarchy is created:
```luau
local example = { Name = "Events";
   Type = "Folder"

   Parent = game:GetService("ReplicatedStorage");
   { Name = "PlayerRemote";
      Type = "RemoteEvent"

      _init = function(self:RemoteEvent)
         self.OnClientEvent:Connect(function()
            print("hello!")
         end)
      end; 
   };
}
```
It will run in deferred mode. Which is on the next frame.

# `_count`
you can specify the amount of individual instances to create through `_count`:
```luau
local example = { Name = "PartStorage";
   Type = "Folder";

   Parent = workspace;
   { Type = "Part";
      _count = 1000;
   };
}
```
you can also combine it with the `_init` to have some custom behavior for generating properties:
```luau
local example = { Name = "PartStorage";
   Type = "Folder";

   Parent = workspace;
   { Type = "Part";
      Size = Vector3.new(0.5,0.5,0.5);

      _count = 1000;
      _init = function(self:Part,id:number) -- if _count is specified, _init will have a second paramater which corresponds to it's creation place in hierarchy
         local x,y = id % 100,math.floor(id*0.01)
         self.Position = Vector3.new(x,0,y) -- generate parts of 100 by 100 grid
         self.Name = `Part_{x}-{y}`
      end;
   };
}
```

# End notes
You can see more examples at [Devforum post](https://devforum.roblox.com/t/hierarchybuilder-simplified-reactfusion/3335612)

This module is distributed "as is.", meaning you are free to change whatever you would want to

Report all issues at github and I will take a look