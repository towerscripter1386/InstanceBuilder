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
`_base` allows to have complex property inheritance. Besides being able to overrride properties, it also supports certain macros like: `_init`, `Parent`, `_exec` or even nested `_base`'s. The properties inside of the `_base` hierarchy will be written to the instance before the ones describing the `_base` will, example below: <br>
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

Common mistake people make when using this macro is to use `Type`. This is an invalid syntax and if you want to have class inheritance you should instead use the 3rd variation of the `Type`, which allows you to specify another hierarchy with `Type`.
