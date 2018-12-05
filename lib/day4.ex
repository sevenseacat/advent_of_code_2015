defmodule Day4 do
  @key "yzbqklnj"

  @doc """
  iex> Day4.part1("abcdef")
  609043

  iex> Day4.part1("pqrstuv")
  1048970
  """
  def part1(input), do: do_parts(input, 0, 20)
  def part2(input), do: do_parts(input, 282_749, 24)

  defp do_parts(input, counter, size) do
    # 5 hexadecimal 0s are 20 bits. 6 are 24.
    case :erlang.md5(input <> Integer.to_string(counter)) do
      <<0::size(size), _::bits>> ->
        counter

      _ ->
        do_parts(input, counter + 1, size)
    end
  end

  def bench do
    Benchee.run(
      %{
        "day 4, part 1" => fn -> part1(@key) end,
        "day 4, part 2" => fn -> part2(@key) end
      },
      Application.get_env(:advent, :benchee)
    )

    :ok
  end
end
