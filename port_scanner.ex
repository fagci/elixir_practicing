#! /usr/bin/env elixir
ip = ~C"192.168.0.250"
ports = 1..1024

check = fn port ->
  case :gen_tcp.connect(ip, port, [], 2000) do
    {:ok, s} ->
      :gen_tcp.close(s)
      port

    _ ->
      nil
  end
end

open_ports =
  ports
  |> Task.async_stream(check, max_concurrency: 256)
  |> Enum.map(fn {_, port} -> port end)
  |> Enum.reject(&is_nil/1)

IO.inspect(open_ports)
