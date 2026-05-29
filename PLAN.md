# al_check_demo — Plan

A fixture project + Livebook tour that showcases every feature of the
[`al_check`](../al_check) parallel code-quality runner.

## Shape

- **Project type:** plain Mix library (no Phoenix, no umbrella).
- **Seeded failures:** the demo starts red — one issue per check category — so a
  viewer can watch each scenario turn green.
- **Tour format:** Livebook (`demo.livemd`) with **pre-recorded asciinema
  casts** embedded above each scenario, plus **live `System.cmd` cells** so a
  viewer can also run it themselves.

## 1. Project skeleton

- `mix.exs` with `:al_check` as a `path: "../al_check"` dep (self-contained, no
  global install required), plus `:credo`, `:dialyxir`, `:sobelow`,
  `:excoveralls`.
- `.formatter.exs`, `.tool-versions` (mirrors al_check), `.gitignore`
  (ignores `_build/`, `deps/`, `.check/`, `cover/`, `*.coverdata`).
- `.dialyzer_ignore.exs` empty stub.
- `config/` reserved but empty for now.

## 2. Library source (~6 small modules)

Realistic-but-tiny utilities domain. Every public function gets `@doc` + a
non-primitive `@spec` (per CLAUDE.md).

| Module | Purpose |
|---|---|
| `AlCheckDemo` | Top-level moduledoc + library name |
| `AlCheckDemo.Calculator` | Arithmetic helpers |
| `AlCheckDemo.Strings` | String helpers |
| `AlCheckDemo.Lists` | List helpers |
| `AlCheckDemo.Money` | Money math (integer cents) |
| `AlCheckDemo.Validator` | Input validation |
| `AlCheckDemo.Parser` | Tiny key=value parser |

## 3. Seeded failures (clearly labeled `# DEMO:` in source)

| Category | Planted defect | Location |
|---|---|---|
| **format** | bad indentation + trailing whitespace | `lib/al_check_demo/strings.ex` |
| **credo** | leftover `IO.inspect`, unused alias, deep nesting | `lib/al_check_demo/parser.ex` |
| **credo_strict** | missing `@moduledoc`, non-idiomatic naming | `lib/al_check_demo/lists.ex` |
| **dialyzer** | `@spec` says `String.t()` but returns `integer()` | `lib/al_check_demo/validator.ex` |
| **failing test** | one wrong `assert` | `test/al_check_demo/calculator_test.exs` |
| **sobelow** (custom check) | `Code.eval_string/1` on user input | `lib/al_check_demo/parser.ex` |

## 4. Test suite

~25–30 small tests across 5 files (`calculator_test.exs`, `strings_test.exs`,
`lists_test.exs`, `money_test.exs`, `validator_test.exs`) — enough so
`--partitions 3` actually splits work and `--failed` has a real failing case to
re-run. Exactly **one** intentional failure.

## 5. `.check.json`

Tuned to showcase the tour scenarios:

```json
{
  "run": ["format", "compile", "compile_test", "credo", "credo_strict", "dialyzer", "test"],
  "fast": ["format", "compile", "credo"],
  "partitions": 3,
  "max_concurrency": 8,
  "coverage": {"mod": "native", "limit": 70, "html": false},
  "fix": [{"run": "mix format"}],
  "checks": {
    "sobelow": {"name": "Security", "run": "mix sobelow --config"},
    "modified_tests": {"run": "builtin:modified_tests"},
    "modified_test_modules": {"run": "builtin:modified_test_modules"}
  }
}
```

Plus a default `.credo.exs` and a minimal `.sobelow-conf`.

## 6. Livebook tour — `demo.livemd`

Scenarios in order. Each section: short markdown explanation → asciinema embed
(`Kino.HTML` with the asciinema player script) → live `System.cmd` cell that
runs the same command and prints captured output.

1. **Setup check** — verify `check` is on PATH (fallback instructions if not).
2. **Full run, all red** — `check` reports format, credo, dialyzer, test failures.
3. **`--fast`** — only the fast subset (format, compile, credo).
4. **`--only format,credo`** — selective checks.
5. **`--fix`** — auto-fix format, show diff before/after.
6. **`--only test --partitions 3`** — partitioned tests, partition outputs in `.check/`.
7. **`--failed`** — re-run only the one previously failing test.
8. **`--only modified_tests`** — create a small edit on a branch, then run.
9. **`--coverage`** — coverage report + caching behavior.
10. **Custom `sobelow` check** — runs the JSON-configured custom check.
11. **Caveats** — `--watch` and the animated spinner are best run live in a
    terminal; the asciinema casts above show them faithfully.

## 7. Asciinema recording workflow

- `scripts/record-casts.sh` records all scenarios via `asciinema rec -c "<cmd>"`
  into `casts/*.cast`.
- The Livebook embeds those files using the asciinema-player web component
  (loaded via CDN in a `Kino.HTML` cell, sources read from disk and base64-encoded
  or served via a tiny `Plug` — TBD; simplest is to ship the `.cast` files and
  embed by `file://` reference, falling back to a "run record-casts first"
  message if missing).
- Live `System.cmd` cells exist whether or not the casts have been recorded, so
  the notebook is always functional.

## 8. README

~20 lines: what the demo is for, list of seeded issues (with file paths), how
to open the Livebook, how to (re)record the casts.

## 9. Verification before handing off

- `mix deps.get`, `mix compile` — confirm the project compiles. The dialyzer
  defect is in a `@spec`, not a compile error.
- `mix test` — confirm exactly 1 failure.
- `check --only format` (if `check` is on PATH) — confirm the format failure
  surfaces. If not on PATH, skip and note in README.

## Known caveats

- **First-time dialyzer is slow** (PLT build). The Livebook will warn.
- **Livebook doesn't render the live spinner** — that's the whole reason for
  the asciinema casts. Live cells produce captured plain output.
- **Path dep on `../al_check`** — the demo assumes the two directories live
  side-by-side. README will say so.
