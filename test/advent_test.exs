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

  describe "day 8, part 1" do
    test "sample input" do
      assert Day8.part1("test/data/day8") == 12
    end
  end
end
