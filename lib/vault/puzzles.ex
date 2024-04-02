defmodule Vault.Puzzles do

  def add_pairs do
    Enum.map (1..20), fn _ ->
      aa = :rand.uniform(20)
      bb = :rand.uniform(20)
      {aa, bb, aa + bb}
    end
  end

  def random_password(len) do
    Vault.Words.read_words()
    |> Enum.filter(&(String.length(&1) == len))
    |> Enum.shuffle()
    |> hd()
    |> String.trim()
  end
end
