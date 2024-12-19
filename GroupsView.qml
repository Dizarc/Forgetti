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
