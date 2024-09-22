defmodule TeapotBackend.Orders.Entities.Payment do
  use OnePiece.Commanded.ValueObject

  embedded_schema do
    field :id, :integer
    field :amount, :integer
    field :processor, :string
    field :paid_at, :utc_datetime_usec
    field :reference, :string
  end
end