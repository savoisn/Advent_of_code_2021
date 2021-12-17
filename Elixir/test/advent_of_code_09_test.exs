defmodule AdventOfCode09Test do
  use ExUnit.Case
  # doctest AdventOfCode09

  setup do
    # do someting to setup test

    on_exit(fn ->
      # do something when test exits
      nil
    end)
  end

  @entries """
  2199943210
  3987894921
  9856789892
  8767896789
  9899965678
  """

  @my_file "../09.txt"

  test "simple test" do
    entries =
      @entries
      |> String.split("\n", trim: true)

    assert AdventOfCode09.process_part1(entries) == 15
  end

  test "complexe test" do
    entries =
      @entries
      |> String.split("\n", trim: true)

    assert AdventOfCode09.process_part2(entries) == 1134
  end

  test "day 09 part1" do
    entries = Helper.read_file(@my_file)
    res = AdventOfCode09.process_part1(entries)
    IO.puts("09-part1 " <> Integer.to_string(res))
  end

  test "day 09 part2" do
    entries = Helper.read_file(@my_file)
    res = AdventOfCode09.process_part2(entries)
    IO.puts("09-part2 " <> Integer.to_string(res))
  end
end
