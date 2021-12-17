ExUnit.start(exclude: [:skip])

defmodule Helper do
  def read_file(file_path) do
    File.read!(file_path)
    |> String.split("\n", trim: true)
  end

  def format_entries(entries) do
    String.split(entries, "\n", trim: true)
  end
end
