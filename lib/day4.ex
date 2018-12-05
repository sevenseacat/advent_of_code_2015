defmodule Day4 do
  @key "yzbqklnj"

  @doc """
  iex> Day4.part1("abcdef")
  609043

  iex> Day4.part1("pqrstuv")
  1048970
  """
  def part1(input), do: do_parts(input, 0, &five_zeroes?/1)
  def part2(input), do: do_parts(input, 282_749, &six_zeroes?/1)

  defp do_parts(input, counter, fun) do
    # The biggest value we need to test against, fits inside three raw binary codepoints,
    # of 8 bits each - so size 24. Slice that off and use that to check against.
    # Reference: https://til.hashrocket.com/posts/7a5f3c7278-compute-md5-hash-of-a-string
    <<val::24, _::binary>> = :erlang.md5("#{input}#{counter}")

    if fun.(val) do
      counter
    else
      do_parts(input, counter + 1, fun)
    end
  end

  # 000000 is 0 and 00000F is therefore 15 - anything between those is five zeroes.
  defp five_zeroes?(val) when val <= 15, do: true
  defp five_zeroes?(_), do: false

  # And just 0 is six zeroes.
  defp six_zeroes?(0), do: true
  defp six_zeroes?(_), do: false

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
