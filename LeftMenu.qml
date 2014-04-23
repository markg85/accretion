import QtQuick 2.0
import QtQuick.Layouts 1.1
import "javascript/util.js" as JsUtil
import "components" as Components

Item {
    id: root
    ListModel {
        id: colors

        ListElement { type: "Places"; text: "Top Used"; icon: "\uf087" }
        ListElement { type: "Places"; text: "Home"; icon: "\uf015" }
        ListElement { type: "Places"; text: "Network"; icon: "\uf0e8" }
        ListElement { type: "Places"; text: "Root"; icon: "\uf07b" }
        ListElement { type: "Places"; text: "Trash"; icon: "\uf014" }
        ListElement { type: "Places"; text: "Favorites"; icon: "\uf006" }

        ListElement { type: "Devices"; text: "AAA"; icon: "\uf0a0" }
        ListElement { type: "Devices"; text: "BBB"; icon: "\uf0a0" }
        ListElement { type: "Devices"; text: "CCC"; icon: "\uf0a0" }
    }

    ListView {
        anchors.margins: 5
        id: v
        anchors.fill: parent
        model: colors
        interactive: false

//        displaced: Transition {
//            NumberAnimation { properties: "x,y"; easing.type: Easing.OutQuad }
//        }

        property int indexOfDraggedIn: -1

        section.property: "type"
        section.delegate: Item {
            width: parent.width
            height: 15

            Text {
                text: section
                color: JsUtil.Theme.ViewContainer.ContentStates.normal.highlight
                font.bold: true
            }
        }

        delegate: MouseArea {
            id: delegateRoot

            property int visualIndex: index

            width: parent.width
            height: 30
            hoverEnabled: true

            onEntered: r.entered()
            onExited: r.exited()
            onClicked: r.clicked()

            drag.target: r
            drag.threshold: 0.0

            Components.FontAwesomeIcon {
                id: r
                width: delegateRoot.width
                height: delegateRoot.height
                iconName: model.icon
                text: model.text
                clickable: false // we manage hover/entered/clicked from the parent mousearea

                Drag.active: delegateRoot.drag.active
                Drag.source: delegateRoot
                Drag.hotSpot.x: 36
                Drag.hotSpot.y: 5

                Drag.onActiveChanged: {
                    if(Drag.active) {
                        r.state = "drag"
                    } else {
                        r.state = "drop"
                    }
                }

                states: [
                    State {
                        name: "drag"
                        ParentChange {
                            target: r
                            parent: root
                        }
                    },
                    State {
                        name: "drop"
                        ParentChange {
                            target: r
                            parent: delegateRoot
                        }

                        PropertyChanges {
                            target: r
                            x: 0
                            y: 0
                        }
                    }
                ]

                transitions: [
                    Transition {
                        to: "drop"
                        ParentAnimation {
                            PropertyAnimation { properties: "x,y"; easing.type: Easing.InOutQuad }
                        }
                    }
                ]
            }

            DropArea {
                anchors.fill: parent
                onEntered: {
                    if(drag.source.visualIndex !== delegateRoot.visualIndex) {
                        // If we change types, update the type to element we're moving in to.
                        var destType = colors.get(delegateRoot.visualIndex).type
                        if(destType !== colors.get(drag.source.visualIndex).type) {
                            colors.setProperty(drag.source.visualIndex, "type", destType)
                        }

                        // Move the currently dragged item to the one we're hovering
                        colors.move(drag.source.visualIndex, delegateRoot.visualIndex, 1)
                    }
                }
            }
        }
    }

}
