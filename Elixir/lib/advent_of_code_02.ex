defmodule AdventOfCode02 do
  @input "../02.txt"

  def read_file do
    File.read!(@input)
    |> String.split("\n", trim: true)
  end

  def simple_process_entries(entries) do
    initial = %{distance: 0, depth: 0}

    entries
    |> Enum.reduce(initial, fn e, acc ->
      simple_process_input(e, acc)
    end)
  end

  defp simple_process_input("forward " <> value, %{distance: distance, depth: depth}) do
    %{distance: distance + String.to_integer(value), depth: depth}
  end

  defp simple_process_input("down " <> value, %{distance: distance, depth: depth}) do
    %{distance: distance, depth: depth + String.to_integer(value)}
  end

  defp simple_process_input("up " <> value, %{distance: distance, depth: depth}) do
    %{distance: distance, depth: depth - String.to_integer(value)}
  end

  def process_entries(entries) do
    initial = %{distance: 0, depth: 0, aim: 0}

    entries
    |> Enum.reduce(initial, fn e, acc ->
      process_input(e, acc)
    end)
  end

  def process_input("forward " <> value, %{distance: distance, depth: depth, aim: aim}) do
    value = String.to_integer(value)
    %{distance: distance + value, depth: depth + aim * value, aim: aim}
  end

  def process_input("down " <> value, %{distance: distance, depth: depth, aim: aim}) do
    value = String.to_integer(value)
    %{distance: distance, depth: depth, aim: aim + value}
  end

  def process_input("up " <> value, %{distance: distance, depth: depth, aim: aim}) do
    value = String.to_integer(value)
    %{distance: distance, depth: depth, aim: aim - value}
  end
end
