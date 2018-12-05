defmodule Day2 do
  def part1(input) do
    input
    |> parse_input
    |> Enum.map(&paper_required/1)
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> parse_input
    |> Enum.map(&ribbon_required/1)
    |> Enum.sum()
  end

  @doc """
  iex> Day2.paper_required([2, 3, 4])
  58

  iex> Day2.paper_required([1, 1, 10])
  43
  """
  def paper_required([w, l, h]) do
    sides = [w * l, l * h, h * w]
    Enum.sum(sides) * 2 + Enum.min(sides)
  end

  @doc """
  iex> Day2.ribbon_required([2, 3, 4])
  34

  iex> Day2.ribbon_required([1, 1, 10])
  14
  """
  def ribbon_required([w, l, h]) do
    %{
      (w * l) => 2 * w + 2 * l,
      (l * h) => 2 * l + 2 * h,
      (h * w) => 2 * h + 2 * w
    }
    |> Enum.min_by(fn {area, _} -> area end)
    |> elem(1)
    |> Kernel.+(w * l * h)
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_row/1)
  end

  defp parse_row(row) do
    row
    |> String.split("x")
    |> Enum.map(&String.to_integer/1)
  end

  def bench do
    Benchee.run(
      %{
        "day 2, part 1" => fn -> Advent.data(2) |> part1 end,
        "day 2, part 2" => fn -> Advent.data(2) |> part2 end
      },
      Application.get_env(:advent, :benchee)
    )

    :ok
  end
end
