defmodule AdventTest do
  use ExUnit.Case
  doctest Day1
  doctest Day2
  doctest Day3
  doctest Day4
  doctest Day5
  doctest Day6
  doctest Day7
  doctest Day8
  doctest Day9
  doctest Day10
  doctest Day11
  doctest Day12
  doctest Day14

  describe "Day13" do
    test "can parse input" do
      input = "Alice would gain 54 happiness units by sitting next to Bob.
Alice would lose 79 happiness units by sitting next to Carol."
      output = [{"Alice", "Bob", 54}, {"Alice", "Carol", -79}]

      assert Day13.parse_input(input) == output
    end

    test "part1" do
      input = File.read!("test/data/day13")
      output = {[{"Alice", 52}, {"Bob", 76}, {"Carol", 115}, {"David", 87}], 330}

      assert Day13.part1(input) == output
    end
  end

  describe "Day15" do
    test "score for cookie" do
      expected = 62_842_880

      result =
        Day15.score_for_cookie(
          [{"Butterscotch", 44}, {"Cinnamon", 56}],
          [
            %{
              name: "Butterscotch",
              capacity: -1,
              durability: -2,
              flavor: 6,
              texture: 3,
              calories: 8
            },
            %{name: "Cinnamon", capacity: 2, durability: 3, flavor: -2, texture: -1, calories: 3}
          ]
        )

      assert expected == result
    end
  end
end
