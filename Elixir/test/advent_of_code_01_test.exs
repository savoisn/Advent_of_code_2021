defmodule AvdentOfCode01Test do
  use ExUnit.Case

  @entries [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]

  @windows [607, 618, 618, 617, 647, 716, 769, 792]

  test "read_file" do
    entries = AvdentOfCode01.read_file()
    res = AvdentOfCode01.process_entries(entries)
    IO.puts("01-simple answer : " <> Integer.to_string(res.value))
  end

  test "process_entries" do
    assert AvdentOfCode01.process_entries(@entries) == %{prev: 263, value: 7}
  end

  test "group_window" do
    assert AvdentOfCode01.group_window(@entries) == @windows
  end

  test "process_windows" do
    entries = AvdentOfCode01.read_file()
    processed_windows = AvdentOfCode01.group_window(entries)
    res = AvdentOfCode01.process_entries(processed_windows)
    IO.puts("01-complex answer : " <> Integer.to_string(res.value))
  end
end
