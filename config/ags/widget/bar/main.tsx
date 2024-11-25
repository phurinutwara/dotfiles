// https://github.com/Aylur/astal/tree/main/examples/js/simple-bar

import { Variable, GLib } from "astal"
import { Astal, Gtk, Gdk } from "astal/gtk3"

import { AudioSlider } from "./_audioSlider"
import { BatteryLevel } from "./_batterylevel"
import { FocusedClient } from "./_focusedClient"
import { Media } from "./_media"
import { SysTray } from "./_tray"
import { Wifi } from "./_wifi"
import { Workspaces } from "./_workspaces"

function Time({ format = "%H:%M:%S - %A %e." }) {
  const time = Variable<string>("").poll(1000, () =>
    GLib.DateTime.new_now_local().format(format)!)

  return <label
    className="Time"
    onDestroy={() => time.drop()}
    label={time()}
  />
}

export default function Bar(monitor: Gdk.Monitor) {
  const anchor = Astal.WindowAnchor.TOP
    | Astal.WindowAnchor.LEFT
    | Astal.WindowAnchor.RIGHT

  return <window
    className="bar"
    gdkmonitor={monitor}
    exclusivity={Astal.Exclusivity.EXCLUSIVE}
    anchor={anchor}>
    <centerbox>
      <box halign={Gtk.Align.START}>
        <FocusedClient />
      </box>
      <box halign={Gtk.Align.CENTER}>
        <Media />
        <Workspaces />
        <Time />
        <BatteryLevel />
      </box>
      <box hexpand halign={Gtk.Align.END}>
        <SysTray />
        <box css="min-width: 1em"></box>
        <AudioSlider />
        <Wifi />
      </box>
    </centerbox>
  </window>
}
