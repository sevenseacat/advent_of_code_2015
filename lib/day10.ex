defmodule Day10 do
  @input 1_113_222_113

  @doc """
  iex> Day10.part1(1, 1)
  {11, 2}

  iex> Day10.part1(1, 2)
  {21, 2}

  iex> Day10.part1(1, 3)
  {1211, 4}

  iex> Day10.part1(1, 4)
  {111221, 6}

  iex> Day10.part1(1, 5)
  {312211, 6}
  """
  def part1(input, times) do
    input
    |> Integer.to_string()
    |> String.graphemes()
    |> look_and_say(times)
  end

  def look_and_say(input, 0) do
    {input |> List.to_string() |> String.to_integer(), length(input)}
  end

  def look_and_say(input, times) do
    input
    |> Enum.chunk_by(fn x -> x end)
    |> Enum.reduce([], fn list, acc -> [hd(list), "#{length(list)}" | acc] end)
    |> Enum.reverse()
    |> look_and_say(times - 1)
  end

  def bench do
    Benchee.run(
      %{
        "day 10, part 1" => fn -> Day10.part1(@input, 40) end,
        "day 10, part 2" => fn -> Day10.part1(@input, 50) end
      },
      Application.get_env(:advent, :benchee)
    )

    :ok
  end
end
