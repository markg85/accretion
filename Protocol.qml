import QtQuick 2.1

Item {
    id: root
    property string protocol: ""

    Rectangle {
        width: 200
        height: 50
        color: "red"

        Text {
            anchors.centerIn: parent
            text: root.protocol
        }
    }
}
