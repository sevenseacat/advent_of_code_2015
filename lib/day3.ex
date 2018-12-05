defmodule Day3 do
  @doc """
  iex> Day3.part1(">")
  2

  iex> Day3.part1("^>v<")
  4

  iex> Day3.part1("^v^v^v^v^v")
  2
  """
  def part1(input) do
    input
    |> String.graphemes()
    |> Enum.reduce(starting_state(), &move/2)
    |> hd
    |> Enum.count()
  end

  def part2(input) do
    moves = String.graphemes(input)

    santa_moves = Enum.drop_every(moves, 2)
    robosanta_moves = Enum.take_every(moves, 2)

    santa_grid = Enum.reduce(santa_moves, starting_state(), &move/2) |> hd
    final_grid = Enum.reduce(robosanta_moves, [santa_grid, {0, 0}], &move/2) |> hd

    Enum.count(final_grid)
  end

  defp starting_state, do: [%{{0, 0} => 1}, {0, 0}]

  defp move("^", [grid, {x, y}]), do: add_to_grid(grid, {x, y + 1})
  defp move("v", [grid, {x, y}]), do: add_to_grid(grid, {x, y - 1})
  defp move("<", [grid, {x, y}]), do: add_to_grid(grid, {x - 1, y})
  defp move(">", [grid, {x, y}]), do: add_to_grid(grid, {x + 1, y})

  defp add_to_grid(grid, position) do
    new_grid = Map.update(grid, position, 1, &(&1 + 1))
    [new_grid, position]
  end

  def bench do
    Benchee.run(
      %{
        "day 3, part 1" => fn -> Advent.data(3) |> part1 end,
        "day 3, part 2" => fn -> Advent.data(3) |> part2 end
      },
      Application.get_env(:advent, :benchee)
    )

    :ok
  end
end
