defmodule TeapotBackend.Orders.Events.OrderPaymentReceived do
  @derive Jason.Encoder

  defstruct [
    :id,
    :amount,
    :payment_processor,
    :payment_reference,
    :recorded_at,
  ]
end
