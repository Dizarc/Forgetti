import QtQuick
import QtQuick.Controls.Material

Dialog {
  id: myRenameDialog

  property int id: -1
  property string name: ""

  property alias newName: renameTextField.displayText

  modal: true
  focus: true
  title: qsTr("Rename")

  standardButtons: Dialog.Save | Dialog.Cancel

  width: parent ? parent.width - 80 : 200
  anchors.centerIn: parent
  contentHeight: renameColumn.height

  Column {
    id: renameColumn

    spacing: 5

    Label {
      text: qsTr("Enter a new name:")
      width: myRenameDialog.availableWidth
      wrapMode: Label.Wrap
    }

    TextField {
      id: renameTextField

      placeholderText: myRenameDialog.name
      width: myRenameDialog.availableWidth
    }
  }
}
