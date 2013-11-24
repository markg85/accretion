import QtQuick 2.1
import kdirchainmodel 1.0 as KDirchain
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
            viewRoot.activeView = true
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

    ListView {
        id: views
        anchors.fill: parent
        model: dirModel
        opacity: activeView ? 1 : 0.5

        Behavior on opacity {
            NumberAnimation { duration: 100 }
        }

        delegate: Views.SingleGroup {
            model: dirModel.modelAtIndex(index)
            groupKey: (display) ? display : "";
        }
    }

//    Loader {
//        anchors.fill: parent
//        id: viewContainer
//    }
}
