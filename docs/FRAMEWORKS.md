# lxr-spirits — Framework Bridge

`shared/framework.lua` is open and buyer-editable. It centralizes framework-specific code.

## Supported Functions

- `Framework.Locale(key)`
- `Framework.Notify(...)`
- `Framework.GetPlayer(source)`
- `Framework.GetIdentifier(source)`
- `Framework.GetJob(source)`
- `Framework.HasItem(source, item, amount)`
- `Framework.RemoveItem(source, item, amount)`

## Primary Frameworks

- LXR-Core
- RSG-Core

## Compatible Frameworks

- VORP Core
- RedEM:RP
- QBR Core
- QR Core
- Standalone fallback

Standalone mode is intended for testing and does not provide real persistence identity beyond player identifiers.
