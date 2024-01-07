defmodule HochfuenfWeb.DashboardController do
  use HochfuenfWeb, :controller

  def show(conn, _params) do
    render(conn, :show)
  end
end
