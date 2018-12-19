defmodule Data.Contexts.Clinic do
  @moduledoc "Context API for Clinic"

  import Ecto.Query

  alias Data.{
    Repo,
    Schemas.Clinic,
  }

  @doc """
  Inserts or Updates clinic depending if record exists. Commonly used in seeds.

  ## Examples

      iex> insert_or_update(params)
      {:ok, %Clinic{}}
  """

  def insert_or_update(params) do
    struct = get_by(%{code: params.code})
    if struct != nil do
      struct
      |> modify(params)
    else
      insert(params)
    end
  end

  @doc """
  Inserts new clinic record.

  ## Examples

      iex> insert(%{field: new_value})
      {:ok, %Clinic{}}

      iex> insert(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def insert(params) do
    %Clinic{}
    |> Clinic.changeset(params)
    |> Repo.insert
  end

  @doc """
  Modifies existing clinic record.

  ## Examples

      iex> modify(struct, %{field: new_value})
      {:ok, %Clinic{}}

      iex> modify(struct, %{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def modify(struct, params) do
    struct
    |> Clinic.changeset(params)
    |> Repo.update
  end

  @doc """
  Deletes a Clinic.

  ## Examples

      iex> delete(clinic)
      {:ok, %Clinic{}}

      iex> delete(clinic)
      {:error, %Ecto.Changeset{}}
  """
  def delete(%Clinic{} = struct) do
    struct
    |> Repo.delete
  end

  @doc """
  Gets a single clinic based on id. Returns nil if Clinic does not exist.

  ## Examples

      iex> get(id)
      %Clinic{}

      iex> get(random_id)
      nil
  """
  def get(id) do
    Clinic
    |> Repo.get(id)
  end

  @doc """
  Gets a single clinic based on exact values of params. Returns nil if Clinic does not exist.

  ## Examples
      params = %{name: "wow"}

      iex> get_by(params)
      %Clinic{}

      iex> get_by(random_params)
      nil
  """
  def get_by(params) do
    Clinic
    |> Repo.get_by(params)
  end



  @doc """
  List all procedures based on parameters

  Logic:
  ```
  params
  |> validate_params
  |> etc
  ```


  ## Examples
      params = %{
        search_value: "value",
        page_number: 1,
        display_per_page: 2,
        sort_by: "sort value",
        order_by: "order value"
      }

      iex> get_procedures(params)
      [%Procedure{}, %Procedure{}]

      iex> get_procedures(invalid_params)
      nil
  """
  def get_procedures(params \\ %{}) do
  end
end
