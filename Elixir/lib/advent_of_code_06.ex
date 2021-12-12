defmodule AdventOfCode06 do
  @input "../06.txt"

  def read_file do
    File.read!(@input)
    |> String.split("\n", trim: true)
  end

  def process_part1(entries, nb_days) do
    entries = entries |> process_entries

    Enum.reduce(0..(nb_days - 1), entries, fn _day, current_day_entries ->
      Enum.reduce(current_day_entries, [], fn
        0, acc ->
          [6 | [8 | acc]]

        x, acc ->
          [x - 1 | acc]
      end)
    end)
    |> length
  end

  def process_entries([entries]) do
    entries
    |> String.split(",")
    |> Enum.map(fn e ->
      String.to_integer(e)
    end)
  end

  def process_part2(entries, nb_days) do
    frequencies =
      entries
      |> process_entries
      |> Enum.frequencies()

    amount =
      Enum.map(0..8, fn i -> frequencies[i] || 0 end)
      |> List.to_tuple()

    1..nb_days
    |> Enum.reduce(amount, fn
      _, {day0, day1, day2, day3, day4, day5, day6, day7, day8} ->
        {day1, day2, day3, day4, day5, day6, day7 + day0, day8, day0}
    end)
    |> Tuple.sum()
  end
end
