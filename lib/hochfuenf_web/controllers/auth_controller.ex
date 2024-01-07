defmodule HochfuenfWeb.AuthController do
  use HochfuenfWeb, :controller
  alias HochFuenf.Accounts
  plug Ueberauth

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: ~p"/")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, _params) do
    case Hochfuenf.Accounts.find_or_create(auth) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Successfully authenticated as #{user.name}.")
        |> put_session(:current_user, user)
        |> redirect(to: "/dashboard")

      {:error, reason} ->
        conn
        |> put_flash(:error, reason)
        |> redirect(to: "/")
    end
  end

  def logout(conn, params) do
    conn
    |> put_flash(:info, "You've been logged out")
    |> configure_session(drop: true)
    |> redirect(to: ~p"/")
  end
end
