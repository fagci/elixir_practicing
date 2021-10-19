#! /usr/bin/env elixir
ip = '192.168.0.250'
ports = 1..1024

check = fn port ->
  with {:ok, s} <- :gen_tcp.connect(ip, port, [], 2000) do
    :gen_tcp.close(s)
    port
  end
end

ports
|> Task.async_stream(check, max_concurrency: 256)
|> Enum.map(fn {_, port} -> port end)
|> Enum.filter(&is_number/1)
|> Enum.each(&IO.puts/1)
