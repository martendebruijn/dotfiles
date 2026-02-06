# Dotfiles

Opinionated macOS setup that keeps shell customizations, app preferences, and platform tooling in one place. Everything in this repo is safe to version control, so you can rebuild a workstation quickly or track tweaks over time.

## Prerequisites

- macOS with Command Line Tools (`xcode-select --install`)
- Homebrew (<https://brew.sh>)
- Git with access to your dotfiles remote
- Python 3.11+ for the helper scripts in `py_scripts`

## Getting Started

1. **Clone** the repository somewhere stable (the examples below assume `~/Documents/Business/business-coding-projects/dotfiles`).
2. **Review before linking.** Never blindly overwrite your existing config; compare each file and decide whether to merge or replace.
3. **Symlink or copy** the pieces you need:
   ```bash
   ln -s ~/Documents/Business/business-coding-projects/dotfiles/git ~/.config/git
   ln -s ~/Documents/Business/business-coding-projects/dotfiles/zsh ~/.config/zsh
   ```
   Adjust the destinations if you prefer `~/.gitconfig`, `~/.zshrc`, or another layout.
4. **Install packages** tracked in the Brewfile:
   ```bash
   cd ~/Documents/Business/business-coding-projects/dotfiles/brew
   brew bundle install --file=Brewfile
   ```
5. **Reload your shell** (or open a new terminal tab) to pick up the custom functions and environment variables.

## Repository Layout

| Path                             | Highlights                                                                                                                                                                  |
| -------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `brew/Brewfile`                  | Canonical list of formulae, casks, and Mac App Store apps. Use `brew bundle` to reproduce the toolchain.                                                                    |
| `ghostty/config`                 | Terminal profile for Ghostty (colors, fonts, window behavior). Symlink into `~/Library/Application Support/com.mitchellh.ghostty` or wherever Ghostty expects it.           |
| `git/`                           | Git configuration snippets (aliases, diffs, ignores). Source or link them from `~/.gitconfig` via the `include.path` directive.                                             |
| `py_scripts/check_file_names.py` | Quick validator that enforces a `YYYY-MM-DD-*` naming convention inside a directory. Helpful for journaling or meeting note archives.                                       |
| `py_scripts/maintenance.py`      | Automates a full system update loop: Homebrew upgrade, `mas upgrade`, cleanup, Brewfile dump/commit, `tldr --update`, and global `npm` refreshes.                           |
| `zsh/custom/*.zsh`               | Modular Zsh functions and aliases split by topic (`git`, `homebrew`, `python`, etc.). Source them from your `~/.zshrc` to keep the shell prompt consistent across machines. |

## Daily Driver Tips

- Add `source ~/Documents/Business/business-coding-projects/dotfiles/zsh/custom/*.zsh` (or a more selective glob) inside `.zshrc` so new functions are always available.
- The Ghostty config is tuned for development: ligature-friendly fonts, focus mode colors, and fast key bindings. Tailor it and commit your changes when you switch work styles.
- Keep the Brewfile authoritative. Any time you install or remove a package, rerun `brew bundle dump -f --describe --file=brew/Brewfile` and commit the delta.

## Automations

### System maintenance

The `py_scripts/maintenance.py` script rolls multiple housekeeping chores into one command.

```bash
python3 py_scripts/maintenance.py
```

What it does:

- Updates and upgrades Homebrew formulae, casks, and Mac App Store apps
- Cleans cache/outdated downloads and prunes orphaned dependencies
- Regenerates the Brewfile (with descriptions) and pushes it if it changed
- Refreshes the `tldr` database, `npm`, and `npm-check-updates`

Consider scheduling it with `launchd`, `cron`, or a manual reminder every week.

### File name linting

If you keep dated files (journals, meeting notes, receipts), run the validator to confirm they follow the enforced format.

```bash
python3 py_scripts/check_file_names.py
```

When prompted, supply the directory path. Any filenames that do not start with `YYYY-MM-DD-` will be listed.

## Contributing / Personalizing

This repo is intentionally personal. If you fork it:

- Swap out fonts, colors, or aliases you do not use
- Update paths inside scripts (for example, `BREWFILE_PATH` in `maintenance.py`) to match your directory structure
- Add per-machine overrides by sourcing `~/.zshrc.local` or `~/.gitconfig.local` before loading the shared pieces

Whenever you make iterative improvements, commit with context (why you changed a keybinding, why a tool was added/removed) so future-you understands the rationale.

## Troubleshooting

- `brew bundle` failures usually mean a formula changed name or moved taps. Check `brew search <name>` and update the Brewfile accordingly.
- If `maintenance.py` cannot find the Brewfile, verify the `BREWFILE_PATH` constant reflects the actual clone location.
- For Zsh sourcing issues, run `echo $fpath` and ensure the custom folder is available, or add it manually: `fpath=(~/Documents/.../zsh/custom $fpath)`.

---

Need to replicate this setup on a new machine? Clone the repo, run the Brewfile, and connect the dots—everything else is documented here.
