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
  doctest Day17

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

  describe "Day18" do
    test "parse_input/1" do
      input = ".#.#.#\n...##.\n#....#\n..#...\n#.#..#\n####.."

      expected = %{
        {0, 0} => :off,
        {0, 1} => :on,
        {0, 2} => :off,
        {0, 3} => :on,
        {0, 4} => :off,
        {0, 5} => :on,
        {1, 0} => :off,
        {1, 1} => :off,
        {1, 2} => :off,
        {1, 3} => :on,
        {1, 4} => :on,
        {1, 5} => :off,
        {2, 0} => :on,
        {2, 1} => :off,
        {2, 2} => :off,
        {2, 3} => :off,
        {2, 4} => :off,
        {2, 5} => :on,
        {3, 0} => :off,
        {3, 1} => :off,
        {3, 2} => :on,
        {3, 3} => :off,
        {3, 4} => :off,
        {3, 5} => :off,
        {4, 0} => :on,
        {4, 1} => :off,
        {4, 2} => :on,
        {4, 3} => :off,
        {4, 4} => :off,
        {4, 5} => :on,
        {5, 0} => :on,
        {5, 1} => :on,
        {5, 2} => :on,
        {5, 3} => :on,
        {5, 4} => :off,
        {5, 5} => :off
      }

      assert Day18.parse_input(input) == expected
    end

    test "format_output/1" do
      input = %{
        {0, 0} => :off,
        {0, 1} => :on,
        {0, 2} => :off,
        {0, 3} => :on,
        {0, 4} => :off,
        {0, 5} => :on,
        {1, 0} => :off,
        {1, 1} => :off,
        {1, 2} => :off,
        {1, 3} => :on,
        {1, 4} => :on,
        {1, 5} => :off,
        {2, 0} => :on,
        {2, 1} => :off,
        {2, 2} => :off,
        {2, 3} => :off,
        {2, 4} => :off,
        {2, 5} => :on,
        {3, 0} => :off,
        {3, 1} => :off,
        {3, 2} => :on,
        {3, 3} => :off,
        {3, 4} => :off,
        {3, 5} => :off,
        {4, 0} => :on,
        {4, 1} => :off,
        {4, 2} => :on,
        {4, 3} => :off,
        {4, 4} => :off,
        {4, 5} => :on,
        {5, 0} => :on,
        {5, 1} => :on,
        {5, 2} => :on,
        {5, 3} => :on,
        {5, 4} => :off,
        {5, 5} => :off
      }

      expected = ".#.#.#\n...##.\n#....#\n..#...\n#.#..#\n####.."

      assert Day18.format_output(input) == expected
    end

    test "running loops, part 1" do
      parsed_input = Day18.parse_input(".#.#.#\n...##.\n#....#\n..#...\n#.#..#\n####..")
      c = & &1
      step1 = "..##..\n..##.#\n...##.\n......\n#.....\n#.##.."
      step2 = "..###.\n......\n..###.\n......\n.#....\n.#...."
      step3 = "...#..\n......\n...#..\n..##..\n......\n......"
      step4 = "......\n......\n..##..\n..##..\n......\n......"

      assert parsed_input |> Day18.loop(1, c) |> Day18.format_output() == step1
      assert parsed_input |> Day18.loop(2, c) |> Day18.format_output() == step2
      assert parsed_input |> Day18.loop(3, c) |> Day18.format_output() == step3
      assert parsed_input |> Day18.loop(4, c) |> Day18.format_output() == step4
    end
  end
end
