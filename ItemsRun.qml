import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

import com.company.ItemsModel

ColumnLayout {
  spacing: 0

  ListView {
    id: itemsRunView

    Layout.fillWidth: true
    Layout.fillHeight: true

    model: ItemsModel

    orientation: ListView.Horizontal
    boundsBehavior: Flickable.StopAtBounds
    snapMode: ListView.SnapOneItem
    interactive: false

    delegate: Pane {
      id: itemsRunDelegate

      required property int id
      required property string name
      required property string pictureSource

      width: itemsRunView.width
      height: itemsRunView.height

      ColumnLayout {
        anchors.fill: parent
        Label {
          text: itemsRunDelegate.name

          elide: Label.ElideRight
          horizontalAlignment: Label.AlignHCenter
          Layout.fillWidth: true
        }
        Image {
          source: itemsRunDelegate.pictureSource

          fillMode: Image.PreserveAspectFit
          Layout.alignment: Qt.AlignHCenter
          Layout.fillWidth: true
          Layout.fillHeight: true
        }
      }

      Flickable {
        id: swipeArea
        anchors.fill: parent
        flickableDirection: Flickable.HorizontalFlick
          onFlickStarted: {
            if (horizontalVelocity < 0) {
              console.log("swiped right")
              itemsRunView.currentIndex += 1
            }
            if (horizontalVelocity > 0) {
              console.log("swiped left")
            }
          }
          boundsMovement: Flickable.StopAtBounds
          pressDelay: 0
      }

      //States to change color of the item depending on left/right swipe.
      //Get states from flickable?
      // states: State {
      //   name: "moved"; when: mouseArea.pressed
      //   PropertyChanges { target: rect; x: 50; y: 50 }
      // }

      // transitions: Transition {
      //   NumberAnimation { properties: "x,y"; easing.type: Easing.InOutQuad }
      // }
    }
  }
}
