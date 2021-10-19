#! /usr/bin/env elixir

defmodule Http do
  def start_link(port: port) do
    IO.puts("hm")
    {:ok, so} = :gen_tcp.listen(port, active: false, packet: :http_bin, reuseaddr: true)
    {:ok, spawn_link(Http, :accept, [so])}
  end

  def accept(so) do
    {:ok, req} = :gen_tcp.accept(so)
    spawn(fn -> respond(req) end)
    accept(so)
  end

  def respond(req) do
    body = "Hello, world!"
    content_length = byte_size(body)

    response = """
    HTTP/1.1 200 OK\r
    Content-Type: text/html\r
    Content-Length: #{content_length}\r
    \r
    #{body}
    """

    :gen_tcp.send(req, response)
    :gen_tcp.close(req)
  end

  def child_spec(opts) do
    %{id: Http, start: {Http, :start_link, [opts]}}
  end
end

Supervisor.start_link([{Http, port: 8088}], [strategy: :one_for_one, name: Http.Supervisor])
