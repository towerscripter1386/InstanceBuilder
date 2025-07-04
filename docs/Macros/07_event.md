# _event

## Status
1.4 beta only

## Type
```luau
_attach:{[Instance]:TypeEntry|InstanceEntry}?
```

## Syntax
```luau
local t1:HierarchyBuilder.TypeEntry = {
  Type = "Part";
  Parent = workspace;
  
  _event = {
    Touched = {
      Connect = {
        function(hit)
          print("I hit something")
        end;
      };
    };
    TouchEnded = {
      Connect = {
        function()
          print("I left")
        end;
      };
    };
  };
}
```

## Info
`_event` came as a replacement for certain use cases of `_init`. Despite bringing syntax sugar for binding methods to Instance events.
Unlike `_init`, `_event` is not deferred and does not provide the functions with the Instance they are connecting to, because of that; 
you are required to use `_attach` in order to retrieve the instance, which can impact performance and readability. So if you need the Instance you are connecting to,
then use the original method instead.
