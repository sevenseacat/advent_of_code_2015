defmodule Day8 do
  def part1(filename) do
    filename
    |> parse_input
    |> Enum.map(&raw_length/1)
    |> Enum.sum()
  end

  def part2(filename) do
    filename
    |> parse_input
    |> Enum.map(&cooked_length/1)
    |> Enum.sum()
  end

  def parse_input(filename) do
    Stream.resource(
      fn -> File.open!(filename, [:binary]) end,
      fn file -> parse_line(file) end,
      fn file -> File.close(file) end
    )
  end

  defp parse_line(file) do
    case IO.binread(file, :line) do
      :eof -> {:halt, file}
      line -> {[String.trim(line)], file}
    end
  end

  def raw_length(raw) do
    {cooked, _} = Code.eval_string(raw)
    String.length(raw) - String.length(cooked)
  end

  def cooked_length(raw) do
    cooked =
      raw
      |> String.replace("\\", "\\\\")
      |> String.replace("\"", "\\\"")

    # 2 - extra quotes needed after the old ones were escaped
    String.length(cooked) - String.length(raw) + 2
  end

  def bench do
    Benchee.run(
      %{
        "day 8, part 1" => fn -> Day8.part1("lib/data/day8") end,
        "day 8, part 2" => fn -> Day8.part2("lib/data/day8") end
      },
      Application.get_env(:advent, :benchee)
    )

    :ok
  end
end
