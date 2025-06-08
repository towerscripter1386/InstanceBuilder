# Type

## Type
```luau
Type:string|Instance|TypeEntry
```


## Syntax
```luau
local t1:HierarchyBuilder.InstanceEntry = {
  Type = "Part";
}

local t2:HierarchyBuilder.InstanceEntry = {
  Type = workspace:FindFirstChildOfClass("Part");
}

local t3:HierarchyBuilder.InstanceEntry = {
  Type = {
    Type = "Part";
  };
}
```

## Info <br>
`Type` is the most important macro in hierarchy builder. It allows you to create a base instance without having to attach to an existing instance. 
Type can accept a `string` similar to `Instance.new`, an instance to clone or another hierarchy. <br> <br>

Instances are cloned trough the usage of `Clone`. So be careful with child instances of the object you provide. Hierarchies provided to the `Type` or `_base` can't have a `_count` macro for an obvious reason.
