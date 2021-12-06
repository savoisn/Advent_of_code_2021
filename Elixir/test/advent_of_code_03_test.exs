defmodule AvdentOfCode03Test do
  use ExUnit.Case

  @entries """
  00100
  11110
  10110
  10111
  10101
  01111
  00111
  11100
  10000
  11001
  00010
  01010
  """

  test "simple process_entries" do
    entries =
      @entries
      |> String.split("\n", trim: true)

    res = AdventOfCode03.process_part1(entries)
    assert(res == 198)
  end

  test "day 03 part1" do
    entries = AdventOfCode03.read_file()
    res = AdventOfCode03.process_part1(entries)
    IO.puts("03-part1 " <> Integer.to_string(res))
  end

  test "day 03 exemple" do
    entries =
      @entries
      |> String.split("\n", trim: true)

    res = AdventOfCode03.process_part2(entries)
    IO.inspect(res)
    assert(res == 230)
  end

  test "day 03 part2" do
    entries = AdventOfCode03.read_file()
    res = AdventOfCode03.process_part2(entries)
    IO.puts("03-part2 " <> Integer.to_string(res))
  end
end
