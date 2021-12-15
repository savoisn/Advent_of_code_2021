defmodule AdventOfCode07Test do
  use ExUnit.Case
  # doctest AdventOfCode07

  setup do
    # do someting to setup test

    on_exit(fn ->
      # do something when test exits
      nil
    end)
  end

  @entries """
  16,1,2,0,4,2,7,1,2,14
  """

  test "dummy test" do
    entries =
      @entries
      |> String.split("\n", trim: true)

    assert AdventOfCode07.process_part1(entries) == 37
  end

  test "complexe test" do
    entries =
      @entries
      |> String.split("\n", trim: true)

    assert AdventOfCode07.process_part2(entries) == 168
  end

  test "day 07 part1" do
    entries = AdventOfCode07.read_file()
    res = AdventOfCode07.process_part1(entries)
    IO.puts("07-part1 " <> Integer.to_string(res))
  end

  test "day 07 part2" do
    entries = AdventOfCode07.read_file()
    res = AdventOfCode07.process_part2(entries)
    IO.puts("07-part2 " <> Integer.to_string(res))
  end
end
