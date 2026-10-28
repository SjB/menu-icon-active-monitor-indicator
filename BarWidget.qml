import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.Commons
import qs.Ui

BarWidget {
  id: root
  moduleName: "sjb.menu-icon-active-monitor-indicator"

  readonly property var monitor: {
    var window = root.QsWindow.window
    var screen = window ? window.screen : null
    return screen ? Hyprland.monitorFor(screen) : null
  }
  readonly property bool focused: {
    var mine = root.monitor ? root.monitor.name : ""
    var active = Hyprland.focusedMonitor ? Hyprland.focusedMonitor.name : ""
    return mine !== "" && mine === active
  }

  implicitWidth: button.implicitWidth
  implicitHeight: button.implicitHeight

  BarIconButton {
    id: button
    anchors.fill: parent
    bar: root.bar
    text: "\ue900"
    fontFamily: "omarchy"
    foreground: root.focused ? Color.accent : (root.bar ? root.bar.barForeground : Color.foreground)
    onPressed: function (button) {
      if (!root.bar) return
      if (button === Qt.RightButton) root.bar.run("xdg-terminal-exec")
      else root.bar.run("omarchy-shell shell toggle omarchy.menu '{\"menu\":\"root\"}'")
    }
  }
}
