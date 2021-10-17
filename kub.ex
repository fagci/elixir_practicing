#! /usr/bin/env elixir

# Find K,U,B
# of equation (K+U+B)^3=KUB
# where digits is different

import Enum, only: [map: 2, filter: 2, each: 2, sum: 1, uniq: 1]
import Integer, only: [digits: 1, pow: 2]

check = fn {v, kub} ->
  length(v) == 3 and pow(sum(v), 3) == kub
end

format = fn {[k, u, b], kub} ->
  "(#{k}+#{u}+#{b})^3=#{kub}"
end

102..987
|> map(&{uniq(digits(&1)), &1})
|> filter(check)
|> map(format)
|> each(&IO.puts/1)
