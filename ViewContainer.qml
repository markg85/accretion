import QtQuick 2.1
import kdirchainmodel 1.0 as KDirchain
import QtGraphicalEffects 1.0
import "views" as Views
import "javascript/util.js" as JsUtil

Item {

    id: viewRoot
    opacity: enabled ? 1.0 : 0.0
    signal reload()
    property alias url: bcModel.url
    property alias urlModel: bcModel
    property bool activeView: true
    property color viewBackgroundColor: (activeView) ? JsUtil.Theme.ViewContainer.Views.active : JsUtil.Theme.ViewContainer.Views.inactive

    function append(basename) {
        bcModel.append(basename)
    }

    function exec(name) {
        Qt.openUrlExternally(url + "/" + name)
        console.log(url + "/" + name)
    }

    function toggleFilter() {
        if(filterPlaceholder.state == "hidden") {
            filterPlaceholder.state = "visible"
        } else {
            filterPlaceholder.state = "hidden"
        }
    }

    function hideFilter() {
        filterPlaceholder.state = "hidden"
    }

    Behavior on opacity {
        NumberAnimation { duration: 100 }
    }

    Rectangle {
        id: overlay
        anchors.fill: parent
        color: parent.viewBackgroundColor
        visible: !parent.activeView
        Behavior on opacity {
            NumberAnimation { duration: 100 }
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            overlay.opacity = 0.5
        }
        onExited: {
            overlay.opacity = 1
        }
        onClicked: {
            if(!viewRoot.activeView) {
                viewRoot.activeView = true
            }
        }

        onWheel: {
            if(!viewRoot.activeView) {
                viewRoot.activeView = true
            }
        }

        z: viewRoot.activeView ? -10 : 1
        enabled: !viewRoot.activeView
    }

    onReload: {
        dirModel.reload()
    }

    KDirchain.DirGroupedModel {
        id: dirModel
        path: bcModel.url
        groupby: KDirchain.DirListModel.MimeIcon
    }

    /**
      Each view has it's own "BreadcrumbUrlModel". This allows for easy switching of urlModel objects in the main window.
      This also allows for easy back/forward maintainability because each view has it's own url model.

      One thing that _must_ be remembered is that each url change must be send to this model! Not to the Dir*Model objects!
      They will be updated once the url model changes it's url.
    */
    KDirchain.BreadcrumbUrlModel {
        id: bcModel
        url: viewRoot.url

        onUrlChanged: {
            console.log("KDirchain.BreadcrumbUrlModel url: " + url)
        }
    }

    state: "list"

    /**
      In the most ideal situation this list should also be build up dynamically. Either based on a config file or by reading the folder that contains the views.
      I guess a config file would be best. in that case it should have at least the following per view:
      - Name (icon, list, tree, ...)
      - Icon (the FontAwesome icon to use for the view
      - File (IconView.qml for icon ... you get the point)
     */
//    states: [
//        State {
//            name: "icon"
//            PropertyChanges { target: views; sourceView: "views/IconView.qml" }
//        },
//        State {
//            name: "list"
//            PropertyChanges { target: views; sourceView: "views/LView.qml" }
//        },
//        State {
//            name: "tree"
//            PropertyChanges { target: views; sourceView: "views/TreeView.qml" }
//        }
//    ]

    Rectangle {
        id: subViewContainer
        anchors.fill: parent
        opacity: activeView ? 1 : 0.5
        color: JsUtil.Theme.Application.background.color

        ListView {
            id: views
            model: dirModel
            anchors.fill: parent
            Behavior on opacity {
                NumberAnimation { duration: 100 }
            }

            delegate: Views.SingleGroup {
                model: dirModel.modelAtIndex(index)
                groupKey: (display) ? display : "";
            }
        }
    }

    FancyBlurredInput {
        id: filterPlaceholder
        bgSource: subViewContainer
        height: 30
        width: parent.width - 10
        placeholderText: "Filter"
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height - height - 4
        onClose: viewRoot.hideFilter()
        icon: FontAwesomeIcon {
            clickable: false
            width: filterPlaceholder.height - (filterPlaceholder.margins * 2)
            height: filterPlaceholder.height - (filterPlaceholder.margins * 2)
            iconName: JsUtil.FA.Filter
//            iconName: JsUtil.FA.Search
        }
        state: "hidden"

        states: [
            State {
                name: "hidden"
                PropertyChanges { target: filterPlaceholder; y: parent.height }
            },
            State {
                name: "visible"
                PropertyChanges { target: filterPlaceholder; y: parent.height - height - 4 }
            }
        ]

        transitions: [
            Transition {
                to: "hidden"
                SequentialAnimation {
                    PropertyAnimation { property: "y"; duration: 100; easing.type: Easing.OutBack }
                    PropertyAction { target: filterPlaceholder; property: "visible"; value: false }
                }
            },
            Transition {
                to: "visible"
                SequentialAnimation {
                    PropertyAction { target: filterPlaceholder; property: "visible"; value: true }
                    PropertyAnimation { property: "y"; duration: 100; easing.type: Easing.OutBack }
                }
            }
        ]

        onTextChanged: {
            dirModel.setInputFilter(text)
        }
    }

//    Loader {
//        anchors.fill: parent
//        id: viewContainer
//    }
}
