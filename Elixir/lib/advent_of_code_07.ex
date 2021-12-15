defmodule AdventOfCode07 do
  @input "../07.txt"

  def read_file do
    File.read!(@input)
    |> String.split("\n", trim: true)
  end

  def process_part1(entries) do
    entries =
      entries
      |> process_entries

    max_pos = Enum.max(entries)

    Enum.reduce(0..max_pos, [], fn pos, acc ->
      cost =
        Enum.reduce(entries, 0, fn e, acc ->
          acc + abs(e - pos)
        end)

      [{pos, cost} | acc]
    end)
    |> Enum.min(fn {_, value}, {_, value2} ->
      value < value2
    end)
    |> then(fn e ->
      elem(e, 1)
    end)
  end

  def process_part2(entries) do
    entries =
      entries
      |> process_entries

    max_pos = Enum.max(entries)

    costs =
      Enum.reduce(0..max_pos, %{}, fn pos, acc ->
        Map.put(
          acc,
          pos,
          Enum.reduce(0..pos, 0, fn e, acc2 ->
            acc2 + e
          end)
        )
      end)

    Enum.reduce(0..max_pos, [], fn pos, acc ->
      cost =
        Enum.reduce(entries, 0, fn e, acc ->
          acc + costs[abs(e - pos)]
        end)

      [{pos, cost} | acc]
    end)
    |> Enum.min(fn {_, value}, {_, value2} ->
      value < value2
    end)
    |> then(fn e ->
      elem(e, 1)
    end)
  end

  def process_entries([entries]) do
    entries
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end
end
