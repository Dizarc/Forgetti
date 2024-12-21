import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

import com.company.GroupsModel
import com.company.ItemsModel

ColumnLayout{
  spacing: 0

  TableView {
    id: groupsTableView

    Layout.fillHeight: true
    Layout.fillWidth: true

    focus: true
    clip: true

    flickableDirection: Flickable.VerticalFlick
    boundsBehavior: Flickable.StopAtBounds
    ScrollIndicator.vertical: ScrollIndicator { }

    model: GroupsModel

    delegate: Pane {
      id: groupsDelegate

      required property int id
      required property string name

      required property int index

      implicitWidth: groupsTableView.width
      implicitHeight: 200

      Button {
        id: groupButton

        text: groupsDelegate.name
        anchors.fill: parent
        padding: 0

        Material.roundedScale: Material.NotRounded

        onPressAndHold: {
          groupsMenu.y = groupButton.pressY
          groupsMenu.x = groupButton.pressX
          groupsMenu.open()
        }

        onClicked: {
          window.title = groupsDelegate.name
          ItemsModel.filterByGroup(groupsDelegate.id)
          stackView.push(itemsViewComponent)
        }

        Menu {
          id: groupsMenu

          Action {
            text: qsTr("Rename")

            onTriggered: {
              renameDialog.open()
              renameDialog.id = groupsDelegate.id
              renameDialog.name = groupsDelegate.name
            }
          }
          Action {
            text: qsTr("Delete")

            onTriggered: {
              deleteDialog.open()
              deleteDialog.id = groupsDelegate.id
            }
          }
        }
      }
    }
  }

  RenameDialog {
    id: renameDialog

    onAccepted: GroupsModel.rename(renameDialog.id, renameDialog.newName)
  }

  DeleteDialog {
    id: deleteDialog

    warning: qsTr("Are you sure you want to delete this Group?\nAny items belonging to this group will also get deleted.")

    onAccepted: GroupsModel.remove(deleteDialog.id)
  }

  Button{
    Layout.alignment: Qt.AlignRight

    Material.roundedScale: Material.LargeScale

    icon.name: "+"
    icon.height: 12
    text: qsTr("Add Group")

    onClicked: addDialog.open()
  }

  Dialog{
    id: addDialog

    modal: true
    focus: true
    title: qsTr("Add")

    standardButtons: Dialog.Save | Dialog.Cancel

    width: window.width / 3 * 2

    x: (window.width - width) / 2
    y: window.height / 6

    contentHeight: renameColumn.height

    onAccepted: GroupsModel.add(addTextField.displayText)

    Column {
      id: renameColumn

      spacing: 5

      Label {
        text: qsTr("Enter a new group:")
        width: addDialog.availableWidth
        wrapMode: Label.Wrap
      }

      TextField {
        id: addTextField

        width: addDialog.availableWidth
      }
    }
  }
}
