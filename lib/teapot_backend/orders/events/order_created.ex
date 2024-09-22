defmodule TeapotBackend.Orders.Events.OrderCreated do
  @derive Jason.Encoder

  defstruct [
    :id,
    :amount,
    :currency,
    :customer_id,
    :line_items,
    :recorded_at,
    :reference,
    :user_id,
  ]
end
