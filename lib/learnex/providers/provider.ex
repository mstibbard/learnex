defmodule Learnex.Providers.Provider do
  use Ecto.Schema
  import Ecto.Changeset

  schema "providers" do
    field :account_type, :string
    field :name, :string
    belongs_to :user, Learnex.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(provider, attrs) do
    provider
    |> cast(attrs, [:name, :account_type, :user_id])
    |> foreign_key_constraint(:user_id)
    |> validate_required([:name, :account_type, :user_id])
  end
end
