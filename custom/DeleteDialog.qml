import QtQuick
import QtQuick.Controls.Material

Dialog {
  id: myDeleteDialog

  property int id: -1

  property alias warning: deleteText.text

  modal: true
  focus: true
  title: qsTr("Delete")

  standardButtons: Dialog.Yes | Dialog.No

  width: parent ? parent.width - 80 : 200
  contentHeight: deleteText.height
  anchors.centerIn: parent

  Label {
    id: deleteText

    height: 50
    width: myDeleteDialog.availableWidth
    wrapMode: Label.Wrap
  }
}
