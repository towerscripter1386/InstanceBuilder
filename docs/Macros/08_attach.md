# _attach

## Status
1.4.0 beta only

## Type
```luau
_attach:{[Instance]:TypeEntry|InstanceEntry}?
```

## Syntax
```luau
local attach = {}

buildInstance{
  Type = "Part";
  Name = "MySuperSpecialPart"
  Parent = workspace;

  _attach = attach;
}

print(attach[workspace.MySuperSpecialPart])
```

## Info
`_attach` was added in order to try to resolve a big flaw of hierarchy builder. It being static makes certain implementations inefficient or extremely inconvenient. 
With this macro you can tell the hierarchy builder to attach the entry to the part it is built, which allows you to cross-communicate between script hierarchies without
involving custom solutions. <br><br>

`_attach` is only allowed where `TypeEntry` is allowed.
