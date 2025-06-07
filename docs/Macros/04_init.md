# _init

## Type
```luau
_init:(self:Instance,id:number) -> ()
```

## Syntax
```luau
local t1:HierarchyBuilder.InstanceEntry = {
  Type = "Part";
  Parent = workspace;
  
  _init = function(self,id)
    self.Position = Vector3.new(id,0,0)
  end;
}
```

## Info
`_init` is one of the 2(second being _exec) macros which allow reactive behavior. Function provided to the `_init` is called trough `task.defer` and if you have a large set of hierarchies with `_init` without deferred signals on they will cause massive performance issues<br><br>

Second argument provides ability to have procedural capabilities.<br><br>

In older versions of hierarchy builder(before `1.3`) `_init`'s `id` would only be present if `_count` was specified. Now even without specifying `_count` `id` will be present
