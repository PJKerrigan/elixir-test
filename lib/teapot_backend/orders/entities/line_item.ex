defmodule TeapotBackend.Orders.Entities.LineItem do
  use OnePiece.Commanded.ValueObject

  embedded_schema do
    field :id, :integer
    field :amount, :integer
    field :product_id, :string
    field :meta, :map
  end
end