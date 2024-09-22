
def TeapotBackend.Orders.Aggregates.Order do
  @moduledoc "Order aggregate root. Tracks payments, in a particular currency, for a set of product line items."

  alias __MODULE__
  alias TeapotBackend.Events.{OrderCreated, OrderPaymentReceived}
  alias TeapotBackend.Orders.Entities.Payment

  defstruct [
    :cancelled_at,
    :currency,
    :customer_id,
    :created_at,
    :updated_at,
    :paid_at,
    :id,
    :line_items,
    :payments_received,
    :reference,
    :status,
    :total,
    :total_received,
  ]

  def apply(%Order{} = aggregate, %OrderCreated{} = event) do
    %OrderCreated{
      id: id,
      amount: amount,
      currency: currency,
      line_items: line_items,
      reference: reference,
      customer_id: customer_id,
      user_id: user_id,
      recorded_at: recorded_at
    } = event

    %Order{aggregate |
      cancelled_at: nil,
      created_at: DateTime.from_iso8601(recorded_at),
      currency: currency,
      customer_id: customer_id,
      id: id,
      line_items: line_items,
      paid_at: nil,
      payments_received: [],
      reference: reference,
      status: :order_created,
      total: amount,
      user_id: user_id,
    }
  end

  def apply(%Order{} = aggregate, %OrderPaymentReceived{} = event) do
    %Order{
      status: existing_status,
      total: total,
      total_received: total_received,
      payments_received: existing_payments,
    } = aggregate

    %OrderPaymentReceived{
      payment_processor: payment_processor,
      payment_reference: payment_reference,
      recorded_at: recorded_at,
      amount: amount
    } = event

    # Count the new total received.
    new_total_received = total_received + amount

    # Change the `status` and `paid_at` if necessary.
    status = existing_status
    paid_at = nil

    if total_received >= total do
      status = :order_paid
      paid_at = recorded_at
    end

    payment_entity = Payment.new(%{
      id: length(existing_payments),
      amount: amount,
      paid_at: recorded_at,
      processor: payment_processor,
      reference: payment_reference
    })

    %Order{aggregate |
      total_received: new_total_received,
      paid_at: paid_at,
      payments_received: [payment_entity | existing_payments],
      status: status,
    }
  end
end
