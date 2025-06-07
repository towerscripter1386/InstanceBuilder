# _base

## Type
```luau
_base:BaseEntry?
```

## Syntax 
```luau
local RedColor:HierarchyBuilder.BaseEntry = {
  Color = Color3.new(1,0,0);
}

local t1:HierarchyBuilder.InstanceEntry = {
  Type = "Part";
  Parent = workspace;
  _base = RedColor;
}
```

## Info
`_base` allows to have complex property inheritance. Besides being able to overrride properties, it also supports certain macros like: `_init`, `Parent`, `_exec` or even nested `_base`. The proprties inside of the `_base` will be written to an instance before the properties desribed in top hierarchy will be applied, example below: <br>
```luau
buildInstance{ -- part will be of green color
  Type = "Part";
  Parent
  Color = Color3.new(0,1,0);
  _base = {
    Color = Color3.new(1,0,0);
  };
}
```

Common mistake people make when using this macro is to put `Type` inside of the `_base` hierarchy. It is incorrect and if you want class inheritance you should instead use the 3rd variation of type which allows you to specify another hierarchy.
