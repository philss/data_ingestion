defmodule DataIngestion.FakeProducer do
  use GenServer

  def start_link(_) do
    GenServer.start_link(__MODULE__, name: __MODULE__)
  end

  def init(_) do
    timer = Process.send_after(self(), :publish, 2000)

    {:ok, timer}
  end

  def handle_info(:publish, _timer) do
    for i <- 1..1234, do: Broadway.test_message(DataIngestion.DemoPipeline, "hello #{i}")

    timer = Process.send_after(self(), :publish, 100)

    {:noreply, timer}
  end

  def handle_info(_, timer) do
    {:noreply, timer}
  end

  def terminate(_, timer) do
    Process.cancel_timer(timer)

    :ok
  end
end
