import QtQuick 2.1
import QtQuick.Layouts 1.1
import "../javascript/util.js" as JsUtil


Item {
    id: faRoot
    property alias font: faIconText.font
    property string iconName: ""
    property alias text: faText.text
    property alias clickable: mouseEvents.enabled // A disabled MouseArea makes it unclickable
    property alias disabled: mouseEvents.visible // Removing the mousearea from visibility makes it act like a disabled input field (slightly more grey tone)

    signal clicked()
    signal entered()
    signal exited()

    onEntered: {
        faIconText.color = JsUtil.Theme.ToolButtons.hover
    }

    onExited: {
        faIconText.color = JsUtil.Theme.ToolButtons.normal
    }

    RowLayout {
        height: parent.height
        width: parent.width
        spacing: 0

        Item {
            id: faIcon
            width: parent.height
            height: parent.height

            Text {
                id: faIconText
                smooth: true
                anchors.centerIn: parent
                text: faRoot.iconName
                color: JsUtil.Theme.ToolButtons.normal
                font.family: "FontAwesome"
                font.pointSize: 15 // 15 seems like a nice default
            }
        }

        Text {
            id: faText
            Layout.fillWidth: true
            color: faIconText.color
            onTextChanged: {
                if(text == "") {
                    visible = false
                }
            }
        }
    }

    MouseArea {
        id: mouseEvents
        anchors.fill: parent
        enabled: true
        hoverEnabled: true
        onClicked: faRoot.clicked()
        onEntered: faRoot.entered()
        onExited: faRoot.exited()

        onVisibleChanged: {
            if(!visible) {
                faIconText.color = JsUtil.Theme.ToolButtons.disabledColor
            } else {
                faIconText.color = JsUtil.Theme.ToolButtons.normal
            }
        }
    }
}
