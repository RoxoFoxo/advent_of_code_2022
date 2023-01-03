defmodule DayThree do
  @lowercase_alphabet ?a..?z |> Enum.map(&<<&1>>)
  @uppercase_alphabet ?A..?Z |> Enum.map(&<<&1>>)

  def rucksack_reorganization do
    get_formatted_input()
    |> Enum.map(&split_rucksack/1)
    |> Enum.map(&find_common/1)
    |> sum_priorities
  end

  defp get_formatted_input do
    "input.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
  end

  defp split_rucksack(rucksack) do
    half =
      rucksack
      |> String.length()
      |> div(2)

    String.split_at(rucksack, half)
  end

  defp find_common({compartment1, compartment2}) do
    compartment1
    |> String.split("", trim: true)
    |> Enum.reduce_while(nil, fn item, _ ->
      case String.contains?(compartment2, item) do
        false -> {:cont, nil}
        true -> {:halt, item}
      end
    end)
  end

  defp sum_priorities(items) do
    priorities = priorities()

    items
    |> Enum.map(&priorities[&1])
    |> Enum.sum()
  end

  defp priorities do
    (@lowercase_alphabet ++ @uppercase_alphabet)
    |> Enum.zip(1..52)
    |> Enum.into(%{})
  end
end
