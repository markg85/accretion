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

    signal folderClicked(string folder)


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

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    itemBackground.color = JsUtil.Theme.ViewContainer.ItemStates.hover.color
                    itemBackground.border.color = JsUtil.Theme.ViewContainer.ItemStates.hover.borderColor
                    content.color = JsUtil.Theme.ViewContainer.ContentStates.hover.highlight
                    normalTextOne.color = JsUtil.Theme.ViewContainer.ContentStates.hover.color
                    normalTextTwo.color = JsUtil.Theme.ViewContainer.ContentStates.hover.color
                    normalTextThree.color = JsUtil.Theme.ViewContainer.ContentStates.hover.color
                    imageIcon.color = JsUtil.Theme.ViewContainer.ItemStates.hover.imageBackground
                    imageIcon.border.color = JsUtil.Theme.ViewContainer.ItemStates.hover.imageBorderColor
                }
                onExited: {
                    itemBackground.color = JsUtil.Theme.ViewContainer.ItemStates.normal.color
                    itemBackground.border.color = JsUtil.Theme.ViewContainer.ItemStates.normal.borderColor
                    content.color = JsUtil.Theme.ViewContainer.ContentStates.normal.highlight
                    normalTextOne.color = JsUtil.Theme.ViewContainer.ContentStates.normal.color
                    normalTextTwo.color = JsUtil.Theme.ViewContainer.ContentStates.normal.color
                    normalTextThree.color = JsUtil.Theme.ViewContainer.ContentStates.normal.color
                    imageIcon.color = JsUtil.Theme.ViewContainer.ItemStates.normal.imageBackground
                    imageIcon.border.color = JsUtil.Theme.ViewContainer.ItemStates.normal.imageBorderColor
                }
            }

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
                /**
                 *  Note: The Flow below is required to put the filename + extension on one line.
                 *  And that is done in two separate elements because both have a different style.
                 *  The downside here is eliding. It's not working because it are two elements.
                 *  I tried using the HTML eliding way by puttin both text in one html string,
                 *  but that seems to present some issues in terms of width.
                 */
                Flow {
                    anchors.verticalCenter: parent.verticalCenter
                    width: items.width - imageIcon.width - 10 // that 10 is for 2x spacing
                    Text {
                        id: content
                        color: JsUtil.Theme.ViewContainer.ContentStates.normal.highlight
                        text: baseName
                        font.bold: true
                        elide: Text.ElideRight
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                if(mimeIcon == "inode-directory") {
                                    // Folder clicked
                                    viewRoot.append(baseName)
                                } else {
                                    // Something else clicked. Execute it.
                                }
                            }
                        }
                    }
                    Text {
                        id: normalTextOne
                        color: JsUtil.Theme.ViewContainer.ContentStates.normal.color
                        text: (extension.length > 0) ? "."+extension : extension
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
        }
    }
}
