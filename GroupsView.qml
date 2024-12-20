import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

import com.company.GroupsModel

ColumnLayout{
  spacing: 0

  TableView {
    id: tableView

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

      implicitWidth: tableView.width
      implicitHeight: 200

      Button {
        id: groupButton

        text: groupsDelegate.name
        anchors.fill: parent
        padding: 0

        Material.roundedScale: Material.NotRounded

        onPressAndHold: {
          groupMenu.y = groupButton.pressY
          groupMenu.x = groupButton.pressX
          groupMenu.open()
        }

        Menu {
          id: groupMenu

          Action {
            text: qsTr("Rename")
            onTriggered: renameDialog.open()
          }
          Action {
            text: qsTr("Delete")
            onTriggered: deleteDialog.open()
          }

          Dialog {
            id: renameDialog

            modal: true
            focus: true
            title: qsTr("Rename")

            standardButtons: Dialog.Save | Dialog.Cancel

            width: window.width / 3 * 2

            x: (window.width - width) / 2
            y: window.height / 6

            contentHeight: renameColumn.height

            Column {
              id: renameColumn

              Label {
                text: groupsDelegate.id
                width: deleteDialog.availableWidth
                wrapMode: Label.Wrap
                font.pixelSize: 12
              }
            }
          }

          Dialog {
            id: deleteDialog

            modal: true
            focus: true
            title: qsTr("Delete")

            standardButtons: Dialog.Ok | Dialog.Cancel

            width: window.width / 3 * 2

            x: (window.width - width) / 2
            y: window.height / 6

            contentHeight: deleteColumn.height

            onAccepted: GroupsModel.remove(groupsDelegate.id)

            Column{
              id: deleteColumn

              spacing: 5

              Label {
                text: qsTr("Are you sure you want to delete this Group?")

                width: deleteDialog.availableWidth
                wrapMode: Label.Wrap
                font.pixelSize: 12
              }

              Label {
                text: qsTr("Any items belonging to this group will also get deleted.")

                width: deleteDialog.availableWidth
                wrapMode: Label.Wrap
                font.pixelSize: 12
              }
            }
          }
        }

        onClicked: console.log("Hey")
      }
    }
  }

  Button{
    Layout.alignment: Qt.AlignRight

    Material.roundedScale: Material.LargeScale

    icon.name: "+"
    icon.height: 12
    text: qsTr("Add Group")
  }
}
