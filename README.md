# Game servers

Self-hosted games server infrastructure using Docker Compose, with auto-start/stop and Discord notifications.

## Stacks

### `stacks/minecraft`

Runs the Minecraft server using [itzg/minecraft-server](https://github.com/itzg/minecraft-server).

- **Version:** 26.1
- **Mod loader:** Fabric
- **Mode:** Survival, PvP enabled, whitelist enforced, offline mode
- **Max players:** 12

**Server-side mods (via Modrinth):**

| Mod | Purpose |
|-----|---------|
| fabric-api | Fabric core API |
| lithium | General-purpose server optimizations |
| c2me-fabric | Chunk generation performance |
| scalablelux | Lighting engine optimization |
| ferrite-core | Memory usage reduction |
| vmp-fabric | Server performance improvements |
| krypton | Network stack optimization |
| packet-fixer | Packet compatibility fixes |
| disconnect-packet-fix | Fixes disconnect packet issues |
| alternate-current | Redstone performance |
| inventory-management | In-game inventory sorting |
| easyauth | Authentication for offline mode |
| easywhitelist | Whitelist management |
| luckperms | Permission management |
| vanilla-permissions | Vanilla-compatible permission nodes |

---

### `stacks/monitoring`

Runs [Loggifly](https://github.com/clemcer/loggifly) to watch Minecraft container logs and send notifications via [Apprise](https://github.com/caronc/apprise) (Discord, Telegram, etc.).

**Triggers:**

| Event | Action |
|-------|--------|
| Server finishes loading (`Preparing spawn area: 100%`) | Sends a "server online" notification |
| Server empty for 60 seconds | Stops the container and sends a "server offline" notification |

The auto-stop behavior keeps resource usage low when no one is playing.

---

## Client mods

The `scripts/download-minecraft-client-mods.sh` script fetches the recommended client-side mods from Modrinth and packages them into a `.zip` file ready to share with players.

**Included client mods:** Sodium, Sodium Extra, Lithium, ImmediatelyFast, FerriteCore, Xaero's Minimap, ModMenu, Inventory Management, Entity Culling, Fabric API.

Run it from the repo root:

```bash
bash scripts/download-minecraft-client-mods.sh
```

The zip is saved to `download/Mods <version>.zip`.

---

## Requirements

- Docker and Docker Compose
- `jq` and `curl` (for the client mods script)

## License

[MIT](LICENSE)