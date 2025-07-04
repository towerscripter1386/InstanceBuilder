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
`_base` allows you to override properties before writing the one's written in the Entry. This allows you to have inheritance in your code. Besides supporting properties, it also supports certain macros; to see which are supported: read the `BaseEntry` definition.
