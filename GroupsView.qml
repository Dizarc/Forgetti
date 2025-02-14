import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

import com.company.GroupsModel
import com.company.ItemsModel

import "custom"

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
      required property bool isFavorite

      required property int index

      implicitWidth: groupsTableView.width
      implicitHeight: 50
      leftPadding: 5
      rightPadding: 5
      verticalPadding: 0

      Button {
        id: groupButton

        anchors.fill: parent

        Material.roundedScale: Material.ExtraSmallScale
        leftPadding: 10
        rightPadding: 50

        contentItem: Label {
          text: groupsDelegate.name

          elide: Label.ElideRight
          horizontalAlignment: Text.AlignLeft
          verticalAlignment: Text.AlignVCenter
        }

        onClicked: {
          window.title = groupsDelegate.name
          ItemsModel.filterByGroup(groupsDelegate.id)
          stackView.push(itemsViewComponent, {"group": groupsDelegate.id})
        }

        onPressAndHold: {
          groupsMenu.y = groupButton.pressY
          groupsMenu.x = groupButton.pressX
          groupsMenu.open()
        }

        Button {
          id: favoriteButton

          implicitHeight: 50
          implicitWidth: 50
          anchors.right: parent.right

          Material.roundedScale: Material.ExtraSmallScale
          flat: true
          checkable: true
          checked: groupsDelegate.isFavorite

          contentItem: Image {
            source: favoriteButton.checked ? "qrc:/icons/star_filled" : "qrc:/icons/star_empty"
            fillMode: Image.PreserveAspectFit
            sourceSize.height: 50
          }

          onClicked: {
            GroupsModel.changeFavorite(groupsDelegate.id, favoriteButton.checked)
          }
        }
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

  RenameDialog {
    id: renameDialog

    onAccepted: GroupsModel.rename(renameDialog.id, renameDialog.name)
  }

  DeleteDialog {
    id: deleteDialog

    warning: qsTr("Are you sure you want to delete this Group?\nAny items belonging to this group will also get deleted.")

    onAccepted: GroupsModel.remove(deleteDialog.id)
  }

  Button {
    Layout.alignment: Qt.AlignRight

    Material.roundedScale: Material.LargeScale

    icon.name: "+"
    icon.height: 12
    text: qsTr("Add Group")

    onClicked: addDialog.open()
  }

  Dialog {
    id: addDialog

    modal: true
    focus: true
    title: qsTr("Add Group")

    standardButtons: Dialog.Save | Dialog.Cancel

    width: window.width - 80
    anchors.centerIn: parent
    contentHeight: nameColumn.height

    onAccepted: GroupsModel.add(addTextField.displayText)

    Column {
      id: nameColumn

      spacing: 5

      Label {
        text: qsTr("Enter a new group name:")
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
