defmodule Hochfuenf.Accounts do
  @moduledoc """
  The Accounts context. Used for managing users on the console mostly,
  but also to get the providers records created/looked up when coming from the
  provider of choice.
  """

  import Ecto.Query, warn: false
  alias Hochfuenf.Repo
  alias Hochfuenf.Accounts.User
  alias Ueberauth.Auth

  def find_or_create(%Auth{
        uid: uid,
        provider: :auth0,
        info: %Auth.Info{name: name, email: email, image: image}
      }) do
    case get_user_by_email(email) do
      nil ->
        user =
          create_user(%{
            email: email,
            name: name,
            external_id: uid,
            provider: "auth0",
            avatar: image
          })

        {:ok, user}

      %User{provider: "auth0"} = user ->
        {:ok, user}

      _ ->
        {:error, "Something went wrong!"}
    end
  end

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user by their email. Returns nil if not found.

  ## Examples

      iex> get_user_by_email("flo@contentful.com")
      %User{}

      iex> get_user!("non-existing@contentful.com")
      nil
  """
  def get_user_by_email(email) do
    query = from u in User, where: u.email == ^email
    query |> Repo.one()
  end

  @doc """
  Gets a single user.

  ## Examples

      iex> get_user(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
