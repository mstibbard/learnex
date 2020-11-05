defmodule LearnexWeb.BalanceControllerTest do
  use LearnexWeb.ConnCase

  alias Learnex.Balances
  import Learnex.AccountsFixtures

  @create_attrs %{amount: "120.5", date: ~D[2010-04-17]}
  @update_attrs %{amount: "456.7", date: ~D[2011-05-18]}
  @invalid_attrs %{amount: nil, date: nil}

  setup do
    %{user: user_fixture()}
  end

  def fixture(:balance) do
    {:ok, balance} = Balances.create_balance(@create_attrs)
    balance
  end

  describe "index" do
    test "lists all balances", %{conn: conn, user: user} do
      conn = conn |> log_in_user(user) |> get(Routes.balance_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Balances"
    end
  end

  describe "new balance" do
    test "renders form", %{conn: conn, user: user} do
      conn = conn |> log_in_user(user) |> get(Routes.balance_path(conn, :new))
      assert html_response(conn, 200) =~ "New Balance"
    end
  end

  describe "create balance" do
    test "redirects to show when data is valid", %{conn: conn, user: user} do
      conn = conn |> log_in_user(user) |> post(Routes.balance_path(conn, :create), balance: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.balance_path(conn, :show, id)

      conn = get(conn, Routes.balance_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Balance"
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = conn |> log_in_user(user) |> post(Routes.balance_path(conn, :create), balance: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Balance"
    end
  end

  describe "edit balance" do
    setup [:create_balance]

    test "renders form for editing chosen balance", %{conn: conn, balance: balance, user: user} do
      conn = conn |> log_in_user(user) |> get(Routes.balance_path(conn, :edit, balance))
      assert html_response(conn, 200) =~ "Edit Balance"
    end
  end

  describe "update balance" do
    setup [:create_balance]

    test "redirects when data is valid", %{conn: conn, balance: balance, user: user} do
      conn = conn |> log_in_user(user) |> put(Routes.balance_path(conn, :update, balance), balance: @update_attrs)
      assert redirected_to(conn) == Routes.balance_path(conn, :show, balance)

      conn = get(conn, Routes.balance_path(conn, :show, balance))
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, balance: balance, user: user} do
      conn = conn |> log_in_user(user) |> put(Routes.balance_path(conn, :update, balance), balance: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Balance"
    end
  end

  describe "delete balance" do
    setup [:create_balance]

    test "deletes chosen balance", %{conn: conn, balance: balance, user: user} do
      conn = conn |> log_in_user(user) |> delete(Routes.balance_path(conn, :delete, balance))
      assert redirected_to(conn) == Routes.balance_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.balance_path(conn, :show, balance))
      end
    end
  end

  defp create_balance(_) do
    balance = fixture(:balance)
    %{balance: balance}
  end
end
