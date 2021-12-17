defmodule AdventOfCode10 do
  # [({(<(())[]>[[{[]{<()<>>
  def process_part1(entries) do
    entries
    |> Enum.map(fn e ->
      String.to_charlist(e)
    end)
    |> Enum.reduce([], fn e, acc ->
      ret =
        Enum.reduce_while(e, [], fn
          f, acc2 ->
            if [f] in ['[', '(', '<', '{'] do
              {:cont, [f | acc2]}
            else
              [head | tail] = acc2

              if [head] == opposite(f) do
                {:cont, tail}
              else
                {:halt, f}
              end
            end
        end)

      if !is_list(ret) do
        [ret | acc]
      else
        acc
      end
    end)
    |> compute_score()
  end

  def process_part2(entries) do
    entries
    |> Enum.map(fn e ->
      String.to_charlist(e)
    end)
    |> Enum.reduce([], fn e, acc ->
      ret =
        Enum.reduce_while(e, [], fn
          f, acc2 ->
            if [f] in ['[', '(', '<', '{'] do
              {:cont, [f | acc2]}
            else
              [head | tail] = acc2

              if [head] == opposite(f) do
                {:cont, tail}
              else
                {:halt, f}
              end
            end
        end)

      if is_list(ret) do
        [ret | acc]
      else
        acc
      end
    end)
    |> complete_line()
    |> compute_score2()
  end

  def complete_line(incomplete_lines) do
    incomplete_lines
    |> Enum.map(fn e ->
      Enum.reduce(e, [], fn f, acc ->
        [opposite(f) | acc]
      end)
    end)
  end

  def compute_score2(completions) do
    ret =
      completions
      |> Enum.map(fn e ->
        Enum.reverse(e)
        |> Enum.reduce(0, fn e, acc ->
          case e do
            ')' -> acc * 5 + 1
            ']' -> acc * 5 + 2
            '}' -> acc * 5 + 3
            '>' -> acc * 5 + 4
          end
        end)
      end)
      |> Enum.sort()

    Enum.at(
      ret,
      div(length(ret), 2)
    )
  end

  def compute_score(errors) do
    Enum.reduce(errors, 0, fn e, acc ->
      case [e] do
        ')' -> 3 + acc
        ']' -> 57 + acc
        '}' -> 1197 + acc
        '>' -> 25137 + acc
      end
    end)
  end

  def opposite(c) when [c] == ')', do: '('
  def opposite(c) when [c] == ']', do: '['
  def opposite(c) when [c] == '>', do: '<'
  def opposite(c) when [c] == '}', do: '{'

  def opposite(c) when [c] == '(', do: ')'
  def opposite(c) when [c] == '[', do: ']'
  def opposite(c) when [c] == '<', do: '>'
  def opposite(c) when [c] == '{', do: '}'
end
