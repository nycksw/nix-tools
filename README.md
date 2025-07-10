# Userland Tools with Nix Home Manager

This setup provides an easy, fast, and distribution-independent way to install your essential userland tools on any machine. It is designed specifically for managing the installation of software, not their configuration files (dotfiles), although this pairs nicely with [OCD](https://github.com/nycksw/ocd) for tracking those.

Using Nix in this way trades disk space for immutability and side-effect-free upgrades. [This example](https://github.com/nycksw/nix-tools/blob/2f790b6629b3dcc385dc0ed348f5f2176153f067/home.nix) of `home.nix` uses 14G. So, it's fine for your workstations that have lots of free space, but it may not be appropriate for your Kali VMs.

## Installation

### Prerequisites

First, install Nix with Flakes support using the [Determinite
Nix installer](https://github.com/DeterminateSystems/nix-installer). This installer enables Flakes by default.

```bash
curl -fsSL [https://install.determinate.systems/nix](https://install.determinate.systems/nix) | sh -s -- install --determinate
```

Ensure the `nix` command is available in your `PATH`. Next, clone the repository:

```bash
git clone git@github.com:nycksw/nix-tools.git && cd nix-tools
```

### Configuration

Before installing, you must configure your user details in `home.nix`. You have two options:

* **Option A (Recommended):** Hardcode your username and home directory directly in the `home.nix` file.
* **Option B (Impure):** Use `builtins.getEnv "USER"` and `builtins.getEnv "HOME"`. This makes the build non-hermetic, requiring you to add the `--impure` flag to all `home-manager` commands.

### First-Time Setup

Run the following command to build Home Manager and apply the configuration for the first time:

```bash
nix run home-manager -- switch --flake .
```

This command installs all packages defined in `home.nix`.

### 4. Updating

After the initial setup, you can update your installed packages by running the `switch` command from anywhere:

```bash
home-manager switch --flake ~/nix-tools
```

---

## Package Selection

The guiding principle for including a package in this configuration is simplicity. This method is best for userland tools that can be added without complex overlays or specialized graphics handling (like NixGL). For more complex software, a traditional package manager may be a better fit.

---

## Maintenance

To reclaim disk space, periodically run the Nix garbage collector to remove old, unused package versions:

```bash
nix-collect-garbage -d
```
