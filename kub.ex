#! /usr/bin/env elixir

# Find K,U,B
# of equation (K+U+B)^3=KUB
# where digits is different

for v <- 102..987 do
  d = Enum.uniq(Integer.digits(v))

  if length(d) == 3 do
    s = Enum.sum(d)

    if Integer.pow(s, 3) == v do
      sum = Enum.join(d, "+")
      IO.puts("(#{sum})^3=#{v}")
    end
  end
end
