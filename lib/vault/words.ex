defmodule Vault.Words do

  # There are 26680
  def read_words do
    Application.app_dir(:vault, "priv/data/words.txt.gz")
    |> File.stream!([:compressed])
  end
end
