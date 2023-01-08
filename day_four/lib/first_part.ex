defmodule DayFour.FirstPart do
  def count_of_section_overlaps do
    get_formatted_input()
    |> Enum.map(&separate_ranges/1)
    |> Enum.map(&pairs_overlap?/1)
    |> Enum.count(fn x -> x == true end)
  end

  defp get_formatted_input do
    "input.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
  end

  defp separate_ranges(pair) do
    pair
    |> String.split(~r'[-,]')
    |> Enum.map(&String.to_integer/1)
    |> then(fn [r1, r2, r3, r4] -> {r1..r2, r3..r4} end)
  end

  defp pairs_overlap?({r1..r2, r3..r4}) do
    (r1 >= r3 and r2 <= r4) or (r3 >= r1 and r4 <= r2)
  end
end
