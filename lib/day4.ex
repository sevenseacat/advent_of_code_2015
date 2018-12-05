defmodule Day4 do
  @doc """
  iex> Day4.part1("abcdef")
  609043

  iex> Day4.part1("pqrstuv")
  1048970
  """
  def part1(input), do: do_parts(input, 0, "00000")
  def part2(input), do: do_parts(input, 0, "000000")

  defp do_parts(input, counter, prefix) do
    md5 = :crypto.hash(:md5, "#{input}#{counter}") |> Base.encode16()

    if String.starts_with?(md5, prefix) do
      counter
    else
      do_parts(input, counter + 1, prefix)
    end
  end

  def bench do
    Benchee.run(
      %{
        "day 4, part 1" => fn -> part1("yzbqklnj") end,
        "day 4, part 2" => fn -> part2("yzbqklnj") end
      },
      Application.get_env(:advent, :benchee)
    )

    :ok
  end
end
