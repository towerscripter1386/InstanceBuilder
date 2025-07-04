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
`_count` allows you to create a set of instances without hardcoding it inside of the `_init`. It can only operate inside of the `InstanceEntry` and allows you to compress the code. <br><br>

Also with the help of `_init` you are able to have some procedural capabilities, example below:
```luau
buildInstance{
  Type = "Part";
  
  Parent = workspace;
  Size = Vector3.one;

  _count = 100;
  _init = function(self,id)
    self.Position = Vector.new(id%10,0,math.floor(id*0.1))
    self.Name = tostring(id)
  end;
}
```
