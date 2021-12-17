defmodule AdventOfCode09 do
  def process_part1(entries) do
    grid = compute_grid(entries)

    compute_low_points(grid)
    |> Enum.reduce(0, fn {_, val}, acc ->
      acc + val + 1
    end)
  end

  def checkNeighboursAllHigher({_, val} = point, grid) do
    [{_, top}, {_, bottom}, {_, left}, {_, right}] = findNeighbours(point, grid)

    if top > val and bottom > val and left > val and right > val do
      true
    end
  end

  def findNeighbours({{x, y}, _}, grid) do
    top = Map.get(grid, {x, y + 1})
    bottom = Map.get(grid, {x, y - 1})
    left = Map.get(grid, {x - 1, y})
    right = Map.get(grid, {x + 1, y})
    [{{x, y + 1}, top}, {{x, y - 1}, bottom}, {{x - 1, y}, left}, {{x + 1, y}, right}]
  end

  def compute_grid(entries) do
    grid =
      entries
      |> Enum.map(fn e ->
        String.to_charlist(e)
      end)
      |> Enum.reduce(%{grid: %{}, x: 0}, fn row, acc ->
        Enum.reduce(row, %{grid: acc.grid, x: acc.x + 1, y: 0}, fn point, acc2 ->
          %{grid: Map.put(acc2.grid, {acc2.x, acc2.y}, point - ?0), x: acc2.x, y: acc2.y + 1}
        end)
      end)
      |> then(& &1.grid)
  end

  def compute_low_points(grid) do
    grid
    |> Map.to_list()
    |> Enum.reduce([], fn point, acc ->
      if checkNeighboursAllHigher(point, grid) do
        [point | acc]
      else
        acc
      end
    end)
  end

  def process_part2(entries) do
    grid = compute_grid(entries)
    low_points = compute_low_points(grid)
    bassins = find_bassins(low_points, grid)

    compute_solution_part2(bassins)
  end

  def compute_solution_part2(bassins) do
    [b1, b2, b3 | _] =
      bassins
      |> Enum.map(fn e ->
        MapSet.size(e)
      end)
      |> Enum.sort(fn e, f ->
        e > f
      end)

    b1 * b2 * b3
  end

  def find_bassins(low_points, grid) do
    Enum.map(low_points, fn point ->
      find_bassin(point, grid)
    end)
  end

  def find_bassin(point, grid) do
    find_bassin(MapSet.new(), point, grid)
  end

  def find_bassin(bassins, {_coord, val} = point, grid) do
    if val in [9, nil] or MapSet.member?(bassins, point) do
      bassins
    else
      [n1, n2, n3, n4] = findNeighbours(point, grid)

      bassins =
        MapSet.put(bassins, point)
        |> find_bassin(n1, grid)
        |> find_bassin(n2, grid)
        |> find_bassin(n3, grid)
        |> find_bassin(n4, grid)
    end
  end
end
