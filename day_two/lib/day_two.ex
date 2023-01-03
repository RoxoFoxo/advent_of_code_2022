defmodule DayTwo do
  @winning_matches %{
    rock: :scissors,
    scissors: :paper,
    paper: :rock
  }

  @losing_matches %{
    scissors: :rock,
    rock: :paper,
    paper: :scissors
  }

  @hand_value %{
    rock: 1,
    paper: 2,
    scissors: 3
  }

  def calculate_total do
    "input.txt"
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(&handle_round/1)
    |> Enum.map(&rock_paper_scissors/1)
    |> Enum.sum()
  end

  defp handle_round(round) do
    [opponent, expected_result] = String.split(round, " ", trim: true)

    expected_result =
      case expected_result do
        "X" -> :lose
        "Y" -> :draw
        "Z" -> :win
      end

    opponent =
      case opponent do
        "A" -> :rock
        "B" -> :paper
        "C" -> :scissors
      end

    {
      opponent,
      case expected_result do
        :win -> @losing_matches[opponent]
        :draw -> opponent
        :lose -> @winning_matches[opponent]
      end
    }
  end

  defp rock_paper_scissors({opponent, ours}) do
    losing_hand = @winning_matches[ours]

    case opponent do
      ^losing_hand -> @hand_value[ours] + 6
      ^ours -> @hand_value[ours] + 3
      _ -> @hand_value[ours]
    end
  end
end
