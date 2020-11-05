defmodule Learnex.Repo.Migrations.CreateBalances do
  use Ecto.Migration

  def change do
    create table(:balances) do
      add :date, :date
      add :amount, :decimal
      add :user_id, references(:users, on_delete: :nothing)
      add :provider_id, references(:providers, on_delete: :nothing)

      timestamps()
    end

    create index(:balances, [:user_id])
    create index(:balances, [:provider_id])
  end
end
