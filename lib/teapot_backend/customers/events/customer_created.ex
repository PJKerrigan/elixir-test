defmodule TeapotBackend.Customers.Events.CustomerCreated do
  @derive Jason.Encoder

  defstruct [
    :id,
    :recorded_at
  ]
end
