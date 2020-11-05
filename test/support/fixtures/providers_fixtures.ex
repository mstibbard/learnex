defmodule Learnex.ProvidersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Learnex.Accounts` context.
  """
  alias Learnex.Providers

  @valid_attrs %{account_type: "some account_type", name: "some name"}

  def provider_fixture(attrs \\ %{}, user) do
    {:ok, provider} =
      attrs
      |> Enum.into(@valid_attrs)
      |> Providers.create_provider(user.id)

    provider
  end
end
