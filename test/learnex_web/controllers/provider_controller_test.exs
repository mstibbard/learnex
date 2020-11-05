defmodule LearnexWeb.ProviderControllerTest do
  use LearnexWeb.ConnCase

  alias Learnex.Providers
  import Learnex.AccountsFixtures

  @create_attrs %{account_type: "some account_type", name: "some name"}
  @update_attrs %{account_type: "some updated account_type", name: "some updated name"}
  @invalid_attrs %{account_type: nil, name: nil}

  setup do
    %{user: user_fixture()}
  end

  def fixture(:provider) do
    user = user_fixture()
    {:ok, provider} = Providers.create_provider(@create_attrs, user.id)
    provider
  end

  describe "index" do
    test "lists all providers", %{conn: conn, user: user} do
      conn = conn |> log_in_user(user) |> get(Routes.provider_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Providers"
    end
  end

  describe "new provider" do
    test "renders form", %{conn: conn, user: user} do
      conn = conn |> log_in_user(user) |> get(Routes.provider_path(conn, :new))
      assert html_response(conn, 200) =~ "New Provider"
    end
  end

  describe "create provider" do
    test "redirects to show when data is valid", %{conn: conn, user: user} do
      conn = conn |> log_in_user(user) |> post(Routes.provider_path(conn, :create), provider: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.provider_path(conn, :show, id)

      conn = get(conn, Routes.provider_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Provider"
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = conn |> log_in_user(user) |> post(Routes.provider_path(conn, :create), provider: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Provider"
    end
  end

  describe "edit provider" do
    setup [:create_provider]

    test "renders form for editing chosen provider", %{conn: conn, provider: provider, user: user} do
      conn = conn |> log_in_user(user) |> get(Routes.provider_path(conn, :edit, provider))
      assert html_response(conn, 200) =~ "Edit Provider"
    end
  end

  describe "update provider" do
    setup [:create_provider]

    test "redirects when data is valid", %{conn: conn, provider: provider, user: user} do
      conn = conn |> log_in_user(user) |> put(Routes.provider_path(conn, :update, provider), provider: @update_attrs)
      assert redirected_to(conn) == Routes.provider_path(conn, :show, provider)

      conn = get(conn, Routes.provider_path(conn, :show, provider))
      assert html_response(conn, 200) =~ "some updated account_type"
    end

    test "renders errors when data is invalid", %{conn: conn, provider: provider, user: user} do
      conn = conn |> log_in_user(user) |> put(Routes.provider_path(conn, :update, provider), provider: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Provider"
    end
  end

  describe "delete provider" do
    setup [:create_provider]

    test "deletes chosen provider", %{conn: conn, provider: provider, user: user} do
      conn = conn |> log_in_user(user) |> delete(Routes.provider_path(conn, :delete, provider))
      assert redirected_to(conn) == Routes.provider_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.provider_path(conn, :show, provider))
      end
    end
  end

  defp create_provider(_) do
    provider = fixture(:provider)
    %{provider: provider}
  end
end
