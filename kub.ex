#! /usr/bin/env elixir

# Find equation K,U,B
# (K+U+B)^3=KUB where digits is different

for v <- 102..987 do
  d = Integer.digits(v)

  if length(Enum.uniq(d)) == 3 do
    s = Enum.sum(d)

    if Integer.pow(s, 3) == v do
      sum = Enum.join(d, "+")
      IO.puts("(#{sum})^3=#{v}")
    end
  end
end
