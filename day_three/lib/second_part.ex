defmodule DayThree.SecondPart do
  @lowercase_alphabet ?a..?z |> Enum.map(&<<&1>>)
  @uppercase_alphabet ?A..?Z |> Enum.map(&<<&1>>)

  def find_badge_by_group do
    get_formatted_input()
    |> Enum.chunk_every(3)
    |> Enum.map(&find_common/1)
    |> sum_priorities
  end

  defp get_formatted_input do
    "input.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
  end

  defp find_common([elf1, elf2, elf3]) do
    elf1
    |> String.split("", trim: true)
    |> Enum.reduce_while(nil, fn item, _ ->
      case String.contains?(elf2, item) and String.contains?(elf3, item) do
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
