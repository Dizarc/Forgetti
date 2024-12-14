import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

import com.company.GroupsModel

ApplicationWindow {
  width: 640
  height: 480
  visible: true

  title: qsTr("Forgetti")

  Material.theme: Material.System

  header: ToolBar {
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
        font.pixelSize: 20

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

    pushEnter: Transition {
      YAnimator {
        from: (stackView.mirrored ? -1 : 1) * stackView.height
        to: 0
        duration: 300
        easing.type: Easing.OutCubic
      }
    }

    popExit: Transition {
      YAnimator {
        from: 0
        to: (stackView.mirrored ? -1 : 1) * stackView.height
        duration: 300
        easing.type: Easing.OutCubic
      }
    }

    initialItem: mainView
  }

  Component{
    id: mainView

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

            padding: 0

            text: groupsDelegate.name

            Material.roundedScale: Material.NotRounded

            anchors.fill: parent

            //NOT a good checking implementation
            checkable: true
            onCheckedChanged: {
              if(groupButton.checked){
                highlighted = true
                icon.name = "✓"

                icon.height = 15
              }
              else{
                highlighted = false
                icon.name = ""
              }
            }

            onClicked: console.log("HEY")
          }
        }
      }

      Button{
        Layout.alignment: Qt.AlignRight

        text: qsTr("Add")
      }

    }
  }
}
