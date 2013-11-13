import QtQuick 2.1
import kdirchainmodel 1.0 as KDirchain
import "views" as Views
import "javascript/util.js" as JsUtil

Item {

    id: root
    signal reload()
    property alias url: dirModel.path
    property bool activeView: true
    property color viewBackgroundColor: (activeView) ? JsUtil.Theme.ViewContainer.Views.active : JsUtil.Theme.ViewContainer.Views.inactive

    onReload: {
        dirModel.reload()
    }

    KDirchain.DirGroupedModel {
        id: dirModel
        groupby: KDirchain.DirListModel.MimeIcon
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
