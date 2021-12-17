defmodule AdventOfCode10Test do
  use ExUnit.Case

  @entries """
  [({(<(())[]>[[{[]{<()<>>
  [(()[<>])]({[<{<<[]>>(
  {([(<{}[<>[]}>{[]{[(<()>
  (((({<>}<{<{<>}{[]{[]{}
  [[<[([]))<([[{}[[()]]]
  [{[{({}]{}}([{[{{{}}([]
  {<[[]]>}<{[{[{[]{()[[[]
  [<(<(<(<{}))><([]([]()
  <{([([[(<>()){}]>(<<{{
  <{([{{}}[<[[[<>{}]]]>[]]
  """

  @my_file '../10.txt'

  test "simple test" do
    entries = Helper.format_entries(@entries)
    assert AdventOfCode10.process_part1(entries) == 26397
  end

  test "complexe test" do
    entries = Helper.format_entries(@entries)
    assert AdventOfCode10.process_part2(entries) == 288_957
  end

  test "day 10 part1" do
    entries = Helper.read_file(@my_file)
    res = AdventOfCode10.process_part1(entries)
    IO.puts("10-part1 " <> Integer.to_string(res))
  end

  test "day 10 part2" do
    entries = Helper.read_file(@my_file)
    res = AdventOfCode10.process_part2(entries)
    IO.puts("10-part2 " <> Integer.to_string(res))
  end
end
