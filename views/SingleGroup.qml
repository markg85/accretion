import QtQuick 2.1
import QtQuick.Controls 1.0
import kdirchainmodel 1.0 as KDirchain
import "../javascript/util.js" as JsUtil

Item {
    id: root
    width: parent.width
    height: mdl.height + rect.height
    property var model: 0
    property var groupKey: ""

    Component.onCompleted: {
        model.hidden = false
    }

    states: [
        State {
            name: "visible"
            PropertyChanges { target: root; visible: true; height: mdl.height + rect.height; }
        },
        State {
            name: "hidden"
            PropertyChanges { target: root; visible: false ; height: 0; }
        }
    ]

    Item {
        id: rect
        height: 20
        width: parent.width
        Row {
            anchors.fill: parent
            spacing: 5

            Text {
                id: items
                width: parent.width * 0.50
                anchors.verticalCenter: parent.verticalCenter
                font.italic: true
                font.bold: true
                text: "0 items"
                color: JsUtil.Theme.ViewContainer.HeaderNames.normal.color
                MouseArea {
                    anchors.fill: parent
                    property int order: Qt.AscendingOrder
                    onClicked: {
                        root.model.sort(KDirchain.DirListModel.Name, order)
                        order = (order == Qt.AscendingOrder) ? Qt.DescendingOrder : Qt.AscendingOrder
                    }
                }
            }

            Text {
                id: date
                width: parent.width * 0.30
                anchors.verticalCenter: parent.verticalCenter
                font.italic: true
                font.bold: true
                text: "date"
                color: JsUtil.Theme.ViewContainer.HeaderNames.normal.color
                MouseArea {
                    anchors.fill: parent
                    property int order: Qt.AscendingOrder
                    onClicked: {
                        root.model.sort(KDirchain.DirListModel.ModificationTime, order)
                        order = (order == Qt.AscendingOrder) ? Qt.DescendingOrder : Qt.AscendingOrder
                    }
                }
            }

            Text {
                id: type
                width: parent.width * 0.20
                anchors.verticalCenter: parent.verticalCenter
                font.italic: true
                font.bold: true
                text: "size"
                color: JsUtil.Theme.ViewContainer.HeaderNames.normal.color
                MouseArea {
                    anchors.fill: parent
                    property int order: Qt.AscendingOrder
                    onClicked: {
                        root.model.sort(KDirchain.DirListModel.Size, order)
                        order = (order == Qt.AscendingOrder) ? Qt.DescendingOrder : Qt.AscendingOrder
                    }
                }
            }
        }

        Rectangle {
            width: parent.width
            height: 1
            anchors.bottom: parent.bottom
            color: JsUtil.Theme.Application.divider.color
        }
    }

    Component {
        id: comp
        Rectangle {
            id: itemBackground
            width: root.width
            height: 42
            color: JsUtil.Theme.ViewContainer.ItemStates.normal.color
            border.color: JsUtil.Theme.ViewContainer.ItemStates.normal.borderColor
            border.width: 1
            radius: 5

            state: "normal"

            function normalColors() {
                itemBackground.color = JsUtil.Theme.ViewContainer.ItemStates.normal.color
                itemBackground.border.color = JsUtil.Theme.ViewContainer.ItemStates.normal.borderColor
                content.color = JsUtil.Theme.ViewContainer.ContentStates.normal.highlight
                content.extensionColor = JsUtil.Theme.ViewContainer.ContentStates.normal.color
                normalTextTwo.color = JsUtil.Theme.ViewContainer.ContentStates.normal.color
                normalTextThree.color = JsUtil.Theme.ViewContainer.ContentStates.normal.color
                imageIcon.color = JsUtil.Theme.ViewContainer.ItemStates.normal.imageBackground
                imageIcon.border.color = JsUtil.Theme.ViewContainer.ItemStates.normal.imageBorderColor
            }

            function hoverColors() {
                itemBackground.color = JsUtil.Theme.ViewContainer.ItemStates.hover.color
                itemBackground.border.color = JsUtil.Theme.ViewContainer.ItemStates.hover.borderColor
                content.color = JsUtil.Theme.ViewContainer.ContentStates.hover.highlight
                content.extensionColor = JsUtil.Theme.ViewContainer.ContentStates.hover.color
                normalTextTwo.color = JsUtil.Theme.ViewContainer.ContentStates.hover.color
                normalTextThree.color = JsUtil.Theme.ViewContainer.ContentStates.hover.color
                imageIcon.color = JsUtil.Theme.ViewContainer.ItemStates.hover.imageBackground
                imageIcon.border.color = JsUtil.Theme.ViewContainer.ItemStates.hover.imageBorderColor
            }

            states: [
                State {
                    name: "normal"
                    StateChangeScript {
                        script: normalColors();
                    }
                },
                State {
                    name: "hover"
                    StateChangeScript {
                        script: hoverColors();
                    }
                }
            ]

            Row {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width
                spacing: 5
                Item {
                    width: 0.1
                    height: 32
                }
                Rectangle {
                    id: imageIcon
                    width: 32
                    height: 32
                    color: JsUtil.Theme.ViewContainer.ItemStates.normal.imageBackground
                    border.color: JsUtil.Theme.ViewContainer.ItemStates.normal.imageBorderColor
                    border.width: 1
                    Image {
                        width: 28
                        height: 28
                        sourceSize.width: width
                        sourceSize.height: height
                        anchors.centerIn: parent
                        source: "image://mime/" + mimeIcon
                        asynchronous: true
                        cache: false
                    }
                }

                Text {
                    property string extensionColor: JsUtil.Theme.ViewContainer.ContentStates.normal.color
                    property string possibleExtension: (extension.length > 0) ? ".<font color=\""+extensionColor+"\">"+extension+"</font>" : ""
                    anchors.verticalCenter: parent.verticalCenter
                    width: items.width - imageIcon.width - 10 // that 10 is for 2x spacing
                    id: content
                    color: JsUtil.Theme.ViewContainer.ContentStates.normal.highlight
                    text: baseName + possibleExtension
                    elide: Text.ElideRight
                    textFormat: Text.StyledText
                    MouseArea {
                        anchors.fill: parent
                        propagateComposedEvents: true
                        onClicked: {
                            if(mimeIcon == "inode-directory") {
                                // Folder clicked
                                viewRoot.append(baseName)
                            } else {
                                viewRoot.exec(name)
                            }
                        }
                    }
                }

                Text {
                    id: normalTextTwo
                    width: date.width
                    anchors.verticalCenter: parent.verticalCenter
                    color: JsUtil.Theme.ViewContainer.ContentStates.normal.color
                    text: Qt.formatDateTime(modificationTime, "dd/MM/yyyy hh:mm.ss")
                    elide: Text.ElideRight
                }
                Text {
                    id: normalTextThree
                    width: type.width
                    anchors.verticalCenter: parent.verticalCenter
                    color: JsUtil.Theme.ViewContainer.ContentStates.normal.color
                    text: JsUtil.humanReadableSize(size)
                    elide: Text.ElideRight
                }
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                propagateComposedEvents: true
                onEntered: itemBackground.state = "hover"
                onExited: itemBackground.state = "normal"
            }
        }
    }

    ListView {
        id: mdl
        y: rect.height
        height: count * 42
        model: parent.model
        delegate: comp

        onCountChanged: {
            items.text = count + " items"

            if(count > 0) {
                root.state = "visible"
            } else {
                root.state = "hidden"
            }
        }
    }
}
