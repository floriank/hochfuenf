defmodule HochfuenfWeb.DashboardController do
  use HochfuenfWeb, :controller

  plug HochfuenfWeb.Secure

  def show(conn, _params) do
    render(conn, :show)
  end
end
