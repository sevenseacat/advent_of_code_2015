defmodule Day11 do
  @input "hxbxwxba"

  @doc """
  iex> Day11.part1("abcdefgh")
  "abcdffaa"

  iex> Day11.part1("ghijklmn")
  "ghjaabcc"
  """
  def part1(input \\ @input) do
    if valid_password?(input) do
      input
    else
      # Increment and try again...
      input
      |> increment_string
      |> part1
    end
  end

  @doc """
  iex> Day11.increment_string("abcdefgh")
  "abcdefgi"

  iex> Day11.increment_string("abcdefgz")
  "abcdefha"

  iex> Day11.increment_string("abcdzzzz")
  "abceaaaa"
  """
  def increment_string(input) do
    chars =
      input
      |> String.reverse()
      |> String.to_charlist()

    chars
    |> gogogo
    |> IO.chardata_to_string()
    |> String.reverse()
  end

  defp gogogo([?z | rest]), do: [?a | gogogo(rest)]
  defp gogogo([notz | rest]), do: [notz + 1 | rest]

  @doc """
  iex> Day11.valid_password?("hijklmmn")
  false

  iex> Day11.valid_password?("abbceffg")
  false

  iex> Day11.valid_password?("abbcegjk")
  false

  iex> Day11.valid_password?("abcdffaa")
  true

  iex> Day11.valid_password?("ghjaabcc")
  true
  """
  def valid_password?(input) do
    !forbidden_letters?(input) && double_letters?(input) &&
      has_sequence?(String.to_charlist(input))
  end

  defp double_letters?(input), do: String.match?(input, ~r/(\w)\1.*(\w)\2/)
  defp forbidden_letters?(input), do: String.contains?(input, ["i", "o", "l"])

  defp has_sequence?([x, y, z | rest]) do
    if y == x + 1 && z == y + 1 do
      true
    else
      has_sequence?([y, z | rest])
    end
  end

  defp has_sequence?(_), do: false

  def bench do
    Benchee.run(
      %{
        "day 11, part 1" => fn -> Day11.part1() end,
        "day 11, part 2" => fn -> Day11.part1() |> Day11.increment_string() |> Day11.part1() end
      },
      Application.get_env(:advent, :benchee)
    )

    :ok
  end
end
