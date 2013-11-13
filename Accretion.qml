import QtQuick 2.1
import QtQuick.Layouts 1.0
import kdirchainmodel 1.0 as KDirchain
import "javascript/util.js" as JsUtil
import "Transitional"

Rectangle {
    id: appRoot
    width: 800
    height: 600
    color: JsUtil.Theme.Application.background.color

    // Only ever include this line ONCE throughout the application!
    AppShortcuts{}

    // Load the "FontAwesome" font for the monochrome icons.
    FontLoader {
        source: "fonts/fontawesome-webfont.ttf"
    }

    Column {
        anchors.fill: parent

        property int topPlaceholderHeight: 30
        property int bottomPlaceholderHeight: 30
        property int headRowHeight: 30
        property int totalHeadHight: topPlaceholderHeight + bottomPlaceholderHeight + headRowHeight

        // Placeholder
        Item {
            width: parent.width
            height: parent.topPlaceholderHeight
        }

        RowLayout {
            width: parent.width
            height: parent.headRowHeight

            FontAwesomeIcon {
                id: backButton
                width: parent.height
                height: parent.height
                iconName: JsUtil.FA.ChevronLeft
                enableMouseEvents: breadCrumbBar.model.hasPrevious

                onClicked: {
                    breadCrumbBar.model.previous()
                }
            }

            FontAwesomeIcon {
                id: forwardButton
                width: parent.height
                height: parent.height
                iconName: JsUtil.FA.ChevronRight
                enableMouseEvents: breadCrumbBar.model.hasNext

                onClicked: {
                    breadCrumbBar.model.next()
                }
            }

            FontAwesomeIcon {
                width: parent.height
                height: parent.height
                iconName: JsUtil.FA.Refresh

                onClicked: {
                    splitView.reload()
                }
            }

            BreadcrumbBar {
                id: breadCrumbBar
                height: parent.height
                Layout.fillWidth: true
                url: "file:///home/"

                onUrlChanged: {
                    console.log("url changed to: " + url)
                }
            }

            FontAwesomeIcon {
                id: rightButtons
                width: parent.height
                height: parent.height
                iconName: JsUtil.FA.Cog
            }
        }

        // Placeholder
        Item {
            width: parent.width
            height: parent.bottomPlaceholderHeight
        }

        Item {
            width: parent.width
            height: appRoot.height - parent.totalHeadHight

            Item {
                anchors.left: parent.left
                anchors.right: spacer.left
                height: parent.height
            }

            Item {
                width: 5
                height: parent.height
                id: spacer
                x: 100


                Rectangle {
                    x: 1
                    width: 1
                    height: parent.height
                    color: JsUtil.Theme.Application.divider.color
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        cursorShape = Qt.SizeHorCursor
                    }
                    drag.axis: Drag.XAxis
                    drag.target: parent
                }
            }

            SplitView {
                id: splitView
                height: parent.height
                anchors.left: spacer.right
                anchors.right: parent.right
                url: breadCrumbBar.url
            }
        }
    }
}
