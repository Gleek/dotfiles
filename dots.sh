#!/usr/bin/env bash
set -eu

root="$(cd "$(dirname "$0")" && pwd)"
config="${XDG_CONFIG_HOME:-$HOME/.config}"

usage() {
  echo "usage: $0 {install|check|adopt [--home] NAME}"
  exit 1
}

link() {
  local action="$1" src="$2" dst="$3"

  if [[ -L "$dst" && -e "$dst" && "$src" -ef "$dst" ]]; then
    printf 'ok       %s\n' "$dst"
  elif [[ -e "$dst" || -L "$dst" ]]; then
    printf 'conflict %s\n' "$dst" >&2
    return 1
  elif [[ "$action" == install ]]; then
    ln -s "$src" "$dst"
    printf 'linked   %s -> %s\n' "$dst" "$src"
  else
    printf 'missing  %s -> %s\n' "$dst" "$src"
  fi
}

run() {
  local action="$1" src name status=0
  [[ "$action" == install ]] && mkdir -p "$config"

  for src in "$root"/home/{*,.[!.]*,..?*}; do
    [[ -e "$src" || -L "$src" ]] || continue
    link "$action" "$src" "$HOME/$(basename "$src")" || status=1
  done

  for src in "$root"/*; do
    name="$(basename "$src")"
    [[ -e "$src/$name" || -L "$src/$name" ]] || continue
    link "$action" "$src/$name" "$config/$name" || status=1
  done
  return "$status"
}

adopt() {
  local target="$config"
  if [[ "${1:-}" == --home ]]; then
    target="$HOME"
    shift
  fi
  [[ "$#" -eq 1 && "$1" != */* && "$1" != . && "$1" != .. ]] || usage

  local name="$1" src="$target/$1" dst
  if [[ "$target" == "$HOME" ]]; then
    dst="$root/home/$name"
  else
    name="${name#.}"
    dst="$root/$name/$name"
  fi

  [[ -e "$src" && ! -L "$src" ]] || { echo "error: not a regular config: $src" >&2; exit 1; }
  [[ ! -e "$dst" && ! -L "$dst" ]] || { echo "error: already managed: $dst" >&2; exit 1; }

  printf 'Move %s to %s? [y/N] ' "$src" "$dst"
  read -r answer
  [[ "$answer" == y || "$answer" == Y ]] || exit 1

  mkdir -p "$(dirname "$dst")"
  mv "$src" "$dst"
  if ! link install "$dst" "$src"; then
    mv "$dst" "$src"
    exit 1
  fi
}

case "${1:-}" in
  install|check) run "$1" ;;
  adopt) shift; adopt "$@" ;;
  *) usage ;;
esac
