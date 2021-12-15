defmodule AdventOfCode08 do
  @input "../08.txt"

  def read_file do
    File.read!(@input)
    |> String.split("\n", trim: true)
  end

  def process_part1(entries) do
    entries
    |> Enum.map(&String.split(&1, " | ", trim: true))
    |> Enum.map(fn [_ | [tail]] -> tail end)
    |> Enum.map(&String.split(&1, " ", trim: true))
    |> Enum.map(fn [a, b, c, d] ->
      [String.length(a), String.length(b), String.length(c), String.length(d)]
    end)
    |> Enum.map(fn [a, b, c, d] ->
      [
        if(a in [2, 3, 4, 7], do: 1, else: 0),
        if(b in [2, 3, 4, 7], do: 1, else: 0),
        if(c in [2, 3, 4, 7], do: 1, else: 0),
        if(d in [2, 3, 4, 7], do: 1, else: 0)
      ]
    end)
    |> Enum.reduce(0, fn e, acc ->
      Enum.reduce(e, 0, fn f, acc2 ->
        acc2 + f
      end) + acc
    end)
  end

  def process_part2(entries) do
    rough_clues =
      entries
      |> Enum.map(&String.split(&1, " |", trim: true))
      |> Enum.map(fn [head | _] -> head end)
      |> Enum.map(&String.split(&1, " ", trim: true))

    # ['be', 'bde', 'bceg', 'abcdf', 'bcdef', 'cdefg', 'abdefg', 'acdefg', 'bcdefg', 'abcdefg']

    reference = %{
      "abcefg" => 0,
      "cf" => 1,
      "acdeg" => 2,
      "acdfg" => 3,
      "bcdf" => 4,
      "abdfg" => 5,
      "abdefg" => 6,
      "acf" => 7,
      "abcdefg" => 8,
      "abcdfg" => 9
    }

    mappings =
      rough_clues
      |> Enum.map(fn e -> get_mapping(e) end)

    values =
      entries
      |> Enum.map(&String.split(&1, " | ", trim: true))
      |> Enum.map(fn [_ | [tail]] -> tail end)
      |> Enum.map(&String.split(&1, " ", trim: true))

    data = Enum.zip(values, mappings)

    # IO.inspect(mapping)

    secrets =
      Enum.map(data, fn {values, mapping} ->
        values
        |> Enum.map(&Enum.sort(String.to_charlist(&1)))
        |> Enum.map(fn e ->
          Enum.map(e, fn f ->
            mapping[[f]]
          end)
        end)
        |> Enum.map(&Enum.sort(&1))
        |> Enum.map(fn e ->
          e = Enum.join(e)
          reference[e]
        end)
      end)

    Enum.map(secrets, fn e ->
      Enum.sum(e)
    end)
    |> Enum.sum()

    Enum.map(secrets, fn e ->
      Enum.join(e)
    end)
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
  end

  ret = """
    0:      1:      2:      3:      4:
   aaaa    ....    aaaa    aaaa    ....
  b    c  .    c  .    c  .    c  b    c
  b    c  .    c  .    c  .    c  b    c
   ....    ....    dddd    dddd    dddd
  e    f  .    f  e    .  .    f  .    f
  e    f  .    f  e    .  .    f  .    f
   gggg    ....    gggg    gggg    ....
  e6-7-8    e0    e3-4-5  e3-4-5    e2

    5:      6:      7:      8:      9:
   aaaa    aaaa    aaaa    aaaa    aaaa
  b    .  b    .  .    c  b    c  b    c
  b    .  b    .  .    c  b    c  b    c
   dddd    dddd    ....    dddd    dddd
  .    f  e    f  .    f  e    f  .    f
  .    f  e    f  .    f  e    f  .    f
   gggg    gggg    ....    gggg    gggg
  e3-4-5  e6-7-8    e1      e9    e6-7-8
  """

  def get_mapping(rough_clues) do
    rough_clues
    |> Enum.map(&Enum.sort(String.to_charlist(&1)))
    |> Enum.sort(fn a, b -> length(a) < length(b) end)
    |> then(fn [e0, e1, e2, e3, e4, e5, e6, e7, e8, e9] ->
      a = e1 -- e0
      r6 = if length(e0 -- e6) == 1, do: e6, else: if(length(e0 -- e7) == 1, do: e7, else: e8)
      # e = e9 -- e8
      c = e9 -- r6
      f = e0 -- c

      r3 = if length(e0 -- e3) == 0, do: e3, else: if(length(e0 -- e4) == 0, do: e4, else: e5)

      r9 =
        if length(e6 -- r3) == 1,
          do: e6,
          else:
            if(length(e7 -- r3) == 1, do: e7, else: if(length(e8 -- r3) == 1, do: e8, else: nil))

      b = r9 -- r3
      e = e9 -- r9
      d = ((e2 -- c) -- b) -- f
      g = (r3 -- e2) -- a

      %{a => 'a', f => 'f', c => 'c', b => 'b', e => 'e', d => 'd', g => 'g'}

      # e = e9 -- e8
      # g = (e8 -- e2) -- a
      # r0 = if containsAll(e0, e6), do: e6, else: e7
      # d = e9 -- r0
      # r3 = if containsAll(e0, e3), do: e3, else: if(containsAll(e0, e4), do: e4, else: e5)
      # b = (e9 -- r3) -- e
      # r2 = if containsAll(e, e3), do: e3, else: if(containsAll(e, e4), do: e4, else: e5)
      # c = (((r2 -- a) -- e) -- d) -- g
      # f = e0 -- c

      # %{a => 'a', g => 'g', e => 'e', d => 'd', b => 'b', c => 'c', f => 'f'}
    end)
  end

  def containsAll(short_list, big_list) do
    MapSet.subset?(MapSet.new(short_list), MapSet.new(big_list))
  end
end
