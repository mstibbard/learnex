defmodule Learnex.ProvidersTest do
  use Learnex.DataCase

  alias Learnex.Providers
  import Learnex.AccountsFixtures

  describe "providers" do
    alias Learnex.Providers.Provider

    @valid_attrs %{account_type: "some account_type", name: "some name"}
    @update_attrs %{account_type: "some updated account_type", name: "some updated name"}
    @invalid_attrs %{account_type: nil, name: nil, user_id: nil}

    def provider_fixture(attrs \\ %{}) do
      user = user_fixture()

      {:ok, provider} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Providers.create_provider(user.id)

      provider
    end

    test "list_providers/0 returns all providers" do
      provider = provider_fixture()
      assert Providers.list_providers() == [provider]
    end

    test "get_provider!/1 returns the provider with given id" do
      provider = provider_fixture()
      assert Providers.get_provider!(provider.id) == provider
    end

    test "create_provider/2 with valid data creates a provider" do
      user = user_fixture()
      assert {:ok, %Provider{} = provider} = Providers.create_provider(@valid_attrs, user.id)
      assert provider.account_type == "some account_type"
      assert provider.name == "some name"
    end

    test "create_provider/2 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Providers.create_provider(@invalid_attrs, 1)
    end

    test "update_provider/2 with valid data updates the provider" do
      provider = provider_fixture()
      assert {:ok, %Provider{} = provider} = Providers.update_provider(provider, @update_attrs)
      assert provider.account_type == "some updated account_type"
      assert provider.name == "some updated name"
    end

    test "update_provider/2 with invalid data returns error changeset" do
      provider = provider_fixture()
      assert {:error, %Ecto.Changeset{}} = Providers.update_provider(provider, @invalid_attrs)
      assert provider == Providers.get_provider!(provider.id)
    end

    test "delete_provider/1 deletes the provider" do
      provider = provider_fixture()
      assert {:ok, %Provider{}} = Providers.delete_provider(provider)
      assert_raise Ecto.NoResultsError, fn -> Providers.get_provider!(provider.id) end
    end

    test "change_provider/1 returns a provider changeset" do
      provider = provider_fixture()
      assert %Ecto.Changeset{} = Providers.change_provider(provider)
    end
  end
end
