#! /usr/bin/env elixir
ip = String.to_charlist("192.168.0.250")
ports = 1..1024

check = fn port ->
  case :gen_tcp.connect(ip, port, [], 2000) do
    {:ok, s} ->
      :gen_tcp.close(s)
      {true, port}

    _ ->
      {false, port}
  end
end

open_ports =
  ports
  |> Task.async_stream(check, max_concurrency: 256)
  |> Enum.filter(fn {_, {open, _}} -> open end)
  |> Enum.map(fn {_, {_, port}} -> port end)

IO.inspect(open_ports)
