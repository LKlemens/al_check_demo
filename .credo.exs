%{
  configs: [
    %{
      name: "default",
      files: %{
        included: ["lib/", "test/"],
        excluded: []
      },
      strict: false,
      color: true,
      checks: [
        # Bumped severity so the seeded defects in `lib/al_check_demo/parser.ex`
        # and `lib/al_check_demo/lists.ex` reliably fail the credo step.
        {Credo.Check.Readability.ModuleDoc, []},
        {Credo.Check.Readability.FunctionNames, []},
        {Credo.Check.Warning.IoInspect, []},
        {Credo.Check.Refactor.Nesting, [max_nesting: 2]}
      ]
    }
  ]
}
