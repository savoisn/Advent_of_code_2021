defmodule AdventOfCode05 do
  @input "../05.txt"

  def read_file do
    File.read!(@input)
    |> String.split("\n", trim: true)
  end

  def process_part1(entries) do
    entries
    |> format_entries
    |> apply_points_from_lines
    |> get_numbers_of_safe_path
  end

  def process_part2(entries) do
    entries
    |> format_entries
    |> apply_points_from_lines_and_diagonals
    |> get_numbers_of_safe_path
  end

  def format_entries(entries) do
    Enum.map(entries, fn e ->
      e
      |> String.split(" -> ")
    end)
    |> Enum.map(fn [e1, e2] ->
      {List.to_tuple(String.split(e1, ",") |> Enum.map(&String.to_integer/1)),
       List.to_tuple(String.split(e2, ",") |> Enum.map(&String.to_integer/1))}
    end)
  end

  def apply_points_from_lines(entries) do
    Enum.reduce(entries, %{}, fn
      {{x1, y1}, {x2, y2}}, acc ->
        cond do
          x1 == x2 ->
            [y1, y2] = Enum.sort([y1, y2])

            Enum.reduce(y1..y2, acc, fn y, acc1 ->
              Map.update(acc1, {x1, y}, 1, fn e ->
                e + 1
              end)
            end)

          y1 == y2 ->
            [x1, x2] = Enum.sort([x1, x2])

            Enum.reduce(x1..x2, acc, fn x, acc1 ->
              Map.update(acc1, {x, y1}, 1, fn e ->
                e + 1
              end)
            end)

          true ->
            acc
        end
    end)
  end

  def apply_points_from_lines_and_diagonals(entries) do
    Enum.reduce(entries, %{}, fn
      {{x1, y1}, {x2, y2}}, acc ->
        cond do
          x1 == x2 ->
            [y1, y2] = Enum.sort([y1, y2])

            Enum.reduce(y1..y2, acc, fn y, acc1 ->
              Map.update(acc1, {x1, y}, 1, fn e ->
                e + 1
              end)
            end)

          y1 == y2 ->
            [x1, x2] = Enum.sort([x1, x2])

            Enum.reduce(x1..x2, acc, fn x, acc1 ->
              Map.update(acc1, {x, y1}, 1, fn e ->
                e + 1
              end)
            end)

          abs(y1 - y2) == abs(x1 - x2) ->
            diag_plots = plot_diagonals({{x1, y1}, {x2, y2}})

            Enum.reduce(diag_plots, acc, fn {x, y}, acc1 ->
              Map.update(acc1, {x, y}, 1, fn e ->
                e + 1
              end)
            end)

          true ->
            acc
        end
    end)
  end

  def plot_diagonals({{x1, y1}, {x2, y2}}) do
    diag_size_x = x2 - x1
    diag_size_y = y2 - y1

    zero_based_diag = Enum.zip(0..diag_size_x, 0..diag_size_y)

    Enum.reduce(zero_based_diag, [], fn e, acc ->
      acc ++ [{x1 + elem(e, 0), y1 + elem(e, 1)}]
    end)
  end

  def get_numbers_of_safe_path(entries) do
    Map.values(entries)
    |> Enum.reduce(%{}, fn e, acc ->
      Map.update(acc, e, 1, fn e ->
        e + 1
      end)
    end)
    |> Enum.reduce(0, fn e, acc ->
      if elem(e, 0) >= 2 do
        acc + elem(e, 1)
      else
        acc
      end
    end)
  end
end
