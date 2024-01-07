defmodule HochfuenfWeb.DashboardController do
  use HochfuenfWeb, :controller

  def show(conn, params) do
    render(conn, :show)
  end
end
