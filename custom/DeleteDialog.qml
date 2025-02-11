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

  width: window.width / 3 * 2
  height: window.height / 7 * 2.5

  x: (window.width - width) / 2
  y: (window.height - height) / 6

  Label {
    id: deleteText

    width: myDeleteDialog.availableWidth
    wrapMode: Label.Wrap
  }
}
