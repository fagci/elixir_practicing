#! /usr/bin/env elixir

# Find K,U,B
# of equation (K+U+B)^3=KUB
# where digits is different

import Enum
import Integer

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
