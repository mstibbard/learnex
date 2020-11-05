defmodule Learnex.BalancesTest do
  use Learnex.DataCase

  alias Learnex.Balances
  import Learnex.AccountsFixtures
  import Learnex.ProvidersFixtures

  describe "balances" do
    alias Learnex.Balances.Balance

    @valid_attrs %{amount: "120.5", date: ~D[2010-04-17]}
    @update_attrs %{amount: "456.7", date: ~D[2011-05-18]}
    @invalid_attrs %{amount: nil, date: nil}

    def balance_fixture(attrs \\ %{}) do
      user = user_fixture()
      provider = provider_fixture(%{account_type: "some account_type", name: "some name"}, user)

      {:ok, balance} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Balances.create_balance(user.id, provider.id)

      balance
    end

    test "list_balances/0 returns all balances" do
      balance = balance_fixture()
      assert Balances.list_balances() == [balance]
    end

    test "get_balance!/1 returns the balance with given id" do
      balance = balance_fixture()
      assert Balances.get_balance!(balance.id) == balance
    end

    test "create_balance/3 with valid data creates a balance" do
      user = user_fixture()
      provider = provider_fixture(%{account_type: "some account_type", name: "some name"}, user)
      assert {:ok, %Balance{} = balance} = Balances.create_balance(@valid_attrs, user.id, provider.id)
      assert balance.amount == Decimal.new("120.5")
      assert balance.date == ~D[2010-04-17]
    end

    test "create_balance/3 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Balances.create_balance(@invalid_attrs, nil, nil)
    end

    test "update_balance/2 with valid data updates the balance" do
      balance = balance_fixture()
      assert {:ok, %Balance{} = balance} = Balances.update_balance(balance, @update_attrs)
      assert balance.amount == Decimal.new("456.7")
      assert balance.date == ~D[2011-05-18]
    end

    test "update_balance/2 with invalid data returns error changeset" do
      balance = balance_fixture()
      assert {:error, %Ecto.Changeset{}} = Balances.update_balance(balance, @invalid_attrs)
      assert balance == Balances.get_balance!(balance.id)
    end

    test "delete_balance/1 deletes the balance" do
      balance = balance_fixture()
      assert {:ok, %Balance{}} = Balances.delete_balance(balance)
      assert_raise Ecto.NoResultsError, fn -> Balances.get_balance!(balance.id) end
    end

    test "change_balance/1 returns a balance changeset" do
      balance = balance_fixture()
      assert %Ecto.Changeset{} = Balances.change_balance(balance)
    end
  end
end
