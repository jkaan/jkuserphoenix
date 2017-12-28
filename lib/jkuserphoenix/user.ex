defmodule Jkuserphoenix.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Jkuserphoenix.User


  schema "users" do
    field :email, :string
    field :password, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password])
    |> validate_required([:username, :email, :password])
    |> validate_length(:password, min: 6)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true} ->
        update_change(changeset, :password,
                   &(Comeonin.Bcrypt.hashpwsalt(&1)))
      _ ->
        changeset
    end
  end
end
