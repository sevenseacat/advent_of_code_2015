defmodule Day11 do
  @input "hxbxwxba"

  @doc """
  iex> Day11.part1("abcdefgh")
  "abcdffaa"

  iex> Day11.part1("ghijklmn")
  "ghjaabcc"
  """
  def part1(input \\ @input) do
    input
    |> cook
    |> do_part1
    |> uncook
  end

  defp do_part1(chars) do
    if valid_password?(chars) do
      chars
    else
      # Increment and try again...
      chars
      |> increment_char
      |> do_part1
    end
  end

  def cook(string) do
    string
    |> String.reverse()
    |> String.to_charlist()
  end

  def uncook(chars) do
    chars
    |> IO.chardata_to_string()
    |> String.reverse()
  end

  @doc """
  iex> Day11.increment("abcdefgh")
  "abcdefgi"

  iex> Day11.increment("abcdefgz")
  "abcdefha"

  iex> Day11.increment("abcdzzzz")
  "abceaaaa"
  """
  def increment(input) do
    input
    |> cook
    |> increment_char
    |> uncook
  end

  defp increment_char([?z | rest]), do: [?a | increment_char(rest)]
  defp increment_char([notz | rest]), do: [notz + 1 | rest]

  @doc """
  iex> "hijklmmn" |> Day11.cook |> Day11.valid_password?
  false

  iex> "abbceffg" |> Day11.cook |> Day11.valid_password?
  false

  iex> "abbcegjk" |> Day11.cook |> Day11.valid_password?
  false

  iex> "abcdffaa" |> Day11.cook |> Day11.valid_password?
  true

  iex> "ghjaabcc" |> Day11.cook |> Day11.valid_password?
  true
  """
  def valid_password?(chars) do
    !forbidden_letters?(chars) && double_letters?(chars, 0) && has_sequence?(chars)
  end

  defp double_letters?(_, 2), do: true
  defp double_letters?([x, x | rest], count), do: double_letters?(rest, count + 1)
  defp double_letters?([_, y | rest], count), do: double_letters?([y | rest], count)
  defp double_letters?(_, _), do: false

  defp forbidden_letters?(chars) do
    Enum.any?(chars, fn char -> char == ?i || char == ?o || char == ?l end)
  end

  defp has_sequence?([z, y, x | rest]) do
    if y == x + 1 && z == y + 1 do
      true
    else
      has_sequence?([y, x | rest])
    end
  end

  defp has_sequence?(_), do: false

  def bench do
    Benchee.run(
      %{
        "day 11, part 1" => fn -> Day11.part1() end,
        "day 11, part 2" => fn ->
          Day11.part1()
          |> Day11.increment()
          |> Day11.part1()
        end
      },
      Application.get_env(:advent, :benchee)
    )

    :ok
  end
end
