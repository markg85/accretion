import QtQuick 2.1
import "javascript/util.js" as JsUtil

Item {
    width: 5

    Rectangle {
        width: 1
        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter
        color: JsUtil.Theme.Application.divider.color
    }

    MouseArea {
        anchors.fill: parent
        drag.target: parent
        drag.axis: Drag.XAxis
        drag.threshold: 0.0
        hoverEnabled: true
        onEntered: {
            cursorShape = Qt.SizeHorCursor
        }
    }
}
