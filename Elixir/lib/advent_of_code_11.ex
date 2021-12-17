defmodule AdventOfCode11 do
  def process_part1(entries) do
    grid = compute_grid(entries)

    {end_grid, flashes} =
      1..100
      |> Enum.reduce({grid, []}, fn _, {grid0, flashes} ->
        {grid1, flashes1} = explode(grid0)
        {grid1, flashes ++ MapSet.to_list(flashes1)}
      end)

    length(flashes)
  end

  def process_part2(entries) do
    grid = compute_grid(entries)

    1..1000
    |> Enum.reduce_while(grid, fn i, grid0 ->
      if uniform_grid?(grid0) do
        {:halt, i - 1}
      else
        {grid1, _} = explode(grid0)
        {:cont, grid1}
      end
    end)
  end

  def uniform_grid?(grid) do
    values = Map.values(grid)

    {ret, _} =
      Enum.reduce_while(values, {true, List.first(values)}, fn e, {_, acc} ->
        if e == acc do
          {:cont, {true, acc}}
        else
          {:halt, {false, acc}}
        end
      end)

    ret
  end

  def format_output(output) do
    output
    |> Map.values()
    |> Enum.map(fn e ->
      Enum.map(e, &Integer.to_string/1)
      |> Enum.join()
    end)
  end

  def explode(grid) do
    explode(Map.keys(grid), grid, MapSet.new())
  end

  def explode([{x, y} = index | tail], grid, flashes) do
    val = Map.get(grid, index)

    if MapSet.member?(flashes, index) or val == nil do
      explode(tail, grid, flashes)
    else
      case val do
        x when x >= 9 ->
          arounds = get_around_indexes(index)

          explode(arounds ++ tail, Map.put(grid, index, 0), MapSet.put(flashes, index))

        _ ->
          explode(tail, Map.put(grid, index, val + 1), flashes)
      end
    end
  end

  def explode([], grid, flashes) do
    {grid, flashes}
  end

  def get_around_indexes({x, y} = index) do
    [
      {x - 1, y - 1},
      {x - 1, y},
      {x - 1, y + 1},
      {x, y - 1},
      {x, y},
      {x, y + 1},
      {x + 1, y - 1},
      {x + 1, y},
      {x + 1, y + 1}
    ]
  end

  def compute_grid(entries) do
    grid =
      entries
      |> Enum.map(fn e ->
        String.to_charlist(e)
      end)
      |> Enum.reduce(%{grid: %{}, x: 0}, fn row, acc ->
        Enum.reduce(row, %{grid: acc.grid, x: acc.x + 1, y: 1}, fn point, acc2 ->
          %{grid: Map.put(acc2.grid, {acc2.x, acc2.y}, point - ?0), x: acc2.x, y: acc2.y + 1}
        end)
      end)
      |> then(& &1.grid)
  end
end
