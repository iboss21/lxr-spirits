# lxr-spirits — Events

## Server Events

```lua
TriggerServerEvent('lxr-spirits:server:requestStart', locationId)
TriggerServerEvent('lxr-spirits:server:completeRitual', locationId)
TriggerServerEvent('lxr-spirits:server:cancelRitual', reason)
```

## Client Events

```lua
TriggerClientEvent('lxr-spirits:client:startRitual', source, location, duration)
TriggerClientEvent('lxr-spirits:client:revealSpirit', source, spiritKey, spiritData, location)
TriggerClientEvent('lxr-spirits:client:showExisting', source, record)
```

Do not call complete directly from another resource unless you also establish active ritual state through the start flow.
