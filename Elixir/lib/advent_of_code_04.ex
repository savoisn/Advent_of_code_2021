defmodule AdventOfCode04 do
  @input "../04.txt"

  def read_file do
    File.read!(@input)
    |> String.split("\n", trim: true)
  end

  def process_part1(entries) do
    {drawns, all_boards} = List.pop_at(entries, 0)

    all_boards =
      all_boards
      |> Enum.map(&String.split(&1, " ", trim: true))
      |> Enum.map(&List.to_tuple/1)
      |> Enum.chunk_every(5)

    other_combinations =
      all_boards
      |> Enum.map(&inverse_matrix/1)

    all_combinations = all_boards ++ other_combinations

    drawns =
      drawns
      |> String.split(",")
      |> List.to_tuple()

    # for pos <- 0..(tuple_size(drawns) - 1) do
    # remove_from_board(all_combinations, elem(drawns, pos))
    # end
    ret = find_first_wining_board(all_combinations, drawns, 0, false, nil)
    {_, drawns, pos, board} = ret
    sum_remaining_slots(board) * String.to_integer(elem(drawns, pos))
  end

  def sum_remaining_slots(board) do
    Enum.reduce(board, 0, fn row, acc ->
      Tuple.to_list(row)
      |> Enum.reduce(acc, &sum_if_not_tuple/2)
    end)
  end

  def sum_if_not_tuple({_, _}, acc), do: acc
  def sum_if_not_tuple(num, acc), do: acc + String.to_integer(num)

  def find_first_wining_board(boards, drawns, pos, _, _board) when pos >= tuple_size(drawns) do
    boards
  end

  def find_first_wining_board(boards, drawns, pos, true, board) do
    {boards, drawns, pos - 1, board}
  end

  def find_first_wining_board(all_combinations, drawns, pos, _is_done, _complete_board) do
    last_number = elem(drawns, pos)
    new_boards = remove_from_board(all_combinations, last_number)
    {is_done, boards} = row_or_col_complete(new_boards)

    board =
      if length(boards) > 0 do
        [head | _] = boards
        head
      else
        nil
      end

    find_first_wining_board(new_boards, drawns, pos + 1, is_done, board)
  end

  def row_or_col_complete(boards) do
    boards
    |> Enum.reduce({false, []}, fn board, acc ->
      {completed, board} = row_complete(board)

      if completed do
        {elem(acc, 0) || true, elem(acc, 1) ++ [board]}
      else
        {elem(acc, 0) || false, elem(acc, 1) ++ []}
      end
    end)
  end

  def row_complete(board) do
    ret =
      board
      |> Enum.reduce_while(false, fn row, acc ->
        {e0, e1, e2, e3, e4} = row

        completed =
          {true, true, true, true, true} ==
            {is_found(e0), is_found(e1), is_found(e2), is_found(e3), is_found(e4)}

        if completed do
          {:halt, true}
        else
          {:cont, false}
        end
      end)

    {ret, board}
  end

  def is_found({_, :found}), do: true
  def is_found(_), do: false

  def inverse_matrix(board) do
    ret =
      for pos <- 0..4 do
        board
        |> Enum.map(&elem(&1, pos))
        |> List.to_tuple()
      end

    ret
  end

  def remove_from_board(boards, drawn) do
    boards
    |> Enum.map(fn board ->
      Enum.map(board, fn e ->
        pos =
          e
          |> Tuple.to_list()
          |> Enum.find_index(fn e -> e == drawn end)

        if(pos != nil) do
          put_elem(e, pos, {elem(e, pos), :found})
        else
          e
        end
      end)
    end)
  end

  def process_part2(entries) do
    {drawns, all_boards} = List.pop_at(entries, 0)

    all_boards =
      all_boards
      |> Enum.map(&String.split(&1, " ", trim: true))
      |> Enum.map(&List.to_tuple/1)
      |> Enum.chunk_every(5)

    other_combinations =
      all_boards
      |> Enum.map(&inverse_matrix/1)

    all_combinations = all_boards ++ other_combinations

    drawns =
      drawns
      |> String.split(",")
      |> List.to_tuple()

    # for pos <- 0..(tuple_size(drawns) - 1) do
    # remove_from_board(all_combinations, elem(drawns, pos))
    # end
    ret = find_last_wining_board(all_combinations, drawns, 0, false, nil)
    {boards, drawns, pos, board} = ret

    # IO.inspect({"last number", String.to_integer(elem(drawns, pos))})
    # IO.inspect({pos, boards})
    # IO.inspect({"remaining", sum_remaining_slots(board)})

    # IO.inspect({sum_remaining_slots(board), String.to_integer(elem(drawns, pos))})
    sum_remaining_slots(board) * String.to_integer(elem(drawns, pos))
  end

  def find_last_wining_board(boards, drawns, pos, _, board) when pos >= tuple_size(drawns) do
    {boards, drawns, pos - 1, board}
  end

  def find_last_wining_board(boards, drawns, pos, true, board) do
    {boards, drawns, pos - 1, board}
  end

  def find_last_wining_board(all_combinations, drawns, pos, _is_done, _complete_board) do
    # IO.inspect(tuple_size(drawns))
    last_number = elem(drawns, pos)
    new_boards = remove_from_board(all_combinations, last_number)
    {board_completed, boards_to_delete} = row_or_col_complete(new_boards)

    # IO.inspect({"completed", length(boards)})

    board =
      if length(boards_to_delete) > 0 do
        [head | _] = boards_to_delete
        head
      else
        nil
      end

    new_new_boards = delete_boards_from_boards(new_boards, boards_to_delete)
    # if board != nil do
    # inv = inverse_matrix(board)
    ## IO.inspect({"inv", inv})

    # List.delete(new_boards, board)
    # |> List.delete(inv)
    # else
    # new_boards
    # end

    # IO.inspect({"new_new_boards", length(new_new_boards)})

    is_done =
      if board_completed do
        length(new_new_boards) == 0
      end

    find_last_wining_board(new_new_boards, drawns, pos + 1, is_done, board)
  end

  def delete_boards_from_boards(boards, boards_to_delete) do
    Enum.reduce(boards_to_delete, boards, fn board, acc ->
      acc
      |> List.delete(board)
      |> List.delete(inverse_matrix(board))
    end)
  end
end
