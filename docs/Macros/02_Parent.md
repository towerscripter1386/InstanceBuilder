# Parent

## Type
```luau
Parent:Instance?
```

## Syntax
```luau
local t1:HierarchyBuilder.InstanceEntry = {
  Type = "Part";
  Parent = workspace;
}
```

## Info
Despite the name, `Parent` is considered a macro in hierarchy builder. It is explained by the fact that in build loop it deliberately ignores it until all of the properties are set and all of the children have been created. This allows hierarchy builder to operate on replicated services without the risk of network overhead
