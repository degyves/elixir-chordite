defmodule ChordTransposerWeb.ToggleSwitchComponent do
  use ChordTransposerWeb, :live_component

  def render(assigns) do
    ~H"""
    <div class="container">
      <%= @label %>
      <div class="toggle-switch">
        <input type="checkbox" class="checkbox" id={@label} phx-click="toggle_dark_mode" { if @dark_mode, do: "checked" } />
        <label class="label" for={@label}>
          <span class="inner"></span>
          <span class="switch"></span>
        </label>
      </div>
    </div>
    """
  end
end

