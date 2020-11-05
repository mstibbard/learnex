defmodule LearnexWeb.BalanceController do
  use LearnexWeb, :controller

  alias Learnex.Balances
  alias Learnex.Balances.Balance

  def index(conn, _params) do
    balances = Balances.list_balances()
    render(conn, "index.html", balances: balances)
  end

  def new(conn, _params) do
    changeset = Balances.change_balance(%Balance{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"balance" => balance_params}) do
    case Balances.create_balance(balance_params) do
      {:ok, balance} ->
        conn
        |> put_flash(:info, "Balance created successfully.")
        |> redirect(to: Routes.balance_path(conn, :show, balance))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    balance = Balances.get_balance!(id)
    render(conn, "show.html", balance: balance)
  end

  def edit(conn, %{"id" => id}) do
    balance = Balances.get_balance!(id)
    changeset = Balances.change_balance(balance)
    render(conn, "edit.html", balance: balance, changeset: changeset)
  end

  def update(conn, %{"id" => id, "balance" => balance_params}) do
    balance = Balances.get_balance!(id)

    case Balances.update_balance(balance, balance_params) do
      {:ok, balance} ->
        conn
        |> put_flash(:info, "Balance updated successfully.")
        |> redirect(to: Routes.balance_path(conn, :show, balance))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", balance: balance, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    balance = Balances.get_balance!(id)
    {:ok, _balance} = Balances.delete_balance(balance)

    conn
    |> put_flash(:info, "Balance deleted successfully.")
    |> redirect(to: Routes.balance_path(conn, :index))
  end
end
