# Children and Properties

Creating children and setting properties in hierarchy builder is quite different from popular instance frameworks. Reason being that it abuses 2 types of table indexes at the same time.<br><br>

Setting properties is done via:
```luau
buildInstance{
  Type = "Part";
  Parent = workspace;
  Name = "MyPart";
  Color = Color3.new();
}
```
<br>

And creating children is done via:
```luau
buildInstance{
  Type = "Part";
  Parent = workspace;
  Name = "MyPart";
  Color = Color3.new();

  {
    Type = "Folder";
    Name = "CoolFolder";
    {
      Type = "ObjectValue";
      Value = game;
    };
  };

  {
    Type = "Configuration";
    Name = "A";
  };
}
```
**Note:**
> Hierarchy children will automatically be parented to it's ancestor, altrough it is still possible to override it via setting `Parent`
<br>

