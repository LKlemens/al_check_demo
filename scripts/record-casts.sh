#!/usr/bin/env bash
# Re-record all asciinema casts used by demo.livemd.
#
# Records two passes:
#   1. GREEN — clean copies from scripts/_clean/ are swapped in, defects gone,
#      so check/test/coverage/etc. all pass. Captures the "healthy project"
#      scenarios.
#   2. RED  — original (defective) files restored. Captures the single failing
#      scenario (check --fast).
#
# Requirements:
#   - asciinema  (brew install asciinema)
#   - check      (the al_check escript on PATH; mix check.install from ../al_check)
#
# Cast files are wiped and rebuilt on each run.

set -u

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CASTS="$ROOT/casts"
CLEAN="$ROOT/scripts/_clean"
mkdir -p "$CASTS"

cd "$ROOT" || exit 1

if ! command -v asciinema >/dev/null 2>&1; then
  echo "asciinema not found. brew install asciinema (or apt install asciinema)." >&2
  exit 1
fi

if ! command -v check >/dev/null 2>&1; then
  echo "check escript not found on PATH. Install it from ../al_check (mix check.install)." >&2
  exit 1
fi

record() {
  local name="$1"
  shift
  local cmd="$*"
  local out="$CASTS/$name.cast"
  echo "==> recording $name :: $cmd"
  rm -f "$out"
  # `stty cols 90 rows 30` inside the inner bash forces tools (mix, check,
  # credo, etc.) to lay out their output as if the terminal were 90x30,
  # which matches the player's cols/rows override in demo.livemd. asciinema's
  # own --cols/--rows are ignored when recording inside tmux, so this is the
  # only reliable knob.
  asciinema rec --overwrite -c "bash -lc 'stty rows 30 cols 90; $cmd'" "$out"
}

# Wipe any stale casts so the directory exactly matches demo.livemd's references.
rm -f "$CASTS"/*.cast

# --- 01: setup. State doesn't matter — just shows --help.
record 01-setup "check --help | head -40"

# --- Backup defective files before swapping in clean copies.
BACKUP=$(mktemp -d)
cp -R lib test "$BACKUP/"

restore_red() {
  echo "==> restoring defective files"
  rm -rf lib test
  cp -R "$BACKUP/lib" "$BACKUP/test" "$ROOT/"
}
trap 'restore_red; rm -rf "$BACKUP"; exit 1' INT TERM

# --- Swap in clean copies.
echo "==> swapping in clean copies for the GREEN pass"
for f in strings parser lists validator; do
  cp "$CLEAN/lib/al_check_demo/$f.ex" "lib/al_check_demo/$f.ex"
done
cp "$CLEAN/test/al_check_demo/calculator_test.exs" "test/al_check_demo/calculator_test.exs"
cp "$CLEAN/test/al_check_demo/lists_test.exs"      "test/al_check_demo/lists_test.exs"

# --- Warm caches so recordings don't capture PLT builds / fresh compiles.
echo "==> warming caches (this may take a few minutes the first time)"
mix deps.get >/dev/null 2>&1 || true
mix compile  >/dev/null 2>&1 || true
MIX_ENV=test mix compile >/dev/null 2>&1 || true
mix dialyzer --plt 2>&1 | tail -3 || true
check >/dev/null 2>&1 || true   # populate .check cache (coverage baseline, etc.)

# --- GREEN casts.
record 02-green-full        "check"
record 03-green-tests       "check --only test"
record 04-green-coverage    "check --coverage"
record 05-green-modified    "check --only modified_tests --repeat 10"
record 06-green-partitions  "check --only test --partitions 5"
record 07-green-verbose     "check --only test --verbose"

# --- Restore defective state for the red pass.
restore_red
rm -rf "$BACKUP"
trap - INT TERM

# Re-warm compile in red state so the RED cast starts at a sensible point.
mix compile 2>/dev/null || true
MIX_ENV=test mix compile 2>/dev/null || true

# --- The single RED scenario.
record 08-red-fast "check --fast"

echo "Done. Casts written to $CASTS"
