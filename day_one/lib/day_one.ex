defmodule DayOne do
  def calorie_count() do
    "input.txt"
    |> File.read!()
    |> String.split("\n\n", trim: true)
    |> Enum.map(&separate_and_sum_calories/1)
    |> sum_top_three()
  end

  defp separate_and_sum_calories(calories_list) do
    calories_list
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce(&(&1 + &2))
  end

  defp sum_top_three(list) do
    list
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.sum()
  end
end
