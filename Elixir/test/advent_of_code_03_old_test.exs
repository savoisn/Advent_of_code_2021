defmodule AvdentOfCode03oldTest do
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

    res = AdventOfCode03old.simple_process_entries(entries)
    assert(res == 198)
  end

  test "simple_process_file" do
    entries = AdventOfCode03old.read_file()
    res = AdventOfCode03old.simple_process_entries(entries)
    # IO.puts("03-simple " <> Integer.to_string(res))
  end

  # test "process_entries" do
  # assert AdventOfCode03old.process_entries(@entries) == %{distance: 15, depth: 60, aim: 10}
  # end

  # test "process_file" do
  # entries = AdventOfCode03old.read_file()
  # res = AdventOfCode03old.process_entries(entries)
  # result = res.depth * res.distance
  # IO.puts("03-complex " <> Integer.to_string(result))
  # end
end
