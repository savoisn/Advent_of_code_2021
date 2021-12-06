defmodule AdventOfCode03 do
  @input "../03.txt"

  def read_file do
    File.read!(@input)
    |> String.split("\n", trim: true)
  end

  def process_part1(entries) do
    entries =
      entries
      |> Enum.map(fn e ->
        String.graphemes(e)
        |> Enum.map(&String.to_integer/1)
        |> List.to_tuple()
      end)

    # convert column to row
    nb_elem = tuple_size(List.first(entries))
    size = Enum.count(entries)

    gamma_bits =
      for pos <- 0..(nb_elem - 1) do
        nb_one =
          entries
          |> Enum.map(&elem(&1, pos))
          |> Enum.count(&(&1 == 1))

        nb_zero = size - nb_one

        if nb_one > nb_zero do
          1
        else
          0
        end
      end

    gamma = gamma_bits |> Enum.join() |> String.to_integer(2)

    epsylon_bits =
      gamma_bits
      |> Enum.map(fn
        0 -> 1
        1 -> 0
      end)

    epsylon = epsylon_bits |> Enum.join() |> String.to_integer(2)

    gamma * epsylon
  end

  def process_part2(entries) do
    entries =
      entries
      |> Enum.map(fn e ->
        String.graphemes(e)
        |> Enum.map(&String.to_integer/1)
        |> List.to_tuple()
      end)

    # nb_elem = tuple_size(List.first(entries))

    # power_by_bits =
    # for pos <- 0..(nb_elem - 1) do
    # nb_one =
    # entries
    # |> Enum.map(&elem(&1, pos))
    # end

    mod = :o2
    o2_rating = recur(entries, mod) |> Tuple.to_list() |> Enum.join() |> String.to_integer(2)
    mod = :co2
    co2_scrubbing = recur(entries, mod) |> Tuple.to_list() |> Enum.join() |> String.to_integer(2)
    o2_rating * co2_scrubbing
  end

  def recur(entries, mod) do
    recur(entries, mod, 0)
  end

  defp recur([last_number], _mod, _row) do
    last_number
  end

  defp recur(entries, mod, row) do
    total = Enum.count(entries)

    nb_ones =
      Enum.map(entries, &elem(&1, row))
      |> Enum.sum()

    nb_zeros = total - nb_ones

    new_entries =
      Enum.filter(entries, fn e ->
        if mod == :o2 do
          compute_o2(e, nb_ones, nb_zeros, row)
        else
          compute_co2(e, nb_ones, nb_zeros, row)
        end
      end)

    recur(new_entries, mod, row + 1)
  end

  def compute_o2(e, nb_ones, nb_zeros, row) do
    if nb_ones >= nb_zeros do
      elem(e, row) == 1
    else
      elem(e, row) == 0
    end
  end

  def compute_co2(e, nb_ones, nb_zeros, row) do
    if nb_ones < nb_zeros do
      elem(e, row) == 1
    else
      elem(e, row) == 0
    end
  end
end
