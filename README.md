# uBlahaj &nbsp; [![build-ublue](https://github.com/blue-build/template/actions/workflows/build.yml/badge.svg)](https://github.com/blue-build/template/actions/workflows/build.yml)

This is a custom fedora atomic image derived from `uBlue` base images.
It currently only includes the `kinoite` variant.
Both `main` and `nvidia` versions are available.

**This is a work in progress. I currently don't recommand using this image for production.**

## Features
Some packages are added or removed from the base image:
- `zsh` installed out of the box, with `zsh-autosuggestions` and `zsh-syntax-highlighting` included.
- `btop` instead of `htop`.
- `wezterm` terminal emulator (Note: it may have issues with Nvidia. If you use an Optimus laptop and render it from the iGPU, you'll be unaffected. Otherwise, try and if it freezes, I recommand layering a terminal emulator of your choosing).
- `firefox` is removed, so it can be replaced with the flatpak version.
- `toolbox` is removed, in favor of `distrobox`.
- `tmux` is removed, as `ezterm` has a built in multiplexer.

`yafti` is used for post installation configs, mainly for flatpak and user configs:
- Replacing fedora flatpak remote with flathub.
- Install recommended flatpaks (You can choose what you want or don't want to install).
- Installing `ohmyzsh` (Note: `yafti` won't set your default shell, you can use `ujust chsh` or simply `chsh` for that).
- Copying user configs from [sharkonfig](https://github.com/Sharkitty/sharkonfig).

Also, `yafti` nyans. You'll get what I mean on first boot :3

## Installation

> **Warning**  
> [This is an experimental feature](https://www.fedoraproject.org/wiki/Changes/OstreeNativeContainerStable), try at your own discretion.

To rebase an existing atomic Fedora installation to the latest build:

- First rebase to the unsigned image, to get the proper signing keys and policies installed:
  ```
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/sharkitty/ublahaj-kinoite-40-main:latest
  ```

  or

  ```
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/sharkitty/ublahaj-kinoite-40-nvidia:latest
  ```

- Reboot to complete the rebase:
  ```
  systemctl reboot
  ```

- Then rebase to the signed image, like so:
  ```
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/sharkitty/ublahaj-kinoite-40-main:latest
  ```

  or

  ```
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/sharkitty/ublahaj-kinoite-40-nvidia:latest
  ```

- Reboot again to complete the installation
  ```
  systemctl reboot
  ```

The `latest` tag will automatically point to the latest build. That build will still always use the Fedora version specified in `recipe.yml`, so you won't get accidentally updated to the next major version.

## ISO

If build on Fedora Atomic, you can generate an offline ISO with the instructions available [here](https://blue-build.org/learn/universal-blue/#fresh-install-from-an-iso). These ISOs cannot unfortunately be distributed on GitHub for free due to large sizes, so for public projects something else has to be used for hosting.

## Verification

These images are signed with [Sigstore](https://www.sigstore.dev/)'s [cosign](https://github.com/sigstore/cosign). You can verify the signature by downloading the `cosign.pub` file from this repo and running the following command:

```bash
cosign verify --key cosign.pub ghcr.io/blue-build/template
```
