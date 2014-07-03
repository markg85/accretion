import QtQuick 2.1
import QtQuick.Controls 1.0
import kdirchainmodel 1.0 as KDirchain
import "../javascript/util.js" as JsUtil
import "../components" as Components

Item {
    id: root
    property var model: 0
    property var groupKey: ""
    readonly property int itemHeight: 42

    Component {
        id: emptyComponent
        Item {}
    }

    Component {
        id: sectionDelegate
        Item {
            id: rect
            height: 20
            width: root.width
            Row {
                anchors.fill: parent
                spacing: 5

                Components.ClickText {
                    id: items
                    width: parent.width * 0.50
                    anchors.verticalCenter: parent.verticalCenter
                    font.italic: true
                    font.bold: true
                    text: {
                        var itemCount = 0
                        if(root.model.groupby == KDirchain.DirListModel.None) {
                            itemCount = mdl.count
                        } else {
                            itemCount = root.model.numOfItemsForGroup(section)
                        }
                        return itemCount + " items"
                    }

                    colorNormal: JsUtil.Theme.ViewContainer.HeaderNames.normal.color
                    colorHover: JsUtil.Theme.ViewContainer.HeaderNames.hover.color
                    property int order: Qt.AscendingOrder

                    onClicked: {
                        root.model.sortGroup(KDirchain.DirListModel.Name, section, order)
                        order = (order == Qt.AscendingOrder) ? Qt.DescendingOrder : Qt.AscendingOrder
                    }
                }

                Components.ClickText {
                    id: date
                    width: parent.width * 0.30
                    anchors.verticalCenter: parent.verticalCenter
                    font.italic: true
                    font.bold: true
                    text: "date"
                    colorNormal: JsUtil.Theme.ViewContainer.HeaderNames.normal.color
                    colorHover: JsUtil.Theme.ViewContainer.HeaderNames.hover.color
                    property int order: Qt.AscendingOrder

                    onClicked: {
                        root.model.sortGroup(KDirchain.DirListModel.ModificationTime, section, order)
                        order = (order == Qt.AscendingOrder) ? Qt.DescendingOrder : Qt.AscendingOrder
                    }
                }

                Components.ClickText {
                    id: type
                    width: parent.width * 0.20
                    anchors.verticalCenter: parent.verticalCenter
                    font.italic: true
                    font.bold: true
                    text: "size"
                    colorNormal: JsUtil.Theme.ViewContainer.HeaderNames.normal.color
                    colorHover: JsUtil.Theme.ViewContainer.HeaderNames.hover.color
                    property int order: Qt.AscendingOrder

                    onClicked: {
                        root.model.sortGroup(KDirchain.DirListModel.Size, section, order)
                        order = (order == Qt.AscendingOrder) ? Qt.DescendingOrder : Qt.AscendingOrder
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
    }

    Component {
        id: comp
        Rectangle {
            id: itemBackground
            width: root.width
            height: root.itemHeight
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
                        cache: true
                    }
                }

                Text {
                    property string extensionColor: JsUtil.Theme.ViewContainer.ContentStates.normal.color
                    property string possibleExtension: (extension.length > 0) ? ".<font color=\""+extensionColor+"\">"+extension+"</font>" : ""
                    anchors.verticalCenter: parent.verticalCenter
                    width: parent.width * 0.50 - imageIcon.width - 10 // that 10 is for 2x spacing
                    id: content
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
                    width: parent.width * 0.30
                    anchors.verticalCenter: parent.verticalCenter
                    text: Qt.formatDateTime(modificationTime, "dd/MM/yyyy hh:mm.ss")
                    elide: Text.ElideRight
                }

                Text {
                    id: normalTextThree
                    width: parent.width * 0.20
                    anchors.verticalCenter: parent.verticalCenter
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

        property int lastStartId: 0
        property int lastEndId: 0

        anchors.fill: parent
        model: parent.model
        focus: true
        delegate: comp
        displaced: Transition {
            NumberAnimation { properties: "x"; duration: 100; easing.type: Easing.InOutQuad }
        }

        remove: Transition {
            ParallelAnimation {
                NumberAnimation { property: "opacity"; to: 0; duration: 100 }
                NumberAnimation { properties: "x"; to: 100; duration: 100; easing.type: Easing.InOutQuad }
            }
        }

        add: Transition {
            ParallelAnimation {
                NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 100 }
                NumberAnimation { properties: "x"; from: 100; to: 0; duration: 100; easing.type: Easing.InOutQuad }
            }
        }

        section.property: root.model.stringGroupRole

        // This bloody - sometimes - crashes when toggling.. Why?
        section.delegate: (root.model.stringGroupRole) ? sectionDelegate : emptyComponent
        header: (!root.model.stringGroupRole) ? sectionDelegate : emptyComponent

        onContentYChanged: {
            var endId = indexAt(root.width - 1, contentY + root.height)
            var startId = indexAt(0, contentY)
            // We can't use this...
            if(startId == -1 && endId == -1) {
                return;
            }

            // If we scroll till the end (or even over it) set the endId value to the count value
            if(endId == -1 && startId > -1) {
                endId = count
            }

            // If we sroll to the beginning (or before it) set startId to 0.
            if(startId == -1 && endId > -1) {
                startId = 0
            }

            // If we have new values (that aren't the same since last time) then we update the values and tell the model of the new values we would like to see sorted
            if(lastStartId != startId || lastEndId != endId) {
                lastStartId = startId
                lastEndId = endId

                var isMovingDown = (verticalVelocity > 0) ? true : false;

                // console.log("parent.model.requestSortForItems("+lastStartId+", "+lastEndId+")")
                // Enable the line below for on-demand sorting.
                //parent.model.requestSortForItems(lastStartId, lastEndId, isMovingDown)
            }
        }
    }

    Components.ScrollBar {
        flickable: mdl;
    }
}
