defmodule AvdentOfCode05Test do
  use ExUnit.Case

  @entries """
  0,9 -> 5,9
  8,0 -> 0,8
  9,4 -> 3,4
  2,2 -> 2,1
  7,0 -> 7,4
  6,4 -> 2,0
  0,9 -> 2,9
  3,4 -> 1,4
  0,0 -> 8,8
  5,5 -> 8,2
  """

  test "simple process_entries" do
    entries =
      @entries
      |> String.split("\n", trim: true)

    res = AdventOfCode05.process_part1(entries)
    assert(res == 5)
  end

  test "advanced process_entries" do
    entries =
      @entries
      |> String.split("\n", trim: true)

    res = AdventOfCode05.process_part2(entries)
    IO.inspect(res)
    assert(res == 12)
  end

  test "plot diagnoal up right" do
    awaited = [{1, 1}, {2, 2}, {3, 3}, {4, 4}]
    assert awaited == AdventOfCode05.plot_diagonals({{1, 1}, {4, 4}})
  end

  test "plot diagnoal up left" do
    awaited = [{1, 4}, {2, 3}, {3, 2}, {4, 1}]
    assert awaited == AdventOfCode05.plot_diagonals({{1, 4}, {4, 1}})
  end

  test "plot diagnoal down left" do
    awaited = [{4, 4}, {3, 3}, {2, 2}, {1, 1}]
    assert awaited == AdventOfCode05.plot_diagonals({{4, 4}, {1, 1}})
  end

  test "plot diagnoal down right" do
    awaited = [{4, 1}, {3, 2}, {2, 3}, {1, 4}]
    assert awaited == AdventOfCode05.plot_diagonals({{4, 1}, {1, 4}})
  end

  test "day 05 part1" do
    entries = AdventOfCode05.read_file()
    res = AdventOfCode05.process_part1(entries)
    IO.puts("05-part1 " <> Integer.to_string(res))
  end

  test "day 05 part2" do
    entries = AdventOfCode05.read_file()
    res = AdventOfCode05.process_part2(entries)
    IO.puts("05-part2 " <> Integer.to_string(res))
  end
end
