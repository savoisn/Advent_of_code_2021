defmodule AdventOfCode03old do
  @input "../03.txt"

  def read_file do
    File.read!(@input)
    |> String.split("\n", trim: true)
  end

  def simple_process_entries(entries) do
    acc =
      List.first(entries)
      |> String.graphemes()
      |> Enum.map(&String.to_integer/1)

    size = Enum.count(entries)

    res =
      entries
      |> Enum.reduce(acc, fn x, acc -> simple_process_element(x, acc) end)
      |> Enum.map(fn
        x when x >= size / 2 -> 1
        _ -> 0
      end)

    inverse =
      res
      |> Enum.map(fn
        0 -> 1
        1 -> 0
      end)

    res =
      res
      |> Enum.map(&Integer.to_string/1)
      |> Enum.join()

    inverse =
      inverse
      |> Enum.map(&Integer.to_string/1)
      |> Enum.join()

    res =
      Integer.parse(res, 2)
      |> elem(0)

    inverse =
      Integer.parse(inverse, 2)
      |> elem(0)

    res * inverse
  end

  def simple_process_element(element, acc) do
    lst =
      String.graphemes(element)
      |> Enum.map(&String.to_integer/1)

    Enum.with_index(lst)
    |> Enum.reduce(acc, fn {x, index}, acc ->
      increase_at(acc, index, x)
    end)
  end

  def increase_at(list, index, value) do
    list
    |> Enum.with_index()
    |> Enum.map(fn
      # match index
      {x, ^index} -> x + value
      # anything else   
      {value, _} -> value
    end)
  end
end
