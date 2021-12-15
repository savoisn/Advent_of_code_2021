defmodule AdventOfCode08Test do
  use ExUnit.Case

  @entries """
  be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
  edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
  fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
  fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
  aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
  fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
  dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
  bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
  egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
  gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce
  """

  test "simple task" do
    entries =
      @entries
      |> String.split("\n", trim: true)

    assert AdventOfCode08.process_part1(entries) == 26
  end

  test "complexe test" do
    entries =
      @entries
      |> String.split("\n", trim: true)

    assert AdventOfCode08.process_part2(entries) == 168
  end

  test "day 08 part1" do
    entries = AdventOfCode08.read_file()
    res = AdventOfCode08.process_part1(entries)
    IO.puts("08-part1 " <> Integer.to_string(res))
  end

  @tag :skip
  test "day 08 part2" do
    entries = AdventOfCode08.read_file()
    res = AdventOfCode08.process_part2(entries)
    IO.puts("08-part2 " <> Integer.to_string(res))
  end
end
