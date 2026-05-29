# al_check_demo

Fixture project + Livebook tour for [`al_check`](../al_check). The library is
deliberately **red on a fresh clone** — one planted defect per check
category, each tagged `# DEMO:` in the source.

## Seeded defects

| Category      | File                                  | Defect                                         |
| ------------- | ------------------------------------- | ---------------------------------------------- |
| format        | `lib/al_check_demo/strings.ex`        | Bad indentation + trailing whitespace          |
| compile       | `lib/al_check_demo/parser.ex`         | Unused alias (fails `mix compile --warnings-as-errors`) |
| credo         | `lib/al_check_demo/parser.ex`         | `IO.inspect`, deep nesting                     |
| credo_strict  | `lib/al_check_demo/lists.ex`          | Missing `@moduledoc`, camelCase function name  |
| dialyzer      | `lib/al_check_demo/validator.ex`      | `@spec` declares `String.t()`, returns integer |
| test          | `test/al_check_demo/calculator_test.exs` | One wrong `assert` on `add/2`              |
| sobelow       | `lib/al_check_demo/parser.ex`         | `Code.eval_string/1` on user input             |

## Setup

```
mix deps.get
mix compile
mix test            # 1 failure, by design
```

Requires the sibling `../al_check` checkout (path dep in `mix.exs`).

## Run the tour

```
livebook server demo.livemd
```

Then open the URL Livebook prints. The tour leads with green scenarios
(check, --only test, --coverage, --only modified_tests, --partitions) on
a clean snapshot of the code, then finishes with one red scenario
(`check --fast`) showing how al_check surfaces the planted defects.

Generate the casts before the first run:

```
./scripts/record-casts.sh    # needs asciinema and `check` on PATH
```

The recorder swaps in clean copies from `scripts/_clean/` before the
green pass and restores the defective originals before the red pass.
