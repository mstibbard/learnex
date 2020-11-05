defmodule Learnex.Balances.Balance do
  use Ecto.Schema
  import Ecto.Changeset

  schema "balances" do
    field :amount, :decimal
    field :date, :date
    belongs_to :user, Learnex.Accounts.User
    belongs_to :provider, Learnex.Providers.Provider

    timestamps()
  end

  @doc false
  def changeset(balance, attrs) do
    balance
    |> cast(attrs, [:date, :amount, :user_id, :provider_id])
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:provider_id)
    |> validate_required([:date, :amount, :user_id, :provider_id])
  end
end
