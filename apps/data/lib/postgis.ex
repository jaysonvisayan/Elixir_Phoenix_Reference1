Postgrex.Types.define(Data.PostgrexTypes,
               [Geo.PostGIS.Extension] ++ Ecto.Adapters.Postgres.extensions(),
               json: Poison)
