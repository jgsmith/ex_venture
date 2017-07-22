defmodule Game.Command.Look do
  @moduledoc """
  The "look" command
  """

  use Game.Command

  @doc """
  Look around the current room
  """
  @spec run([], session :: Session.t, state :: map) :: :ok
  def run([], _session, %{socket: socket, save: %{room_id: room_id}}) do
    room = @room.look(room_id)
    socket |> @socket.echo(Format.room(room))
    :ok
  end
  def run([item_name], _session, %{socket: socket, save: %{room_id: room_id}}) do
    room = @room.look(room_id)

    case Enum.find(room.items, &(Game.Item.matches_lookup?(&1, item_name))) do
       nil -> nil
       item -> socket |> @socket.echo(Format.item(item))
    end

    :ok
  end
end
