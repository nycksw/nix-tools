# Nix Home Manager for Userland Tools

Install all your favorite userland tools in a moment on practically any
distribution.

This is _not_ for dotfiles, because for those I use
[OCD](https://github.com/nycksw/ocd), which is just Git using `$HOME` as the
work tree. It doesn't get any simpler than that. For _tools_, I want a
similarly minimal way to install just about everything I typically need, and
in a way that's as distribution-independent as possible. That's what this is.

## Installing

You must modify
[home.nix](https://github.com/nycksw/nix-tools/blob/main/home.nix) with your
own username and home directory. Alternatively you could use `builtins.getEnv`
(for `$HOME` and `$USER`)  but then you'll need to add `--impure` to the
`home-manager` commands below, since the build would no longer be hermetic.

Next, install [Determinite
Nix](https://github.com/DeterminateSystems/nix-installer):

```
curl -fsSL https://install.determinate.systems/nix | sh -s -- install --determinate
```

Ensure your `PATH` is updated appropriately to include the `nix` command.

Determinite Nix enables Flakes by default. The `home-manager` tool won't be
built yet, so it has to be built using `nix run`:

```
git clone git@github.com:nycksw/nix-tools.git && cd nix-tools
nix run home-manager -- switch --flake .
```

That installs everything from
[`home.nix`](https://github.com/nycksw/nix-tools/blob/main/home.nix) and
provides `home-manager`. Subsequent updates are just:

```
home-manager switch --flake ~/nix-tools
```

## Which Packages to Include?

My rule: if I can add it to the config without too much additional complexity,
e.g. no NixGL, no complicated overlays, and it's all in userland, then
it [belongs](https://github.com/nycksw/nix-tools/blob/main/home.nix).
Otherwise I'm happy to install the tool manually or with a traditional
package manager.

## Housekeeping

Run `nix-collect-garbage -d` to free up space.
