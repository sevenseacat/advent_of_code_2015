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
end
