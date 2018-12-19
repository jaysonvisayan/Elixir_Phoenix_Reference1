{:ok, _} = Application.ensure_all_started(:ex_machina)

ExUnit.configure(exclude: [
  pending: true,
  hydra: true
])
ExUnit.start()
Faker.start()
Ecto.Adapters.SQL.Sandbox.mode(Data.Repo, :manual)

Code.load_file("test/support/schema_case.ex")
Code.load_file("test/support/factories.ex")
