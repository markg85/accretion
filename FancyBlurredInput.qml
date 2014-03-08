import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.1
import "javascript/util.js" as JsUtil

Item {
    id: root
    property Item bgSource: undefined
    property alias text: ti.text
    property alias placeholderText: placeholder.text
    property int margins: height * 0.2
    property alias icon: loader.sourceComponent

    signal close()

    ShaderEffectSource {
        id: effect_source
        hideSource: false
        // sourceItem: bgSource
        sourceRect: Qt.rect(root.x, root.y, root.width, root.height)
        width: sourceRect.width
        height: sourceRect.height
    }

    // Blurred background
    GaussianBlur {
        id: blur
        anchors.fill: effect_source
        source: effect_source
        radius: 16
        samples: 32
        visible: false
    }

    // Rounded corners
    OpacityMask {
        id: mask
        anchors.fill: root
        source: blur
        maskSource: Rectangle {
            width: effect_source.width
            height: effect_source.height
            radius: 5
        }
        visible: false
    }

    // Give the blurred stuff a color
    Colorize {
        id: colorized
        anchors.fill: mask
        source: mask
        hue: 0.5
        saturation: 0.50
        lightness: 0.75
    }

    // Shadow
    DropShadow {
        anchors.fill: colorized
        horizontalOffset: 0
        verticalOffset: 0
        radius: 16
        samples: 24
        color: "#66afe9"
        transparentBorder: true;
        source: colorized
    }

    // Rounded border
    Rectangle {
        id: container
        anchors.fill: effect_source
        border.color: "#66afe9"
        border.width: 1
        radius: 5
        color: "transparent"
        Item {
            anchors.fill: parent
            anchors.margins: root.margins
            clip: true // Prevent the text from being drawn outside of this item

            RowLayout {
                anchors.fill: parent
                Loader { id: loader }
                TextInput {
                    id: ti
                    font.pointSize: root.margins * 2
                    color: "#555555"
                    anchors.verticalCenter: parent.verticalCenter
                    Layout.fillWidth: true
                    focus: root.visible
                    onTextChanged: {
                        if(text !== "") {
                            placeholder.visible = false
                        } else {
                            placeholder.visible = true
                        }
                    }

                    Text {
                        id: placeholder
                        font: parent.font
                        opacity: 0.2
                    }
                }
                FontAwesomeIcon {
                    height: loader.height
                    width: loader.height
                    iconName: JsUtil.FA.Remove
                    onClicked: root.close()
                }
            }
        }
    }
}
