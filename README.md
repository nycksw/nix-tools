# Nix Home‑Manager: Userland Tools

Install essential user‑space CLI tools on any Linux distro. Dotfiles live elsewhere (try <https://github.com/nycksw/ocd>). Nix yields immutable, side‑effect‑free upgrades but this example costs ~14 GiB, so it's not very tiny Kali VMs.

## Install

1. Install Nix (flakes enabled):

```bash
curl -fsSL https://install.determinate.systems/nix | sh -s -- install --determinate
```

2. Clone and enter repo:

```bash
git clone https://github.com/nycksw/nix-tools.git && cd nix-tools
```

3. Edit `home.nix`  
   • **Best:** hard‑code `username` and `home`  
   • Alt: use `builtins.getEnv` (needs `--impure` on every run)

4. Build + activate:

```bash
nix run home-manager -- switch --flake .
```

## Update

```bash
home-manager switch --flake ~/nix-tools
```

## Clean up

```bash
nix-collect-garbage -d
```

### Scope

Great for simple CLI tools that need no overlays/NixGL. Use your distro’s package manager for heavyweight GUI apps.
