defmodule Data.Contexts.UtilityContext do
  @moduledoc false

  use Arc.Ecto.Schema
  alias Ecto.Changeset

  def transform_error_message(changeset) do
   errors = Enum.map(changeset.errors, fn({key, {message, _}}) ->
      %{
         key => transform_required(key, message)
      }
    end)

    Enum.reduce(errors, fn(head, tail) ->
      Map.merge(head, tail)
    end)
  end

  defp transform_required(key, "is required"), do: "Enter #{key}"
  defp transform_required(:error, message), do: "#{message}"
  defp transform_required(key, message), do: "#{key} #{message}"

  def to_upcase_value(changeset, keys \\ []) when is_map(changeset) do
    changes =
      Enum.into(changeset.changes, %{}, fn({key, val}) ->
        if Enum.member?(keys, key) do
          {key, to_upcase(val)}
        else
          {key, val}
        end
      end)

    Map.put(changeset, :changes, changes)
  end

  def to_upcase(str) do
      String.upcase(str)
    rescue
      _ ->
       str
  end

  def transform_account_error_message(changeset) do
    errors = Enum.map(changeset.errors, fn({key, {message, _}}) ->
      transform_message(message, key)
    end)

    Enum.reduce(errors, fn(head, tail) ->
      Map.merge(head, tail)
    end)
  end

  def changeset_errors_to_string(errors) do
    for {field, {message, _opts}} <- errors do
      transform_address_message(message, field)
    end
    |> Enum.join(", ")
  end

  def capitalize_from_changeset(changeset, key) do
    with true <- Map.has_key?(changeset.changes, key) do
      string =
        changeset.changes[key]
        |> String.split(" ")
        |> Enum.map(&(String.capitalize(&1)))
        |> Enum.join(" ")
      changeset
      |> Changeset.put_change(key, string)
    else
      _ ->
        changeset
    end
  end

  defp transform_address_message("Enter", field), do: "#{field}: Enter #{transform_atom(field)}"
  defp transform_address_message("Invalid", field), do: "#{field}: Invalid #{transform_atom(field)}"
  defp transform_address_message("is invalid", field), do: "#{field}: Invalid #{transform_atom(field)}"
  defp transform_address_message(message, field), do: "#{field}: #{message}"
  defp transform_message("Enter", :addresses), do: %{"addresses" => "Enter at least one address"}
  defp transform_message("Enter", :contacts), do: %{"contacts" => "At least one corp signatory,contact person, account manager and account officer is required to be added"}
  defp transform_message("Enter", key), do: %{"#{key}" => "Enter #{transform_atom(key)}"}
  defp transform_message("is invalid", key), do: %{"#{key}" => "Invalid #{transform_atom(key)}"}
  defp transform_message(message, key), do: %{"#{key}" => "#{message}"}

  defp transform_atom(key) do
    key
    |> Atom.to_string()
    |> String.split("_")
    |> Enum.join(" ")
  end

  def do_randomizer(length, lists) do
    range = get_range(length)
    range
    |> Enum.reduce([], fn(_, acc) -> [Enum.random(lists) | acc] end)
    |> Enum.join("")
  end

  defp get_range(length) when length > 1, do: (1..length)
  defp get_range(length), do: [1]

  def create_photo(conn, base64, name) do
    {:ok, image_binary} = Base.decode64(base64)
    filename =
      image_binary
      |> image_extension()
      |> unique_filename(name)

    path = get_application_path(Application.get_env(:data, :env))
    File.mkdir_p!(path)
    File.write!("#{path}/#{filename}", image_binary)
    Data.FileUploader.store({%{filename: "#{filename}", path: "#{path}/#{filename}"}, name})
    url = Data.FileUploader.url({filename, name}, :original)
    File.rm_rf("#{path}/#{filename}")
    is_test(Application.get_env(:data, :env), "#{path}/#{name}")
    path = get_path(Application.get_env(:api, :env), conn)
    "#{path}#{url}"
  end

  defp is_test(:test, path), do: File.rm_rf(path)
  defp is_test(_env, _path), do: ""

  def image_extension(<<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, _::binary>>), do: ".png"
  def image_extension(<<0xff, 0xD8, _::binary>>), do: ".jpg"

  defp get_path(:prod, conn), do: Atom.to_string(conn.scheme) <> "://" <> ApiWeb.Endpoint.struct_url.host
  defp get_path(_, _), do: ApiWeb.Endpoint.url
  defp unique_filename(extension, name) do
    "IMG_#{name}" <> extension
  end

  defp get_application_path(:test), do: Path.expand('./../../uploads/files/')
  defp get_application_path(:dev), do: Path.expand('./uploads/files/')
  defp get_application_path(:prod), do: Path.expand('./uploads/files/')
  defp get_application_path(_), do: ""

end
