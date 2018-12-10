defmodule Day12 do
  @doc """
  iex> Day12.part1("{\\"a\\":2,\\"b\\":4}")
  6

  iex> Day12.part1("{\\"a\\":[-1,1]}")
  0

  iex> Day12.part1("{}")
  0

  iex> Day12.part1("[[[3]]]")
  3
  """
  def part1(input) do
    Regex.scan(~r/-?\d+/, input)
    |> List.flatten()
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
  end
end
