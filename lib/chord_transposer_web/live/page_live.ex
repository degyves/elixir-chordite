defmodule ChordTransposerWeb.PageLive do
  use ChordTransposerWeb, :live_view

  alias ChordTransposer.Transposer
  alias ChordTransposerWeb.ToggleSwitchComponent

  def mount(_params, _session, socket) do
    socket = assign(socket, dark_mode: false, chords: "", semitones: 0, transposed_chords: [])
    {:ok, socket}
  end

  def handle_event("toggle_dark_mode", _value, socket) do
    {:noreply, assign(socket, :dark_mode, !socket.assigns.dark_mode)}
  end

  def handle_event("transpose", %{"chords" => chords, "semitones" => semitones}, socket) do
    chord_list = String.split(chords, ",") |> Enum.map(&String.trim/1)
    semitone_count = String.to_integer(semitones)
    transposed_chords = ChordTransposer.transpose_chords(chord_list, semitone_count)
    {:noreply, assign(socket, transposed_chords: transposed_chords)}
  end

  def render(assigns) do
    ~H"""
    <div id="page-live" class={@dark_mode && "dark-mode" || "light-mode"}>
      <header class="app-header">
        <div class="toggle-switch-container">
          <.live_component module={ToggleSwitchComponent} id="toggle-switch" label="Dark Mode" dark_mode={@dark_mode} />
        </div>
        <h1>Chord Transposer</h1>
        <div>
          <label>
            Chords (comma-separated):
            <input type="text" phx-debounce="500" value={@chords} phx-change="transpose" />
          </label>
        </div>
        <div>
          <label>
            Semitones:
            <input type="number" value={@semitones} phx-debounce="500" phx-change="transpose" />
          </label>
        </div>
        <button phx-click="transpose">Transpose</button>
        <%= if @transposed_chords != [] do %>
          <div>
            <h2>Transposed Chords</h2>
            <table>
              <thead>
                <tr>
                  <%= for chord <- String.split(@chords, ",") do %>
                    <th><%= chord %></th>
                  <% end %>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <%= for chord <- @transposed_chords do %>
                    <td><%= chord %></td>
                  <% end %>
                </tr>
              </tbody>
            </table>
          </div>
        <% end %>
      </header>
    </div>
    """
  end
end

