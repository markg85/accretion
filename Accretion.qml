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

        onReload: viewManager.reload()
        onBack: breadCrumbBar.model.previous()
        onForward: breadCrumbBar.model.next()
        onFilter: viewManager.toggleFilter()
        onEsc: viewManager.hideFilter()
    }

    // Load the "FontAwesome" font for the monochrome icons.
    FontLoader {
        source: "fonts/fontawesome-webfont.ttf"
    }

    ViewManager {
        id: viewManager
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
                disabled: breadCrumbBar.model.hasPrevious

                onClicked: {
                    breadCrumbBar.model.previous()
                }
            }

            FontAwesomeIcon {
                id: forwardButton
                width: parent.height
                height: parent.height
                iconName: JsUtil.FA.ChevronRight
                disabled: breadCrumbBar.model.hasNext

                onClicked: {
                    breadCrumbBar.model.next()
                }
            }

            FontAwesomeIcon {
                width: parent.height
                height: parent.height
                iconName: JsUtil.FA.Refresh

                onClicked: {
                    viewManager.reload()
                }
            }

            BreadcrumbBar {
                id: breadCrumbBar
                height: parent.height
                Layout.fillWidth: true
                model: viewManager.activeView.urlModel
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

        KDirchain.SplitView {
            id: splitView
            width: parent.width
            height: appRoot.height - parent.totalHeadHight
            resizeHandleDelegate: VSplitHandle{}

            LeftMenu {
                width: 150
            }

            ViewContainer {
                clip: true
                url: "file:///home/kde-devel"
            }
        }
    }
}
