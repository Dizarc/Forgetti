import QtQuick
import QtQuick.Controls.Material

Dialog {
  id: myDeleteDialog

  property int id: -1

  property alias warning: deleteText.text

  modal: true
  focus: true
  title: qsTr("Delete")

  standardButtons: Dialog.Ok | Dialog.Cancel

  width: window.width - 80
  anchors.centerIn: Overlay.overlay

  Label {
    id: deleteText

    width: myDeleteDialog.availableWidth
    wrapMode: Label.Wrap
  }
}
