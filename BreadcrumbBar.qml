import QtQuick 2.1
import kdirchainmodel 1.0 as KDirchain
import "javascript/util.js" as JsUtil

Rectangle {
    id: root
    color: "transparent"
    property alias model: bcView.model

    Component {
        id: comp
        Row {
            width: folder.width + arrow.width
            height: parent.height
            Text {
                id: folder
                text: display
                anchors.verticalCenter: parent.verticalCenter
                color: {
                    if(index == (bcView.count - 1)) {
                        return JsUtil.Theme.BreadCrumb.fontColorActive.normal;
                    } else {
                        return JsUtil.Theme.BreadCrumb.fontColorInactive.normal;
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        if(index == (bcView.count - 1)) {
                            parent.color = JsUtil.Theme.BreadCrumb.fontColorActive.hover;
                        } else {
                            parent.color = JsUtil.Theme.BreadCrumb.fontColorInactive.hover;
                        }
                    }
                    onExited: {
                        if(index == (bcView.count - 1)) {
                            parent.color = JsUtil.Theme.BreadCrumb.fontColorActive.normal;
                        } else {
                            parent.color = JsUtil.Theme.BreadCrumb.fontColorInactive.normal;
                        }
                    }
                    onClicked: {
                        root.model.removeAfterIndex(index)
                    }
                }
            }
            Item {
                width: 15
                id: arrow
                height: parent.height
                Text {
                    y: 12
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.family: "FontAwesome"
                    text: JsUtil.FA.ChevronRight
                    font.pointSize: 6
                }
                visible: (index == (bcView.count - 1)) ? false : true
            }
        }
    }

    ListView {
        id: bcView
        interactive: false
        width: parent.width
        height: parent.height
        orientation: Qt.Horizontal
        delegate: comp
    }

}
