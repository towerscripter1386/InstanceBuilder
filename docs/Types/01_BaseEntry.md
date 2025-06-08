# BaseEntry

## Type
```luau
export type BaseEntry = {
	Parent:Instance?;
	_base:BaseEntry?;
	_init:(self:Instance,id:number?) -> ()?;
	_exec:{[string]:{{any}}}?;
	[number|string]:InstanceEntry|any;
}
```

## Info
BaseEntry is a base class for all entries of the hierarchy builder. It's main purpose is to serve as a guide to preventing undefined behavior inside of the `_base` macro.
