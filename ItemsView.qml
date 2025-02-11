import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

import com.company.ItemsModel

import "custom"

ColumnLayout {
  spacing: 0

  TableView {
    id: itemsTableView

    Layout.fillHeight: true
    Layout.fillWidth: true

    focus: true
    clip: true

    flickableDirection: Flickable.VerticalFlick
    boundsBehavior: Flickable.StopAtBounds
    ScrollIndicator.vertical: ScrollIndicator { }

    model: ItemsModel

    delegate: Pane {
      id: itemsDelegate

      required property int id
      required property string name
      required property string pictureSource
      required property int groupId

      required property int index

      implicitWidth: itemsTableView.width
      implicitHeight: 50
      leftPadding: 5
      rightPadding: 5
      verticalPadding: 0

      Button {
        id: itemsButton

        anchors.fill: parent

        Material.roundedScale: Material.ExtraSmallScale
        leftPadding: 10
        rightPadding: 50

        contentItem: Label {
          text: itemsDelegate.name

          elide: Label.ElideRight
          horizontalAlignment: Text.AlignLeft
          verticalAlignment: Text.AlignVCenter
        }

        onClicked: {
          itemsMenu.y = itemsButton.pressY
          itemsMenu.x = itemsButton.pressX
          itemsMenu.open()
        }

        Menu {
          id: itemsMenu

          Action {
            text: qsTr("Rename")

            onTriggered: {
              renameDialog.open()
              renameDialog.id = itemsDelegate.id
              renameDialog.name = itemsDelegate.name
            }
          }
          Action {
            text: qsTr("Delete")

            onTriggered: {
              deleteDialog.open()
              deleteDialog.id = itemsDelegate.id
            }
          }
        }
      }
    }
  }

  Row{
    Layout.alignment: Qt.AlignRight

    spacing: 5

    Button {
      Material.roundedScale: Material.LargeScale
      icon.name: "+"
      icon.height: 12
      text: qsTr("Add Item")

      onClicked: addDialog.open()
    }

    Button {
      Material.roundedScale: Material.LargeScale

      text: qsTr("Run")
    }
  }

  RenameDialog {
    id: renameDialog

    onAccepted: ItemsModel.rename(renameDialog.id, renameDialog.newName)
  }

  DeleteDialog {
    id: deleteDialog

    warning: qsTr("Are you sure you want to delete this Item?")

    onAccepted: ItemsModel.remove(deleteDialog.id)
  }

  Dialog {
    id: addDialog

    //onAccepted: ItemsModel.add(addDialog.name)
  }

}
