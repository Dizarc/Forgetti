import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

import com.company.GroupsModel

ApplicationWindow {
  width: 640
  height: 480
  visible: true

  title: qsTr("Forgetti")

  header: ToolBar {
    Material.foreground: "white"

    RowLayout {
      spacing: 20

      anchors.fill: parent

      ToolButton {
        text: qsTr("<")

        enabled: stackView.depth === 1 ? false : true

        onClicked: {
          if (stackView.depth > 1)
              stackView.pop()
        }
      }

      Label {
        text: if(stackView.depth === 1) qsTr("Forgetti")

        elide: Label.ElideRight
        horizontalAlignment: Qt.AlignHCenter
        verticalAlignment: Qt.AlignVCenter
        Layout.fillWidth: true
      }

      ToolButton {
        text: qsTr("⋮")

        onClicked : menu.open()

        Menu {
          id: menu

          x: parent.width - width
          transformOrigin: Menu.TopRight
          Action {
            text: qsTr("Help")
            //onTriggered:
          }
          Action {
            text: qsTr("About")
            //onTriggered:
          }
        }
      }
    }
  }

  StackView {
    id: stackView

    anchors.fill: parent

    initialItem: TableView {
      id: tableView

      focus: true

      flickableDirection: Flickable.VerticalFlick
      boundsBehavior: Flickable.StopAtBounds
      ScrollIndicator.vertical: ScrollIndicator { }

      model: GroupsModel

      delegate: ItemDelegate {
        id: groupsDelegate

        required property int id
        required property string name

        required property int index

        width: tableView.width
        height: 50
        text: name

        onClicked: {
          console.log("HEY")
        }
      }
    }
  }
}
