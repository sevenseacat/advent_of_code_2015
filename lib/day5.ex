defmodule Day5 do
  @vowels ~w/a e i o u/
  @forbidden_sequences ~w/ab cd pq xy/

  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.count(&nice?/1)
  end

  def part2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.count(&new_nice?/1)
  end

  @doc """
  iex> Day5.nice?("ugknbfddgicrmopn")
  true

  iex> Day5.nice?("aaa")
  true

  iex> Day5.nice?("jchzalrnumimnmhp")
  false

  iex> Day5.nice?("haegwjzuvuyypxyu")
  false

  iex> Day5.nice?("dvszwmarrgswjxmb")
  false
  """
  def nice?(string) do
    string
    |> String.graphemes()
    |> check_nice_rules({0, false, false})
  end

  @doc """
  iex> Day5.new_nice?("qjhvhtzxzqqjkmpb")
  true

  iex> Day5.new_nice?("xxyxx")
  true

  iex> Day5.new_nice?("uurcxstgmygtbstg")
  false

  iex> Day5.new_nice?("ieodomkazucvgmuy")
  false
  """
  def new_nice?(string) do
    Regex.match?(~r/(.)\w\1/, string) && Regex.match?(~r/(.)(.)\w*\1\2/, string)
  end

  defp check_nice_rules([x], {vowels, double_letter, sequences}) do
    vowels = check_for_vowels(vowels, x)
    vowels >= 3 && double_letter && !sequences
  end

  defp check_nice_rules([x, y | rest], {vowels, double_letter, sequences}) do
    check_nice_rules([y | rest], {
      check_for_vowels(vowels, x),
      check_for_double_letter(double_letter, x, y),
      check_for_sequences(sequences, x, y)
    })
  end

  defp check_for_double_letter(true, _, _), do: true
  defp check_for_double_letter(_, x, x), do: true
  defp check_for_double_letter(_, _, _), do: false

  defp check_for_vowels(vowels, _) when vowels >= 3, do: vowels
  defp check_for_vowels(vowels, x) when x in @vowels, do: vowels + 1
  defp check_for_vowels(vowels, _), do: vowels

  defp check_for_sequences(true, _, _), do: true
  defp check_for_sequences(_, x, y), do: Enum.member?(@forbidden_sequences, "#{x}#{y}")

  def bench do
    Benchee.run(
      %{
        "day 5, part 1" => fn -> Advent.data(5) |> Day5.part1() end,
        "day 5, part 2" => fn -> Advent.data(5) |> Day5.part2() end
      },
      Application.get_env(:advent, :benchee)
    )

    :ok
  end
end
