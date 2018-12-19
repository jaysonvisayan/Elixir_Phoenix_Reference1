defmodule ApiWeb.AccountView do
  use ApiWeb, :view

  def render("error.json", %{error: error}) do
    %{
      errors: error
    }
  end

  def render("account.json", %{result: account}) do
    %{
      profile_photo: account.photo,
      segment: account.segment,
      code: account.code,
      name: account.name,
      type: account.type,
      industry: account.industry,
      effective_date: account.effective_date,
      expiry_date: account.expiry_date,
      addresses: render_many(
        account.account_addresses,
        ApiWeb.AccountView,
        "account_address.json",
        as: :address
      ),
      address_same_as_billing: account.address_same_as_billing,
      contacts: render_many(
        account.account_contacts,
        ApiWeb.AccountView,
        "account_contact.json",
        as: :contact
      ),
      tin: account.tin,
      vat_status: account.vat_status,
      previous_carrier: account.previous_carrier,
      attachment_point: account.attachment_point,
      banks: render_many(
        account.account_banks,
        ApiWeb.AccountView,
        "account_bank.json",
        as: :bank
      ),
      bank_same_as_funding: account.bank_same_as_funding,
      personnels: render_many(
        account.account_personnels,
        ApiWeb.AccountView,
        "account_personnel.json",
        as: :personnel
      ),
      version: account.version,
      status: account.status
    }
  end

  def render("account_address.json", %{address: address}) do
    %{
      type: address.type,
      address_line_1: address.address_line_1,
      address_line_2: address.address_line_2,
      city: address.city,
      province: address.province,
      region: address.region,
      country: address.country,
      postal: address.postal
    }
  end

  def render("account_contact.json", %{contact: contact}) do
    %{
      type: contact.type,
      name: contact.name,
      department: contact.department,
      designation: contact.designation,
      telephone: contact.telephone,
      mobile: contact.mobile,
      fax: contact.fax,
      email_address: contact.email_address,
      ctc: contact.ctc,
      ctc_date_issued: contact.ctc_date_issued,
      ctc_place_issued: contact.ctc_place_issued,
      passport: contact.passport,
      passport_date_issued: contact.passport_date_issued,
      passport_place_issued: contact.passport_place_issued
    }
  end

  def render("account_bank.json", %{bank: bank}) do
    %{
      payment_mode: bank.payment_mode,
      payee_name: bank.payee_name,
      bank_account: bank.bank_account,
      bank_name: bank.bank_name,
      authority_to_debit: bank.authority_to_debit,
      authorization_form: bank.authorization_form
    }
  end

  def render("account_personnel.json", %{personnel: personnel}) do
    %{
      personnel: personnel.personnel,
      specialization: personnel.specialization,
      location: personnel.location,
      schedule: personnel.schedule,
      no_of_personnel: personnel.no_of_personnel,
      payment_mode: personnel.payment_mode,
      retainer_fee: personnel.retainer_fee,
      amount: personnel.amount
    }
  end

  def render("accounts.json", %{result: accounts}) do
    %{
      accounts: accounts
    }
  end

  def render("view_account.json", %{result: response}) do
    %{
      account: response.result
    }
  end
end
