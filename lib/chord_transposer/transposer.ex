defmodule ChordTransposer.Transposer do
  @note_order ~w(C C# D D# E F F# G G# A A# B)

  def transpose_chords(chords, semitones) do
    chords
    |> Enum.map(&transpose_chord(&1, semitones))
  end

  defp transpose_chord(chord, semitones) do
    [root | rest] = Regex.run(~r/^([A-G]#?)(.*)$/, chord, capture: :all_but_first)
    new_root = transpose(root, semitones)
    new_root <> Enum.join(rest)
  end

  defp transpose(note, semitones) do
    index = Enum.find_index(@note_order, fn n -> n == note end)
    new_index = rem(index + semitones + length(@note_order), length(@note_order))
    Enum.at(@note_order, new_index)
  end
end

