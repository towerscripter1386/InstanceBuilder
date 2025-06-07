# Enviroment

Hierarchy builder is not picky about it's enviroment. It can be used anywhere from everywhere and does not require any dependecies in order to work.

**Note:**
> This documentation will only cover the Roblox Studio setup. If you work in any other enviroment like `Rojo`, you will have to set it up yourself using the Roblox Studio example.

1. Get the source code of hierarchy builder either from releases or directly from the repository
2. Put the source code into a module script and call it however you want, we will call it `HierarchyBuilder`

Done! Simple as that is only the usage of the recursive builder itself:

```luau
local buildInstance = require("/HierarchyBuilder") -- assuming you put the module in the same directory where you execute this script

buildInstance{ Name = "MyPart"
  Type = "Part";
  Parent = workspace;
}
```
