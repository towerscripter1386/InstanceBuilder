# _exec

## Type 
```luau
_exec:{[string]:{{any}}?
```

## Syntax
```luau
local t1:HierarchyBuilder.InstanceEntry = {
  Type = "Part";
  Parent = workspace;
  _exec = {
    SetAttribute = {
      {"MyAttribute",12};
      {"Test","My string"};
    };
    AddTag = {
      {"Pickable"};
      {"HasAttributes"};
    }
  };
}
```

## Info
`_exec` came as a replacement for certain use cases of `_init`, particulary when it is used for setting attributes or tags. <br><br>

This macro allows you make certain actions like tagging or attributing declerative. <br><br>

Function collections provided in the `_exec` will automatically have first argument as the parenting isntance(equivalent to calling via `Instance:SetAttribute()`). They are also executed immediately after setting the properties of the instance.<br><br>

The syntax is a bit confusing since it tries to fit many use cases of either attributing,taggin and etc. `_exec` is a hash table which contains the function name you want to execute, for example `AddTag`. That index must contain an array of tables. Amount of tables inside of that array is equivalent to how many times the function will be executed. Code below shows equivalent between `_init` and `_exec`:
```luau
local t1:HierarchyBuilder.InstanceEntry = {
  Type = "Part";
  Parent = workspace;

  _init = function(self,id)
    self:SetAttribute("Example",12)
    self:SetAttribute("Example2","asd")

    self:AddTag("Testing")
  end;
}

local t2:HierarchyBuilder.InstanceEntry = {
  Type = "Part";
  Parent = workspace;

  _exec = {
    SetAttribute = {
      {"Example",12};
      {"Example2","asd"};
    };
    AddTag = {
      {"Testing"};
    };
  };
}
```
