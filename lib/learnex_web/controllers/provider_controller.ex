defmodule LearnexWeb.ProviderController do
  use LearnexWeb, :controller

  alias Learnex.Providers
  alias Learnex.Providers.Provider

  def index(conn, _params) do
    providers = Providers.list_providers()
    render(conn, "index.html", providers: providers)
  end

  def new(conn, _params) do
    changeset = Providers.change_provider(%Provider{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"provider" => provider_params}) do
    user_id = conn.assigns.current_user.id

    case Providers.create_provider(provider_params, user_id) do
      {:ok, provider} ->
        conn
        |> put_flash(:info, "Provider created successfully.")
        |> redirect(to: Routes.provider_path(conn, :show, provider))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    provider = Providers.get_provider!(id)
    render(conn, "show.html", provider: provider)
  end

  def edit(conn, %{"id" => id}) do
    provider = Providers.get_provider!(id)
    changeset = Providers.change_provider(provider)
    render(conn, "edit.html", provider: provider, changeset: changeset)
  end

  def update(conn, %{"id" => id, "provider" => provider_params}) do
    provider = Providers.get_provider!(id)

    case Providers.update_provider(provider, provider_params) do
      {:ok, provider} ->
        conn
        |> put_flash(:info, "Provider updated successfully.")
        |> redirect(to: Routes.provider_path(conn, :show, provider))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", provider: provider, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    provider = Providers.get_provider!(id)
    {:ok, _provider} = Providers.delete_provider(provider)

    conn
    |> put_flash(:info, "Provider deleted successfully.")
    |> redirect(to: Routes.provider_path(conn, :index))
  end
end
