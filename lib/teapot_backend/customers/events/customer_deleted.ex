defmodule TeapotBackend.Customers.Events.CustomerDeleted do
  @derive Jason.Encoder

  defstruct [
    :id,
    :reason,
    :recorded_at
  ]
end
