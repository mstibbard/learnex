defmodule Learnex.Repo.Migrations.CreateProviders do
  use Ecto.Migration

  def change do
    create table(:providers) do
      add :name, :string
      add :account_type, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:providers, [:user_id])
  end
end
