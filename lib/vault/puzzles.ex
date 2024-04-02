defmodule Vault.Puzzles do

  def add_pairs do
    Enum.map (1..20), fn _ ->
      aa = :rand.uniform(20)
      bb = :rand.uniform(20)
      {aa, bb, aa + bb}
    end
  end
end
