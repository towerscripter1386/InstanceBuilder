# _count

## Type
```luau
_count:number?
```

## Syntax
```luau
local t1:HierarchyBuilder.InstanceEntry = {
  Type = "Part";
  Parent = workspace;
  _count = 10;
}
```

## Info
`_count` allows to create a set of instances without hardcoding it inside of the code. It can operate under any hierarchy and allows to compress the code if used right. <br><br>

It also affects `_init`, providing it with a second argument telling the functions it's instace index derived from `_count` loop.
