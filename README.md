# Dotfiles Repository

This repository contains publicly shareable instances of my dotfiles.

## Purpose

- Provide a centralized location for configuration files.
- Serve as a reference for setting up a consistent development environment.
- Allow others to use, modify, and contribute to improving these dotfiles.

## Getting Started

Clone the repository to your local machine into a suitable directory whose
location will not change:

```bash
git clone https://github.com/mmottl/dotfiles.git
```

Then navigate to the repository directory:

```bash
cd dotfiles
```

Use the provided install script to stow the dotfiles into your home directory.
The script supports three actions:

- **Stow (`-S`)**: Symlink dotfiles into the home directory (default).
- **Delete (`-D`)**: Remove the symlinks from the home directory.
- **Restow (`-R`)**: Remove then re-create the symlinks.

For example, to stow all packages, run:

```bash
./install.sh
```

To install only the `zsh` configuration, run:

```bash
./install.sh zsh
```

To perform a dry-run (show actions without making changes), use the `-n` option:

```bash
./install.sh -n
```

## License

This project is dedicated to the public domain under the
[Creative Commons Zero v1.0 Universal](https://creativecommons.org/publicdomain/zero/1.0/)
License.
