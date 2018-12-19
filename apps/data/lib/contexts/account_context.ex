defmodule Data.Contexts.AccountContext do
  @moduledoc false

  import Ecto.{Query}, warn: false
  alias Data.Repo
  alias Data.Schemas.{
    Account,
    AccountAddress,
    AccountContact,
    AccountBank,
    AccountPersonnel,
    AccountPlan,
    AccountApprover
  }
  alias Data.Contexts.AddressLookUpContext, as: AC
  alias Data.Contexts.GenericLookUpContext, as: GC
  alias Data.Contexts.UtilityContext, as: UC
  alias Ecto.Changeset, warn: false

  def validate_params(:create, params) do
    fields = %{
      profile_photo: :string,
      segment: :string,
      name: :string,
      type: :string,
      industry: :string,
      effective_date: :string,
      expiry_date: :string,
      addresses: {:array, :map},
      address_same_as_billing:  :boolean,
      contacts: {:array, :map},
      tin: :string,
      vat_status: :string,
      previous_carrier: :string,
      attachment_point: :integer,
      banks: {:array, :map},
      bank_same_as_funding: :boolean,
      personnels: {:array, :map}
    }

    changeset =
      {%{}, fields}
      |> Changeset.cast(params, Map.keys(fields))
      |> Changeset.validate_required([
        :segment,
        :name,
        :type,
        :industry,
        :effective_date,
        :expiry_date,
        :addresses,
        :address_same_as_billing,
        :contacts,
        :tin,
        :vat_status,
        :banks,
        :bank_same_as_funding,
        :personnels
      ], message: "Enter")
      |> validate_file_format()
      |> validate_file_size()
      |> Changeset.validate_length(:name, max: 80, message: "Only 80 alphanumeric characters are allowed")
      |> validate_inclusion(:segment, "account_segment")
      |> validate_inclusion(:type, "account_type")
      |> validate_industry_inclusion(:industry, "industry")
      |> Changeset.validate_format(:effective_date,
                                   ~r/^(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)[\/\-](0?[1-9]|[12][0-9]|3[01])[\/\-]\d{4}$/,
                                   message: "Invalid effective date")
      |> Changeset.validate_format(:expiry_date,
                                  ~r/^(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)[\/\-](0?[1-9]|[12][0-9]|3[01])[\/\-]\d{4}$/,
                                  message: "Invalid expiry date")
      |> validate_date_range()
      |> validate_addresses()
      |> validate_contacts()
      |> validate_banks()
      |> validate_personnels()
      |> validate_inclusion(:vat_status, "vat_status")
      |> Changeset.validate_length(:previous_carrier, max: 80, message: "Only 80 alphanumeric characters are allowed")
      |> Changeset.validate_length(:tin, max: 12, message: "Only 12 numeric characters are allowed")
      |> validate_ap_length()

      {changeset.valid?, changeset}
  end

  defp validate_file_format(%{changes: %{profile_photo: profile_photo}} = changeset) do
    profile_photo
    |> Base.decode64!()
    |> UC.image_extension()
    |> validate_photo_format(changeset)
    rescue
    _ ->
    error_msg(changeset, :profile_photo, "Invalid profile photo")
  end
  defp validate_file_format(%{changes: %{authorization_form: authorization_form}} = changeset) do
    authorization_form
    |> Base.decode64!()
    |> UC.image_extension()
    |> validate_photo_format(changeset)
    rescue
    _ ->
    error_msg(changeset, :authorization_form, "Invalid authorization form")
  end
  defp validate_file_format(changeset), do: changeset

  defp validate_photo_format(".png", changeset), do: changeset
  defp validate_photo_format(".jpg", changeset), do: changeset
  defp validate_photo_format(_image, changeset), do: error_msg(changeset, :profile_photo, "Invalid profile photo")

  defp validate_file_size(%{changes: %{profile_photo: profile_photo}} = changeset) do
    profile_photo
    |> String.length()
    |> Kernel./(3)
    |> Kernel.*(0.5624896334383812)
    |> Kernel.*(4)
    |> Kernel./(1024)
    |> Kernel.>(5000)
    |> validate_photo_size(changeset)
  end
  defp validate_file_size(%{changes: %{authorization_form: authorization_form}} = changeset) do
    authorization_form
    |> String.length()
    |> Kernel./(3)
    |> Kernel.*(0.5624896334383812)
    |> Kernel.*(4)
    |> Kernel./(1024)
    |> Kernel.>(5000)
    |> validate_photo_size(changeset)
  end
  defp validate_file_size(changeset), do: changeset

  defp validate_photo_size(true, changeset), do: error_msg(changeset, :profile_photo, "Maximum file size is 5 megabytes")
  defp validate_photo_size(false, changeset), do: changeset

  defp validate_inclusion(changeset, key, type) do
    changeset
    |> Changeset.get_field(key)
    |> GC.get_generic_look_up_by_code(type)
    |> validate_inclusion_key(
      Changeset.get_field(changeset, key),
      changeset,
      key
    )
  end

  defp validate_industry_inclusion(changeset, key, type) do
    changeset
    |> Changeset.get_field(key)
    |> GC.get_generic_look_up_by_industry(type)
    |> validate_inclusion_key(
      Changeset.get_field(changeset, key),
      changeset,
      key
    )
  end

  defp validate_address_inclusion(changeset, :type = key) do
    changeset
    |> Changeset.get_field(key)
    |> GC.get_generic_look_up_by_code("address_type")
    |> validate_address_inclusion_key(
      Changeset.get_field(changeset, key),
      changeset,
      key
    )
  end

  defp validate_address_inclusion(%{changes: %{city: _city}} = changeset, :city = key) do
    changeset
    |> Changeset.get_field(key)
    |> AC.get_address_look_up_by_city()
    |> validate_address_inclusion_key(
      Changeset.get_field(changeset, key),
      changeset,
      key
    )
  end

  defp validate_address_inclusion(%{changes: %{province: _province}} = changeset, :province = key) do
    changeset
    |> Changeset.get_field(key)
    |> AC.get_address_look_up_by_province()
    |> validate_address_inclusion_key(
      Changeset.get_field(changeset, key),
      changeset,
      key
    )
  end

  defp validate_address_inclusion(%{changes: %{region: _region}} = changeset, :region = key) do
    changeset
    |> Changeset.get_field(key)
    |> AC.get_address_look_up_by_region()
    |> validate_address_inclusion_key(
      Changeset.get_field(changeset, key),
      changeset,
      key
    )
  end
  defp validate_address_inclusion(changeset, _key), do: changeset

  defp validate_inclusion_key(_, nil, changeset, _), do: changeset
  defp validate_inclusion_key(nil, _, changeset, key), do: error_msg(changeset, key, "Invalid #{transform_atom(key)}")
  defp validate_inclusion_key(_, _, changeset, _), do: changeset

  defp validate_address_inclusion_key(_, nil, changeset, _), do: changeset
  defp validate_address_inclusion_key(nil, _, changeset, key), do: error_msg(changeset, key, "Invalid")
  defp validate_address_inclusion_key(_, _, changeset, _), do: changeset

  defp transform_atom(key) do
    key
    |> Atom.to_string()
    |> String.split("_")
    |> Enum.join(" ")
  end

  defp validate_date_range(changeset) do
    errors =
      for {field, {_message, _opts}} <- changeset.errors do
        "#{field}"
      end

    errors
    |> Enum.member?("effective_date")
    |> validate_effective_date(changeset, errors)
  end

  defp validate_effective_date(true, changeset, _errors), do: changeset
  defp validate_effective_date(false, changeset, errors), do: validate_expiry_date(Enum.member?(errors, "expiry_date"), changeset)

  defp validate_expiry_date(true, changeset), do: changeset
  defp validate_expiry_date(false, %{
    changes: %{
      effective_date: effective_date,
      expiry_date: expiry_date
    }
  } = changeset) do

    effective_date =
      effective_date
      |> transform_to_timex_date()

    expiry_date =
      expiry_date
      |> transform_to_timex_date()

    date_today = Timex.now()
    date_today =
      date_today
      |> Timex.to_date()

    date_compare =
      expiry_date
      |> Timex.compare(effective_date)

    date_compare_now =
      effective_date
      |> Timex.compare(date_today)

    date_compare
    |> validate_date_compare(date_compare_now, changeset)
  end

  defp validate_date_compare(0, _, changeset), do: error_msg(changeset, :expiry_date, "must be greater than effective date")
  defp validate_date_compare(-1, _, changeset), do: error_msg(changeset, :expiry_date, "must be greater than effective date")
  defp validate_date_compare(_, 0, changeset), do: error_msg(changeset, :effective_date, "must be future dated")
  defp validate_date_compare(_, -1, changeset), do: error_msg(changeset, :effective_date, "must be future dated")
  defp validate_date_compare(_, _, changeset), do: changeset
  defp transform_to_timex_date(date) do
    {month, day, year} =
      date
      |> String.split("-")
      |> List.to_tuple()

    Timex.to_date({
      String.to_integer(year),
      month_index[String.downcase(month)],
      day_index(String.first(day), day)
    })
  end

  defp month_index do
    %{
      "jan" => 1,
      "feb" => 2,
      "mar" => 3,
      "apr" => 4,
      "may" => 5,
      "jun" => 6,
      "jul" => 7,
      "aug" => 8,
      "sep" => 9,
      "oct" => 10,
      "nov" => 11,
      "dec" => 12
    }
  end

  defp day_index("0", day), do: String.to_integer(String.slice(day, 1..2))
  defp day_index(_, day), do: String.to_integer(day)

  defp validate_addresses(%{changes: %{addresses: addresses}} = changeset) do
    addresses
    |> Enum.with_index(1)
    |> validate_addresses_params([])
    |> Enum.join(", ")
    |> validate_errors(changeset, :addresses)
  end
  defp validate_addresses(changeset), do: changeset

  defp validate_addresses_params([{params, index} | tails], errors) do
    fields = %{
      type: :string,
      address_line_1: :string,
      address_line_2: :string,
      city: :string,
      province: :string,
      region: :string,
      country: :string,
      postal: :string
    }

    changeset =
      {%{}, fields}
      |> Changeset.cast(params, Map.keys(fields))
      |> Changeset.validate_required([
        :type,
        :address_line_1,
        :address_line_2,
        :city,
        :province,
        :region,
        :country,
        :postal
      ], message: "Enter")
      |> validate_address_inclusion(:type)
      |> Changeset.validate_length(:address_line_1, max: 150, message: "Only 150 alphanumeric characters are allowed")
      |> Changeset.validate_length(:address_line_2, max: 150, message: "Only 150 alphanumeric characters are allowed")
      |> Changeset.validate_inclusion(:country, ["Philippines"], message: "Invalid country")
      |> Changeset.validate_length(:postal, max: 5, message: "Only 5 numeric characters are allowed")
      |> validate_address_inclusion(:city)
      |> validate_address_inclusion(:province)
      |> validate_address_inclusion(:region)

      validate_address_changeset(changeset.valid?, changeset, index, tails, errors)
  end
  defp validate_addresss_params([], errors), do: errors

  defp validate_address_changeset(true, _changeset, _index, tails, errors), do: validate_addresss_params(tails, errors)
  defp validate_address_changeset(false, changeset, index, tails, errors) do
    changeset_errors = UC.changeset_errors_to_string(changeset.errors)
    errors = errors ++ ["row #{index} errors (#{changeset_errors})"]
    validate_addresss_params(tails, errors)
  end

  defp validate_contacts(%{changes: %{contacts: contacts}} = changeset) do
    contacts
    |> Enum.with_index(1)
    |> validate_contacts_params([])
    |> Enum.join(", ")
    |> validate_errors(changeset, :contacts)
  end
  defp validate_contacts(changeset), do: changeset

  defp validate_contacts_params([{params, index} | tails], errors) do
    fields = %{
      type: :string,
      name: :string,
      department: :string,
      designation: :string,
      telephone: {:array, :map},
      mobile: {:array, :map},
      fax: {:array, :map},
      email_address: :string,
      ctc: :string,
      ctc_date_issued: :string,
      ctc_place_issued: :string,
      passport: :string,
      passport_date_issued: :string,
      passport_place_issued: :string
    }

    changeset =
      {%{}, fields}
      |> Changeset.cast(params, Map.keys(fields))
      |> Changeset.validate_required([
        :type,
        :name,
        :department,
        :designation,
        :mobile,
        :email_address,
      ], message: "Enter")
      |> Changeset.validate_length(:name, max: 80, message: "Only 80 alphanumeric characters are allowed")
      |> Changeset.validate_format(:name, ~r/^[ a-zA-Z0-9-_.]*$/, message: "Only 80 alphanumeric characters are allowed")
      |> Changeset.validate_length(:type, max: 80, message: "Only 80 alphanumeric characters are allowed")
      |> Changeset.validate_format(:type, ~r/^[ a-zA-Z0-9-_.]*$/, message: "Only 80 alphanumeric characters are allowed")
      |> Changeset.validate_length(:department, max: 80, message: "Only 80 alphanumeric characters are allowed")
      |> Changeset.validate_format(:department, ~r/^[ a-zA-Z0-9-_.]*$/, message: "Only 80 alphanumeric characters are allowed")
      |> Changeset.validate_length(:designation, max: 80, message: "Only 80 alphanumeric characters are allowed")
      |> Changeset.validate_format(:designation, ~r/^[ a-zA-Z0-9-_.]*$/, message: "Only 80 alphanumeric characters are allowed")
      |> Changeset.validate_length(:email_address, max: 80, message: "Only 80 alphanumeric characters are allowed")
      |> Changeset.validate_format(:email_address, ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/, message: "Invalid email address")
      |> Changeset.validate_length(:ctc, max: 80, message: "Only 80 alphanumeric characters are allowed")
      |> Changeset.validate_length(:ctc_place_issued, max: 80, message: "Only 80 alphanumeric characters are allowed")
      |> Changeset.validate_length(:passport, max: 80, message: "Only 80 alphanumeric characters are allowed")
      |> Changeset.validate_length(:passport_place_issued, max: 80, message: "Only 80 alphanumeric characters are allowed")
      |> validate_inclusion(:type, "account_contact_type")
      |> Changeset.validate_format(:ctc_date_issued,
                                   ~r/^(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)[\/\-](0?[1-9]|[12][0-9]|3[01])[\/\-]\d{4}$/,
                                   message: "Invalid ctc date issued")
                                   |> Changeset.validate_format(:passport_date_issued,
                                                                ~r/^(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)[\/\-](0?[1-9]|[12][0-9]|3[01])[\/\-]\d{4}$/,
                                                                message: "Invalid passport date issued")
                                                                |> validate_telephones()
                                                                |> validate_mobiles()
                                                                |> validate_faxes()

                                                                validate_contact_changeset(changeset.valid?, changeset, index, tails, errors)
  end
  defp validate_contacts_params([], errors), do: errors

  defp validate_contact_changeset(true, _changeset, _index, tails, errors), do: validate_contacts_params(tails, errors)
  defp validate_contact_changeset(false, changeset, index, tails, errors) do
    changeset_errors = UC.changeset_errors_to_string(changeset.errors)
    errors = errors ++ ["row #{index} errors (#{changeset_errors})"]
    validate_contacts_params(tails, errors)
  end

  defp validate_telephones(%{changes: %{telephone: telephone}} = changeset) do
    telephone
    |> Enum.with_index(1)
    |> validate_telephone_params([])
    |> Enum.join(", ")
    |> validate_errors(changeset, :contacts)
  end
  defp validate_telephones(changeset), do: changeset

  defp validate_mobiles(%{changes: %{mobile: mobile}} = changeset) do
    mobile
    |> Enum.with_index(1)
    |> validate_mobile_params([])
    |> Enum.join(", ")
    |> validate_errors(changeset, :contacts)
  end
  defp validate_mobiles(changeset), do: changeset

  defp validate_faxes(%{changes: %{fax: fax}} = changeset) do
    fax
    |> Enum.with_index(1)
    |> validate_fax_params([])
    |> Enum.join(", ")
    |> validate_errors(changeset, :contacts)
  end
  defp validate_faxes(changeset), do: changeset

  defp validate_telephone_params([{params, index} | tails], errors) do
    fields = %{
      area_code: :string,
      number: :string,
      local: :string
    }

    changeset =
      {%{}, fields}
      |> Changeset.cast(params, Map.keys(fields))
      |> Changeset.validate_required([
        :area_code,
        :number,
        :local
      ], message: "Enter")
      |> Changeset.validate_length(:area_code, max: 6, message: "Only 6 numeric characters are allowed")
      |> Changeset.validate_length(:number, max: 7, message: "Only 7 numeric characters are allowed")
      |> Changeset.validate_length(:local, max: 3, message: "Only 3 numeric characters are allowed")

    validate_telephone_changeset(changeset.valid?, changeset, index, tails, errors)
  end
  defp validate_telephone_params([], errors), do: errors

  defp validate_telephone_changeset(true, _changeset, _index, tails, errors), do: validate_telephone_params(tails, errors)
  defp validate_telephone_changeset(false, changeset, index, tails, errors) do
    changeset_errors = UC.changeset_errors_to_string(changeset.errors)
    errors = errors ++ ["row #{index} errors (#{changeset_errors})"]
    validate_telephone_params(tails, errors)
  end

  defp validate_mobile_params([{params, index} | tails], errors) do
    fields = %{
      number: :string
    }

    changeset =
      {%{}, fields}
      |> Changeset.cast(params, Map.keys(fields))
      |> Changeset.validate_required([
        :number
      ], message: "Enter")
      |> Changeset.validate_length(:number, max: 10, message: "Only 10 numeric characters are allowed")

    validate_mobile_changeset(changeset.valid?, changeset, index, tails, errors)
  end
  defp validate_mobile_params([], errors), do: errors

  defp validate_mobile_changeset(true, _changeset, _index, tails, errors), do: validate_mobile_params(tails, errors)
  defp validate_mobile_changeset(false, changeset, index, tails, errors) do
    changeset_errors = UC.changeset_errors_to_string(changeset.errors)
    errors = errors ++ ["row #{index} errors (#{changeset_errors})"]
    validate_mobile_params(tails, errors)
  end

  defp validate_fax_params([{params, index} | tails], errors) do
    fields = %{
      area_code: :string,
      number: :string,
      local: :string
    }

    changeset =
      {%{}, fields}
      |> Changeset.cast(params, Map.keys(fields))
      |> Changeset.validate_required([
        :area_code,
        :number,
        :local
      ], message: "Enter")
      |> Changeset.validate_length(:area_code, max: 6, message: "Only 6 numeric characters are allowed")
      |> Changeset.validate_length(:number, max: 7, message: "Only 7 numeric characters are allowed")
      |> Changeset.validate_length(:local, max: 3, message: "Only 3 numeric characters are allowed")

    validate_fax_changeset(changeset.valid?, changeset, index, tails, errors)
  end
  defp validate_fax_params([], errors), do: errors

  defp validate_fax_changeset(true, _changeset, _index, tails, errors), do: validate_fax_params(tails, errors)
  defp validate_fax_changeset(false, changeset, index, tails, errors) do
    changeset_errors = UC.changeset_errors_to_string(changeset.errors)
    errors = errors ++ ["row #{index} errors (#{changeset_errors})"]
    validate_fax_params(tails, errors)
  end

  defp validate_banks(%{changes: %{banks: banks}} = changeset) do
    banks
    |> Enum.with_index(1)
    |> validate_banks_params([])
    |> Enum.join(", ")
    |> validate_errors(changeset, :banks)
  end
  defp validate_banks(changeset), do: changeset

  defp validate_banks_params([{params, index} | tails], errors) do
    fields = %{
      payment_mode: :string,
      payee_name: :string,
      bank_account: :string,
      bank_name: :string,
      bank_branch: :string,
      authority_to_debit: :boolean,
      authorization_form: :string
    }

    changeset =
      {%{}, fields}
      |> Changeset.cast(params, Map.keys(fields))
      |> Changeset.validate_required([
        :payment_mode
      ], message: "Enter")
      |> validate_inclusion(:payment_mode, "bank_payment_mode")
      |> validate_file_format()
      |> validate_file_size()
      |> Changeset.validate_length(:payee_name, max: 80, message: "Only 80 alphanumeric characters are allowed")
      |> Changeset.validate_length(:bank_account, max: 12, message: "Only 12 numeric characters are allowed")
      |> Changeset.validate_length(:bank_name, max: 80, message: "Only 80 alphanumeric characters are allowed")
      |> Changeset.validate_length(:bank_branch, max: 80, message: "Only 80 alphanumeric characters are allowed")

    validate_banks_changeset(changeset.valid?, changeset, index, tails, errors)
  end
  defp validate_banks_params([], errors), do: errors

  defp validate_banks_changeset(true, _changeset, _index, tails, errors), do: validate_banks_params(tails, errors)
  defp validate_banks_changeset(false, changeset, index, tails, errors) do
    changeset_errors = UC.changeset_errors_to_string(changeset.errors)
    errors = errors ++ ["row #{index} errors (#{changeset_errors})"]
    validate_banks_params(tails, errors)
  end

  defp validate_personnels(%{changes: %{personnels: personnels}} = changeset) do
    personnels
    |> Enum.with_index(1)
    |> validate_personnels_params([])
    |> Enum.join(", ")
    |> validate_errors(changeset, :personnels)
  end
  defp validate_personnels(changeset), do: changeset

  defp validate_personnels_params([{params, index} | tails], errors) do
    fields = %{
      personnel: :string,
      specialization: :string,
      location: :string,
      schedule: :string,
      no_of_personnel: :integer,
      payment_mode: :string,
      retainer_fee: :string,
      amount: :decimal
    }

    changeset =
      {%{}, fields}
      |> Changeset.cast(params, Map.keys(fields))
      |> Changeset.validate_required([
        :personnel,
        :specialization,
        :location,
        :schedule,
        :no_of_personnel,
        :payment_mode,
        :retainer_fee,
        :amount
      ], message: "Enter")
      |> validate_inclusion(:payment_mode, "account_personnel_payment_mode")
      |> validate_inclusion(:retainer_fee, "retainer_fee")
      |> Changeset.validate_length(:personnel, max: 80, message: "Only 80 alphanumeric characters are allowed")
      |> Changeset.validate_length(:specialization, max: 80, message: "Only 80 alphanumeric characters are allowed")
      |> Changeset.validate_length(:location, max: 80, message: "Only 80 alphanumeric characters are allowed")
      |> Changeset.validate_length(:schedule, max: 80, message: "Only 80 alphanumeric characters are allowed")
      |> validate_amount_length()

      validate_personnels_changeset(changeset.valid?, changeset, index, tails, errors)
  end
  defp validate_personnels_params([], errors), do: errors

  defp validate_personnels_changeset(true, _changeset, _index, tails, errors), do: validate_personnels_params(tails, errors)
  defp validate_personnels_changeset(false, changeset, index, tails, errors) do
    changeset_errors = UC.changeset_errors_to_string(changeset.errors)
    errors = errors ++ ["row #{index} errors (#{changeset_errors})"]
    validate_personnels_params(tails, errors)
  end

  defp validate_ap_length(changeset) do
    for {field, {_message, _opts}} <- changeset.errors do
      "#{field}"
    end
    |> Enum.member?("attachment_point")
    |> validate_ap_error(changeset)
  end
  defp validate_ap_error(true, changeset), do: error_msg(changeset, :attachment_point, "Invalid attachment point")
  defp validate_ap_error(false, %{changes: %{attachment_point: attachment_point}} = changeset), do: validate_ap_length(String.length("#{attachment_point}") > 12, changeset)
  defp validate_ap_length(true, changeset), do: error_msg(changeset, :attachment_point, "Only 12 numeric characters are allowed")
  defp validate_ap_length(false, changeset), do: changeset

  defp validate_amount_length(changeset) do
    for {field, {_message, _opts}} <- changeset.errors do
      "#{field}"
    end
    |> Enum.member?("amount")
    |> validate_amount_error(changeset)
  end
  defp validate_amount_error(true, changeset), do: changeset
  defp validate_amount_error(false, %{changes: %{amount: amount}} = changeset), do: validate_amount_length(String.length("#{amount}") > 8, changeset)
  defp validate_amount_length(true, changeset), do: error_msg(changeset, :amount, "Only 8 numeric characters are allowed")
  defp validate_amount_length(false, changeset), do: changeset

  defp validate_errors("", changeset, _key), do: changeset
  defp validate_errors(message, changeset, key), do: error_msg(changeset, key, message)

  defp error_msg(changeset, key, message), do: Changeset.add_error(changeset, key, message)

  def generate_account_code({:error, changeset}), do: {:error, changeset}
  def generate_account_code(params) do
    random = String.upcase(generate_random_account_code())
    Account
    |> where([a], a.code == ^random)
    |> Repo.all()
    |> generate_random(params, random)
  end

  defp generate_random([], params, random), do: params = params |> Map.put(:code, random)
  defp generate_random(_account, params, _random), do: generate_account_code(params)

  def generate_random_account_code do
    alphabets = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    numbers = "0123456789"
    random = UC.do_randomizer(8, String.split("#{alphabets}#{numbers}", "", trim: true))

    validate_alphabets(String.contains?(random, String.split(alphabets, "", trim: true)), numbers, random)
  end

  defp validate_alphabets(true, numbers, random), do: validate_numbers(String.contains?(random, String.split(numbers, "", trim: true)), random)
  defp validate_alphabets(false, _numbers, _random), do: generate_random_account_code()

  defp validate_numbers(true, random), do: random
  defp validate_numbers(false, _random), do: generate_random_account_code()

  def insert_account({:error, changeset}, conn), do: {:error, changeset}
  def insert_account(params, conn) do

    params =
      params
      |> Map.put(:step, "7")
      |> Map.put(:version, "1")
      |> Map.put(:inserted_by, "Masteradmin")
      |> Map.put(:updated_by, "Masteradmin")
      |> Map.put(:effective_date, transform_to_timex_date(params[:effective_date]))
      |> Map.put(:expiry_date, transform_to_timex_date(params[:expiry_date]))
      |> Map.put(:attachment_point, Integer.to_string(params[:attachment_point]))

    account =
      :create
      |> Account.changeset(%Account{}, params)
      |> Repo.insert!()

    for address_params <- params[:addresses] do
      address_params =
        address_params
        |> Map.put("account_code", params[:code])

      :create
      |> AccountAddress.changeset(%AccountAddress{}, address_params)
      |> Repo.insert!()
    end

    for contact_params <- params[:contacts] do
      contact_params =
        contact_params
        |> Map.put("account_code", params[:code])
        |> Map.put("ctc_date_issued", transform_to_timex_date(contact_params["ctc_date_issued"]))
        |> Map.put("passport_date_issued", transform_to_timex_date(contact_params["passport_date_issued"]))

      :create
      |> AccountContact.changeset(%AccountContact{}, contact_params)
      |> Repo.insert!()
    end

    for bank_params <- params[:banks] do
      bank_params =
        bank_params
        |> Map.put("account_code", params[:code])

      account_bank =
        :create
        |> AccountBank.changeset(%AccountBank{}, bank_params)
        |> Repo.insert!()

      auth_url = UC.create_photo(conn, bank_params["authorization_form"], params[:code])

      account_bank
      |> Ecto.Changeset.change(%{authorization_form: auth_url})
      |> Repo.update()
    end

    for personnel_params <- params[:personnels] do
      personnel_params =
        personnel_params
        |> Map.put("account_code", params[:code])
        |> Map.put("amount", Decimal.new(personnel_params["amount"]))

      :create
      |> AccountPersonnel.changeset(%AccountPersonnel{}, personnel_params)
      |> Repo.insert!()
    end

    url = UC.create_photo(conn, params[:profile_photo], params[:code])

    {:ok, account} =
      account
      |> Ecto.Changeset.change(%{photo: url})
      |> Repo.update()

    account
    |> Repo.preload([
      :account_addresses,
      :account_contacts,
      :account_banks,
      :account_personnels
    ])
  end

  def validate_params(:search, params) do
    fields = %{
      search_value: :string,
      page_number: :integer,
      display_per_page: :integer,
      sort_by: :string,
      order_by: :string
    }

    {%{}, fields}
    |> Changeset.cast(params, Map.keys(fields))
    |> Changeset.validate_required([:page_number, :display_per_page, :sort_by, :order_by], message: "is required")
    |> lower_value(:sort_by)
    |> lower_value(:order_by)
    |> Changeset.validate_inclusion(:sort_by, ["code", "name", "segment", "status", "effective_date", "expiry_date"], message: "is invalid")
    |> Changeset.validate_inclusion(:order_by, ["asc", "desc"], message: "is invalid")
    |> validate_key_search(params["search_value"])
    |> is_valid_changeset?()
  end

  def get_accounts({:error, changeset}, _), do: {:error, changeset}
  def get_accounts(params, :search) do
    search_value = if Map.has_key?(params, :search_value), do: params.search_value, else: ""
    offset = (params.page_number * params.display_per_page) - params.display_per_page

    Account
    |> where([a],
             ilike(a.code, ^"%#{search_value}%") or
             ilike(a.name, ^"%#{search_value}%") or
             ilike(a.segment, ^"%#{search_value}%") or
             ilike(a.status, ^"%#{search_value}%") or
             ilike(fragment("to_char(?, 'MON DD, YYYY')", a.effective_date), ^("%#{search_value}%")) or
             ilike(fragment("to_char(?, 'MON DD, YYYY')", a.expiry_date), ^("%#{search_value}%"))
    )
    |> select([a],
              %{
                code: a.code,
                name: a.name,
                segment: a.segment,
                effective_date: fragment("to_char(?, 'MON DD, YYYY')", a.effective_date),
                expiry_date: fragment("to_char(?, 'MON DD, YYYY')", a.expiry_date),
                status: a.status
              }
    )
    |> order_datatable(
      params.sort_by,
      params.order_by
    )
    |> offset(^offset)
    |> limit(^params.display_per_page)
    |> Repo.all()
  end

  def is_valid_changeset?(changeset), do: {changeset.valid?, changeset}

  defp lower_value(changeset, key) do
    with true <- Map.has_key?(changeset.changes, key) do
      string =
        changeset.changes[key]
        |> String.split(" ")
        |> Enum.map(&(String.downcase(&1)))
        |> Enum.join(" ")
      changeset
      |> Changeset.put_change(key, string)
    else
      _ ->
        changeset
    end
  end

  # For Seed

  def insert_account_seed(params) do
    params
    |> get_by()
    |> create_update_account(params)
  end

  defp create_update_account(nil, params) do
    :create
    |> Account.changeset(%Account{}, params)
    |> Repo.insert()
  end

  defp create_update_account(account, params) do
    :create
    |> Account.changeset(account, params)
    |> Repo.update()
  end

  #Ascending
  defp order_datatable(query, nil, nil), do: query
  defp order_datatable(query, "", ""), do: query
  defp order_datatable(query, "code", "asc"), do: query |> order_by([a], asc: a.code)
  defp order_datatable(query, "name", "asc"), do: query |> order_by([a], asc: a.name)
  defp order_datatable(query, "segment", "asc"), do: query |> order_by([a], asc: a.segment)
  defp order_datatable(query, "effective_date", "asc"), do: query |> order_by([a], asc: a.effective_date)
  defp order_datatable(query, "expiry_date", "asc"), do: query |> order_by([a], asc: a.expiry_date)
  defp order_datatable(query, "status", "asc"), do: query |> order_by([a], asc: a.status)

  # Descending
  defp order_datatable(query, "", ""), do: query
  defp order_datatable(query, "code", "desc"), do: query |> order_by([a], desc: a.code)
  defp order_datatable(query, "name", "desc"), do: query |> order_by([a], desc: a.name)
  defp order_datatable(query, "segment", "desc"), do: query |> order_by([a], desc: a.segment)
  defp order_datatable(query, "effective_date", "desc"), do: query |> order_by([a], desc: a.effective_date)
  defp order_datatable(query, "expiry_date", "desc"), do: query |> order_by([a], desc: a.expiry_date)
  defp order_datatable(query, "status", "desc"), do: query |> order_by([a], desc: a.status)

  defp validate_key_search(changeset, ""), do: changeset |> Changeset.put_change(:search_value, "")
  defp validate_key_search(changeset, nil), do: changeset |> Changeset.add_error(:search_value, "is not in the parameters")
  defp validate_key_search(changeset, _params), do: changeset |> validate_search_value(changeset.changes)

  defp validate_search_value(changeset, changes) when map_size(changes) == 0 do
    changeset
    |> Changeset.add_error(:search_value, "is not in the parameters")
  end
  defp validate_search_value(changeset, _changes), do: changeset

  defp get_by(params) do
    Account |> Repo.get_by(params)
  end

  def validate_params(:view, params) do
    if params["tab"] == "" do
      params =
        params
        |> Map.put("tab", "all")
    end

    fields = %{
      code: :string,
      tab: :string
    }

    {%{}, fields}
    |> Changeset.cast(params, Map.keys(fields))
    |> Changeset.validate_required([:code, :tab], message: "is required")
    |> Changeset.validate_inclusion(:tab, [
      "all",
      "profile",
      "addresses",
      "contacts",
      "banks",
      "personnels",
      "plans",
      "approvers"
    ], message: "invalid parameters")
    |> validate_code_exist?()
    |> is_valid_changeset?()
  end

  defp validate_code_exist?(%{changes: %{code: code}} = changeset) do
    checker = get_by(%{code: code})
    if is_nil(checker) do
      Changeset.add_error(changeset, :code, "does not exists")
    else
      changeset
    end
  end
  defp validate_code_exist?(changeset), do: changeset

  def get_account({:error, changeset}, _), do: {:error, changeset}
  def get_account(params, "") do
    if params.tab == "all" do
      get_account_data(params, "")
    else
      params
    end
  end
  def get_account(params, :profile) do
    if params.tab == "profile" do
      get_account_data(params, :profile)
    else
      params
    end
  end

  def get_account(params, :addresses) do
    if params.tab == "addresses" do
      get_account_data(params, :addresses)
    else
      params
    end
  end

  def get_account(params, :contacts) do
    if params.tab == "contacts" do
      get_account_data(params, :contacts)
    else
      params
    end
  end

  def get_account(params, :banks) do
    if params.tab == "banks" do
      get_account_data(params, :banks)
    else
      params
    end
  end
  def get_account(params, :personnels) do
    if params.tab == "personnels" do
      get_account_data(params, :personnels)
    else
      params
    end
  end

  def get_account(params, :plans) do
    if params.tab == "plans" do
      get_account_data(params, :plans)
    else
      params
    end
  end

  def get_account(params, :approvers) do
    if params.tab == "approvers" do
      get_account_data(params, :approvers)
    else
      params
    end
  end

  def get_account_data(params, "") do
    if is_nil(params) do
      params =
        params
        |> Map.merge(%{result: nil})
    else
      account =
        Account
        |> where([a], a.code == ^params.code)
        |> select([a], %{
          code: a.code,
          status: a.status,
          step: a.step,
          photo: a.photo,
          segment: a.segment,
          name: a.name,
          type: a.type,
          industry: a.industry,
          effective_date: a.effective_date,
          expiry_date: a.expiry_date,
          address_same_as_billing: a.address_same_as_billing,
          tin: a.tin,
          vat_status: a.vat_status,
          previous_carrier: a.previous_carrier,
          attachment_point: a.attachment_point,
          bank_same_as_funding: a.bank_same_as_funding,
          inserted_by: a.inserted_by,
          updated_by: a.updated_by,
          version: a.version
        })
        |> Repo.one()

        if is_nil(account) do
          params =
            params
            |> Map.merge(%{result: nil})
        else
          result =
            account
            |> Map.put(:addresses, get_account_address_data(params))
            |> Map.put(:contacts, get_account_contact_data(params))
            |> Map.put(:personnels, get_account_personnel_data(params))
            |> Map.put(:banks, get_account_bank_data(params))
            |> Map.put(:plans, get_account_plan_data(params))
            |> Map.put(:approvers, get_account_approver_data(params))

          params =
            params
            |> Map.merge(%{result: result})
        end
    end
  end

  def get_account_data(params, :profile) do
    if is_nil(params) do
      params =
        params
        |> Map.merge(%{result: nil})
    else
      account =
        Account
        |> where([a], a.code == ^params.code)
        |> select([a], %{
          code: a.code,
          status: a.status,
          step: a.step,
          photo: a.photo,
          segment: a.segment,
          name: a.name,
          type: a.type,
          industry: a.industry,
          effective_date: a.effective_date,
          expiry_date: a.expiry_date,
          address_same_as_billing: a.address_same_as_billing,
          tin: a.tin,
          vat_status: a.vat_status,
          previous_carrier: a.previous_carrier,
          attachment_point: a.attachment_point,
          bank_same_as_funding: a.bank_same_as_funding,
          inserted_by: a.inserted_by,
          updated_by: a.updated_by,
          version: a.version
        })
        |> Repo.one()

      params =
        params
        |> Map.merge(%{result: account})
    end
  end

  def get_account_data(params, :addresses) do
    if is_nil(params) do
      params =
        params
        |> Map.merge(%{result: nil})
    else
      account =
        Account
        |> where([a], a.code == ^params.code)
        |> select([a], %{
          code: a.code,
          name: a.name
        })
        |> Repo.one()

        if is_nil(account) do
          params =
            params
            |> Map.merge(%{result: nil})
        else
          result =
            account
            |> Map.put(:addresses, get_account_address_data(params))

            params =
              params
              |> Map.merge(%{result: result})
        end
    end
  end

  def get_account_data(params, :contacts) do
    if is_nil(params) do
      params =
        params
        |> Map.merge(%{result: nil})
    else
      account =
        Account
        |> where([a], a.code == ^params.code)
        |> select([a], %{
          code: a.code,
          name: a.name
        })
        |> Repo.one()
        if is_nil(account) do
          params =
            params
            |> Map.merge(%{result: nil})
        else
          result =
            account
            |> Map.put(:contacts, get_account_contact_data(params))

            params =
              params
              |> Map.merge(%{result: result})
        end
    end
  end

  def get_account_data(params, :personnels) do
    if is_nil(params) do
      params =
        params
        |> Map.merge(%{result: nil})
    else
      account =
        Account
        |> where([a], a.code == ^params.code)
        |> select([a], %{
          code: a.code,
          name: a.name
        })
        |> Repo.one()
        if is_nil(account) do
          params =
            params
            |> Map.merge(%{result: nil})
        else
          result =
            account
            |> Map.put(:personnels, get_account_personnel_data(params))

            params =
              params
              |> Map.merge(%{result: result})
        end
    end
  end

  def get_account_data(params, :banks) do
    if is_nil(params) do
      params =
        params
        |> Map.merge(%{result: nil})
    else
      account =
        Account
        |> where([a], a.code == ^params.code)
        |> select([a], %{
          code: a.code,
          name: a.name
        })
        |> Repo.one()
        if is_nil(account) do
          params =
            params
            |> Map.merge(%{result: nil})
        else
          result =
            account
            |> Map.put(:banks, get_account_bank_data(params))

            params =
              params
              |> Map.merge(%{result: result})
        end
    end
  end

  def get_account_data(params, :plans) do
    if is_nil(params) do
      params =
        params
        |> Map.merge(%{result: nil})
    else
      account =
        Account
        |> where([a], a.code == ^params.code)
        |> select([a], %{
          code: a.code,
          name: a.name
        })
        |> Repo.one()
        if is_nil(account) do
          params =
            params
            |> Map.merge(%{result: nil})
        else
          result =
            account
            |> Map.put(:plans, get_account_plan_data(params))

            params =
              params
              |> Map.merge(%{result: result})
        end
    end
  end

  def get_account_data(params, :approvers) do
    if is_nil(params) do
      nil
    else
      account =
        Account
        |> where([a], a.code == ^params.code)
        |> select([a], %{
          code: a.code,
          name: a.name
        })
        |> Repo.one()
        if is_nil(account) do
          nil
        else
          result =
            account
            |> Map.put(:approvers, get_account_approver_data(params))

            params =
              params
              |> Map.merge(%{result: result})
        end
    end
  end

  defp get_account_address_data(params) do
    AccountAddress
    |> where([ad], ad.account_code == ^params.code)
    |> select([ad], %{
      type: ad.type,
      address_line_1: ad.address_line_1,
      address_line_2: ad.address_line_2,
      city: ad.city,
      province: ad.province,
      region: ad.region,
      country: ad.country,
      postal: ad.postal
    })
    |> Repo.all()
  end

  defp get_account_contact_data(params) do
    AccountContact
    |> where([ac], ac.account_code == ^params.code)
    |> select([ac], %{
      type: ac.type,
      name: ac.name,
      department: ac.department,
      designation: ac.designation,
      telephone: ac.telephone,
      mobile: ac.mobile,
      fax: ac.fax,
      email_address: ac.email_address,
      ctc: ac.ctc,
      ctc_date_issued: ac.ctc_date_issued,
      ctc_place_issued: ac.ctc_place_issued,
      passport: ac.passport,
      passport_date_issued: ac.passport_date_issued,
      passport_place_issued: ac.passport_place_issued
    })
    |> Repo.all()
  end

  defp get_account_personnel_data(params) do
    AccountPersonnel
    |> where([ap], ap.account_code == ^params.code)
    |> select([ap], %{
      personnel: ap.personnel,
      specialization: ap.specialization,
      location: ap.location,
      schedule: ap.schedule,
      no_of_personnel: ap.no_of_personnel,
      payment_mode: ap.payment_mode,
      retainer_fee: ap.retainer_fee,
      amount: ap.amount
    })
    |> Repo.all()
  end

  defp get_account_bank_data(params) do
    AccountBank
    |> where([ab], ab.account_code == ^params.code)
    |> select([ab], %{
      payment_mode: ab.payment_mode,
      payee_name: ab.payee_name,
      bank_account: ab.bank_account,
      bank_name: ab.bank_name,
      bank_branch: ab.bank_branch,
      authority_to_debit: ab.authority_to_debit,
      authorization_form: ab.authorization_form
    })
    |> Repo.all()
  end

  defp get_account_plan_data(params) do
    AccountPlan
    |> where([ape], ape.account_code == ^params.code)
    |> select([ape], %{
      plan_code: ape.plan_code,
      plan_name: ape.plan_name,
      plan_type: ape.plan_type,
      plan_limit_type: ape.plan_limit_type,
      plan_limit_amount: ape.plan_limit_amount,
      no_of_members: ape.no_of_members,
      no_of_benefits: ape.no_of_benefits
    })
    |> Repo.all()
  end

  defp get_account_approver_data(params) do
    AccountApprover
    |> where([aa], aa.account_code == ^params.code)
    |> select([aa], %{
      username: aa.username,
      name: aa.name,
      telephone: aa.telephone,
      mobile: aa.mobile,
      email: aa.email
    })
    |> Repo.all()
  end
end
