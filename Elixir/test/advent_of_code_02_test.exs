defmodule AvdentOfCode02Test do
  use ExUnit.Case

  @entries [
    "forward 5",
    "down 5",
    "forward 8",
    "up 3",
    "down 8",
    "forward 2"
  ]

  test "simple process_entries" do
    assert AdventOfCode02.simple_process_entries(@entries) == %{distance: 15, depth: 10}
  end

  test "simple_process_file" do
    entries = AdventOfCode02.read_file()
    res = AdventOfCode02.simple_process_entries(entries)
    result = res.depth * res.distance
    IO.puts("02-simple " <> Integer.to_string(result))
  end

  test "process_entries" do
    assert AdventOfCode02.process_entries(@entries) == %{distance: 15, depth: 60, aim: 10}
  end

  test "process_file" do
    entries = AdventOfCode02.read_file()
    res = AdventOfCode02.process_entries(entries)
    result = res.depth * res.distance
    IO.puts("02-complex " <> Integer.to_string(result))
  end
end
