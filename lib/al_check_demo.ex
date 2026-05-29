defmodule AlCheckDemo do
  @moduledoc """
  Tiny utilities library used as a fixture for the AlCheck tour.

  Every submodule under `AlCheckDemo.*` contains intentional defects so that the
  `check` tool has something to report. Look for `# DEMO:` comments to locate
  each planted issue.
  """

  @doc """
  Returns the library name.

  ## Examples

      iex> AlCheckDemo.name()
      "al_check_demo"

  """
  @spec name() :: String.t()
  def name, do: "al_check_demo"
end
