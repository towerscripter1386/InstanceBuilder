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
`_init` is one of the 2(second being _exec) macros which allow created instances to have a reactive behavior. Function provided to the `_init` is called trough `task.defer`. So beware of the added performance overhead of creating threads<br><br>

Second argument provides index of the cloned instance via `_count`.<br><br>

In older versions of the hierarchy builder(before `1.3`) `_init`'s `id` would only be present if `_count` was specified.
