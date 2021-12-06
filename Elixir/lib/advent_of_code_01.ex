defmodule AvdentOfCode01 do
  @input "../01.txt"

  def read_file do
    File.stream!(@input)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
  end

  def group_window(entries) do
    %{value: value} =
      entries
      |> Enum.reduce(%{prevprev: 0, prev: 0, value: []}, fn e, acc ->
        compute_window_value(e, acc)
      end)

    value
  end

  def compute_window_value(new, %{prevprev: prevprev, prev: prev, value: value})
      when prev != 0 and prevprev != 0 do
    %{prevprev: prev, prev: new, value: value ++ [prevprev + prev + new]}
  end

  def compute_window_value(new, %{prevprev: _, prev: prev, value: value}) do
    %{prevprev: prev, prev: new, value: value}
  end

  def process_entries(entries) do
    entries
    |> Enum.reduce(%{prev: 0, value: 0}, fn e, acc ->
      inc_if_higher(e, acc)
    end)
  end

  def inc_if_higher(new, %{prev: prev, value: value}) when prev == 0 do
    %{prev: new, value: value}
  end

  def inc_if_higher(new, %{prev: prev, value: value}) when new > prev do
    %{prev: new, value: value + 1}
  end

  def inc_if_higher(new, %{value: value}) do
    %{prev: new, value: value}
  end
end
