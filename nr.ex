#! /usr/bin/env elixir

check = fn ip ->
  case :gen_tcp.connect(ip, 80, [], 1000) do
    {:ok, s} ->
      :gen_tcp.close(s)
      {a, b, c, d} = ip
      IO.puts("#{a}.#{b}.#{c}.#{d}")
      ip

    _ ->
      nil
  end
end

defmodule IPGen do
  def gen_ip do
    intip = Enum.random(0x1000000..0xE0000000)

    if (0xA000000 <= intip and intip <= 0xAFFFFFF) or
         (0x64400000 <= intip and intip <= 0x647FFFFF) or
         (0x7F000000 <= intip and intip <= 0x7FFFFFFF) or
         (0xA9FE0000 <= intip and intip <= 0xA9FEFFFF) or
         (0xAC100000 <= intip and intip <= 0xAC1FFFFF) or
         (0xC0000000 <= intip and intip <= 0xC0000007) or
         (0xC00000AA <= intip and intip <= 0xC00000AB) or
         (0xC0000200 <= intip and intip <= 0xC00002FF) or
         (0xC0A80000 <= intip and intip <= 0xC0A8FFFF) or
         (0xC6120000 <= intip and intip <= 0xC613FFFF) or
         (0xC6336400 <= intip and intip <= 0xC63364FF) or
         (0xCB007100 <= intip and intip <= 0xCB0071FF) or
         (0xF0000000 <= intip and intip <= 0xFFFFFFFF) do
      gen_ip()
    else
      <<a, b, c, d>> = <<intip::unsigned-integer-size(32)>>
      {a, b, c, d}
    end
  end

  def infinite() do
    Stream.repeatedly(&gen_ip/0)
  end
end

IPGen.infinite()
|> Task.async_stream(check, max_concurrency: 2048, ordered: false)
|> Enum.to_list()
