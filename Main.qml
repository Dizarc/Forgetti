import QtQuick
import QtQuick.Layouts

Window {
  width: 640
  height: 480
  visible: true
  title: qsTr("Forgetti")
  ColumnLayout{
    anchors.fill: parent
    Text{
      Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
      text: qsTr("Forgetti")
      font.pointSize: 25
    }

    ListView{

    }
  }
}
