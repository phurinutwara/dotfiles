import { bind } from "astal"
import { Gtk } from "astal/gtk3"
import Hyprland from "gi://AstalHyprland"

export function FocusedClient() {
  const hypr = Hyprland.get_default()
  const focused = bind(hypr, "focusedClient")

  return <box
    className="Focused"
    visible={focused.as(Boolean)}>
    {focused.as(client => (
      client && <box vertical={true} >
        <label halign={Gtk.Align.START} label={bind(client, "class").as(String)} />
        <label halign={Gtk.Align.START} label={bind(client, "title").as(String)} />
      </box>
    ))}
  </box>
}
