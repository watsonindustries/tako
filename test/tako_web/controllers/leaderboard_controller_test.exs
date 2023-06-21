defmodule TakoWeb.LeaderboardControllerTest do
  use TakoWeb.ConnCase

  import Tako.LeaderboardsFixtures

  alias Tako.Leaderboards.Leaderboard

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all leaderboard", %{conn: conn} do
      conn = get(conn, ~p"/api/leaderboard")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create leaderboard" do
    test "renders leaderboard when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/leaderboard", leaderboard: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/leaderboard/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/leaderboard", leaderboard: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update leaderboard" do
    setup [:create_leaderboard]

    test "renders leaderboard when data is valid", %{
      conn: conn,
      leaderboard: %Leaderboard{id: id} = leaderboard
    } do
      conn = put(conn, ~p"/api/leaderboard/#{leaderboard}", leaderboard: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/leaderboard/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, leaderboard: leaderboard} do
      conn = put(conn, ~p"/api/leaderboard/#{leaderboard}", leaderboard: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete leaderboard" do
    setup [:create_leaderboard]

    test "deletes chosen leaderboard", %{conn: conn, leaderboard: leaderboard} do
      conn = delete(conn, ~p"/api/leaderboard/#{leaderboard}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/leaderboard/#{leaderboard}")
      end
    end
  end

  defp create_leaderboard(_) do
    leaderboard = leaderboard_fixture()
    %{leaderboard: leaderboard}
  end
end
