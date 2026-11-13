# Local linting for benjaminchocolate/homebrew-tap.
#
# Uses a throwaway Homebrew clone (not the nix-homebrew one), because
# nix-homebrew's Library/Homebrew lives in the read-only Nix store and
# `brew audit` / `brew style` need to install gems there.

tap := "benjaminchocolate/tap"
lint_dir := env("XDG_CACHE_HOME", env("HOME") / ".cache") / "brew-lint"
brew := lint_dir / "bin/brew"
tap_link := lint_dir / "Library/Taps/benjaminchocolate/homebrew-tap"

# Never let the lint copy auto-update: that would `git pull` inside this repo
# through the symlink.
export HOMEBREW_NO_AUTO_UPDATE := "1"

# List recipes
default:
    @just --list

# Clone the lint copy of Homebrew and link this tap into it (safe to rerun)
setup:
    #!/usr/bin/env bash
    set -euo pipefail
    if [[ ! -x "{{ brew }}" ]]; then
      echo "Cloning Homebrew into {{ lint_dir }} ..."
      git clone --depth 1 https://github.com/Homebrew/brew "{{ lint_dir }}"
    fi
    mkdir -p "$(dirname "{{ tap_link }}")"
    ln -sfn "{{ justfile_directory() }}" "{{ tap_link }}"

# Check formatting and run a full audit of every cask
lint: setup
    {{ brew }} style {{ tap }}
    {{ brew }} audit --tap {{ tap }}

# Auto-fix formatting of the casks in place (check `git diff` afterwards).
# Only Casks/*.rb: autocorrecting README.md through rubocop-md mangles it.
fix: setup
    {{ brew }} style --fix Casks/*.rb

# Audit one cask, e.g. `just audit carla`
audit cask: setup
    {{ brew }} audit --cask {{ tap }}/{{ cask }}

# Pull the latest Homebrew into the lint copy (does not touch this repo)
update: setup
    git -C "{{ lint_dir }}" pull --ff-only

# Delete the lint copy entirely (this repo is untouched)
clean:
    rm -rf "{{ lint_dir }}"
