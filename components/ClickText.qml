import QtQuick 2.1

Text {
    id: root
    property color colorNormal: "red"
    property color colorHover: "red"
    property bool emitClickedEvents: true
    color: colorNormal
    signal clicked();
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        enabled: parent.emitClickedEvents
        onClicked: {
            root.clicked()
        }
        onEntered: {
            parent.color = parent.colorHover
        }
        onExited: {
            parent.color = parent.colorNormal
        }
    }
}
