defmodule Chika do
  alias Alchemy.Client

  def start(_type, _args) do
    login = Client.start(Application.fetch_env!(:chika, :token))
    Alchemy.Cogs.set_prefix("c.")
    use Chika.Commands.LOL
    login
  end
end
