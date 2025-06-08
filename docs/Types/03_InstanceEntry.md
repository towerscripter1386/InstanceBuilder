# InstanceEntry

## Type
```luau
export type InstanceEntry = TypeEntry&{
	_count:number?;
}
```

## Info
This type's purpose mostly serves as a barrier for the usage of `_count`. As it can't be used in certain macros like `Type` or `_base`.
