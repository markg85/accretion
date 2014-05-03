import QtQuick 2.1
import kdirchainmodel 1.0 as KDirchain
import QtGraphicalEffects 1.0
import "views" as Views
import "javascript/util.js" as JsUtil

Item {

    id: viewRoot
    opacity: enabled ? 1.0 : 0.0
    clip: true
    property alias url: bcModel.url
    property alias urlModel: bcModel
    property bool activeView: false
    property color viewBackgroundColor: (activeView) ? JsUtil.Theme.ViewContainer.Views.active : JsUtil.Theme.ViewContainer.Views.inactive
    function reload() { dirModel.reload() }
    function append(basename) { bcModel.append(basename) }

    Component.onCompleted: viewManager.registerView(viewRoot)


    function exec(name) {
        Qt.openUrlExternally(url + "/" + name)
        console.log(url + "/" + name)
    }

    function toggleFilter() {
//        if(filterPlaceholder.state == "hidden") {
//            filterPlaceholder.state = "visible"
//        } else {
//            filterPlaceholder.state = "hidden"
//        }
    }

    function hideFilter() {
//        filterPlaceholder.state = "hidden"
    }

    function toggleGrouping() {
        if(dirModel.groupby == KDirchain.DirListModel.None) {
            dirModel.groupby = KDirchain.DirListModel.MimeIcon
        } else {
            dirModel.groupby = KDirchain.DirListModel.None
        }
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
        onClicked: viewManager.setActive(viewRoot)

        onWheel: viewManager.setActive(viewRoot)

        z: viewRoot.activeView ? -10 : 1
        enabled: !viewRoot.activeView
    }

    KDirchain.FlatDirGroupedSortModel {
        id: dirModel
        details: "2"
        path: bcModel.url
        groupby: KDirchain.DirListModel.MimeIcon
        property string stringGroupRole: stringRole(groupby)
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
    }

//    ListView {
//        id: views
//        model: dirModel
//        anchors.fill: parent
//        Behavior on opacity {
//            NumberAnimation { duration: 100 }
//        }

//        delegate: Views.SingleGroup {
//            width: viewRoot.width
//            height: viewRoot.height
//                model: dirModel.modelAtIndex(index)
//                groupKey: (groupedName) ? groupedName : "";
//        }
//    }

    Views.SingleGroup {
        anchors.fill: parent
        model: dirModel
    }


}
