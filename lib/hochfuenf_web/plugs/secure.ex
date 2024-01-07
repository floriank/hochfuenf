defmodule HochfuenfWeb.Secure do
  import Plug.Conn

  import Phoenix.Controller, only: [redirect: 2]

  @moduledoc """
  A Plug to make sure that a user is present. Halts the plug chain otherwise
  """

  @doc false
  def call(conn, _params) do
    user = get_session(conn, :current_user)

    case user do
      nil ->
        conn |> redirect(to: "/") |> halt

      _ ->
        conn
        |> assign(:current_user, user)
    end
  end
end
