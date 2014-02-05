import QtQuick 2.1
import QtQuick.Layouts 1.0
import kdirchainmodel 1.0 as KDirchain
import "javascript/util.js" as JsUtil

Rectangle {
    id: appRoot
    width: 800
    height: 600
    color: JsUtil.Theme.Application.background.color

    // Only ever include this line ONCE throughout the application!
    AppShortcuts {
        // Split view keyboars shortcut
        onSplitViewActivated: {
            splitView.splitView = !splitView.splitView
        }

        onReload: splitView.reload()
        onBack: breadCrumbBar.model.previous()
        onForward: breadCrumbBar.model.next()
        onFilter: splitView.activeViewContainer.toggleFilter()
        onEsc: splitView.activeViewContainer.hideFilter()
    }

    // Load the "FontAwesome" font for the monochrome icons.
    FontLoader {
        source: "fonts/fontawesome-webfont.ttf"
    }

    Column {
        anchors.fill: parent
        id: parCol

        property int topPlaceholderHeight: 30
        property int bottomPlaceholderHeight: 30
        property int headRowHeight: 30
        property bool isExpandedForSettings: false
        property int totalHeadHight: topPlaceholderHeight + bottomPlaceholderHeight + headRowHeight

        function toggleQuickSettings() {
            if(isExpandedForSettings) {
                topPlaceholderHeight = 30
                bottomPlaceholderHeight = 30
                settings.opacity = 0.0
            } else {
                topPlaceholderHeight = 5
                bottomPlaceholderHeight = 55
                settings.opacity = 1.0
            }
            isExpandedForSettings = !isExpandedForSettings
        }

        // Placeholder
        Item {
            width: parent.width
            height: parent.topPlaceholderHeight
            Behavior on height {
                NumberAnimation { duration: 100 }
            }
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
                model: splitView.activeViewContainer.urlModel
            }

            FontAwesomeIcon {
                id: rightButtons
                width: parent.height
                height: parent.height
                iconName: JsUtil.FA.Cog

                onClicked: {
                    parCol.toggleQuickSettings()
                }
            }
        }

        // Placeholder
        Item {
            width: parent.width - 10
            x: 5
            height: parent.bottomPlaceholderHeight
            Behavior on height {
                NumberAnimation { duration: 100 }
            }

            Grid {
                id: settings
                opacity: 0.0
                columns: 3
                Behavior on opacity {
                    NumberAnimation { duration: 100 }
                }
                anchors.fill: parent
                property int cellHeight: parent.height / 3
                property int cellWidth: parent.width / 3
                Item {
                    width: settings.cellWidth
                    height: settings.cellHeight
                    Row {
                        anchors.fill: parent
                        spacing: 5
                        FontAwesomeIcon {
                            width: parent.height
                            height: parent.height
                            iconName: JsUtil.FA.Columns

                            onClicked: {
                                splitView.splitView = !splitView.splitView
                            }
                        }
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            color: JsUtil.Theme.BreadCrumb.fontColorActive.normal
                            text: "Split view"
                        }
                    }
                }
            }
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
                    drag.threshold: 0.0
                }
            }

            SplitView {
                id: splitView
                height: parent.height
                anchors.left: spacer.right
                anchors.right: parent.right
                url: "file:///home/kde-devel"
                splitView: false
            }
        }
    }
}
