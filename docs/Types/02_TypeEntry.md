# TypeEntry

## Type
```luau
export type TypeEntry = BaseEntry&{
	Type:string|Instance|TypeEntry;
}
```

## Info
Tables of this type can now be used freely under any hierarchy. Which makes them be able to be directly used inside of the `buildInstance`.
