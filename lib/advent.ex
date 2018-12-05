defmodule Advent do
  def data(day), do: File.read!("lib/data/day#{day}")
end
