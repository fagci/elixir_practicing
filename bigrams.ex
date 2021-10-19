#! /usr/bin/env elixir

text = "Test text to test bigrams generator"

Regex.split(~r|\W+|, text |> String.downcase())
|> Enum.map(&String.to_charlist/1)
|> Enum.map(&Enum.chunk_every(&1, 2, 1, :discard))
|> Enum.concat()
|> Enum.frequencies()
|> Enum.sort_by(fn {_, v} -> -v end)
|> IO.inspect()
