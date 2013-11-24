import QtQuick 2.1
import "javascript/util.js" as JsUtil

Item {
    id: root
    property bool splitView: false
    property ViewContainer activeViewContainer: leftView
    property string url: ""

    function reload() {
        activeViewContainer.reload()
    }

    function hideInactiveView() {
        if(activeViewContainer === leftView) {
            rightView.enabled = false
            viewSplitter.state = "toRight"
        } else {
            leftView.enabled = false
            viewSplitter.state = "toLeft"
        }
    }

    function showInactiveView() {
        rightView.enabled = true
        leftView.enabled = true
        viewSplitter.state = "toSplit"
    }

    onSplitViewChanged: {
        if(splitView) {
            showInactiveView()
        } else {
            hideInactiveView()
        }
    }

    ViewContainer {
        id: leftView
        anchors.left: parent.left
        anchors.right: viewSplitter.left
        height: parent.height
        url: root.url
        activeView: true
        clip: true

        onActiveViewChanged: {
            if(activeView) {
                activeViewContainer.activeView = false
                activeViewContainer = leftView
            }
        }
    }

    Item {
        id: viewSplitter
        width: 5
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        height: parent.height
        visible: parent.splitView

        state: "toRight"

        states: [
            State {
                name: "toSplit"
                PropertyChanges { target: viewSplitter; x: root.width / 2 - viewSplitter.width }
            },
            State {
                name: "toLeft"
                PropertyChanges { target: viewSplitter; x: 0 - viewSplitter.width }
            },
            State {
                name: "toRight"
                PropertyChanges { target: viewSplitter; x: root.width }
            }
        ]

        Behavior on x {
            NumberAnimation { duration: 100; easing.type: Easing.OutBack }
        }

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

            onDoubleClicked: {
                viewSplitter.state = "random"
                viewSplitter.state = "toSplit"
            }
        }
    }

    ViewContainer {
        id: rightView
        anchors.left: viewSplitter.right
        anchors.right: parent.right
        height: parent.height
        clip: true
        activeView: false // There can only be one view active at any given time.
        url: root.url

        onActiveViewChanged: {
            if(activeView) {
                activeViewContainer.activeView = false
                activeViewContainer = rightView
            }
        }
    }
}
