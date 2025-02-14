import QtQuick
import QtQuick.Layouts
import QtQuick.Dialogs
import QtQuick.Controls.Material
import QtCore

import com.company.ItemsModel

import "custom"

ColumnLayout {
  id: itemsView

  spacing: 0

  property int group

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

        onClicked: imagePopup.open()

        onPressAndHold: {
          itemsMenu.y = itemsButton.pressY
          itemsMenu.x = itemsButton.pressX
          itemsMenu.open()
        }
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

      Popup {
        id: imagePopup

        modal: true
        focus: true

        width: window.width - 80

        anchors.centerIn: Overlay.overlay

        height: window.height / 2

        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

        contentItem: Image {
          source: itemsDelegate.pictureSource
          fillMode: Image.PreserveAspectFit
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

    modal: true
    focus: true
    title: qsTr("Add Item")
    standardButtons: Dialog.Save | Dialog.Cancel

    width: window.width - 80
    anchors.centerIn: parent
    contentHeight: addColumn.height

    onAccepted: ItemsModel.add(addTextField.displayText, itemImage.source, itemsView.group)

    Column {
      id: addColumn

      spacing: 5

      Label {
        text: qsTr("Enter a new item name:")
        width: addDialog.availableWidth
        wrapMode: Label.Wrap
      }

      TextField {
        id: addTextField

        width: addDialog.availableWidth
      }

      Label {
        text: qsTr("Choose a picture:")
        width: addDialog.availableWidth
        wrapMode: Label.Wrap
      }

      Rectangle {
        id: imageRect

        width: addDialog.availableWidth - 10
        height: 200

        color: "transparent"

        Image {
          id: itemImage

          anchors.fill: parent

          source: ""
          sourceSize.width: imageRect.width - 6

          fillMode: Image.PreserveAspectFit
        }

        Label {
          anchors.centerIn: parent
          text: qsTr("Click to select an image")
          opacity: 0.7
        }

        MouseArea {
          anchors.fill: parent
          onClicked: imageChoiceFileDialog.open()
        }
      }
    }

    FileDialog {
      id: imageChoiceFileDialog
      title: qsTr("Select an Image")

      nameFilters: ["Image files (*.png *.jpg *.jpeg *.bmp)"]
      currentFolder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
      onAccepted: itemImage.source = selectedFile
    }
  }

}
