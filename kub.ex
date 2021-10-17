#! /usr/bin/env elixir

# Find K,U,B
# of equation (K+U+B)^3=KUB
# where digits is different

102..987
|> Enum.map(fn kub -> {Enum.uniq(Integer.digits(kub)), kub} end)
|> Enum.filter(fn {v, kub} ->
  length(v) == 3 and Integer.pow(Enum.sum(v), 3) == kub
end)
|> Enum.map(fn {[k, u, b], kub} ->
  "(#{k}+#{u}+#{b})^3=#{kub}"
end)
|> IO.puts()
