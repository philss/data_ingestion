defmodule DataIngestion.AnotherDemo do
  use Broadway

  def start_link(opts) do
    Broadway.start_link(__MODULE__,
      name: __MODULE__,
      producer: [
        module: {Broadway.DummyProducer, opts},
        concurrency: 1
      ],
      processors: [
        default: [concurrency: 5]
      ]
    )
  end

  @impl true
  def handle_message(_, %Broadway.Message{} = message, _) do
    Broadway.Message.update_data(message, fn data ->
      hex = Base.encode16(:crypto.strong_rand_bytes(64))

      String.upcase(data <> hex)
    end)
    |> Broadway.Message.put_batcher(pick_batcher_key())
  end

  @impl true
  def handle_batch(:default, messages, _, _) do
    Enum.map(messages, fn message ->
      Broadway.Message.update_data(message, fn data ->
        String.downcase(data)
      end)
    end)
  end

  @impl true
  def handle_batch(:foo, messages, _, _), do: messages

  defp pick_batcher_key do
    Enum.shuffle([:default, :foo]) |> List.first()
  end
end
