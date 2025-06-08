# buildInstance

This is the main function for hierarchy builder. It accepts any type of entry and builds an instance from it<br><br>
**Note**
> buildInstance will error the current thread if it meets improperly typed table. For example:
> ```luau
> buildInstance{
>  Type = "Part";
>  Asd = nil; -- does not exist in class type Part
> }
> ```
> Will cause the hierarchy builder to error and discard the built instances

buildInstance can be used to also attaching to existing instance like:
```luau
buildInstance({
  Name = "Test"
},workspace)
```
which will set `Workspace` name to Test. This is useful for making a declarative plugin guis. Where you can just attach to `DockWidgetPluginGui`
