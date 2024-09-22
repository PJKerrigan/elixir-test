defmodule TeapotBackend.Customers.Commands.DeleteCustomer do
  use OnePiece.Commanded.Command, aggregate_identifier: :id

  @enforce_keys []
  @type t :: %__MODULE__{id: integer, reason: string}

  embedded_schema do
    field :reason, :string
  end
end
