defmodule TeapotBackend.Cmd do
  use Commanded.Application, otp_app: :teapot_backend
  
  # Customer command routing.
  router(TeapotBackend.Customers.Router)
end