defmodule AdventOfCode11Test do
  use ExUnit.Case

  @entries """
  5483143223
  2745854711
  5264556173
  6141336146
  6357385478
  4167524645
  2176841721
  6882881134
  4846848554
  5283751526
  """

  @result """
  0397666866
  0749766918
  0053976933
  0004297822
  0004229892
  0053222877
  0532222966
  9322228966
  7922286866
  6789998766
  """

  @my_file "../11.txt"

  @small_nb_step 3

  test "simple test" do
    entries = Helper.format_entries(@entries)
    result = Helper.format_entries(@result)

    assert AdventOfCode11.process_part1(entries) == 1656
  end

  test "complexe test" do
    entries = Helper.format_entries(@entries)
    result = Helper.format_entries(@result)

    assert AdventOfCode11.process_part2(entries) == 195
  end

  test "day 11 part1" do
    entries = Helper.read_file(@my_file)
    res = AdventOfCode11.process_part1(entries)
    IO.puts("11-part1 " <> Integer.to_string(res))
  end

  test "day 11 part2" do
    entries = Helper.read_file(@my_file)
    res = AdventOfCode11.process_part2(entries)
    IO.puts("11-part2 " <> Integer.to_string(res))
  end
end
