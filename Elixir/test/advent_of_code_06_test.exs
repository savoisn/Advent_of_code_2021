defmodule AdventOfCode06Test do
  use ExUnit.Case

  setup do
    # do someting to setup test

    on_exit(fn ->
      # do something when test exits
      nil
    end)
  end

  @entries """
  3,4,3,1,2
  """

  @nb_days_part1 80
  @nb_days_part2 256

  test "simple process entry" do
    entries =
      @entries
      |> String.split("\n", trim: true)

    res = AdventOfCode06.process_part1(entries, @nb_days_part1)
    assert(res == 5934)
  end

  @tag timeout: :infinity
  test "day 06 part1" do
    entries = AdventOfCode06.read_file()
    res = AdventOfCode06.process_part1(entries, @nb_days_part1)
    IO.puts("06-part1 " <> Integer.to_string(res))
  end

  test "complexe process entry" do
    entries =
      @entries
      |> String.split("\n", trim: true)

    res = AdventOfCode06.process_part2(entries, @nb_days_part2)
    assert(res == 26_984_457_539)
  end

  test "day 06 part2" do
    entries = AdventOfCode06.read_file()
    res = AdventOfCode06.process_part2(entries, @nb_days_part2)
    IO.puts("06-part2 " <> Integer.to_string(res))
  end
end
