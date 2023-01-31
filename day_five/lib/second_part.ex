defmodule DayFive.SecondPart do
  def get_top_crates do
    {crate_drawing, commands} =
      get_formatted_input()
      |> Enum.split(9)

    columns =
      crate_drawing
      |> Enum.map(&line_into_list/1)
      |> List.delete_at(8)
      |> lines_into_columns()

    commands
    |> Enum.map(&command_into_tuple(&1))
    |> Enum.reduce(columns, &run_command(&1, &2))
    |> Enum.map(&List.first/1)
    |> Enum.reduce(&(&2 <> &1))
  end

  defp get_formatted_input do
    "input.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
  end

  defp line_into_list(crate_line) do
    crate_line
    |> String.codepoints()
    |> Enum.chunk_every(4)
    |> Enum.map(&Enum.at(&1, 1))
  end

  defp lines_into_columns(line_list) do
    line_list
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(fn column -> Enum.drop_while(column, &(&1 == " ")) end)
  end

  defp command_into_tuple(command) do
    command
    |> String.split(" ")
    |> Enum.drop_every(2)
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end

  defp run_command({amount_to_move, from, destination}, columns) do
    from_index = from - 1
    dest_index = destination - 1

    from_column =
      columns
      |> Enum.at(from_index)

    dest_column =
      columns
      |> Enum.at(dest_index)

    crates_to_move =
      from_column
      |> Enum.take(amount_to_move)

    dest_column_final = crates_to_move ++ dest_column

    from_column_final = Enum.drop(from_column, amount_to_move)

    columns
    |> List.replace_at(from_index, from_column_final)
    |> List.replace_at(dest_index, dest_column_final)
  end
end
