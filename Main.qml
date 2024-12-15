import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

import com.company.GroupsModel

ApplicationWindow {
  id: window
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
            onTriggered: helpDialog.open()
          }
          Action {
            text: qsTr("About")
            onTriggered: aboutDialog.open()
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

            text: groupsDelegate.name
            anchors.fill: parent
            padding: 0
            Material.roundedScale: Material.NotRounded

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

        Material.roundedScale: Material.LargeScale

        icon.name: "+"
        icon.height: 12
        text: qsTr("Add Group")
      }
    }
  }

  Dialog {
    id: helpDialog

    modal: true
    focus: true
    title: qsTr("Help")

    width: window.width / 3 * 2

    x: (window.width - width) / 2
    y: window.height / 6

    contentHeight: helpColumn.height

    Column {
      id: helpColumn

      spacing: 10

      Label {
        text: qsTr("How to use the Application:")

        width: helpColumn.availableWidth
        wrapMode: Label.Wrap
        font.pixelSize: 14
      }

      Label {
        text: qsTr("1. Create a group by clicking add Group.")

        width: helpColumn.availableWidth
        wrapMode: Label.Wrap
        font.pixelSize: 12
      }
      Label {
        text: qsTr("")

        width: helpColumn.availableWidth
        wrapMode: Label.Wrap
        font.pixelSize: 12
      }
    }
  }

  Dialog {
    id: aboutDialog

    modal: true
    focus: true
    title: qsTr("About")

    width: window.width / 3 * 2

    x: (window.width - width) / 2
    y: window.height / 6

    contentHeight: aboutColumn.height

    Column {
      id: aboutColumn

      spacing: 10

      Label {
        text: qsTr("This is an application coded with Qt and C++ for forgetful people made by Dizarc.")

        width: aboutDialog.availableWidth
        wrapMode: Label.Wrap
        font.pixelSize: 12
      }

      Label {
        text: '<html><a href="https://github.com/Dizarc/Forgetti">Project at github</a></html>'

        onLinkActivated: (link) => Qt.openUrlExternally(link)
        width: aboutDialog.availableWidth
        wrapMode: Label.Wrap
        font.pixelSize: 12
      }
    }
  }
}
